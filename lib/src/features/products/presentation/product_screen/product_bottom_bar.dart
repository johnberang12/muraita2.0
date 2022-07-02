import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/custom_text.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';
import '../../domain/product.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Sizes.p24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: double.infinity,
                width: width * .15,
                child: const Center(child: Icon(Icons.heart_broken_sharp))),
            SizedBox(
                height: double.infinity,
                width: width * .60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText('P${product.price}',
                        fontSize: width * .04, fontWeight: FontWeight.bold),
                    CustomText(
                      'Fixed Price',
                      fontSize: width * .03,
                      color: kBlack40,
                    ),
                  ],
                )),
            SizedBox(
                height: double.infinity,
                width: width * .25,
                child: Center(
                    child: ElevatedButton(
                        child: const Text(
                          'Chat',
                        ),
                        onPressed: () =>
                            context.pushNamed(AppRoute.chat.name)))),
          ],
        ),
      ),
    );
  }
}
