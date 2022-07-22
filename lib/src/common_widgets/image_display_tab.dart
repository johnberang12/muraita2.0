import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/products/presentation/add_product/add_product_screen_controller.dart';
import 'package:muraita_2_0/src/features/products/presentation/add_product/take_image_button.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/styles.dart';
import '../features/products/presentation/add_product/add_product_camera_controller.dart';

class ImageDisplayTab extends ConsumerWidget {
  const ImageDisplayTab({
    Key? key,
  }) : super(key: key);

  final _maxImageCount = 10;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageList = ref.watch(productImageListProvider.state).state;
    final imageTakenLength = ref.watch(pickedImageCountProvider.state).state;
    final submitted = ref.watch(isProductSubmittedProvider.state).state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const TakeImageButton(),
                for (var i = 0; i < imageList.length; i++)
                  imageList.isEmpty
                      ? const SizedBox()
                      : _ImageTile(file: imageList[i], index: i),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Text('$imageTakenLength/$_maxImageCount'),
            gapW12,
            Visibility(
              visible: imageList.isEmpty && submitted,
              child: Text(
                'Image can\'t be empty',
                style: Styles.k12
                    .copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ImageTile extends ConsumerWidget {
  const _ImageTile({
    Key? key,
    required this.file,
    required this.index,
  }) : super(key: key);
  final File file;
  final int index;

  // bool _onLongPress = false;

  void _onImagePressed(WidgetRef ref) {
    ref.read(imagePressedProvider.state).state =
        !ref.watch(imagePressedProvider.state).state;
  }

  void _onDeleteItem(WidgetRef ref) {
    final selectedImage =
        ref.watch(productImageListProvider.state).state[index];

    ref
        .read(productImageListProvider.state)
        .state
        .removeWhere((image) => image.path == selectedImage.path);
    ref.refresh(productImageListProvider.state).state;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onImagePressed = ref.watch(imagePressedProvider.state).state;
    return InkWell(
      onTap: () => _onImagePressed(ref),
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Sizes.p8),
            child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: AppColors.black20,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: AppColors.black60)),
                child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ))),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: Visibility(
              visible: onImagePressed == true,
              child: InkWell(
                onTap: () => _onDeleteItem(ref),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: AppColors.transparent80,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
