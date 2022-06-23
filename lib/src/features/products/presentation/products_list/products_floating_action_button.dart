import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';

class FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: Sizes.p64),
          child: FloatingActionButton(
            onPressed: () => context.pushNamed(AppRoute.addListing.name),
            backgroundColor: kPrimaryHue,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
