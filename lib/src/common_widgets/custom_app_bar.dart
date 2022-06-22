import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor = kBlackf7,
  }) : super(key: key);
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSize? bottom;
  final Color backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      bottom: bottom,
      leading: leading,
      actions: actions,
    );
  }
}
