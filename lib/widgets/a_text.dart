import 'package:flutter/material.dart';

class AText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;

  const AText(
    this.text, {
    Key? key,
    this.fontSize,
    this.color,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        height: 1.0,
        fontFamily: 'SourceHanSansSC',
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
