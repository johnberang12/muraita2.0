import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';

import '../../../../constants/styles.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(
      {Key? key,
      required this.label,
      required this.height,
      required this.width,
      required this.onPressed})
      : super(key: key);
  final String label;
  final double height;
  final double width;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(height * 0.25)),
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(label, style: Styles.k16Bold.copyWith(color: Colors.white)),
      ),
    );
  }
}
