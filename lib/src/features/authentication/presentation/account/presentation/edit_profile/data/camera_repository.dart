import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraRepository {
  XFile? imageTaken;

  Future<XFile?> takePicture(void Function(String) onException(e)) async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
      );

      imageTaken = image;
    } on PlatformException catch (e) {
      onException(e);
    }
  }
}

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraRepository();
});

final imageTakenProvider = StateProvider.autoDispose<XFile?>((ref) {
  final controller = ref.watch(cameraRepositoryProvider);
  return controller.imageTaken;
});
