import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../../domain/search.dart';

abstract class RemoteSearchRepository {
  Stream<List<Search>> watchSearch();
  Future<void> setSearch(Search search);
}

final remoteSearchRepositoryProvider = Provider<RemoteSearchRepository>((ref) {
  throw UnimplementedError();
});
