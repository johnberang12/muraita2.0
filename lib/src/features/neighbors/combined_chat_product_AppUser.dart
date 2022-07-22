// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/data/users_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:rxdart/rxdart.dart';

import 'package:muraita_2_0/src/common_widgets/custom_image.dart';
import 'package:muraita_2_0/src/common_widgets/grid_layout.dart';
import 'package:muraita_2_0/src/features/chats/data/chat_repository.dart';

import '../../common_widgets/responsive_center.dart';
import '../authentication/domain/app_user.dart';
import '../chats/domain/chat.dart';
import '../products/data/products_repository.dart';
import '../products/domain/product.dart';

///combine chat and product objects

class UserProduct {
  final String productId;
  final String productOwnerId;
  final String productImageUrl;
  final String productTitle;
  final String userId;
  final String userLocation;
  final String userName;
  final String userPhotoUrl;

  UserProduct(
      {required this.productId,
      required this.productOwnerId,
      required this.productImageUrl,
      required this.productTitle,
      required this.userId,
      required this.userLocation,
      required this.userName,
      required this.userPhotoUrl});
}

class ChatListViewModel {
  ChatListViewModel({
    required this.ref,
  });
  Ref ref;

  // Stream<List<UserProduct>> productChats(Product product) {
  //   final productDb = ProductsRepository();
  //   final userDb = UsersRepository(ref: ref);

  //   return Rx.combineLatest2(productDb.watchProductsList(), userDb.watchUsers(),
  //       (List<Product> products, List<AppUser> appUsers) {
  //     return products.map((product) {
  //       final appUser = appUsers.firstWhere(
  //         (appUser) => appUser.uid == product.ownerId,
  //       );
  //       return UserProduct(
  //           productId: product.id,
  //           productOwnerId: product.ownerId,
  //           productImageUrl: product.photos[0],
  //           productTitle: product.title,
  //           userId: appUser.uid,
  //           userLocation: appUser.userLocation,
  //           userName: appUser.displayName!,
  //           userPhotoUrl: appUser.photoUrl!);
  //     }).toList();
  //   });
  // }
}

final chatListViewModelProvider =
    Provider<ChatListViewModel>((ref) => ChatListViewModel(ref: ref));

// final productChatsStreamProvider = StreamProvider.autoDispose
//     .family<List<UserProduct>, Product>((ref, product) {
//   final repository = ref.watch(chatListViewModelProvider);
//   return repository.productChats(product);
// });


// final sellerFilteredProductsStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
//   final sellerId = ref.watch(sellerIdProvider); // a StreamProvider
//   final productStatus = ref.watch(productStatusProvider); // another StreamProvider
//   if (sellerId.hasValue && productStatus.hasValue) {
//   final repository = ref.watch(productsRepositoryProvider);   
// return repository.watchSellersProductsByStatus(       sellerId: sellerId.value, productStatus: productStatus.value); });
//   } else {
//     // no value yet
//     return Stream.empty();
//   }
// });