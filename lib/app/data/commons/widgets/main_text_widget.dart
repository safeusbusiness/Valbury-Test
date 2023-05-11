import 'package:flutter/material.dart';

class MainTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;

  const MainTextWidget(this.text,
      {Key? key, this.style, this.overflow, this.maxLines, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
