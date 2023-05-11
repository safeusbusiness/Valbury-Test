import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';
import 'package:valbury/app/data/commons/constants/ui_constant.dart';
import 'package:valbury/app/data/commons/widgets/main_text_widget.dart';

class MainEmptyDataWidget extends StatelessWidget {

  final String title;
  final bool isShow;
  const MainEmptyDataWidget({super.key, this.title = TextConstant.emptyData, this.isShow = true});

  @override
  Widget build(BuildContext context) {

    Widget lottieWidget() {
      Random random = Random();
      int randomNumber = random.nextInt(4);
      if (randomNumber == 0) randomNumber = 1;
      if (randomNumber == 4) randomNumber = 3;

      double width = 200.w;
      switch(randomNumber) {
        case 1: {
          width = 250.w;
          break;
        }
        case 2: {
          width = 200.w;
          break;
        }
        case 3: {
          width = 160.w;
          break;
        }
      }

      return SizedBox(
          width: width,
          child: Lottie.asset('assets/jsons/lotties/empty/json_lotties_empty_$randomNumber.json')
      );
    }

    Widget titleWidget() => MainTextWidget(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        );

    Widget itemWidget() => Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            lottieWidget(),
            Padding(
              padding: const EdgeInsets.only(
                left: MarginSizeConstant.extraLarge,
                right: MarginSizeConstant.extraLarge,
                top: MarginSizeConstant.large,
                bottom: MarginSizeConstant.extraLarge
              ),
              child: titleWidget(),
            )
          ],
        ));

    return AnimatedOpacity(
      opacity: isShow ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 550),
      child: Visibility(visible: isShow, child: itemWidget()),
    );
  }
}
