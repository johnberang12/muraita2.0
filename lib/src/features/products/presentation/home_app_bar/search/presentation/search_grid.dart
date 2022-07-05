import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';
import 'package:muraita_2_0/src/constants/styles.dart';

import '../../../../../../common_widgets/grid_layout.dart';
import '../../../../../../constants/app_sizes.dart';
import '../data/search_product_repository.dart';
import '../domain/search.dart';
import 'dart:developer' as dev;

/// A widget that displays the list of products that match the search query.
class SearchGrid extends ConsumerStatefulWidget {
  const SearchGrid({super.key});

  @override
  ConsumerState<SearchGrid> createState() => _SearchGridState();
}

class _SearchGridState extends ConsumerState<SearchGrid> {
  Future<void> _onDeleteItem(
      BuildContext context, WidgetRef ref, String id) async {
    final controller = ref.watch(searchRepositoryProvider);
    await controller.deleteItem(context, id);
    ref.refresh(searchListFutureProvider);
  }

  // @override
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(searchRepositoryProvider);
    final AsyncValue<List> searchList = ref.watch(searchListFutureProvider);

    return AsyncValueWidget<List>(
        value: searchList,
        data: (searches) => GridLayout(
              rowsCount: 2,
              itemCount: searches.length,
              itemBuilder: (_, index) {
                final search = searches[index];
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
                            search.title,
                            style: kProductTitleSyle,
                          ),
                        ),
                        onTap: () => controller.searchItem(search.title),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: const Icon(
                          Icons.close,
                          size: Sizes.p12,
                        ),
                        onTap: () => _onDeleteItem(context, ref, search.id),
                      ),
                    ),
                  ],
                );
              },
            ));
  }
}
