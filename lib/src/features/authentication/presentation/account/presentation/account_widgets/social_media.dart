import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';

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
              onTap: () =>
                  showAlertDialog(context: context, title: 'UnImplemented'),
              label: 'facebook',
              iconSize: height * .025,
              avatarRadius: height * .025,
              labelFontSize: height * .018,
            ),
            LabeledIcon(
              icon: (Icons.camera_alt_outlined),
              onTap: () =>
                  showAlertDialog(context: context, title: 'UnImplemented'),
              label: 'instagram',
              iconSize: height * .025,
              avatarRadius: height * .025,
              labelFontSize: height * .018,
            ),
            LabeledIcon(
              icon: (Icons.access_alarm_outlined),
              onTap: () =>
                  showAlertDialog(context: context, title: 'UnImplemented'),
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
