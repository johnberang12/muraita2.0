import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    Key? key,
    required this.avatarSize,
    required this.fontSize,
  }) : super(key: key);

  final double avatarSize, fontSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: avatarSize,
      backgroundColor: AppColors.primaryHue,
      child: Image.asset(
        'assets/app_icon_foreground.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
