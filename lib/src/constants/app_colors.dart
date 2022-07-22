import 'package:flutter/material.dart';

const appBackground = Color(0x30d9d9d9);
const appBarColor = AppColors.black10;

class AppColors {
  static const primaryHue = Color(0xffffbf00);
  static const primaryTint80 = Color(0xffffd147);
  static const primaryTint60 = Color(0xffffde7c);
  static const primaryTint40 = Color(0x70fbe4a0);
  static const primaryTint20 = Color(0xfffff4d3);
  static const primaryTint10 = Color(0xfffffbeb);
  static const primaryShade20 = Color(0xffd6a001);
  static const primaryShade60 = Color(0xffa87e00);

  static const blue = Color(0xff1d4e89);
  static const activeColor = Color(0xff418452);

  static const black80 = Color(0xff474747);
  static const black60 = Color(0xff767676);
  static const black40 = Color(0xffb1b1b1);
  static const black20 = Color(0xffd9d9d9);
  static const black10 = Color(0xffefefef);

  static const transparent = Color(0x00000000);
  static const transparent80 = Color(0x70000000);
  static const greyTransparent20 = Color(0x20767676);
  static const greyTransparent80 = Color(0x80767676);
}

final primaryMaterailColor = MaterialStateProperty.all(AppColors.primaryHue);

///primary button color
const primaryButtonColor = AppColors.primaryHue;
const primaryButtonTextColor = Colors.white;
