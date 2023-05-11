import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/widgets/main_scaffold_widget.dart';
import 'package:valbury/app/modules/init/components/home/pages/home_page.dart';

import '../controllers/init_controller.dart';

class InitView extends GetView<InitController> {
  const InitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Widget iconWidget(IconData iconData) => Icon(
      iconData,
      size: 18.h,
    );

    return MainScaffoldWidget(
      onBackPressed: (){},
      body: PersistentTabView(
        context,
        controller: controller.persistenTabController,
        screens: const [
          HomePage(),
          ColoredBox(
            color: Colors.indigo,
          ),
          ColoredBox(
            color: Colors.deepOrange,
          ),
          ColoredBox(
            color: Colors.green,
          ),
        ],
        items: [
          PersistentBottomNavBarItem(
              icon: iconWidget(Icons.home_rounded),
              title: TextConstant.home,
              activeColorPrimary: Theme.of(context).primaryColor,
              inactiveColorPrimary: Colors.grey
          ),
          PersistentBottomNavBarItem(
              icon: iconWidget(Icons.local_hospital_rounded),
              title: TextConstant.rs,
              activeColorPrimary: Theme.of(context).primaryColor,
              inactiveColorPrimary: Colors.grey
          ),
          PersistentBottomNavBarItem(
              icon: iconWidget(Icons.accessible),
              title: TextConstant.clinic,
              activeColorPrimary: Theme.of(context).primaryColor,
              inactiveColorPrimary: Colors.grey
          ),
          PersistentBottomNavBarItem(
              icon: iconWidget(Icons.person_rounded),
              title: TextConstant.profile,
              activeColorPrimary: Theme.of(context).primaryColor,
              inactiveColorPrimary: Colors.grey
          ),
        ],
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle: NavBarStyle.style9,
        onItemSelected: (index) => controller.onItemSelected(index),
      ),
    );
  }
}
