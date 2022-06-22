import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox(
    this.text, {
    Key? key,
    this.align = TextAlign.center,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.color = kBlack80,
    this.borderRadius = Sizes.p8,
    this.textPadding = Sizes.p8,
  }) : super(key: key);

  final String? text;
  final TextAlign align;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? borderRadius;
  final double? textPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: Padding(
        padding: EdgeInsets.all(textPadding!),
        child: Text(
          text!,
          textAlign: align,
          style: TextStyle(
            fontSize: fontSize!,
            fontWeight: fontWeight!,
            color: color!,
          ),
        ),
      ),
    );
  }
}
