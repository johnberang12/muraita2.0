// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/camera_repository.dart';

class ImageProfileCameraController {
  ImageProfileCameraController({
    required this.ref,
  });
  Ref ref;

  Future<void> pickFile(BuildContext context) async {
    final repository = ref.watch(cameraRepositoryProvider);
    final image = await repository.pickGalleryImage();
    ref.read(pickedProfileImageProvider.state).state = image;
    Navigator.of(context).pop();
  }

  Future<void> captureImage(BuildContext context) async {
    final repository = ref.watch(cameraRepositoryProvider);
    final image = await repository.takeImage();
    ref.read(pickedProfileImageProvider.state).state = image;
    Navigator.of(context).pop();
  }
}

final imageProfileCameraControllerProvider =
    Provider<ImageProfileCameraController>(
        (ref) => ImageProfileCameraController(ref: ref));

final pickedProfileImageProvider = StateProvider.autoDispose<File?>((ref) {
  File? file;
  return file;
});
