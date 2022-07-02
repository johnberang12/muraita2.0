import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';
import '../../../../routing/goRouter/route_utils.dart';

class HomeFloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: Sizes.p64),
          child: FloatingActionButton(
            onPressed: () => context.pushNamed(AppRoute.addProduct.name),
            backgroundColor: kPrimaryHue,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
