import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';

final pickedProfileImageProvider = StateProvider.autoDispose<File?>((ref) {
  File? file;
  return file;
});

final nameStringProvider = StateProvider.autoDispose<String?>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  final name = auth.currentUser?.displayName;
  return name;
});

final isSubmittedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final saveLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
