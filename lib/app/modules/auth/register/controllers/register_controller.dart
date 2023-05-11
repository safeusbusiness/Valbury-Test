import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/helpers/utility_helper.dart';
import 'package:valbury/app/data/commons/widgets/global_widget.dart';
import 'package:valbury/app/data/models/user/user_model.dart';
import 'package:valbury/app/modules/auth/controllers/base_auth_controller.dart';
import 'package:valbury/app/routes/app_pages.dart';

class RegisterController extends BaseAuthController {

  var isCheckTermsAndPrivacy = false.obs;

  var phoneController = TextEditingController().obs;
  var phoneError = ''.obs;

  var firstNameController = TextEditingController().obs;
  var firstNameError = ''.obs;

  var lastNameController = TextEditingController().obs;
  var lastNameError = ''.obs;

  var reInputPasswordController = TextEditingController().obs;
  var reInputPasswordError = ''.obs;

  @override
  bool isButtonDisable() {
    if (!isCheckTermsAndPrivacy.value) return true;

    bool isDisable = false;

    if (UtilityHelper.isTextFieldNotValid(
        errorText: emailError.value,
        text: emailController.value.text
    )) {
      isDisable = true;
    }

    if (UtilityHelper.isTextFieldNotValid(
        errorText: phoneError.value,
        text: phoneController.value.text
    )) {
      isDisable = true;
    }

    if (UtilityHelper.isTextFieldNotValid(
        errorText: firstNameError.value,
        text: firstNameController.value.text
    )) {
      isDisable = true;
    }

    if (UtilityHelper.isTextFieldNotValid(
        errorText: lastNameError.value,
        text: lastNameController.value.text
    )) {
      isDisable = true;
    }

    if (UtilityHelper.isTextFieldNotValid(
        errorText: passwordError.value,
        text: passwordController.value.text
    )) {
      isDisable = true;
    }

    if (UtilityHelper.isTextFieldNotValid(
        errorText: reInputPasswordError.value,
        text: reInputPasswordController.value.text
    )) {
      isDisable = true;
    }

    return isDisable;
  }

  @override
  void resetAllData() {
    isCheckTermsAndPrivacy.value = false;
    emailController.value.text = '';
    phoneController.value.text = '';
    passwordController.value.text = '';
    reInputPasswordController.value.text = '';
    emailError.value = '';
    phoneError.value = '';
    passwordError.value = '';
    reInputPasswordError.value = '';
  }

  @override
  Future<void> submit() async {

    var email = emailController.value.text.toLowerCase();
    var password = passwordController.value.text;
    var rePassword = reInputPasswordController.value.text;
    var phone = phoneController.value.text.toLowerCase();
    var firstName = firstNameController.value.text;
    var lastName = lastNameController.value.text;

    if (password != rePassword) {
      reInputPasswordError.value = TextConstant.passwordDoesntMatch;
      return;
    }

    var isEmailAlreadyExists = (await userRepo.getUserByEmail(email: email)) != null;
    if (isEmailAlreadyExists) {
      GlobalWidget.showToast(TextConstant.registrationFailedEmail);
      setIdle();
      return;
    }

    var isPhoneAlreadyExists = (await userRepo.getUserByPhone(phone: phone)) != null;
    if (isPhoneAlreadyExists) {
      GlobalWidget.showToast(TextConstant.registrationFailedPhone);
      setIdle();
      return;
    }

    setBusy();

    var userModel = await userRepo.loginRegisterAccount(
        userModel: UserModel(
          userEmail: email,
          userFirstName: firstName,
          userLastName: lastName,
          userPhone: phone.replaceAll('+62 - ', '+62'),
          userPassword: password
        ),
        isLogin: false,
        onError: (e) {
          onFailedAuth(e);
        }
    );

    if (userModel != null) {
      GlobalWidget.showToast(TextConstant.registrationSuccess);
      Get.offAllNamed(Routes.login);
    } else {
      GlobalWidget.showToast(TextConstant.registrationFailed);
    }

    setIdle();
  }

  @override
  String textButtonLogic() {
    return TextConstant.register.tr;
  }

  @override
  void initializeData() {}

  void onBackPressed() {
    Get.toNamed(Routes.login);
  }
}
