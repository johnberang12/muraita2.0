import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/custom_image.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/data/users_repository.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../constants/styles.dart';
import '../../../../routing/app_router.dart';
import '../../../authentication/domain/app_user.dart';
import '../../domain/product.dart';

class SellerInfoTab extends ConsumerWidget {
  SellerInfoTab({Key? key, required this.product, this.height})
      : super(key: key);
  final double? height;
  Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellerInfoValue = ref.watch(sellerInfoProvider(product.ownerId));
    return AsyncValueWidget<AppUser?>(
      value: sellerInfoValue,
      data: (seller) => SizedBox(
        height: height,
        child: Row(children: [
          Expanded(
            child: InkWell(
              onTap: () => context.pushNamed(AppRoute.sellerinfo.name,
                  params: {'sellerId': product.ownerId}),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    seller!.photoUrl != ''
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: seller.photoUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Image.asset(kDefaultUserProfile),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Text(seller.displayName!,
                                style: Styles.k12Bold),
                          ),
                          Text(
                            seller.userLocation,
                            style: Styles.k10,
                          )
                        ]),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
            ),
          ),
        ]),
      ),
    );
  }
}
