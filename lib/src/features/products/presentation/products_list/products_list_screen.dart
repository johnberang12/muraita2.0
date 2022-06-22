// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/features/products/presentation/products_list/products_grid.dart';
import 'package:muraita_2_0/src/features/products/presentation/products_list/products_list_view.dart';
import 'package:muraita_2_0/src/features/products/presentation/products_list/productss_floating_action_button.dart';

import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/breakpoints.dart';
import '../home_app_bar/home_app_bar.dart';

/// Shows the list of products with a search field at the top.
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: screenWidth < Breakpoint.tablet
                ? ProductListView()
                : ProductsGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingAction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}