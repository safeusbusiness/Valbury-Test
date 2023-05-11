import 'package:flutter/material.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';

class MainScaffoldBottomSheetModel {
  final EdgeInsets margin;
  final double size;
  final Widget child;

  const MainScaffoldBottomSheetModel({
    this.margin = const EdgeInsets.only(
        left: MarginSizeConstant.medium,
        right: MarginSizeConstant.medium,
        bottom: MarginSizeConstant.medium
    ),
    this.size = 45,
    required this.child
  });
}