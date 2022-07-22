// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/favourite_repository.dart';
import '../domain/favourite.dart';

class ProductBottomBarController {
  ProductBottomBarController({
    required this.ref,
  });
  Ref ref;

  Future<void> setFavourite(String productId, bool isFavourite) async {
    final repo = ref.watch(favouriteRepositoryProvider);
    final favourite = Favourite(
      productId: productId,
      isFavourite: isFavourite,
    );
    await repo.setFavourite(favourite: favourite);
  }
}

final productBottomBarControllerProvider = Provider<ProductBottomBarController>(
    (ref) => ProductBottomBarController(ref: ref));
