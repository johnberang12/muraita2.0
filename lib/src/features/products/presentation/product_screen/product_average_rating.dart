import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_sizes.dart';

import '../../domain/product.dart';

/// Shows the product average rating score and the number of ratings
/// this will be changed to sellers trust rating
class ProductAverageRating extends ConsumerWidget {
  const ProductAverageRating(this.product, {super.key});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        gapW8,
        Text(
          product.followCount.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        gapW8,
        Expanded(
          child: Text(
            product.messageCount == 1 ? '1 rating' : '4.5 ratings',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
