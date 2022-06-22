import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';

class FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: Sizes.p64),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryHue,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
