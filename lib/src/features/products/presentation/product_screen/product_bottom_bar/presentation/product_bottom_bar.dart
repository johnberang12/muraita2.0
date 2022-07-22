import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';

import '../../../../../../common_widgets/async_value_widget.dart';
import '../../../../../../common_widgets/custom_text.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/app_sizes.dart';
import '../../../../../../routing/app_router.dart';
import '../../../../../../utils/currency_formatter.dart';
import '../../../../domain/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'like_animation.dart';
import 'product_bottom_bar_controller.dart';

// import '../data/favourite_repository.dart';
// import '../data/product_view_model.dart';
// import '../domain/favourite.dart';
// import '../domain/product_user_favourite.dart';

class ProductBottomBar extends ConsumerWidget {
  ProductBottomBar({Key? key, required this.product}) : super(key: key);
  final Product product;
  bool _isLiked = false;
  bool isLikeAnimating = false;

  void _setFavourite(WidgetRef ref) {
    final controller = ref.watch(productBottomBarControllerProvider);
    _isLiked = !_isLiked;
    controller.setFavourite(product.id, _isLiked);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final height = MediaQuery.of(context).size.height;
    final priceFormatted = kCurrencyFormatter.format(product.price);
    final width = MediaQuery.of(context).size.width;
    final user = ref.watch(authRepositoryProvider).currentUser;

    return product.ownerId == user!.uid
        ? const SizedBox()
        : SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: Sizes.p24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: IconButton(
                          onPressed: () => _setFavourite(ref),
                          icon: Icon(
                            FontAwesomeIcons.heart,
                            color: _isLiked ? Colors.red : AppColors.black40,
                          )),
                      // child: LikeAnimation(
                      //   smallLike: true,
                      //   child:  IconButton(

                      //     icon:  product.likes.contains(uid) ?
                      //     Icon(Icons.favorite, color: Colors.red) :  Icon(Icons.favorite_border),
                      //     onPressed: () {
                      //       ///add userId to the likes array
                      //     },
                      //     ),

                      //   isAnimating: ///true if likes array containes uid,

                      //   ),
                    ),
                  ),
                  SizedBox(
                      height: double.infinity,
                      width: width * .60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(priceFormatted,
                              fontSize: width * .04,
                              fontWeight: FontWeight.bold),
                          CustomText(
                            product.negotiable!
                                ? 'Negotiable'
                                : 'Non-negotiable',
                            fontSize: width * .03,
                            color: AppColors.black40,
                          ),
                        ],
                      )),
                  SizedBox(
                      height: double.infinity,
                      width: width * .25,
                      child: Center(
                          child: ElevatedButton(
                              child: const Text(
                                'Chat',
                              ),
                              onPressed: () => context.pushNamed(
                                  AppRoute.chat.name,
                                  params: {'customerId': user.uid},
                                  extra: product)))),
                ],
              ),
            ),
          );
  }
}
