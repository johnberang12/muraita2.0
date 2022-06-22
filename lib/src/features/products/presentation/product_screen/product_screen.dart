import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/products/presentation/product_screen/product_average_rating.dart';
import 'package:muraita_2_0/src/localization/string_hardcoded.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/custom_image.dart';
import '../../../../common_widgets/empty_placeholder_widget.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../common_widgets/responsive_two_column_layout.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/currency_formatter.dart';
import '../../../reviews/presentation/product_reviews/product_reviews_list.dart';
import '../../data/fake_products_repository.dart';
import '../../domain/product.dart';
import '../home_app_bar/home_app_bar.dart';
import 'leave_review_action.dart';

/// Shows the product page for a given product ID.
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final productValue = ref.watch(productProvider(productId));
          return AsyncValueWidget<Product?>(
            value: productValue,
            data: (product) => product == null
                ? EmptyPlaceholderWidget(
                    message: 'Product not found'.hardcoded,
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: ProductDetails(product: product),
                      ),
                      ProductReviewsList(productId: productId),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

/// Shows all the product details along with actions to:
/// - leave a review
/// - add to cart
class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final priceFormatted = kCurrencyFormatter.format(product.price);

    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: CustomImage(imageUrl: product.imageUrl),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product.title, style: Theme.of(context).textTheme.headline6),
              gapH8,
              Text(product.description),
              // Only show average if there is at least one rating
              if (product.numRatings >= 1) ...[
                gapH8,
                ProductAverageRating(product: product),
              ],
              gapH8,
              const Divider(),
              gapH8,
              Text(priceFormatted,
                  style: Theme.of(context).textTheme.headline5),
              gapH8,
              LeaveReviewAction(productId: product.id),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
