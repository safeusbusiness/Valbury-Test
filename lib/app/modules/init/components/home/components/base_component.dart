import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/global_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_button_transparent_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';
import 'package:valbury/app/data/commons/widgets/photo_widget.dart';
import 'package:valbury/app/modules/init/components/home/controllers/home_controller.dart';

abstract class BaseHomeComponents extends GetView<HomeController> {

  const BaseHomeComponents({super.key});

  Widget titleWidget(String title) => Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainTextWidget(
            title,
            style: Theme.of(Get.context!).textTheme.displaySmall,
          ),
          MainTextWidget(
            TextConstant.seeAll,
            style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                color: Colors.blue
            ),
          ),
        ],
      ),
      SizedBox(
        height: MarginSizeConstant.small.h,
      ),
      GlobalWidget.customDivider(
          height: 1.h
      ),
      SizedBox(
        height: MarginSizeConstant.medium.h,
      ),
    ],
  ).marginSymmetric(
      horizontal: MarginSizeConstant.medium.w
  );

  Widget itemVerticalWidget({
    required String picture,
    required String title,
    required String address
  }) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PhotoWidget(
            photoURL: picture,
            width: 110.w,
            height: 65.h,
            boxFit: BoxFit.cover,
            borderRadius: BorderRadius.circular(
                BorderRadiusConstant.low.r
            ),
          ),
          SizedBox(
            width: 150.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainTextWidget(
                  title,
                  maxLines: 2,
                  style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 3.h,
                ),
                MainTextWidget(
                  address,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!).textTheme.bodyMedium,
                ),
              ],
            ).marginSymmetric(
                horizontal: MarginSizeConstant.normal.w
            ),
          )
        ],
      ),
      MainTextWidget(
        TextConstant.seeDetail,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            color: Colors.blue
        ),
      ),
    ],
  ).marginOnly(
      bottom: MarginSizeConstant.normal.h
  );

  Widget itemHorizontalWidget({
    required int index,
    required String title,
    required Function(int) onTap,
    required bool isEnabled
  }) => MainButtonTransparentWidget(
    onTap: () => onTap(index),
    child: AnimatedContainer(
      margin: EdgeInsets.zero,
      duration: const Duration(
        milliseconds: 550
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BorderRadiusConstant.low.r),
        color: isEnabled ? Theme.of(Get.context!).primaryColor : Colors.white,
      ),
      child: MainTextWidget(
        title,
        style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
          color: isEnabled ? Colors.white : Colors.black
        ),
      ).paddingSymmetric(
          horizontal: MarginSizeConstant.medium.w,
          vertical: MarginSizeConstant.extraSmall.h
      ),
    ).marginOnly(
        right: MarginSizeConstant.medium.w,
        left: index == 0 ? MarginSizeConstant.medium.w : 0,
        bottom: 3.h
    ),
  );


}