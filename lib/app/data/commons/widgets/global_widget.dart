import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/helpers/log_helper.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';

class GlobalWidget {

  static Future<void> showSnackBar({String? title, required String message}) async {
    try {
      await Get.showSnackbar(GetSnackBar(
        borderRadius: BorderRadiusConstant.medium,
        titleText: title != null ? Center(
          child: MainTextWidget(
            title,
            style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ) : null,
        messageText: Center(
          child: MainTextWidget(
            message,
            style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ),
        duration: const Duration(seconds: 4),
        margin: EdgeInsets.all(MarginSizeConstant.medium.w),
      )).future;
    } catch(e) {
      LogHelper.error('Snackbar: $e');
    }
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0.sp
    );
  }

  static Widget customDivider({double? height}) => Divider(
    thickness: 0.35,
    color: Colors.black12,
    height: height,
  );

  static Widget shadowBody({required child}) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red,
            Colors.transparent,
            Colors.transparent,
            Colors.red
          ],
          stops: [0.0, 0.01, 1.0, 0.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: child,
    );
  }

}