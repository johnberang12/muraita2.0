import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muraita_2_0/src/common_widgets/primary_button.dart';
import 'package:muraita_2_0/src/features/products/presentation/add_product_controller_provider.dart';

import '../../../../../../../constants/styles.dart';
import '../data/file_picker_repository.dart';
import 'edit_profile_provider.dart';

class CameraBottonModalSheet extends ConsumerWidget {
  CameraBottonModalSheet({
    Key? key,
    this.allowMultiple = false,
  }) : super(key: key);

  bool allowMultiple;

  Future<void> _openGallery(BuildContext context, WidgetRef ref) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.image,
    );
    print('results are ====> $result');
    if (result == null) return;

    ///execute this if only 1 file selected
    if (result.count == 1) {
      final file = File(result.files.first.path!);
      ref.read(pickedProfileImageProvider.state).state = file;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }

    ///execute this if multiple files are selected
    if (result.count > 1) {
      for (var i = 0; i < result.count; i++) {
        final file = File(result.files[i].path!);
        print('this file is ===> $file');
        ref.read(productImageListProvider.state).state.add(file);
        ref.read(pickedImageCountProvider.state).state++;
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }

    // ref.read(pickedProfileImageProvider.state).state = file;

    // ignore: use_build_context_synchronously
  }

  Future<void> _takeImage(BuildContext context, WidgetRef ref) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (image == null) return;
    ref.read(pickedProfileImageProvider.state).state = File(image.path);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height * .30,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CameraModalButton(
                buttonHeight: height * .06,
                onTap: () => _openGallery(context, ref),
                title: 'Image Galley',
                icon: Icons.image,
              ),
              // PrimaryButton(
              //   text: 'Phone Gallery',
              //   onPressed: () => _openGallery(context, ref),
              // ),
              CameraModalButton(
                buttonHeight: height * .06,
                onTap: () => _takeImage(context, ref),
                title: 'Device Camera',
                icon: Icons.camera_alt,
              ),

              const Opacity(
                opacity: 0.0,
                child: PrimaryButton(
                  text: '',
                ),
              ),
            ]),
      ),
    );
  }
}

class CameraModalButton extends StatelessWidget {
  const CameraModalButton(
      {Key? key, this.buttonHeight, this.onTap, this.title, this.icon})
      : super(key: key);
  final double? buttonHeight;
  final VoidCallback? onTap;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              icon,
              size: height * .04,
            ),
            Text(
              title!,
              style: Styles.k20Bold.copyWith(color: Colors.white),
            ),
            Opacity(
                opacity: 0.0,
                child: Icon(
                  Icons.picture_as_pdf,
                  size: height * .03,
                )),
          ]),
        ),
      ),
    );
  }
}
