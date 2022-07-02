import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';

import '../../../../../../constants/styles.dart';
import 'labeled_icon.dart';

class Favorites extends ConsumerWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LabeledIcon(
          icon: (Icons.thumb_up_alt_outlined),
          label: 'favourites',
          iconSize: height * .025,
          avatarRadius: height * .025,
          labelFontSize: height * .018,
        ),
        LabeledIcon(
          icon: (Icons.shopping_bag_outlined),
          label: 'purchases',
          iconSize: height * .025,
          avatarRadius: height * .025,
          labelFontSize: height * .018,
        ),
        LabeledIcon(
          icon: (Icons.list_outlined),
          label: 'listings',
          iconSize: height * .025,
          avatarRadius: height * .025,
          labelFontSize: height * .018,
        ),
      ],
    );
  }
}
