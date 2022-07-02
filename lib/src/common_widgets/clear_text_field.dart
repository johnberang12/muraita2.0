import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/strings.dart';
import 'custom_text.dart';

class ClearTextField extends StatelessWidget {
  const ClearTextField({
    Key? key,
    required this.controller,
    this.label,
    this.width = double.infinity,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: CustomText(label!, color: kBlack40),
        ),
        autocorrect: false,
      ),
    );
  }
}
