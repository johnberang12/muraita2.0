import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';

import '../../common_widgets/custom_list_tile.dart';
import '../../common_widgets/grid_layout.dart';
import '../../common_widgets/responsive_center.dart';
import '../products/data/products_repository.dart';
import '../products/domain/product.dart';
import '../products/presentation/all_products_list/products_list_view.dart';
import 'combined_chat_product_AppUser.dart';

class NeighborhoodScreen extends StatelessWidget {
  NeighborhoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            ResponsiveSliverCenter(child: UsersListView()),
          ],
        ));
  }
}

class UsersListView extends ConsumerWidget {
  UsersListView({Key? key}) : super(key: key);

  final String ownerId = 'NVQYDfmZ4HTCkvldXLZepm6PJdp1';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listValue = ref.watch(productsListStreamProvider);
    return SizedBox();

    // AsyncValueWidget<List<Product>>(
    //     value: listValue,
    //     data: (products) {
    //       final product = products[0];
    //       final productUserValue =
    //           ref.watch(productChatsStreamProvider(product));
    //       return AsyncValueWidget<List<UserProduct>>(
    //         value: productUserValue,
    //         data: (productUsers) => GridLayout(
    //           rowsCount: 1,
    //           itemCount: productUsers.length,
    //           itemBuilder: (_, index) {
    //             final item = productUsers[index];
    //             return CustomListTile(
    //               thumbnail: CircleAvatar(
    //                   child: CachedNetworkImage(
    //                 imageUrl: item.userPhotoUrl,
    //               )),
    //               title: Text(item.productTitle),
    //               location: Text(item.userLocation),
    //             );
    //           },
    //         ),
    //       );
    //     });
  }
}
