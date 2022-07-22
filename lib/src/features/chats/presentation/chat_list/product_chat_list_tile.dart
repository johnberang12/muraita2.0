import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muraita_2_0/src/common_widgets/product_title_widget.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/chats/domain/last_message.dart';
import 'package:muraita_2_0/src/features/chats/domain/product_cutomer_model.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/custom_image.dart';
import '../../../../common_widgets/profile_avatar_with_indicator.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/styles.dart';
import '../../../products/domain/product.dart';
import '../../data/chat_repository.dart';

class ProductChatListTile extends ConsumerWidget {
  const ProductChatListTile({
    Key? key,
    required this.sellerImageUrl,
    required this.isActive,
    required this.isActivity,
    required this.isSeen,
    required this.product,
    required this.lastMessage,
    required this.timeAgo,
    required this.onTap,
    required this.productCutomer,
  }) : super(key: key);
  final String? sellerImageUrl;
  final bool isActive;
  final bool isActivity;
  final bool isSeen;
  final Product product;
  final String? lastMessage;
  final String? timeAgo;
  final ProductCustomerModel productCutomer;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final lastMessagevalue =
        ref.watch(productChatLastMessageProvider(productCutomer));
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColors.black10,
        height: height * .09,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                flex: 16,
                // width: width * .020,
                child: Center(
                    child: ProfileAvatarWithIndicator(
                  imageUrl: sellerImageUrl!,
                  isActive: isActive,
                )),
              ),
              Expanded(
                flex: 68,
                // width: width * .060,
                child: AsyncValueWidget<LastMessage?>(
                  value: lastMessagevalue,
                  data: (message) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleWidget(product: product),
                        gapH4,
                        isActivity
                            ? Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SpinKitThreeBounce(
                                    color: AppColors.black40,
                                    size: height * .025,
                                  )
                                ],
                              )
                            : Text(
                                message?.lastMessage ?? '',
                                style: isSeen ? Styles.k12 : Styles.k12Bold,
                              )
                      ]),
                ),
              ),
              Expanded(
                flex: 16,
                // width: width * .020,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: CustomImage(imageUrl: product.photos[0]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
