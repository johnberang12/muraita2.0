import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/product_title_widget.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/products/presentation/product_screen/seller_info_tab.dart';

import '../../../../common_widgets/responsive_two_column_layout.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/styles.dart';

import '../../domain/product.dart';

class ProductDetailsWidget extends ConsumerWidget {
  const ProductDetailsWidget({super.key, required this.product});
  final Product product;

  final timePassed = '3mins ago';
  final viewsCount = '97';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final priceFormatted = kCurrencyFormatter.format(product.price);
    final height = MediaQuery.of(context).size.height;
    final user = ref.watch(authRepositoryProvider).currentUser;
    return ResponsiveTwoColumnLayout(
      startContent: product.ownerId == user!.uid
          ? const SizedBox()
          : Card(child: SellerInfoTab(product: product, height: height * .080)),
      spacing: Sizes.p4,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductTitleWidget(
                product: product,
                style: Styles.k16Bold,
              ),
              gapH4,
              Text(
                '${product.category} . $timePassed',
                style: Styles.k12Grey,
              ),
              gapH4,
              const Divider(),
              gapH8,
              Text(product.description!, style: Styles.k14),
              gapH16,
              Text(
                '${product.messageCount} chats . ${product.followCount} favourites . $viewsCount views ',
                style: Styles.k12Grey,
              ),
              gapH8,
            ],
          ),
        ),
      ),
    );
  }
}
