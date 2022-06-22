import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class CustomBody extends StatelessWidget {
  const CustomBody({Key? key, this.alignment, required this.child})
      : super(key: key);

  final Alignment? alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
          child: child,
        ),
      ),
    );
  }
}
