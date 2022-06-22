import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/localization/string_hardcoded.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/custom_image.dart';
import '../../../../common_widgets/custom_list_tile.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/styles.dart';
import '../../../../services/firestore_database.dart';
import '../../domain/listing.dart';
import '../home_app_bar/home_app_bar.dart';
import 'custom_floating_action_button.dart';

/// Shows the list of products with a search field at the top.
class ListingsScreen extends StatefulWidget {
  const ListingsScreen({super.key});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Column(
        children: [
          const Divider(height: 0.5),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: const [
                ResponsiveSliverCenter(
                    padding: EdgeInsets.all(Sizes.p16),
                    child: ListingListView()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class ListingListView extends ConsumerWidget {
  const ListingListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingListValue = ref.watch(listingsListStreamProvider);
    return AsyncValueWidget<List<Listing?>>(
      value: listingListValue,
      data: (listings) => listings.isEmpty
          ? Center(
              child: Text(
                'No products found'.hardcoded,
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : LisitngLayoutGrid(
              itemCount: listings.length,
              itemBuilder: (_, index) {
                final listing = listings[index];
                return _ListingListTile(listing: listing!, onPressed: () {}
                    // => context.goNamed(
                    //   AppRoute.product.name,
                    //   params: {'id': product.id},
                    // ),
                    );
              },
            ),
    );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class LisitngLayoutGrid extends StatelessWidget {
  const LisitngLayoutGrid({
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
class _ListingListTile extends StatelessWidget {
  const _ListingListTile({
    required this.listing,
    required this.onPressed,
  });

  final Listing listing;
  final VoidCallback onPressed;
  final String messageCount = '50';
  final String likeCount = '100';

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: onPressed,
      thumbnail: const CustomImage(
        imageUrl: 'assets/products/bruschetta-plate.jpg',
      ),
      title: Text(
        listing.title,
        style: TextSizes.k14,
      ),
      subTitle: Text(
        listing.description,
        style: TextSizes.k12Grey,
      ),
      caption: Text(
        'Php ${listing.price}',
        style: kProductPriceStyle,
      ),
      trailing1: [
        const Icon(
          Icons.message,
          size: Sizes.p16,
          color: kBlack60,
        ),
        Text(
          messageCount,
          style: TextSizes.k12Grey,
        ),
      ],
      trailing2: [
        const Icon(
          Icons.heart_broken_outlined,
          size: Sizes.p16,
          color: kBlack60,
        ),
        Text(
          likeCount,
          style: TextSizes.k12Grey,
        ),
      ],
    );
  }
}
