// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/chats/data/chat_repository.dart';
import 'package:muraita_2_0/src/features/chats/domain/chat_path.dart';
import 'package:muraita_2_0/src/features/chats/domain/last_message.dart';
import 'package:muraita_2_0/src/features/chats/domain/product_cutomer_model.dart';
import 'package:muraita_2_0/src/features/products/data/products_repository.dart';
import 'package:muraita_2_0/src/features/products/presentation/add_product/add_product_screen.dart';

import '../../../authentication/presentation/sign_in/string_validators.dart';
import '../../../products/domain/product.dart';
import '../../domain/chat.dart';

mixin ChatValidator {
  final StringValidator chatSubmitValidator = NonEmptyStringValidator();
}

class ChatScreenController with ChatValidator {
  ChatScreenController({
    required this.ref,
  });
  Ref ref;

  bool canSubmitText(String text) {
    return chatSubmitValidator.isValid(text);
  }

  Future<void> sendMessage(
      BuildContext context, ProductCustomerModel productCustomer) async {
    final repository = ref.read(chatRepositoryProvider);
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    final sellerId = productCustomer.product.ownerId;
    final message = ref.read(chatTextFieldValueProvider.state).state;
    final chat = Chat(
      id: documentIdFromCurrentDate(),
      sentTime: currentDateTime(),
      senderId: userId!,
      type: MessageType.text,
      sellerId: sellerId,
      content: message,
    );
    final chatPath = ChatPath(
        productId: productCustomer.product.id,
        sellerId: sellerId,
        senderId: userId,
        lastMessage: message);

    final lastMessage = LastMessage(
        senderId: userId,
        lastMessage: message,
        dateSent: DateTime.now().toUtc(),
        isAcitvity: false,
        isSeen: true);
    if (canSubmitText(message)) {
      try {
        EasyLoading.show();
        // await repository.setChatToProduct(product, chat);
        await repository.setChatToProduct(productCustomer, chat);
        await repository.setChatReference(
            product: productCustomer.product, chatPath: chatPath);
        await repository.setLastMessage(
            productCustomer.product, lastMessage, productCustomer.customerId);
        EasyLoading.dismiss();
        ref.read(chatTextFieldController).clear();
        EasyLoading.showSuccess('Message sent');
      } on FirebaseException catch (e) {
        EasyLoading.dismiss();
        showExceptionAlertDialog(
            context: context, title: kOperationFailed, exception: e);
      }
    }
  }

  Future<void> deleteChat(Product product, Chat chat) async {
    final repository = ref.watch(chatRepositoryProvider);
    await repository.deleteChat(product, chat);
  }

  // Future<void> deleteConversation(Product product, String customerId) async {
  //   final repository = ref.watch(chatRepositoryProvider);
  //   await repository.deleteProductChatCollection(product, customerId);
  //   await repository.deleteChatReference(product);
  // }
}

final chatScreenControllerProvider =
    Provider<ChatScreenController>((ref) => ChatScreenController(ref: ref));

final chatTextFieldValueProvider = StateProvider.autoDispose<String>((ref) {
  final controller = ref.watch(chatTextFieldController);
  return controller.text;
});

final chatTextFieldController =
    StateProvider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());

final isSomoneChattingProvider =
    StateProvider.autoDispose<bool>((ref) => false);
