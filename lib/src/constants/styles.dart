import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';

import 'app_colors.dart';

const kProductTitleSyle = Styles.k14;
const kProductPriceStyle = Styles.k14Bold;

class ProductStyle {
  static const title = Styles.k14;
  static const subTitle = Styles.k12Grey;
  static const price = Styles.k14Bold;
  static const iconCounts = Styles.k10Grey;
}

class Styles {
  static const k32 = TextStyle(fontSize: Sizes.p32, color: AppColors.black80);
  static const k32Grey =
      TextStyle(fontSize: Sizes.p32, color: AppColors.black40);
  static const k32Bold = TextStyle(
      fontSize: Sizes.p32,
      color: AppColors.black80,
      fontWeight: FontWeight.bold);

  static const k24 = TextStyle(fontSize: Sizes.p24, color: AppColors.black80);
  static const k24Grey =
      TextStyle(fontSize: Sizes.p24, color: AppColors.black40);
  static const k24Bold = TextStyle(
      fontSize: Sizes.p24,
      color: AppColors.black80,
      fontWeight: FontWeight.bold);

  static const k20 = TextStyle(fontSize: Sizes.p20, color: AppColors.black80);
  static const k20Grey =
      TextStyle(fontSize: Sizes.p20, color: AppColors.black40);
  static const k20Bold = TextStyle(
      fontSize: Sizes.p20,
      color: AppColors.black80,
      fontWeight: FontWeight.bold);

  static const k16 = TextStyle(fontSize: Sizes.p16, color: AppColors.black80);
  static const k16Grey =
      TextStyle(fontSize: Sizes.p16, color: AppColors.black40);
  static const k16Bold = TextStyle(
      fontSize: Sizes.p16,
      color: AppColors.black80,
      fontWeight: FontWeight.bold);

  static const k14 = TextStyle(fontSize: Sizes.p14, color: AppColors.black80);
  static const k14Grey =
      TextStyle(fontSize: Sizes.p14, color: AppColors.black40);
  static const k14Bold = TextStyle(
      fontSize: Sizes.p14,
      color: AppColors.black80,
      fontWeight: FontWeight.bold);

  static const k12 = TextStyle(fontSize: Sizes.p12, color: AppColors.black80);
  static const k12Grey =
      TextStyle(fontSize: Sizes.p12, color: AppColors.black40);
  static const k12Bold = TextStyle(
      fontSize: Sizes.p12,
      color: AppColors.black80,
      fontWeight: FontWeight.bold);

  static const k10 = TextStyle(fontSize: 10, color: AppColors.black80);
  static const k10Grey = TextStyle(fontSize: 10, color: AppColors.black40);
  static const k10Bold = TextStyle(
      fontSize: 10, color: AppColors.black80, fontWeight: FontWeight.bold);

  static const k8 = TextStyle(fontSize: Sizes.p8, color: AppColors.black80);
  static const k8Grey = TextStyle(fontSize: Sizes.p8, color: AppColors.black40);
  static const k8Bold = TextStyle(
      fontSize: Sizes.p8,
      color: AppColors.black80,
      fontWeight: FontWeight.bold);
}
