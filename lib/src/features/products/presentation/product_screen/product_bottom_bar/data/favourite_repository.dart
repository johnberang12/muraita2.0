// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/services/api_path.dart';
import '../../../../../../services/firestore_service.dart';
import '../../../../domain/product.dart';
import '../domain/favourite.dart';

abstract class FavouriteBase {
  Future<void> setFavourite({required Favourite favourite});
}

class FavouriteRepository implements FavouriteBase {
  FavouriteRepository({
    required this.ref,
  });
  Ref ref;

  final _service = FirestoreService.instance;
  @override
  Future<void> setFavourite({required Favourite favourite}) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.setData(
        path: APIPath.favourite(user!.uid, favourite.productId),
        data: {'isFavourite': favourite.isFavourite});
  }

  Stream<Favourite> watchFavourite(Product product) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.documentStream(
      path: APIPath.favourite(user!.uid, product.id),
      builder: (data, documentId) => Favourite.fromMap(data, documentId),
    );
  }

  Stream<List<Favourite>> watchFavouriteList() {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.collectionStream(
      path: APIPath.favourites(user!.uid),
      builder: (data, documentId) => Favourite.fromMap(data, documentId),
    );
  }
}

final favouriteRepositoryProvider =
    Provider<FavouriteRepository>((ref) => FavouriteRepository(ref: ref));

final favouriteStreamProvider =
    StreamProvider.autoDispose.family<Favourite, Product>((ref, product) {
  final controller = ref.watch(favouriteRepositoryProvider);
  return controller.watchFavourite(product);
});

final favouriteListStreamProvider =
    StreamProvider.autoDispose<List<Favourite>>((ref) {
  final controller = ref.watch(favouriteRepositoryProvider);
  return controller.watchFavouriteList();
});
