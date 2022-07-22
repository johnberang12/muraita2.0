import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/chats/domain/chat_path.dart';
import '../../../services/api_path.dart';
import '../../../services/firestore_service.dart';
import '../domain/product.dart';
import '../presentation/home_app_bar/search/domain/search.dart';

abstract class ProductBase {
  Future<void> setProduct(Product product);
  Future<void> deleteProduct(Product product);
  Stream<Product?> watchProduct({required String productId});
  Stream<List<Product>> watchProductsList();
  Future<void> addSearch(Search search);
  Stream<List<Product>> watchAllSellersProducts({required String sellerId});
  Stream<List<Product>> watchSellersProductsByStatus(
      {required String sellerId, required String productStatus});
}

String productIdFromCurrentDate() => DateTime.now().toIso8601String();
String idFromCurrentDate() => DateTime.now().toString();

class ProductsRepository implements ProductBase {
  ProductsRepository({this.addDelay = true, required this.ref});
  final bool addDelay;
  Ref ref;

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

  Future<void> updateMessageCount({required Product product}) {
    return _service.updateDoc(
        path: APIPath.listing(product.id),
        data: {'messageCount': product.messageCount++});
  }

  @override
  Stream<Product> watchProduct({required String productId}) =>
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

  @override
  Future<void> addSearch(Search search) =>
      _service.addCollection(path: APIPath.searches(), data: search.toMap());

  @override
  Stream<List<Product>> watchAllSellersProducts({required String sellerId}) =>
      _service.filteredCollectionStream(
          path: APIPath.listings(),
          fieldKey: DocKey.ownerId(),
          fieldValue: sellerId,
          builder: (data, documentId) => Product.fromMap(data, documentId));

  @override
  Stream<List<Product>> watchSellersProductsByStatus(
      {required String sellerId, required String productStatus}) {
    return _service.filteredCollectionWidCondition(
        path: APIPath.listings(),
        primaryFieldKey: DocKey.ownerId(),
        primaryFieldValue: sellerId,
        secondaryFieldKey: DocKey.productStatus(),
        secondaryFieldValue: productStatus,
        builder: (data, documentId) => Product.fromMap(data, documentId));
  }

  Stream<List> watchProductMessages(Product product) {
    // final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.collectionStream(
        path: APIPath.productChatList(
            listingId: product.id, sellerId: product.ownerId),
        builder: (data, documentId) => ChatPath.fromMap(data, documentId));
  }
}

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepository(ref: ref);
});

///watch the product list
final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
});

///watch single product
final productStreamProvider =
    StreamProvider.autoDispose.family<Product, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(productId: id);
});

final sellerAllProductsStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  final sellerId = ref.watch(productOwnerIdProvider);
  return repository.watchAllSellersProducts(sellerId: sellerId!);
});

final sellerFilteredProductsStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  final sellerId = ref.read(productOwnerIdProvider);
  final productStatus = ref.watch(productStatusProvider);
  return repository.watchSellersProductsByStatus(
      sellerId: sellerId!, productStatus: productStatus!);
});

final productMessageCountStreamProvider =
    StreamProvider.autoDispose.family<List, Product>((ref, product) {
  final repo = ref.watch(productsRepositoryProvider);
  return repo.watchProductMessages(product);
});

final productOwnerIdProvider = StateProvider<String?>((ref) {
  String? ownerId;
  return ownerId;
});

final productStatusProvider = StateProvider<String?>((ref) {
  String? productStatus;
  return productStatus;
});
