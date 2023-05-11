import 'package:flutter/material.dart';

class MainScaffoldBottomAppBarModel {

  TabController? controller;
  EdgeInsets? padding;
  Function(int)? onTap;
  Decoration? indicator;
  double indicatorWeight;
  List<Tab> tabs;

  MainScaffoldBottomAppBarModel({
    this.controller,
    this.padding,
    this.onTap,
    this.indicator,
    this.indicatorWeight = 2.0,
    required this.tabs
  });
}