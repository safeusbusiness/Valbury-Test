import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';

class DialogUtilsHelper {

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
