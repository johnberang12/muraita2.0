import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muraita_2_0/src/common_widgets/outlined_text_field.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/features/chats/domain/product_cutomer_model.dart';

import '../../../../constants/app_sizes.dart';
import '../../../products/domain/product.dart';
import 'chat_screen_controller.dart';

class ChatInputField extends ConsumerStatefulWidget {
  ChatInputField(
      {Key? key, required this.productCustomer, required this.scrollController})
      : super(key: key);
  final ProductCustomerModel productCustomer;
  final ScrollController scrollController;

  @override
  ConsumerState<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends ConsumerState<ChatInputField> {
  final FocusNode focusNode = FocusNode();

  bool isEmoji = false;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isEmoji = false;
        });
      }
    });
  }

  void _pressImoji() {
    setState(() {
      isEmoji = !isEmoji;
    });
  }

  Future<void> _sendMessage(BuildContext context, WidgetRef ref) async {
    ref.read(isSomoneChattingProvider.state).state = false;
    final controller = ref.watch(chatScreenControllerProvider);
    await controller.sendMessage(context, widget.productCustomer);
    ref.read(chatTextFieldValueProvider.state).state = '';
    widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  void _onChanged(String value, WidgetRef ref) {
    ref.read(isSomoneChattingProvider.state).state = true;
    ref.read(chatTextFieldValueProvider.state).state = value;
    print('chat is => ${ref.read(chatTextFieldValueProvider.state).state}');
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    final chat = ref.watch(chatTextFieldValueProvider.state).state;
    print('chat is => $chat');
    final controller = ref.watch(chatScreenControllerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(children: [
          IconButton(
            onPressed: () {
              ///TODO: show camera and image button
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.p4,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: ref.watch(chatTextFieldController.state).state,
                    focusNode: focusNode,
                    onChanged: (value) => _onChanged(value, ref),
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a message',
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: AppColors.primaryHue,
                        ),
                        onPressed: () => _pressImoji(),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: Sizes.p12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed:
                chat.isNotEmpty ? () => _sendMessage(context, ref) : null,
            icon: Icon(
              Icons.send,
              color: chat.isNotEmpty ? AppColors.primaryHue : null,
            ),
          ),
        ]),
        // isEmoji ? const EmojiSelect() : const SizedBox(),
      ],
    );
  }
}

// class EmojiSelect extends ConsumerWidget {
//   const EmojiSelect({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   return EmojiPicker(onEmojiSelected: (emoji, category) => print('emoji'));
  // }
// }
