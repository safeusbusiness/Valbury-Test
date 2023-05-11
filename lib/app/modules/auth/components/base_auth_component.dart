import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/main_scaffold_widget.dart';
import 'package:valbury/app/data/models/main_scaffold/main_scaffold_bottomsheet_model.dart';

class BaseAuthComponent extends StatelessWidget {

  final List<Widget> body;
  final Function()? onBackPressed;
  final Widget bottomButton;

  const BaseAuthComponent({Key? key, required this.body, this.onBackPressed, required this.bottomButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffoldWidget(
      onBackPressed: onBackPressed,
      bottomSheet: MainScaffoldBottomSheetModel(
        size: 110.h,
        child: bottomButton
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MarginSizeConstant.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MarginSizeConstant.large.h,),
            ...body,
          ],
        ),
      ),
    );
  }
}
