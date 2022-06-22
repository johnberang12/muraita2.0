import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:muraita_2_0/src/constants/styles.dart';
import '../../../constants/app_sizes.dart';
import '../data/search_product_repository.dart';

/// A widget that displays the list of products that match the search query.
class SearchGrid extends StatefulWidget {
  const SearchGrid({super.key});

  @override
  State<SearchGrid> createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  final _repository = SearchRepository.instance;

  Future<void> _onDeleteItem(String id) async {
    await _repository.deleteItem(context, id);
    setState(() {});
  }

  // @override
  // void initState() {
  //   _repository.getSearches();
  //   super.initState();
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder<List>(
        future: _repository.getSearches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductsLayoutGrid(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, index) {
                final search = snapshot.data![index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: InkWell(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: Sizes.p8),
                          child: Text(
                            search.name,
                            style: kProductTitleSyle,
                          ),
                        ),
                        onTap: () => _repository.searchItem(search.name),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: const Icon(
                          Icons.close,
                          size: Sizes.p12,
                        ),
                        onTap: () => _onDeleteItem(search.id),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
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
  final int? itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(2, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount! / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: 0, // equivalent to mainAxisSpacing
        columnGap: 20, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount!; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
