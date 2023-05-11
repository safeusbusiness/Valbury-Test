import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valbury/app/configs/app_data_config.dart';
import 'package:valbury/app/data/commons/constants/global_constant.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/helpers/date_helper.dart';
import 'package:valbury/app/data/commons/helpers/dialog_utils_helper.dart';
import 'package:valbury/app/data/commons/helpers/log_helper.dart';
import 'package:valbury/app/data/commons/widgets/global_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_button_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_textfield_widget.dart';
import 'package:valbury/app/data/models/user/user_model.dart';
import 'package:valbury/app/modules/auth/controllers/base_auth_controller.dart';

class LoginController extends BaseAuthController {

  var substractExpiredDateTime = DateTime.now().obs;

  var countFailedLogin = 0.obs;
  var countDownTimerFailedLogin = 0;
  RxInt runningTimer = 30.obs;

  var isCheckRememberMe = false.obs;

  Timer? timer;
  Timer? countDownTimer;

  void onCheckRememberMe() {
    isCheckRememberMe.value = !isCheckRememberMe.value;
  }

  void checkCountDownTimerLogin() async {
    var currentValue = DateTime.fromMillisecondsSinceEpoch(AppDataConfig.failedLoginMultipleTimes ?? 0);
    if (!(await DateHelper.isTimeDone(timestamp: currentValue.millisecondsSinceEpoch))) {
      countFailedLogin.value = GlobalConstant.maximumCountFailedLogin;
      startCountDownTimer(currentValue.millisecondsSinceEpoch);
    }
  }

  void startCountDownTimer(int substractDateTime) {
    void start() {
      var dateTimeNow = DateHelper.getDeviceTimeStamp();
      var substractMillsec = substractDateTime - dateTimeNow;
      substractExpiredDateTime.value = DateTime.fromMillisecondsSinceEpoch(substractMillsec);
    }
    start();
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      start();
    });
  }

  @override
  bool isButtonDisable() {
    if (countFailedLogin.value == GlobalConstant.maximumCountFailedLogin) return true;
    bool isDisable = false;
    var email = emailController.value.text;
    var password = passwordController.value.text;
    if (emailError.value.isNotEmpty) {
      isDisable = true;
    } else {
      if (email.isEmpty) {
        isDisable = true;
      }
    }
    if (passwordError.value.isNotEmpty) {
      isDisable = true;
    } else {
      if (password.isEmpty) {
        isDisable = true;
      }
    }
    return isDisable;
  }

  @override
  void resetAllData() {
    emailController.value.text = '';
    passwordController.value.text = '';
    emailError.value = '';
    passwordError.value = '';
  }

  @override
  Future<void> submit() async {
    setBusy();
    var email = emailController.value.text.toLowerCase();
    var password = passwordController.value.text;
    var userModel = await userRepo.loginRegisterAccount(
        userModel: UserModel(
            userEmail: email,
            userPassword: password,
        ),
        onError: (e) {
          countFailedLogin.value++;
          if (countFailedLogin.value >= GlobalConstant.maximumCountFailedLogin) {
            var value = DateTime.now();
            switch(countFailedLogin.value) {
              case GlobalConstant.maximumCountFailedLogin: {
                value = DateTime.now().add(const Duration(minutes: 1));
                break;
              }
              case GlobalConstant.maximumCountFailedLogin + 1: {
                value = DateTime.now().add(const Duration(minutes: 5));
                break;
              }
              default: {
                value = DateTime.now().add(const Duration(minutes: 15));
              }
            }
            GlobalWidget.showSnackBar(
                title: TextConstant.errorLoginWaitTitle,
                message: TextConstant.errorLoginWaitDesc
            );
            AppDataConfig.failedLoginMultipleTimes = value.millisecondsSinceEpoch;
            startCountDownTimer(value.millisecondsSinceEpoch);
          } else {
            onFailedAuth(e);
          }
        }
    );
    if (userModel != null) {
      LogHelper.print('Test: ${userModel.toJson()}');
      AppDataConfig.userModel = userModel;
      if (isCheckRememberMe.value) {
        AppDataConfig.savedEmailRememberMe = email;
      }
      AppDataConfig.timeStampReLogin = DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch;
      GlobalWidget.showToast(TextConstant.loginSuccess);
      onNavigateHome();
    }
    setIdle();
  }

  @override
  String textButtonLogic() {
    if (countDownTimer?.isActive ?? false) {
      return '${substractExpiredDateTime.value.minute}:${substractExpiredDateTime.value.second}';
    } else {
      return TextConstant.login;
    }
  }

  @override
  void initializeData() {
    emailController.value.text = AppDataConfig.savedEmailRememberMe ?? '';
    if (emailController.value.text.isNotEmpty) {
      isCheckRememberMe.value = true;
    }
    checkCountDownTimerLogin();
  }

  void onForgotPassword() {

    void onCancelTimer() {
      if (timer == null) return;
      if (timer!.isActive) timer!.cancel();
    }

    runningTimer.value = AppDataConfig.maximumForgotPasswordTimes;
    var isLoading = false.obs;

    Rx<TextEditingController> emailController = TextEditingController().obs;
    var emailError = ''.obs;

    void onRunningTimer() {
      onCancelTimer();
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (runningTimer.value != 0) {
          runningTimer.value--;
        }
        AppDataConfig.maximumForgotPasswordTimes = runningTimer.value;
      });
    }

    if (runningTimer.value != 0) onRunningTimer();

    void onConfirmation() async {
      if (isLoading.value) return;

      bool isAllPass = true;
      String email = emailController.value.text;
      if (emailError.value.isNotEmpty) isAllPass = false;
      if (email.isEmpty) {
        emailError.value = TextConstant.required.tr;
        isAllPass = false;
      }

      if (isAllPass) {
        isLoading.value = true;
        var value = await userRepo.getUserByEmail(email: email);
        if (value != null) {
          userRepo.fAuth.sendPasswordResetEmail(email: email).then((value) {
            GlobalWidget.showSnackBar(message: TextConstant.checkYourEmailForgotPassword);
            isLoading.value = false;
            runningTimer.value = 60;
            AppDataConfig.maximumForgotPasswordTimes = runningTimer.value;
            onRunningTimer();
          }).catchError((s) {
            isLoading.value = false;
            GlobalWidget.showSnackBar(message: TextConstant.errorDefault);
          });
        } else {
          isLoading.value = false;
          GlobalWidget.showSnackBar(message: TextConstant.emailNotFound);
        }
      }
    }

    DialogUtilsHelper.showGeneralDrawer(
        withStrip: true,
        radius: 16,
        content: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(TextConstant.forgotPassword,
                style: Theme.of(Get.context!).textTheme.displayLarge),
            const SizedBox(
              height: 5,
            ),
            Text(
              TextConstant.forgotPasswordDesc,
              style: Theme.of(Get.context!).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            MainTextFieldWidget(
              title: TextConstant.email,
              errorText: emailError,
              icon: Icons.email_rounded,
              hint: TextConstant.emailHint,
              keyboardType: TextInputType.emailAddress,
              controller: emailController.value,
              enableStrip: true,
            ),
            const SizedBox(
              height: 30,
            ),
            MainButtonWidget(
              text: runningTimer.value == 0
                  ? TextConstant.confirm.tr
                  : runningTimer.value.toString(),
              isLoading: isLoading.value,
              isDisable: runningTimer.value != 0,
              onPressed: () => onConfirmation(),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: Get.mediaQuery.viewInsets.bottom,
            )
          ],
        )));
  }

}
