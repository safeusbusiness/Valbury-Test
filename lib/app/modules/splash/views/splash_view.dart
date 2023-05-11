import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/helpers/assets_helper.dart';
import 'package:valbury/app/data/commons/widgets/loading_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_scaffold_widget.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MainScaffoldWidget(
      onBackPressed: () {},
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetsHelper.icLogo,
              width: (context.width - 180).w,
            ),
            SizedBox(
              height: (MarginSizeConstant.extraLarge).h,
            ),
            Center(
              child: LoadingWidget.circularProgress()
            )
          ],
        ),
      ),
    );
  }
}
