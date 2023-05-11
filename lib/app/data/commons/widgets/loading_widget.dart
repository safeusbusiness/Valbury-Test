import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';

class LoadingWidget {

  static Widget listFourLoading() => ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : MarginSizeConstant.medium.h),
          child: fourLoading(),
        );
      }
  );

  static Widget fourLoading() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: MarginSizeConstant.medium.h,
      ),
      loadingShimmerCard(
          width: 280.w,
          height: MarginSizeConstant.medium.h
      ),
      SizedBox(
        height: MarginSizeConstant.small.h,
      ),
      loadingShimmerCard(
          width: 250.w,
          height: MarginSizeConstant.medium.h
      ),
      SizedBox(
        height: MarginSizeConstant.small.h,
      ),
      loadingShimmerCard(
          width: 220.w,
          height: MarginSizeConstant.medium.h
      ),
      SizedBox(
        height: MarginSizeConstant.small.h,
      ),
      loadingShimmerCard(
          width: 190.w,
          height: MarginSizeConstant.medium.h
      ),
    ],
  );
  
  static Widget circularProgress(
      {double size = 23, double? value, double strokeWidth = 4.0}) {
    return SizedBox(
      width: size.w,
      height: size.h,
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(Get.context!).primaryColor,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: strokeWidth.w,
        value: value,
      ),
    );
  }

  static Widget loadingShimmerCardList({required double height}) => ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: (MarginSizeConstant.small + 4).h,
          ),
          child: LoadingWidget.loadingShimmerCard(
              height: height.h,
              width: double.maxFinite
          ),
        );
      }
  );

  static Widget loadingShimmerCard({
      double? height,
      double radius = BorderRadiusConstant.low,
      double? width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.withOpacity(0.05),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        elevation: 0,
        child: SizedBox(height: height ?? 230.h, width: width ?? double.maxFinite),
      ),
    );
  }

  static Widget loadingShimmerText() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.w,
            height: 12.0.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(BorderRadiusConstant.veryLow.r))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0.h),
          ),
          Container(
            width: double.maxFinite,
            height: 12.0.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(BorderRadiusConstant.veryLow.r))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0.h),
          ),
          Container(
            width: double.maxFinite,
            height: 12.0.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(BorderRadiusConstant.veryLow.r))),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Container(
            width: 120.w,
            height: 12.0.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(BorderRadiusConstant.veryLow.r))),
          ),
        ],
      ),
    );
  }

  static Widget onLoadingWidget({required bool loadingStatus, required Widget child, bool isCard = false, EdgeInsets? customPadding}) {

    EdgeInsets padding = customPadding ?? EdgeInsets.only(
        left: MarginSizeConstant.medium.w,
        right: MarginSizeConstant.medium.w,
        bottom: MarginSizeConstant.medium.h,
        top: MarginSizeConstant.extraSmall.h
    );

    if (loadingStatus) {
      if (isCard) {
        return GridView.builder(
            padding: padding,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: MarginSizeConstant.medium - 2,
                mainAxisSpacing: MarginSizeConstant.medium - 2
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return LoadingWidget.loadingShimmerCard(
                height: 250.h
              );
            }
        );
      } else {
        return Padding(
          padding: padding,
          child: LoadingWidget.listFourLoading(),
        );
      }

    } else {
      return child;
    }
  }

}
