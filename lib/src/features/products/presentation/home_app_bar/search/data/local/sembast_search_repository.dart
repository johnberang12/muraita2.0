// import 'package:flutter/foundation.dart';
// import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/search/data/local/locat_search_repository.dart';
// import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/search/domain/search.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';
// import 'package:sembast_web/sembast_web.dart';

// class SembastSearchRepository implements LocalSearchRepository {
//   SembastSearchRepository(this.db);
//   final Database db;
//   final store = StoreRef.main();

//   static Future<Database> createDatabase(String filename) async {
//     if (!kIsWeb) {
//       final appDir = await getApplicationDocumentsDirectory();
//       return databaseFactoryIo.openDatabase('${appDir.path}/$filename');
//     } else {
//       return databaseFactoryWeb.openDatabase(filename);
//     }
//   }

//   static Future<SembastSearchRepository> makeDefault() async {
//     return SembastSearchRepository(await createDatabase('default.db'));
//   }

//   static const searchItemsKey = 'cartItems';

//   @override
//   Future<Search> fetchSearch() async {
//     final cartJson = await store.record(searchItemsKey).get(db) as String;
//     if (cartJson != null) {
//       return Search.fromJson(cartJson);
//     } else {
//       return const Search();
//     }
//   }

//   @override
//   Future<void> setSearch(Search search) async {
//     return store.record(searchItemsKey).put(db, search.toJson());
//   }

//   @override
//   Stream<Search> watchSearch() {
//     final record = store.record(searchItemsKey);
//     return record.onSnapshot(db).map((snapshot) {
//       if (snapshot != null) {
//         return Search.fromJson(snapshot.value);
//       } else {
//         return const Search();
//       }
//     });
//   }
// }
