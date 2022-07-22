import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';

class HomeFloatingAction extends StatelessWidget {
  const HomeFloatingAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: Sizes.p64),
          child: FloatingActionButton(
            onPressed: () => context.pushNamed(AppRoute.addProduct.name),
            backgroundColor: AppColors.primaryHue,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
