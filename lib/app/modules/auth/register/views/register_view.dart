import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/helpers/regex_rule_helper.dart';
import 'package:valbury/app/data/commons/widgets/main_circle_button_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_textfield_widget.dart';
import 'package:valbury/app/modules/auth/components/base_auth_component.dart';
import 'package:valbury/app/modules/auth/components/bottom_auth_component.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {

  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseAuthComponent(
      onBackPressed: controller.onBackPressed,
      bottomButton: BottomAuthComponent(
        isButtonDisable: controller.isButtonDisable(),
        isButtonLoading: controller.loadingStatus.value,
        buttonText: controller.textButtonLogic(),
        onButtonPressed: controller.submit,
        bottomText1: TextConstant.alreadyHaveAccount,
        bottomText2: TextConstant.login,
        onClickBottomText: controller.onBackPressed,
      ),
      body: [
        Align(
          alignment: Alignment.topLeft,
          child: MainCircleButtonWidget(
              iconData: Icons.chevron_left_rounded,
              onPressed: controller.onBackPressed,
              radius: 22.r,
              size: 28.h,
          ),
        ),
        SizedBox(
          height: MarginSizeConstant.large.h,
        ),
        MainTextFieldWidget(
          title: TextConstant.phoneNumber,
          hint: TextConstant.phoneNumberHint,
          errorText: controller.phoneError,
          controller: controller.phoneController.value,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: MarginSizeConstant.medium.h),
        MainTextFieldWidget(
          title: TextConstant.email,
          hint: TextConstant.emailHint,
          errorText: controller.emailError,
          controller: controller.emailController.value,
          validation: [
            RegexRuleHelper.emailValidationRule
          ],
        ),
        SizedBox(height: MarginSizeConstant.medium.h),
        MainTextFieldWidget(
          title: TextConstant.firstName,
          hint: TextConstant.firstNameHint,
          errorText: controller.firstNameError,
          controller: controller.firstNameController.value,
          validation: [
            RegexRuleHelper.alphabetValidationRule
          ],
        ),
        SizedBox(height: MarginSizeConstant.medium.h),
        MainTextFieldWidget(
          title: TextConstant.lastName,
          hint: TextConstant.lastNameHint,
          errorText: controller.lastNameError,
          controller: controller.lastNameController.value,
          validation: [
            RegexRuleHelper.alphabetValidationRule
          ],
        ),
        SizedBox(height: MarginSizeConstant.medium.h),
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
        SizedBox(height: MarginSizeConstant.medium.h),
        MainTextFieldWidget(
          title: TextConstant.rePassword,
          hint: TextConstant.rePasswordHint,
          errorText: controller.reInputPasswordError,
          controller: controller.reInputPasswordController.value,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: controller.isCheckTermsAndPrivacy.value,
                  onChanged: (val) => controller.isCheckTermsAndPrivacy.value = !controller.isCheckTermsAndPrivacy.value
              ),
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: TextConstant.iAgreeWith,
                          style: context.theme.textTheme.bodyMedium
                      ),
                      TextSpan(
                          text: TextConstant.terms,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.primaryColor,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      TextSpan(
                          text: ' ${TextConstant.and} ',
                          style: context.theme.textTheme.bodyMedium
                      ),
                      TextSpan(
                          text: TextConstant.privacy,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.primaryColor,
                              fontWeight: FontWeight.bold
                          )
                      )
                    ]
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom + MarginSizeConstant.extraLarge,
        )
      ],
    ));
  }
}
