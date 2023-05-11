import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:valbury/app/data/commons/helpers/assets_helper.dart';
import 'package:valbury/app/data/commons/helpers/utility_helper.dart';
import 'package:valbury/app/data/commons/widgets/photo_view_widget.dart';

class PhotoWidget extends StatelessWidget {

  static const String blurryImage =
      'https://ak.picdn.net/shutterstock/videos/26823310/thumb/1.jpg';

  final String? photoURL;
  final AssetImage? emptyImage;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool isIgnoreOnClick;

  const PhotoWidget({
    super.key,
    this.photoURL = blurryImage,
    this.boxFit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.emptyImage,
    this.isIgnoreOnClick = false
  });

  @override
  Widget build(BuildContext context) {

    bool isPhotoUrlNotEmpty() => photoURL?.isNotEmpty ?? false;

    Widget emptyImageWidget() {
      if (emptyImage != null) {
        Widget image = Image(
          image: emptyImage ?? AssetsHelper.icLogo,
          width: width?.w,
          height: height?.h,
          fit: boxFit,
        );
        if (borderRadius != null) {
          return ClipRRect(
            borderRadius: borderRadius,
            child: image,
          );
        } else {
          return image;
        }
      } else {
        return PhotoWidget(
          photoURL: blurryImage,
          borderRadius: borderRadius,
          isIgnoreOnClick: isIgnoreOnClick,
          width: width?.w,
          height: height?.h,
        );
      }
    }

    Widget loadingWidget(double progress) => SizedBox(
      width: width,
      height: height,
      child: Center(
        child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.white
              ),
              value: progress,
            )),
      ),
    );

    Widget itemWidget() {

      Widget finalWidget() {
        String imageUrl = photoURL ?? blurryImage;
        if (isPhotoUrlNotEmpty()) {
          if (UtilityHelper.isTextIsUrl(imageUrl)) {
            return CachedNetworkImage(
                imageUrl: imageUrl,
                fit: boxFit,
                width: width?.w,
                height: height?.h,
                errorWidget: (context, url, error) {
                  return emptyImageWidget();
                },
                progressIndicatorBuilder: (context, url, loadingProgress) {
                  double? value = loadingProgress.progress ?? 0.0;
                  return loadingWidget(value);
                }
            );
          } else {
            return Image(
              image: FileImage(File(photoURL ?? '')),
              width: width?.w,
              height: height?.h,
              fit: boxFit,
            );
          }
        } else {
          return emptyImageWidget();
        }
      }

      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(120.r)),
        child: finalWidget(),
      );
    }

    return !isIgnoreOnClick
        ? InkWell(
            onTap: () => isPhotoUrlNotEmpty() ? Get.to(
                PhotoViewWidget(urlPhoto: photoURL!),
                transition: Transition.fadeIn
            ) : null,
            borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(120)),
            child: itemWidget(),
          )
        : itemWidget();
  }
}
