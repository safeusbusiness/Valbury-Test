import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/helpers/assets_helper.dart';
import 'package:valbury/app/data/commons/helpers/regex_rule_helper.dart';
import 'package:valbury/app/data/commons/widgets/main_button_transparent_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_textfield_widget.dart';
import 'package:valbury/app/modules/auth/components/base_auth_component.dart';
import 'package:valbury/app/modules/auth/components/bottom_auth_component.dart';
import 'package:valbury/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Obx(() => BaseAuthComponent(
      bottomButton: BottomAuthComponent(
        isButtonDisable: controller.isButtonDisable(),
        isButtonLoading: controller.loadingStatus.value,
        buttonText: controller.textButtonLogic(),
        onButtonPressed: controller.submit,
        bottomText1: TextConstant.dontHaveAnAccount,
        bottomText2: TextConstant.register,
        onClickBottomText: () => Get.toNamed(Routes.register),
      ),
      body: [
        Image(
          image: AssetsHelper.icLogo,
          height: 120.h,
        ),
        SizedBox(height: MarginSizeConstant.large.h,),
        MainTextFieldWidget(
          title: TextConstant.email,
          hint: TextConstant.emailHint,
          errorText: controller.emailError,
          controller: controller.emailController.value,
          validation: [
            RegexRuleHelper.emailValidationRule
          ],
        ),
        SizedBox(height: MarginSizeConstant.medium.h,),
        MainTextFieldWidget(
          title: TextConstant.password,
          hint: TextConstant.passwordHint,
          errorText: controller.passwordError,
          controller: controller.passwordController.value,
          obscureText: true,
          validation: [
            RegexRuleHelper.maximum10CharRule
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: MarginSizeConstant.small.h),
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MainButtonTransparentWidget(
                  onTap: () => controller.onCheckRememberMe(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: controller.isCheckRememberMe.value,
                          onChanged: (val) => controller.onCheckRememberMe()
                      ),
                      Text(
                        TextConstant.rememberMe,
                        style: context.theme.textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
              ),
              MainButtonTransparentWidget(
                onTap: controller.onForgotPassword,
                child: MainTextWidget(
                  TextConstant.forgotPassword,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blue
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
