import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/api_path.dart';
import '../../../services/firestore_service.dart';
import '../../authentication/domain/app_user.dart';
import '../domain/product.dart';

abstract class ProductDatabase {
  Future<void> setProduct(Product product);
  Future<void> deleteProduct(Product product);
  Stream<Product?> watchProduct({required String productId});
  Stream<List<Product?>> watchProductsList();
}

String listingIdFromCurrentDate() => DateTime.now().toIso8601String();

class ProductsRepository implements ProductDatabase {
  ProductsRepository({this.addDelay = true});
  final bool addDelay;
  // FirestoreDatabase({required this.uid});
  // final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setProduct(Product product) => _service.setData(
        path: APIPath.listing(product.id),
        data: product.toMap(),
      );

  @override
  Future<void> deleteProduct(Product product) => _service.deleteData(
        path: APIPath.listing(product.id),
      );

  @override
  Stream<Product?> watchProduct({required String productId}) =>
      _service.documentStream<Product>(
        path: APIPath.listing(productId),
        builder: (data, documentId) => Product.fromMap(data, documentId),
      );

  @override
  Stream<List<Product>> watchProductsList() =>
      _service.collectionStream<Product>(
        path: APIPath.listings(),
        builder: (data, documentId) => Product.fromMap(data, documentId),
      );
}

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepository();
});

///watch the product list
final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
});

///watch single product
final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(productId: id);
});
