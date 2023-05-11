import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/main_button_widget.dart';

class DialogUtilsHelper {

  static Future<void> showPopUpDialog(
      {required DialogType dialogType,
        AnimType animType = AnimType.bottomSlide,
        required String title,
        required String desc,
        Function()? btnCancelOnPress,
        required Function() btnOkOnPress,
        String? btnOkText,
        String? btnCancelText,
        Function(dynamic)? onDissmissCallback,
        Duration? autoHide}) async {
    await AwesomeDialog(
      context: Get.context!,
      dialogBackgroundColor: Theme.of(Get.context!).primaryColorLight,
      padding: const EdgeInsets.all(MarginSizeConstant.medium),
      dialogType: dialogType,
      autoHide: autoHide,
      onDismissCallback:
      onDissmissCallback != null ? (s) => onDissmissCallback(s) : null,
      animType: animType,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: title,
      desc: desc,
      btnCancel: btnCancelOnPress != null
          ? SizedBox(
        height: 45.h,
        child: MainButtonWidget(
          text: btnCancelText ?? TextConstant.cancel,
          radius: 120.r,
          color: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            Get.back();
            btnCancelOnPress();
          },
        ),
      )
          : null,
      btnOk: SizedBox(
        height: 45.h,
        child: MainButtonWidget(
          text: btnOkText ?? TextConstant.confirm,
          radius: 120.r,
          color: Theme.of(Get.context!).primaryColor,
          textColor: Colors.white,
          onPressed: () {
            Get.back();
            btnOkOnPress();
          },
        ),
      ),
    ).show();
  }

  static Future<dynamic> showGeneralDrawer({
    bool isDismissible = true,
    double radius = 0,
    bool withStrip = false,
    Color? color,
    Widget? content,
    EdgeInsets padding =
        const EdgeInsets.all(MarginSizeConstant.medium),
  }) async {
    await showModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius.r),
                topRight: Radius.circular(radius.r),
              ),
            ),
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (withStrip) Center(
                  child: Container(
                    width: 65,
                    height: 5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(BorderRadiusConstant.veryLow.r),
                        color: Theme.of(context).unselectedWidgetColor),
                  ),
                ),
                SizedBox(
                  height: MarginSizeConstant.large.h,
                ),
                content ?? const SizedBox(),
                SizedBox(
                  height: MarginSizeConstant.medium.h,
                ),
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
