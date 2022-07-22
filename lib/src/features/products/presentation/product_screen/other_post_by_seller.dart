import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/product_title_widget.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/grid_layout.dart';
import '../../../../constants/styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../utils/currency_formatter.dart';
import '../../../authentication/data/users_repository.dart';
import '../../../authentication/domain/app_user.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';

class OtherProductsWidget extends ConsumerWidget {
  const OtherProductsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  // final String ownerId = 'NVQYDfmZ4HTCkvldXLZepm6PJdp1';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellerProductsValue = ref.watch(sellerAllProductsStreamProvider);
    final productOwnerId = ref.read(productOwnerIdProvider);

    final sellerInfoValue = ref.watch(sellerInfoProvider(productOwnerId!));
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AsyncValueWidget<List<Product>?>(
            value: sellerProductsValue,
            data: (sellerProducts) => sellerProducts!.isEmpty
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AsyncValueWidget<AppUser?>(
                              value: sellerInfoValue,
                              data: (seller) => Text(
                                'Other post by ${seller!.displayName}',
                                style: Styles.k16Bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  ref.read(productOwnerIdProvider.state).state =
                                      sellerProducts[0].ownerId;
                                  context.pushNamed(AppRoute.myproducts.name,
                                      params: {
                                        'ownerId': sellerProducts[0].ownerId
                                      },
                                      extra: product);
                                },
                                child: const Text('See more'))
                          ],
                        ),
                      ),
                      GridLayout(
                          rowsCount: 2,
                          itemCount: sellerProducts.length <= 6
                              ? sellerProducts.length
                              : 6,
                          itemBuilder: (_, index) {
                            final priceFormatted = kCurrencyFormatter
                                .format(sellerProducts[index].price);
                            return InkWell(
                              onTap: () => context.pushNamed(
                                AppRoute.product.name,
                                params: {'id': sellerProducts[index].id},
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 140,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            sellerProducts[index].photos[0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: ProductTitleWidget(
                                      product: sellerProducts[index],
                                      style: Styles.k12Bold,
                                    ),
                                  ),
                                  Text(
                                    priceFormatted,
                                    style: Styles.k14Bold,
                                  )
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
