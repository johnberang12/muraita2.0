import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchValueProvider = StateProvider.autoDispose<String>((ref) {
  final controller = ref.watch(searchControllerProvider);
  return controller.text;
});

final searchControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());

final searchSubmittedProvider = StateProvider.autoDispose<bool>((ref) => false);
