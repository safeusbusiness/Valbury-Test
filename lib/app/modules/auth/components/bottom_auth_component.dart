import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/main_button_widget.dart';

class BottomAuthComponent extends StatelessWidget {

  final bool isButtonDisable;
  final bool isButtonLoading;
  final String buttonText;
  final Function() onButtonPressed;

  final String bottomText1;
  final String bottomText2;
  final Function() onClickBottomText;

  const BottomAuthComponent({Key? key, required this.isButtonDisable, required this.isButtonLoading, required this.buttonText, required this.onButtonPressed, required this.bottomText1, required this.bottomText2, required this.onClickBottomText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: MarginSizeConstant.medium,),
        MainButtonWidget(
          isDisable: isButtonDisable,
          text: buttonText,
          isLoading: isButtonLoading,
          onPressed: onButtonPressed,
        ),
        SizedBox(height: MarginSizeConstant.medium.h,),
        RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: bottomText1,
                    style: context.theme.textTheme.bodyMedium
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = onClickBottomText,
                  text: ' $bottomText2',
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ]
          ),
        ),
      ]
    );
  }
}
