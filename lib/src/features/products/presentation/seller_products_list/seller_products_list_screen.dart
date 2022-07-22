// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:muraita_2_0/src/constants/strings.dart';

import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';
import '../all_products_list/products_list_view.dart';

class SellerProductsListScreen extends ConsumerStatefulWidget {
  const SellerProductsListScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;
  @override
  ConsumerState<SellerProductsListScreen> createState() =>
      _SellerProductsListScreenState();
}

class _SellerProductsListScreenState
    extends ConsumerState<SellerProductsListScreen> {
  String productStatus = kProductStatus[1];

  int _selectedIndex = 0;

  AutoDisposeStreamProvider<List<Product>>? _filteredProducts =
      sellerAllProductsStreamProvider;

  void _onSelectTab(int i) {
    setState(() {
      _selectedIndex = i;
    });

    if (_selectedIndex != 0) {
      _filteredProducts = sellerFilteredProductsStreamProvider;
    } else {
      _filteredProducts = sellerAllProductsStreamProvider;
    }
    if (_selectedIndex == 1) {
      ref.read(productStatusProvider.state).state = kProductStatus[1];
    } else if (_selectedIndex == 2) {
      ref.read(productStatusProvider.state).state = kProductStatus[2];
    } else if (_selectedIndex == 3) {
      ref.read(productStatusProvider.state).state = kProductStatus[3];
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // final sellerProductsValue =
    //     ref.watch(sellerAllProductsStreamProvider(ownerId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            for (var i = 0; i < kProductStatus.length; i++)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: i == _selectedIndex ? 2 : 0))),
                  child: TextButton(
                    onPressed: () => _onSelectTab(i),
                    child: Text(
                      kProductStatus[i],
                    ),
                  ),
                ),
              ),
          ]),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          ResponsiveSliverCenter(
              child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.p4, vertical: Sizes.p16),
            child: ProductListView(listValue: ref.watch(_filteredProducts!)),
          )),
        ],
      ),
    );
  }
}
