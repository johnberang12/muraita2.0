import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/chats/data/chat_repository.dart';
import 'package:muraita_2_0/src/features/chats/domain/product_cutomer_model.dart';
import 'package:muraita_2_0/src/features/chats/presentation/chat/product_tab_widget.dart';
import 'package:muraita_2_0/src/features/chats/presentation/chat/typing_indicator.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/strings.dart';
import '../../../../constants/styles.dart';
import '../../../authentication/data/users_repository.dart';
import '../../../authentication/domain/app_user.dart';
import '../../../products/domain/product.dart';
import '../../domain/chat.dart';
import 'chat_input_field.dart';
import 'dart:developer' as dev;

import 'chat_list_view.dart';
import 'chat_screen_controller.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({Key? key, required this.customerId, required this.product})
      : super(key: key);
  final String customerId;
  final Product product;
  bool _typing = false;
  bool _isEmoji = false;

  final _scrollController = ScrollController();
  // Future<void> _deleteConversation(BuildContext context, WidgetRef ref) async {
  //   final confirm = await showAlertDialog(
  //     context: context,
  //     title: 'Are you sure you want to delete this conversation?',
  //     cancelActionText: 'Cancel',
  //     defaultActionText: 'Delete',
  //   );
  //   if (confirm == true) {
  //     final controller = ref.watch(chatScreenControllerProvider);
  //     await controller.deleteConversation(product, customerId);
  //   } else {}
  // }

  Future<bool> _onWillPop() async {
    if (_isEmoji) {
      _isEmoji = false;
    } else {
      // Navigator.of(context).pop();
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sellerInfoValue = ref.watch(sellerInfoProvider(product.ownerId));
    final productCustomer =
        ProductCustomerModel(product: product, customerId: customerId);

    final chatStreamValue = ref.watch(productChatsStreamProvider(product));

    // final repository = ref.watch(chatRepositoryProvider);
    // final isSomeoneChatting = ref.watch(isSomoneChattingProvider.state).state;
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: AsyncValueWidget<AppUser?>(
            value: sellerInfoValue,
            data: (seller) => Text(seller!.displayName!)),
        actions: [
          PopUpMenu(
            menuList: [
              PopupMenuItem(
                  padding: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {},
                      //  => _deleteConversation(context, ref),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 20,
                            color: Theme.of(context).errorColor,
                          ),
                          gapW12,
                          const Text(kDeleteConversation, style: Styles.k12)
                        ],
                      ),
                    ),
                  ))
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
        height: height,
        width: width,
        child: WillPopScope(
          onWillPop: () => _onWillPop(),
          child: Column(children: [
            SizedBox(
              height: height * .12,
              child: ProductTab(product: product),
            ),
            const Divider(height: 5),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AsyncValueWidget<List<Chat>?>(
                        value: chatStreamValue,
                        data: (chats) {
                          return chats!.isEmpty
                              ? const Center(
                                  child: Text(
                                  'Start conversation',
                                ))
                              : ChatListView(
                                  chats: chats,
                                  scrollController: _scrollController,
                                  height: height,
                                  product: product,
                                );
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ChatInputField(
                        productCustomer: productCustomer,
                        scrollController: _scrollController),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
      // bottomNavigationBar: Container(
      //     padding: MediaQuery.of(context).viewInsets,
      //     color: Colors.grey[300],
      //     child: Container(
      //       // padding: EdgeInsets.symmetric(vertical: 2),
      //       // margin: EdgeInsets.symmetric(horizontal: 5),
      //       child: SizedBox(
      //           height: height * .08,
      //           child:
      //               // SizedBox()

      //               ChatInputField(
      //                   productCustomer: productCustomer,
      //                   scrollController: _scrollController)
      //                   ),
      //     ))
    );
  }
}

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({Key? key, required this.menuList, required this.icon})
      : super(key: key);
  final List<PopupMenuEntry> menuList;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // offset: const Offset(50, 100),
      constraints: const BoxConstraints(maxWidth: 170),

      padding: const EdgeInsets.all(0),
      itemBuilder: ((context) => menuList),
      icon: icon,
      onSelected: ((value) => print(value)),
    );
  }
}



    // padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).viewInsets.bottom),










      // child: StreamBuilder<List<Chat>>(
      //             stream: repository.watchProductChats(product, customerId),

      //             // FirebaseFirestore.instance
      //             //     .collection(
      //             //         'listings/${productCustomer.product.id}/messages/${productCustomer.product.ownerId}'
      //             //         '/customers/${productCustomer.customerId}/chats')
      //             //     .snapshots(),
      //             builder: (context, snapshot) {
      //               print(snapshot.data);

      //               // dev.debugger();
      //               if (snapshot.hasError) {
      //                 return Center(child: Text(snapshot.error.toString()));
      //               } else if (snapshot.connectionState ==
      //                   ConnectionState.waiting) {
      //                 return const Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               } else {
      //                 final chats = snapshot.data!;

      //                 return ListView(
      //                   shrinkWrap: true,
      //                   children: [
      //                     for (var i = 0; i < chats.length; i++)
      //                       Text(chats[i].content)
      //                   ],
      //                 );
      //               }
      //             },
      //           ),