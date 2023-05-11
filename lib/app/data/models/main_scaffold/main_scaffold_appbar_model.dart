import 'package:flutter/material.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_bottombar_model.dart';

class MainScaffoldAppbarModel {

  bool isShowBackIcon;
  String? titleTextAppBar;
  IconData? titleIconAppBar;
  Color? appBarColor;
  List<Widget>? actionsAppBar;
  Widget? titleWidgetAppBar;
  MainScaffoldBottomAppBarModel? bottomAppBar;
  double elevationAppBar = 0;
  double toolbarHeight;

  MainScaffoldAppbarModel({
    this.titleTextAppBar,
    this.titleIconAppBar,
    this.appBarColor,
    this.actionsAppBar,
    this.titleWidgetAppBar,
    this.bottomAppBar,
    this.elevationAppBar = 0,
    this.isShowBackIcon = true,
    this.toolbarHeight = kToolbarHeight
  });

}