// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/products/data/products_repository.dart';

import '../../data/local/sql_search_repository.dart';
import '../../domain/search.dart';

class SearchController {
  SearchController({
    required this.ref,
  });
  Ref ref;

  Future<void> onSubmitValue(VoidCallback onPopScreen) async {
    final localRepository = ref.watch(searchRepositoryProvider);
    final searchValue = ref.read(searchValueProvider.state).state;
    final fireRepository = ref.watch(productsRepositoryProvider);
    final search = Search(id: productIdFromCurrentDate(), title: searchValue);
    await fireRepository.addSearch(search);
    await localRepository.addSearch(searchValue);
    // ref.read(searchValueProvider.state).state = '';
    ref.read(searchEditingControllerProvider).clear();
    ref.refresh(searchListFutureProvider);

    ///TODO: filter the search list

    onPopScreen();
  }

  void onEditing(
    String value,
  ) {
    ref.read(searchValueProvider.state).state = value;
  }
}

final searchConrollerProvider =
    Provider<SearchController>((ref) => SearchController(ref: ref));

final searchValueProvider = StateProvider.autoDispose<String>((ref) {
  final controller = ref.watch(searchEditingControllerProvider);
  return controller.text;
});

final searchEditingControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());

final searchSubmittedProvider = StateProvider.autoDispose<bool>((ref) => false);
