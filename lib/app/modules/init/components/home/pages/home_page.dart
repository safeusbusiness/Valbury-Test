import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:valbury/app/data/commons/constants/global_constant.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/helpers/assets_helper.dart';
import 'package:valbury/app/data/commons/widgets/loading_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_button_transparent_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_circle_button_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_empty_data_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_scaffold_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_smartrefresher_widget.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';
import 'package:valbury/app/data/commons/widgets/photo_widget.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_appbar_model.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_bottombar_model.dart';
import 'package:valbury/app/modules/init/components/home/components/base_component.dart';

import '../controllers/home_controller.dart';

part '../components/hospital_component.dart';

part '../components/banner_component.dart';

part '../components/clinic_component.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Obx(() => DefaultTabController(
          length: 2,
          child: MainScaffoldWidget(
            appBar: MainScaffoldAppbarModel(
              toolbarHeight: !controller.loadingStatus.value
                  ? (GetPlatform.isAndroid ? 100.h : 80.h)
                  : kToolbarHeight,
              titleWidgetAppBar: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetsHelper.icLogo,
                        width: 32.w,
                      ),
                      SizedBox(
                        width: MarginSizeConstant.medium.w,
                      ),
                      MainTextWidget(
                        GlobalConstant.appName,
                      )
                    ],
                  ),
                  Container(
                    transform: Matrix4.translationValues(16, 5, 0),
                    child: MainCircleButtonWidget(
                      onPressed: controller.onStartLogout,
                      iconData: Icons.logout_rounded,
                      backgroundColor: Theme.of(context).primaryColor,
                      iconColor: Colors.white,
                    ),
                  )
                ],
              ),
              bottomAppBar: !controller.loadingStatus.value
                  ? MainScaffoldBottomAppBarModel(
                      padding: const EdgeInsets.only(
                          left: MarginSizeConstant.medium,
                          right: MarginSizeConstant.medium),
                      onTap: controller.onTabChanged,
                      indicatorWeight: 3,
                      tabs: [
                          const Tab(
                            text: TextConstant.label,
                          ),
                          const Tab(
                            text: TextConstant.label,
                          ),
                        ])
                  : null,
            ),
            body: MainSmartRefresherWidget(
              controller: controller.refreshController.value,
              onReload: controller.initializeData,
              child: LoadingWidget.onLoadingWidget(
                  loadingStatus: controller.loadingStatus.value,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MarginSizeConstant.medium.h,
                        ),
                        const _HospitalComponent(),
                        SizedBox(
                          height: MarginSizeConstant.large.h,
                        ),
                        const _BannerComponent(),
                        SizedBox(
                          height: MarginSizeConstant.large.h,
                        ),
                        const _ClinicComponent(),
                        SizedBox(
                          height: MarginSizeConstant.extraLarge.h,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
