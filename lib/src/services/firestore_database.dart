import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/products/domain/listing.dart';
import '../utils/delay.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Future<void> setListing(Listing listing);
  Future<void> deleteListing(Listing listing);
  Stream<Listing?> watchListing({required String listingId});
  Stream<List<Listing?>> watchListingsList();
}

String listingIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({this.addDelay = true});
  final bool addDelay;
  // FirestoreDatabase({required this.uid});
  // final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setListing(Listing listing) => _service.setData(
        path: APIPath.listing(listing.id),
        data: listing.toMap(),
      );

  @override
  Future<void> deleteListing(Listing listing) => _service.deleteData(
        path: APIPath.listing(listing.id),
      );

  @override
  Stream<Listing?> watchListing({required String listingId}) =>
      _service.documentStream<Listing>(
        path: APIPath.listing(listingId),
        builder: (data, documentId) => Listing.fromMap(data, documentId),
      );

  @override
  Stream<List<Listing?>> watchListingsList() =>
      _service.collectionStream<Listing>(
        path: APIPath.listings(),
        builder: (data, documentId) => Listing.fromMap(data, documentId),
      );
}

final productsRepositoryProvider = Provider<FirestoreDatabase>((ref) {
  return FirestoreDatabase();
});

///watch the product list
final listingsListStreamProvider = StreamProvider.autoDispose((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchListingsList();
});

///watch single product
final listingProvider =
    StreamProvider.autoDispose.family<Listing?, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchListing(listingId: id);
});
