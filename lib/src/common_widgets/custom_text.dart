import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.align = TextAlign.center,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w300,
    this.color = AppColors.black80,
  }) : super(key: key);

  final String text;
  final TextAlign? align;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: fontSize!,
        fontWeight: fontWeight!,
        color: color!,
      ),
    );
  }
}
