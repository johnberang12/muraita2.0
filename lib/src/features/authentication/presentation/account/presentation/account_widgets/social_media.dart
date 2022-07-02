import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';

import '../../../../../../common_widgets/custom_text.dart';
import '../../../../../../constants/styles.dart';
import 'labeled_icon.dart';

class SocialMedia extends ConsumerWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Social Media',
          style: Styles.k16.copyWith(fontSize: height * .02),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LabeledIcon(
              icon: (Icons.facebook),
              label: 'facebook',
              iconSize: height * .025,
              avatarRadius: height * .025,
              labelFontSize: height * .018,
            ),
            LabeledIcon(
              icon: (Icons.camera_alt_outlined),
              label: 'instagram',
              iconSize: height * .025,
              avatarRadius: height * .025,
              labelFontSize: height * .018,
            ),
            LabeledIcon(
              icon: (Icons.access_alarm_outlined),
              label: 'twitter',
              iconSize: height * .025,
              avatarRadius: height * .025,
              labelFontSize: height * .018,
            ),
          ],
        )
      ],
    );
  }
}
