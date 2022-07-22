// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/chats/domain/last_message.dart';
import 'package:muraita_2_0/src/features/chats/domain/product_cutomer_model.dart';
import 'package:muraita_2_0/src/features/products/data/products_repository.dart';
import 'package:muraita_2_0/src/services/api_path.dart';
import '../../../services/firestore_service.dart';
import '../../products/domain/product.dart';
import '../domain/chat.dart';
import '../domain/chat_path.dart';

abstract class ChatBase {
  Future<void> setChatToProduct(
      ProductCustomerModel productCustomer, Chat chat);
  // Future<void> setChatToSeller(Product product, Chat chat);
  Future<void> deleteChat(Product product, Chat chat);
  // Stream<List<Chat>> watchProductChats(Product product);
  // // Stream<List<Chat>> watchMessages(Product product);
  // Stream<List<Chat>> watchChatList(Product product);
  // Stream<List<Chat>> watchProductChats(ProductCustomerModel productCustomer);
}

class ChatsRepository implements ChatBase {
  ChatsRepository({
    required this.ref,
  });
  Ref ref;

  final _service = FirestoreService.instance;
  @override
  Future<void> setChatToProduct(
      ProductCustomerModel productCustomer, Chat chat) {
    return _service.setData(
      path: APIPath.chatToProduct(
          listingId: productCustomer.product.id,
          sellerId: productCustomer.product.ownerId,
          customerId: productCustomer.customerId,
          chatId: chat.id),
      data: chat.toMap(),
    );
  }

  Future<void> setLastMessage(
    Product product,
    LastMessage lastMessage,
    String customerId,
  ) async {
    final path = APIPath.productChatLastMessage(
        listingId: product.id,
        sellerId: product.ownerId,
        customerId: customerId);
    final reference = FirebaseFirestore.instance.doc(path);
    final productRepo = ref.watch(productsRepositoryProvider);
    await reference.get().then((document) async {
      if (document.exists) {
        await reference.update({
          'dateSent': Timestamp.fromDate(DateTime.now().toUtc()),
          'lastMessage': lastMessage.lastMessage
        });
      } else {
        await reference.set(lastMessage.toMap());
        await productRepo.updateMessageCount(product: product);
      }
    });
  }

  @override
  Future<void> deleteChat(Product product, Chat chat) {
    // final user = ref.read(authRepositoryProvider).currentUser;
    return _service.deleteData(
        path: APIPath.chatToProduct(
            listingId: product.id,
            sellerId: product.ownerId,
            customerId: chat.senderId,
            chatId: chat.id));
  }

  Future<void> deleteProductChatCollection(
      Product product, String customerId) async {
    _service.deleteData(
        path: APIPath.productChatCollection(
            product.id, product.ownerId, customerId));
  }

  // Future<void> deleteChatReference(Product product) async {
  //   final user = ref.read(authRepositoryProvider).currentUser;
  //   await _service.deleteData(
  //       path: APIPath.referenceProductChatToSelfCollection(user!.uid));
  //   await _service.deleteData(
  //       path: APIPath.referenceChatToSellerCollection(product.ownerId));
  // }

  Future<void> setChatReference(
      {required Product product, required ChatPath chatPath}) async {
    await _setChatRefIfExist(product: product, chatPath: chatPath);
    await _setChatRefIfExistToSeller(product: product, chatPath: chatPath);
  }

  ///create chat path if path is empty and update last message if path exist
  Future<void> _setChatRefIfExist(
      {required Product product, required ChatPath chatPath}) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    final path = APIPath.productReferenceChatToSelf(
        userId: user!.uid, productId: product.id);
    final reference = FirebaseFirestore.instance.doc(path);
    final productRepo = ref.watch(productsRepositoryProvider);
    reference.get().then((document) async {
      if (document.exists) {
        await reference.update({
          'lastMessage': chatPath.lastMessage,
        });
      } else {
        await reference.set(chatPath.toMap());
        await productRepo.updateMessageCount(product: product);
      }
    });
  }

  Future<void> _setChatRefIfExistToSeller(
      {required Product product, required ChatPath chatPath}) async {
    final path = APIPath.productReferenceChatToSeller(
      sellerId: product.ownerId,
      productId: product.id,
    );
    final reference = FirebaseFirestore.instance.doc(path);
    reference.get().then((doc) async {
      if (doc.exists) {
        await reference.update({'lastMessage': chatPath.lastMessage});
      } else {
        await reference.set(chatPath.toMap());
      }
    });
  }

  Future<void> updateUserLastSeen(String userId) async {
    return _service.updateDoc(
        path: APIPath.user(userId), data: {'lastSeen': DateTime.now().toUtc()});
  }

  Stream<LastMessage> watchProductLastMessage(
      Product product, String customerId) {
    return _service.documentStream<LastMessage>(
        path: APIPath.productChatLastMessage(
            listingId: product.id,
            sellerId: product.ownerId,
            customerId: customerId),
        builder: (data, documentId) => LastMessage.fromMap(data, documentId));
  }

  ///reads the chat references
  Stream<List<ChatPath>> watchChatReference() {
    final user = ref.read(authRepositoryProvider).currentUser;
    return _service.collectionStream(
      path: APIPath.productReferenceChats(userId: user!.uid),
      builder: (data, documentId) => ChatPath.fromMap(data, documentId),
    );
  }

  Stream<List<Chat>> watchProductChats(Product product, String customerId) {
    // final user = ref.read(authRepositoryProvider).currentUser;
    return _service.collectionStream(
      path: APIPath.productChats(
          listingId: product.id,
          sellerId: product.ownerId,
          customerId: customerId),
      builder: (data, documentId) => Chat.fromMap(data, documentId),
    );
  }
}

final chatRepositoryProvider =
    Provider<ChatsRepository>((ref) => ChatsRepository(ref: ref));

final productChatsStreamProvider =
    StreamProvider.autoDispose.family<List<Chat>, Product>((ref, product) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  final repository = ref.watch(chatRepositoryProvider);
  final customerId = ref.watch(chatSenderIdProvider.state).state;
  return repository.watchProductChats(product, customerId ?? user!.uid);
});

final chatPathsStreamProvider =
    StreamProvider.autoDispose<List<ChatPath>>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.watchChatReference();
});

final productChatLastMessageProvider = StreamProvider.autoDispose
    .family<LastMessage, ProductCustomerModel>((ref, productCustomer) {
  final repo = ref.watch(chatRepositoryProvider);
  final customerId = ref.read(chatSenderIdProvider.state).state;
  return repo.watchProductLastMessage(
      productCustomer.product, productCustomer.customerId);
});

final selectedProductIdProvider = StateProvider.autoDispose<String?>((ref) {
  String? productId;
  return productId!;
});

final chatSenderIdProvider = StateProvider<String?>((ref) {
  String? senderId;
  return senderId;
});





// APIPath.productChats(
//           listingId: productCustomer.product.id,
//           sellerId: productCustomer.product.ownerId,
//           customerId: productCustomer.customerId)