import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/photo_manager/take_image_button.dart';
import 'package:muraita_2_0/src/features/products/presentation/add_product_controller_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class CustomImageInput extends ConsumerWidget {
  const CustomImageInput({
    Key? key,
  }) : super(key: key);

  final _maxImageCount = 10;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageList = ref.watch(productImageListProvider.state).state;
    final imageTakenLength = ref.watch(pickedImageCountProvider.state).state;
    print('imageList is $imageList');
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
                      : _ImageTile(file: imageList[i]),
              ],
            ),
          ),
        ),
        Text('$imageTakenLength/$_maxImageCount'),
      ],
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({
    Key? key,
    required this.file,
  }) : super(key: key);
  final File file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Sizes.p8),
      child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: kBlack20,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: kBlack60)),
          child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ))),
    );
  }
}
