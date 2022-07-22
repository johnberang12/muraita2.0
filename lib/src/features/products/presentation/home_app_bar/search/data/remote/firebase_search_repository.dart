import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/search/data/remote/remote_search_repository.dart';

import '../../../../../../../services/api_path.dart';
import '../../../../../../../services/firestore_service.dart';
import '../../domain/search.dart';

class FirebaseSearchRepository implements RemoteSearchRepository {
  final _service = FirestoreService.instance;

  @override
  Stream<List<Search>> watchSearch() => _service.collectionStream<Search>(
        path: APIPath.searches(),
        builder: (data, _) => Search.fromMap(data),
      );

  @override
  Future<void> setSearch(Search search) => _service.setData(
        path: APIPath.searches(),
        data: search.toMap(),
      );
}

final remoteSearchRepositoryProvider = Provider<RemoteSearchRepository>((ref) {
  throw UnimplementedError();
});
