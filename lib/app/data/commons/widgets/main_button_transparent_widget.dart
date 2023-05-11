import 'package:flutter/material.dart';

class MainButtonTransparentWidget extends StatelessWidget {

  final Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const MainButtonTransparentWidget({Key? key, this.onTap, this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      key: key,
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: child,
      ),
    );
  }
}
