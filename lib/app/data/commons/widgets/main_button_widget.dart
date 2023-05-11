import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/loading_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';

class MainButtonWidget extends StatelessWidget {
  final String? text;

  final Color? color;
  final Color textColor;

  final bool? isLoading;
  final bool isDisable;
  final bool isTextButtonCenter;

  final double height;
  final double? elevation;
  final double radius;

  final TextStyle? buttonTextStyle;
  final BorderSide? borderSide;
  final Widget? customLeftWidget;
  final Widget? customRightWidget;
  final EdgeInsets? padding;
  final Function onPressed;

  const MainButtonWidget(
      {Key? key,
      this.text,
      this.buttonTextStyle,
      this.isTextButtonCenter = true,
      this.isDisable = false,
      required this.onPressed,
      this.color,
      this.textColor = Colors.white,
      this.radius = BorderRadiusConstant.low,
      this.elevation,
      this.isLoading,
      this.customRightWidget,
      this.borderSide,
      this.customLeftWidget,
      this.padding,
      this.height = 45})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textItemWidget = MainTextWidget(
      text ?? TextConstant.confirm,
      style: buttonTextStyle ?? Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor),
    );

    return MaterialButton(
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (isDisable) return;
        onPressed();
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: isDisable
          ? Theme.of(context).hintColor
          : color ?? Theme.of(context).primaryColor,
      elevation: elevation,
      height: height.h,
      padding: padding ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(radius.r)),
          side: borderSide ?? BorderSide.none),
      child: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 550),
              opacity: isLoading ?? false ? 0.0 : 1.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: customRightWidget != null
                    ? MainAxisAlignment.spaceBetween
                    : isTextButtonCenter
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                children: [
                  if (customLeftWidget != null) ...[
                    customLeftWidget!,
                    SizedBox(
                      width: (MarginSizeConstant.small + 2).w,
                    ),
                  ],
                  Expanded(
                    child: customLeftWidget != null || customRightWidget != null
                        ? textItemWidget
                        : Center(
                            child: textItemWidget,
                          ),
                  ),
                  if (customRightWidget != null) ...[
                    SizedBox(
                      width: (MarginSizeConstant.small + 2).w,
                    ),
                    customRightWidget!,
                  ],
                ],
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 550),
              opacity: isLoading ?? false ? 1.0 : 0.0,
              child: SizedBox(
                  width: 18.w,
                  height: 18.h,
                  child: LoadingWidget.circularProgress()),
            ),
          ),
        ],
      ).marginOnly(
          left: MarginSizeConstant.medium.w,
          right: MarginSizeConstant.medium.w
      ),
    );
  }
}
