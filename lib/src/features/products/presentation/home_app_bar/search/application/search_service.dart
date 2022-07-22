// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
// import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/search/data/local/locat_search_repository.dart';
// import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/search/data/remote/remote_search_repository.dart';
// import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/search/domain/mutable_search.dart';

// import '../domain/search.dart';

// class SearchService {
//   SearchService(this.ref);
//   final Ref ref;

//   Future<Search> _fetchLocalSearch() async {
//     return ref.read(localSearchRepositoryProvider).fetchSearch();
//   }

//   ///save search to the local or remote repository
//   Future<void> _setLocalSearch(Search search) async {
//     await ref.read(localSearchRepositoryProvider).setSearch(search);
//   }

//   Future<void> removeLocalItemById(SearchID searchId) async {
//     final search = await _fetchLocalSearch();
//     final updated = search.removeItemById(searchId);
//     await _setLocalSearch(updated);
//   }

//   Future<void> _setRemoteSearch(Search search) async {
//     await ref.read(remoteSearchRepositoryProvider).setSearch(search);
//   }

// //   Future<void> removeRemoteItemById(SearchID searchId) async {
// //     final search = await _fetchRemoteSearch();
// //     final updated = search.removeItemById(searchId);
// //     await _setLocalSearch(updated);
// //   }
// }

// final searchServiceProvider = Provider<SearchService>((ref) {
//   return SearchService(ref);
// });

// final localSearchProvider = StreamProvider<Search>((ref) {
//   return ref.watch(localSearchRepositoryProvider).watchSearch();
// });
