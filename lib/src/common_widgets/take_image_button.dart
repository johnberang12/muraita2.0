import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/constants/strings.dart';

import '../constants/app_colors.dart';
import '../features/authentication/presentation/account/presentation/edit_profile/data/photo_gallery_repository.dart';

class TakeImageButton extends ConsumerWidget {
  TakeImageButton({Key? key}) : super(key: key);

  Future<XFile?> takePicture(context, WidgetRef ref) async {
    ref.read(loadingProvider.state).state = true;
    ref.read(pickedImageControllerProvider.state).state = null;
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
      );

      if (image == null) throw UnimplementedError();
      // final fileImage = File(image.path);

      final imageFile = File(image.path);
      final success = await _saveImage(context, imageFile, ref);
      if (success) {
        Navigator.of(context).pop();
      }
    } on PlatformException catch (e) {
      showAlertDialog(
          context: context, title: kOperationFailed, content: e.toString());
    } finally {
      ref.read(loadingProvider.state).state = false;
    }
  }

  Future<bool> _saveImage(context, capturedImage, WidgetRef ref) async {
    try {
      ref.read(capturedImageControllerProvider.state).state = capturedImage;
      // ref.read(cameraControllerProvider).capturedImage = capturedImage;
      return true;
    } on Exception catch (e) {
      showExceptionAlertDialog(
          context: context, title: kOperationFailed, exception: e);
      ref.read(loadingProvider.state).state = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.read(capturedImageControllerProvider.state).state;
    final galleryImage = ref.watch(cameraControllerProvider).selectedEntity;
    return InkWell(
      onTap: () => takePicture(context, ref),
      highlightColor: kPrimaryHue,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
            decoration: BoxDecoration(
                color: kTransparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: kBlack60)),
            height: 100,
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 50,
              color: kBlack60,
            )),
      ),
    );
  }
}
