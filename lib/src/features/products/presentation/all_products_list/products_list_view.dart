import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/custom_image.dart';
import 'package:muraita_2_0/src/common_widgets/product_title_widget.dart';

import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/constants/styles.dart';
import 'package:muraita_2_0/src/localization/string_hardcoded.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/custom_list_tile.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../common_widgets/grid_layout.dart';
import '../../../../constants/app_sizes.dart';

import '../../../../routing/app_router.dart';
import '../../../../routing/goRouter/route_utils.dart';
import '../../../../utils/currency_formatter.dart';
import '../../../chats/domain/chat_path.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';

/// A widget that displays the list of products that match the search query.

/// A widget that displays the list of products that match the search query.
class ProductListView extends ConsumerWidget {
  const ProductListView({super.key, required this.listValue});

  final dynamic listValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final productsListValue = ref.watch(productsListStreamProvider);

    return AsyncValueWidget<List<Product>>(
      value: listValue,
      data: (products) => products.isEmpty
          ? Center(
              child: Text(
                'No products found'.hardcoded,
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : GridLayout(
              rowsCount: 1,
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];

                return Column(
                  children: [
                    ProductListTile(
                      product: product,
                      onPressed: () {
                        ///essential
                        ref.read(productOwnerIdProvider.state).state =
                            product.ownerId;
                        context.goNamed(
                          AppRoute.product.name,
                          // PAGES.product.name,
                          params: {'id': product.id},
                        );
                        // print(ref.read(productOwnerIdProvider.state).state);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: .5,
                    ),
                  ],
                );
              },
            ),
    );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class ProductsLayoutGrid extends StatelessWidget {
  const ProductsLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: Sizes.p24, // equivalent to mainAxisSpacing
        columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class ProductListTile extends ConsumerWidget {
  const ProductListTile({
    required this.product,
    required this.onPressed,
  });

  final Product product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted = kCurrencyFormatter.format(product.price);
    final messageCountValue =
        ref.watch(productMessageCountStreamProvider(product));
    return CustomListTile(
      onTap: onPressed,
      thumbnail: Hero(
          tag: product.id,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Opacity(
                  opacity: product.status == kProductStatus[3] ? .6 : 1.0,
                  child: CustomImage(imageUrl: product.photos[0])))),
      title: ProductTitleWidget(
        product: product,
        style: Styles.k14Bold,
      ),
      location: Text(
        product.location,
        style: Styles.k12Grey,
      ),
      price: Text(
        priceFormatted,
        style: Styles.k14Bold,
      ),
      status: const SizedBox(),
      trailing1: [
        product.messageCount == 0
            ? const SizedBox()
            : const Padding(
                padding: EdgeInsets.only(right: Sizes.p4),
                child: Icon(
                  FontAwesomeIcons.message,
                  size: Sizes.p16,
                  color: AppColors.black60,
                ),
              ),
        product.messageCount == 0
            ? const SizedBox()
            : CustomText(
                product.messageCount.toString(),
                fontSize: 8,
              )
      ],
      trailing2: [
        product.followCount == 0
            ? const SizedBox()
            : const Padding(
                padding: EdgeInsets.only(right: Sizes.p4),
                child: Icon(
                  FontAwesomeIcons.heart,
                  size: Sizes.p16,
                  color: AppColors.black60,
                ),
              ),
        product.followCount == 0
            ? const SizedBox()
            : CustomText(
                product.followCount.toString(),
                fontSize: 8,
              ),
      ],
    );
  }
}
