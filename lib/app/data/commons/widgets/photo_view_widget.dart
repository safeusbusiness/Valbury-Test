import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/widgets/main_scaffold_widget.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_appbar_model.dart';

class PhotoViewWidget extends StatelessWidget {
  final String urlPhoto;
  const PhotoViewWidget({Key? key, required this.urlPhoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageProvider(ImageProvider image) => PhotoView(
          imageProvider: image,
          loadingBuilder: (context, loadingProgress) {
            return Center(
              child: SizedBox(
                  width: 45.w,
                  height: 45.h,
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                    value: (loadingProgress?.expectedTotalBytes ?? 0) != 0
                        ? ((loadingProgress?.cumulativeBytesLoaded ?? 0) /
                            int.parse((loadingProgress?.expectedTotalBytes ?? 0)
                                .toString()))
                        : 0,
                  )),
            );
          },
        );

    Widget itemWidget() {
      return Uri.parse(urlPhoto).isAbsolute
          ? imageProvider(NetworkImage(urlPhoto))
          : imageProvider(FileImage(File(urlPhoto)));
    }

    return MainScaffoldWidget(
        onBackPressed: () => Get.back(),
        isUseShadow: false,
        appBar: MainScaffoldAppbarModel(
            titleTextAppBar: TextConstant.seePhoto
        ),
        body: itemWidget()
    );
  }
}
