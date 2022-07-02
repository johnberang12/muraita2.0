import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';

class CustomBody extends StatelessWidget {
  const CustomBody(
      {Key? key, this.alignment, required this.child, this.padding})
      : super(key: key);

  final Alignment? alignment;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Divider(
            height: 0.5,
          ),
          Expanded(
            child: Container(
              padding: padding,
              alignment: alignment,
              color: appBackground,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
