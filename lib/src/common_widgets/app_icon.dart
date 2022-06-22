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
      backgroundColor: kPrimaryHue,
      child: Image.asset(
        'assets/icon_logo.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
