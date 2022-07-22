import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';

import '../constants/app_sizes.dart';

class BoxColumn extends StatelessWidget {
  const BoxColumn({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryHue,
          borderRadius: BorderRadius.circular(Sizes.p8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p12),
          child: Column(
              mainAxisAlignment: mainAxisAlignment!,
              crossAxisAlignment: crossAxisAlignment!,
              children: children),
        ),
      ),
    );
  }
}
