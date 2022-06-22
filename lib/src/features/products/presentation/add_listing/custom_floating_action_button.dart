import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * floatingActionMargin),
      // margin: const EdgeInsets.only(bottom: Sizes.p48),
      child: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRoute.addListing.name),
        child: const Icon(Icons.add),
      ),
    );
  }
}
