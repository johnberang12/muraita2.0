import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraRepository {
  File? imageTaken;

  Future<File?> takePicture() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (image == null) return imageTaken = null;

    imageTaken = File(image.path);
  }
}

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraRepository();
});
