import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

import 'custom_text.dart';

class ClearTextField extends StatelessWidget {
  const ClearTextField({
    Key? key,
    required this.controller,
    this.label,
    this.width = double.infinity,
    this.keyboardType,
    this.autovalidateMode,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final double? width;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: CustomText(label!, color: AppColors.black40),
        ),
        autovalidateMode: autovalidateMode,
        validator: validator,
        autocorrect: false,
        maxLines: null,
        keyboardType: keyboardType,
      ),
    );
  }
}
