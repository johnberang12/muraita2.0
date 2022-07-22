import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/product_title_widget.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import '../../../../common_widgets/custom_image.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../utils/currency_formatter.dart';
import '../../../products/domain/product.dart';

class ProductTab extends ConsumerWidget {
  ProductTab({Key? key, required this.product}) : super(key: key);
  Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted = kCurrencyFormatter.format(product.price);
    final user = ref.watch(authRepositoryProvider).currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 75,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CustomImage(imageUrl: product.photos[0])),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: Sizes.p4),
                          child: ProductTitleWidget(
                            product: product,
                            style: Styles.k12Bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(priceFormatted, style: Styles.k12Bold),
                          Text(
                              product.negotiable!
                                  ? '(Negotialble)'
                                  : '(Non-negotiable)',
                              style: Styles.k12)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 25,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
            child: SizedBox(
                width: 140,
                height: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 1),
                  onPressed: () => context.pushNamed(AppRoute.leaveReview.name,
                      params: {'id': product.id}),
                  child: Row(children: [
                    const Icon(
                      Icons.edit,
                      color: AppColors.black80,
                    ),
                    Text(
                      product.ownerId == user!.uid
                          ? 'Set status'
                          : 'Leave review',
                      style: Styles.k12.copyWith(color: AppColors.black80),
                    )
                  ]),
                )),
          ),
        ),
      ],
    );
  }
}
