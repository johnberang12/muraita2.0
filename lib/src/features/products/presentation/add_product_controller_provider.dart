import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final productImageListProvider = StateProvider.autoDispose<List<File>>((ref) {
  List<File> files = [];
  return files;
});

final pickedImageCountProvider = StateProvider.autoDispose<int>((ref) => 0);
