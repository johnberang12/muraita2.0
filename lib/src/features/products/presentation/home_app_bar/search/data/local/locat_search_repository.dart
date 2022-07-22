import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/search.dart';

abstract class LocalSearchRepository {
  Future<Search> fetchSearch();
  Stream<Search> watchSearch();
  Future<void> setSearch(Search search);
}

final localSearchRepositoryProvider = Provider<LocalSearchRepository>((ref) {
  throw UnimplementedError();
});
