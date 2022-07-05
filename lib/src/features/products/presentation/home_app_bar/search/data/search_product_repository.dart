import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../../common_widgets/alert_dialogs.dart';
import '../../../../../../services/local_db/sqflite.dart';

import '../domain/search.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class SearchRepository {
  final _db = SQLite.instance;

  Future<List> fetchSearches() async {
    final searches = await _db.getAll(table: 'productSearch');
    List searchList = await searches
        .map((search) => Search(id: search['id'], title: search['name']))
        .toList();
    return searchList;
  }

  Future<void> addSearch(context, name) async {
    try {
      await _db.saveData(
          table: 'productSearch',
          data: Search(id: DateTime.now().toString(), title: name),
          conflictAlgo: ConflictAlgorithm.replace);
      print('save data pressed');
    } on Exception catch (e) {
      showExceptionAlertDialog(
          context: context, title: 'Operation Failed', exception: e);
    }
  }

  Future<void> deleteItem(context, id) async {
    try {
      await _db.delete(table: 'productSearch', id: id);
    } on Exception catch (e) {
      showExceptionAlertDialog(
          context: context, title: 'Operation Failed', exception: e);
    }
  }

  Future<void> searchItem(String searchTitle) async {
    ///TODO: implement search item
  }
}

final searchRepositoryProvider =
    Provider<SearchRepository>((ref) => SearchRepository());

final searchListFutureProvider = FutureProvider<List>((ref) async {
  final controller = ref.watch(searchRepositoryProvider);
  List searches = await controller.fetchSearches();

  return searches;
});
