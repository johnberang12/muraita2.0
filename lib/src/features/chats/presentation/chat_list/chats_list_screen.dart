import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/grid_layout.dart';
import 'package:muraita_2_0/src/common_widgets/profile_avatar_with_indicator.dart';
import 'package:muraita_2_0/src/common_widgets/responsive_center.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/chats/data/chat_repository.dart';
import 'package:muraita_2_0/src/features/chats/domain/product_cutomer_model.dart';
import 'package:muraita_2_0/src/features/products/data/products_repository.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/custom_image.dart';
import '../../../../constants/styles.dart';
import '../../../../routing/app_router.dart';
import '../../../authentication/data/users_repository.dart';
import '../../../authentication/domain/app_user.dart';
import '../../../products/domain/product.dart';
import '../../domain/chat.dart';
import '../../domain/chat_path.dart';
import '../../domain/last_message.dart';
import 'product_chat_list_tile.dart';

class ChatsListScreen extends ConsumerWidget {
  ChatsListScreen({Key? key}) : super(key: key);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    final chatPathListValue = ref.watch(chatPathsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: CustomScrollView(controller: _scrollController, slivers: [
        ResponsiveSliverCenter(
          child: AsyncValueWidget<List<ChatPath>>(
              value: chatPathListValue,
              data: (chatPaths) {
                return chatPaths.isEmpty
                    ? const Center(
                        child: Text('Chats is empty'),
                      )
                    : GridLayout(
                        rowGap: 05,
                        rowsCount: 1,
                        itemCount: chatPaths.length,
                        itemBuilder: (_, index) {
                          final chatPath = chatPaths[index];

                          final productValue = ref
                              .watch(productStreamProvider(chatPath.productId));

                          return AsyncValueWidget<Product>(
                              value: productValue,
                              data: (product) {
                                final userInfoValue = ref
                                    .watch(sellerInfoProvider(product.ownerId));
                                final productCustomer = ProductCustomerModel(
                                    product: product,
                                    customerId: chatPath.senderId);
                                return AsyncValueWidget<AppUser?>(
                                  value: userInfoValue,
                                  data: (user) => ProductChatListTile(
                                    onTap: () {
                                      ref
                                          .read(chatSenderIdProvider.state)
                                          .state = chatPath.senderId;
                                      context.pushNamed(AppRoute.chat.name,
                                          params: {
                                            'customerId': chatPath.senderId
                                          },
                                          extra: product);
                                    },
                                    sellerImageUrl: user!.photoUrl != null ||
                                            user.photoUrl == ""
                                        ? user.photoUrl
                                        : null,
                                    isActive: true,
                                    isActivity: false,
                                    isSeen: false,
                                    product: product,
                                    lastMessage: null,
                                    timeAgo: null,
                                    productCutomer: productCustomer,
                                  ),
                                );
                              });
                        });
              }),
        ),
      ]),
    );
  }
}

//






