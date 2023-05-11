import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:valbury/app/configs/app_theme_config.dart';
import 'package:valbury/app/data/commons/constants/global_constant.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: GlobalConstant.appName,
          debugShowCheckedModeBanner: false,
          theme: AppThemeConfig.theme,
          themeMode: ThemeMode.light,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          home: child,
        );
      },
    ),
  );
}
