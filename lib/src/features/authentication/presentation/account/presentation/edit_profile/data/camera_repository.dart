// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../constants/strings.dart';
import '../../../../../../products/presentation/add_product/add_product_camera_controller.dart';

class CameraRepository {
  CameraRepository({
    required this.ref,
  });

  Ref ref;

  Future<File?> pickGalleryImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return null;

    final file = File(result.files.first.path!);
    return file;
  }

  Future<List<File>?> pickMultipleImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result == null) return null;
    List<File> pickedImages = [];
    final imageCount = ref.read(productImageListProvider.state).state.length;
    if (imageCount < kmaxImageCount) {
      if (result.count > 1) {
        for (var i = 0; i < result.count; i++) {
          final file = File(result.files[i].path!);
          pickedImages.add(file);
        }
      } else {
        final file = File(result.files.first.path!);
        pickedImages.add(file);
      }
    }

    return pickedImages;
  }

  Future<File?> takeImage() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );

    if (image == null) return null;
    final file = File(image.path);
    return file;
  }

  Future<File> saveFilePermanently(File file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = '$appStorage/$file';
    return File(file.path).copy(newFile);
  }

  // void openFile(
  //         {required BuildContext context,
  //         required File file,
  //         required String route}) =>
  //     context.goNamed(route);
}

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraRepository(ref: ref);
});
