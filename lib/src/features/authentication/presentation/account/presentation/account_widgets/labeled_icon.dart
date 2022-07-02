import 'package:flutter/material.dart';

import '../../../../../../common_widgets/custom_text.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/app_sizes.dart';

class LabeledIcon extends StatelessWidget {
  const LabeledIcon({
    Key? key,
    required this.icon,
    this.iconSize = Sizes.p24,
    required this.label,
    this.labelFontSize = Sizes.p14,
    this.avatarRadius = Sizes.p24,
  }) : super(key: key);
  final IconData icon;
  final double iconSize;
  final String label;
  final double labelFontSize;
  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          highlightColor: kPrimaryHue,
          onTap: () {
            print('tapped');
          },
          child: CircleAvatar(
            backgroundColor: kPrimaryTint40,
            radius: avatarRadius,
            child: Icon(
              icon,
              size: iconSize,
              color: kPrimaryShade60,
            ),
          ),
        ),
        CustomText(
          label,
          fontSize: labelFontSize,
        )
      ],
    );
  }
}
