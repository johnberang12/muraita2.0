import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/search/presentation/home_search_bar/products_search_text_field.dart';

import '../../../../../../../common_widgets/responsive_center.dart';

import '../search_grid.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  _popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ProductsSearchTextField(
          onPopScreen: () => _popScreen(context),
        ),
      ),
      body: const CustomScrollView(
        slivers: [
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(16.0),
            child: SearchGrid(),
          ),
        ],
      ),
    );
  }
}
