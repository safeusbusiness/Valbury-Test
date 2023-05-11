import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCircleButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  final double size;
  final double radius;
  final Color? backgroundColor;
  final Color? iconColor;

  const MainCircleButtonWidget(
      {super.key, required this.iconData,
      required this.onPressed,
      this.size = 22,
      this.radius = 18,
      this.iconColor = Colors.white,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: (backgroundColor ?? Colors.black12),
      radius: radius.r,
      child: IconButton(
        padding: EdgeInsets.zero,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        alignment: Alignment.center,
        highlightColor: Colors.transparent,
        icon: Icon(
          iconData,
          color: iconColor,
          size: size,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
