import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common_widgets/responsive_center.dart';
import '../../../../../../constants/app_sizes.dart';
import '../../../../../products/data/products_repository.dart';
import '../../../../../products/presentation/all_products_list/products_list_view.dart';

class FavouriteListScreen extends ConsumerWidget {
  const FavouriteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: CustomScrollView(
        slivers: [
          ResponsiveSliverCenter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.p4),
            child: ProductListView(
                // to bechanged with list of favourites
                listValue: ref.watch(productsListStreamProvider)),
          )),
        ],
      ),
    );
  }
}
