import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../products/domain/product.dart';
import '../../domain/chat.dart';
import 'chat_screen_controller.dart';

class ChatListView extends ConsumerStatefulWidget {
  const ChatListView({
    Key? key,
    required this.chats,
    required this.scrollController,
    required this.height,
    required this.product,
  }) : super(key: key);

  final List<Chat> chats;
  final ScrollController scrollController;
  final double height;
  final Product product;

  @override
  ConsumerState<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends ConsumerState<ChatListView> {
  @override
  void initState() {
    super.initState();
  }

  // bool _needScroll = false;

  // _scrollToEnd() {
  //   widget.scrollController.animateTo(
  //       widget.scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut);
  // }

  @override
  Widget build(BuildContext context) {
    // if (_needScroll) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    //   _needScroll == true;
    // }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = ref.watch(authRepositoryProvider).currentUser;
    final controller = ref.watch(chatScreenControllerProvider);
    return ListView(
      controller: widget.scrollController,
      shrinkWrap: true,
      children: [
        for (var i = 0; i < widget.chats.length; i++)
          i == widget.chats.length + 1
              ? SizedBox(
                  height: height * .20,
                )
              : Container(
                  alignment: widget.chats[i].senderId == user!.uid
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.p16, vertical: 4),
                    child: InkWell(
                      onTap: () => controller.deleteChat(
                          widget.product, widget.chats[i]),
                      child: Card(
                        color: widget.chats[i].senderId == user.uid
                            ? AppColors.primaryHue
                            : AppColors.black40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          child: Text(widget.chats[i].content),
                        ),
                      ),
                    ),
                  )),
      ],
    );
  }
}
