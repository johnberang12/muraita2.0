import 'dart:math';

import '../features/products/data/products_repository.dart';

class APIPath {
  ///to be changed with product
  static String listing(String listingId) => 'listings/$listingId';
  static String listings() => 'listings';

  ///search path
  static String searches() => 'searches';

  ///users path
  static String user(String userId) => 'users/$userId';
  static String users() => 'users';

  ///favouites
  static String favourite(String userId, String favouriteId) =>
      'users/$userId/favourites/$favouriteId';
  static String favourites(String userId) => 'users/$userId/favourites';

  ///product chats paths
  static String chatToProduct(
          {required String listingId,
          required String sellerId,
          required String customerId,
          required String chatId}) =>
      'listings/$listingId/messages/$sellerId/customers/$customerId/chats/$chatId';

  static String productChatLastMessage({
    required String listingId,
    required String sellerId,
    required String customerId,
  }) =>
      'listings/$listingId/messages/$sellerId/customers/$customerId';

  static String productChats(
          {required String listingId,
          required String sellerId,
          required String customerId}) =>
      'listings/$listingId/messages/$sellerId/customers/$customerId/chats';

  static String productChatCollection(
          String listingId, String sellerId, String customerId) =>
      'listings/$listingId/messages/$sellerId/customers/$customerId';

  ///product chat reference paths
  static String productReferenceChatToSelf(
          {required String userId, required String productId}) =>
      'users/$userId/messages/productChat/chats/$productId';

  // static String referenceProductChatToSelfCollection(String userId) =>
  //     'users/$userId/messages/productChat';

  static String productReferenceChatToSeller(
          {required String sellerId, required String productId}) =>
      'users/$sellerId/messages/productChat/chats/$productId';

  // static String referenceChatToSellerCollection(String sellerId) =>
  //     'users/$sellerId/messages/productChat';

  static String productReferenceChats({required String userId}) =>
      'users/$userId/messages/productChat/chats';

  static String productChatList(
          {required String listingId, required String sellerId}) =>
      'listings/$listingId/messages/$sellerId/customers';

  ///person to person chat paths
  static String chatPath(String userId, String chatPathId) =>
      'users/$userId/chatPaths/$chatPathId';

  static String chatPaths(String userId) => 'users/$userId/chatPaths';

  static String messages({required String listingId}) =>
      'listings/$listingId/messages';

  ///test path for experiment
  static String products() => 'products';

  ///path to firebase storage
  ///profile picture
  static String profileImagePath(String userId) =>
      'users/profile/$userId/${productIdFromCurrentDate()}.jpg';

  ///product images
  static String productImagePath(
          String userId, String category, String dateTime) =>
      'products/$userId/$category/$dateTime/${Random().nextInt(10000)}.jpg';
}

class DocKey {
  static String ownerId() => 'ownerId';
  static String productId() => 'id';
  static String productStatus() => 'status';
}
