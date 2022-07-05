import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/custom_image.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/styles.dart';
import 'package:muraita_2_0/src/localization/string_hardcoded.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/custom_list_tile.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../common_widgets/grid_layout.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';
import '../../../../routing/goRouter/route_utils.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';

/// A widget that displays the list of products that match the search query.

/// A widget that displays the list of products that match the search query.
class ProductListView extends ConsumerWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsListValue = ref.watch(productsListStreamProvider);
    return AsyncValueWidget<List<Product>>(
      value: productsListValue,
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
                return _ProductListTile(
                  product: product,
                  onPressed: () => context.goNamed(
                    // APP_Route.product.name,
                    PAGES.product.name,
                    params: {'id': product.id},
                  ),
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
class _ProductListTile extends StatelessWidget {
  const _ProductListTile({
    required this.product,
    required this.onPressed,
  });

  final Product product;
  final VoidCallback onPressed;
  final String messageCount = '50';
  final String likeCount = '100';

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: onPressed,
      thumbnail: Image.asset(
        'assets/products/bruschetta-plate.jpg',
      ),
      title: Text(
        product.title!,
        style: kProductTitleSyle,
      ),
      subTitle: CustomText(
        product.description!,
        fontSize: 12,
      ),
      caption: Text(
        'Php ${product.price}',
        style: kProductPriceStyle,
      ),
      trailing1: [
        const Icon(
          Icons.message,
          size: Sizes.p16,
          color: kBlack60,
        ),
        CustomText(
          messageCount,
          fontSize: 8,
        ),
      ],
      trailing2: [
        const Icon(
          Icons.heart_broken_outlined,
          size: Sizes.p16,
          color: kBlack60,
        ),
        CustomText(
          likeCount,
          fontSize: 8,
        ),
      ],
    );
  }
}
