import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:muraita_2_0/src/features/products/presentation/product_screen/app_bar_photo_gallery.dart';
import 'package:muraita_2_0/src/features/products/presentation/product_screen/other_post_by_seller.dart';

import 'package:muraita_2_0/src/features/products/presentation/product_screen/product_details_widget.dart';

import 'package:muraita_2_0/src/localization/string_hardcoded.dart';

import '../../../../common_widgets/async_value_widget.dart';

import '../../../../common_widgets/empty_placeholder_widget.dart';
import '../../../../common_widgets/responsive_center.dart';

import '../../../../constants/app_sizes.dart';

import '../../../../routing/app_router.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';

import 'product_bottom_bar/presentation/product_bottom_bar.dart';

/// Shows the product page for a given product ID.
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: Consumer(
        builder: (context, ref, _) {
          final productValue = ref.watch(productStreamProvider(productId));
          return AsyncValueWidget<Product?>(
            value: productValue,
            data: (product) => product == null
                ? EmptyPlaceholderWidget(
                    message: 'Product not found'.hardcoded,
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 88,
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              leadingWidth: 100,
                              leading: Row(
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: const Icon(
                                          Icons.arrow_back_ios_new_outlined)),
                                  IconButton(
                                      onPressed: () =>
                                          context.goNamed(AppRoute.home.name),
                                      icon: const Icon(
                                        Icons.home_outlined,
                                        size: 30,
                                      )),
                                ],
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_vert),
                                )
                              ],
                              pinned: true,
                              stretch: true,
                              expandedHeight: 300,
                              flexibleSpace: FlexibleSpaceBar(
                                  background: AppBarPhotoGallery(
                                product: product,
                              )),
                            ),
                            ResponsiveSliverCenter(
                              padding: const EdgeInsets.all(Sizes.p4),
                              child: ProductDetailsWidget(product: product),
                            ),
                            // ProductReviewsList(productId: productId),
                            ResponsiveSliverCenter(
                                child: OtherProductsWidget(
                              product: product,
                            ))
                          ],
                        ),
                      ),
                      const Divider(height: 0.5),
                      Expanded(
                        flex: 12,
                        child: ProductBottomBar(product: product),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
