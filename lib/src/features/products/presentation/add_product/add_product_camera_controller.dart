// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/data/camera_repository.dart';
import 'package:path_provider/path_provider.dart';

class ProductImagesCameraController {
  ProductImagesCameraController({
    required this.ref,
  });
  Ref ref;

  Future<void> takeCameraShot(BuildContext context) async {
    final repository = ref.watch(cameraRepositoryProvider);
    final image = await repository.takeImage();
    final imageCount = ref.read(productImageListProvider.state).state.length;
    if (imageCount < kmaxImageCount) {
      ref.read(productImageListProvider.state).state.add(image!);
      ref.refresh(productImageListProvider.state).state;
      ref.refresh(pickedImageCountProvider.state).state;
      await saveFilePermanently(image);
      Navigator.of(context).pop();
    }
  }

  Future<void> pickGalleryImages(BuildContext context) async {
    final repository = ref.watch(cameraRepositoryProvider);
    final images = await repository.pickMultipleImages();
    print('images length is => ${images?.length}');

    ref.read(productImageListProvider.state).state.addAll(images!);
    ref.refresh(productImageListProvider.state).state;
    ref.refresh(pickedImageCountProvider.state).state;
    Navigator.of(context).pop();
  }

  Future<File> saveFilePermanently(File file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = '$appStorage/$file';
    return File(file.path).copy(newFile);
  }
}

final productImagesCameraControllerProvider =
    Provider<ProductImagesCameraController>(
        (ref) => ProductImagesCameraController(ref: ref));

final productImageListProvider = StateProvider.autoDispose<List<File>>((ref) {
  List<File> files = [];
  return files;
});

final pickedImageCountProvider = StateProvider.autoDispose<int>((ref) {
  final imageList = ref.watch(productImageListProvider.state).state;
  return imageList.length;
});

final imagePressedProvider = StateProvider.autoDispose<bool>((ref) => false);
