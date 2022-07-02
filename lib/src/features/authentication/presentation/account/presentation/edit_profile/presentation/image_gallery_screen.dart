import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';
import 'package:muraita_2_0/src/common_widgets/custom_app_bar.dart';
import 'package:muraita_2_0/src/common_widgets/custom_body.dart';
import 'package:muraita_2_0/src/common_widgets/empty_placeholder_widget.dart';
import 'package:muraita_2_0/src/common_widgets/grid_layout.dart';
import 'package:muraita_2_0/src/common_widgets/responsive_center.dart';
import 'package:muraita_2_0/src/common_widgets/take_image_button.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/data/camera_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/domain/gallery_Image.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../../../../common_widgets/alert_dialogs.dart';
import '../../../../../../../common_widgets/custom_image.dart';
import '../../../../../../../constants/app_sizes.dart';
import '../../../../../../../constants/styles.dart';
import '../data/photo_gallery_repository.dart';

class ImageGalleryScreen extends ConsumerStatefulWidget {
  const ImageGalleryScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends ConsumerState<ImageGalleryScreen> {
  final _scrollController = ScrollController();
  int? _selectedIndex;

  int _imageLength = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await _getImages();
    super.didChangeDependencies();
  }

  Future<void> _getImages() async {
    final controller = ref.read(cameraControllerProvider);
    await controller.getUserPermission();
    if (!controller.isPermissionGranted) {
      _permissionDenied();
    }
    await controller.getAssetPathList();
    if (controller.isPathEmpty) {
      _pathIsEmpty();
    }
    await controller.getAssetEntities();
    ref.read(imageListControllerProvider.state).state = controller.entities;
    ref
        .read(imageListControllerProvider.state)
        .state!
        .insert(0, controller.entities![0]);
  }

  void _pathIsEmpty() {
    showExceptionAlertDialog(
        context: context,
        title: kOperationFailed,
        exception: 'No gallery found in your device.');
  }

  void _permissionDenied() {
    showExceptionAlertDialog(
        context: context,
        title: kOperationFailed,
        exception: 'Please grant access to your camera');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cameraControllerProvider);
    final selectedImage = ref.watch(pickedImageControllerProvider.state).state;

    final imageTaken = ref.watch(imageTakenProvider.state).state?.path;
    // final imageTaken = File(state.imageTaken!.path);
    print('image taken is => $imageTaken');

    final images = (ref.watch(imageListControllerProvider));
    // final assetToFile = File(selectedImage.toString());

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(
          'Pick image',
          style: Styles.k16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
      body: CustomBody(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Row(
                  children: [
                    selectedImage == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 8),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Container(
                                  color: kGreyTransparent20,
                                  child: state.selectedEntity == null
                                      ? const Icon(
                                          Icons.person,
                                          size: 80,
                                          color: kGreyTransparent80,
                                        )
                                      : FittedBox(
                                          fit: BoxFit.fill,
                                          child:
                                              AssetEntityImage(selectedImage))),
                            ),
                          ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                  flex: 90,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      ResponsiveSliverCenter(
                        child: GridLayout(
                          rowsCount: 4,
                          itemCount: images!.length,
                          itemBuilder: (_, index) {
                            final image = images[index];
                            if (state.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            }
                            if (state.path == null) {
                              return const Center(
                                  child: Text('Request paths first.'));
                            }
                            if (images.isNotEmpty != true) {
                              return const Center(
                                  child:
                                      Text('No assets found on this device.'));
                            }
                            if (index == 0) {
                              return TakeImageButton();
                            }

                            return InkWell(
                              onTap: () {
                                _onTapImage(image, index);
                              },
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: index == _selectedIndex
                                                ? 3
                                                : 0.0,
                                            color: kPrimaryHue),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: kPrimaryShade60,
                                              blurRadius: 2,
                                              offset: Offset(
                                                index == _selectedIndex
                                                    ? _offsetLeft
                                                    : 0.0,
                                                index == _selectedIndex
                                                    ? _offsetRight
                                                    : 0.0,
                                              ))
                                        ]),
                                    height: 100,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: AssetEntityImage(
                                        image,
                                        thumbnailSize:
                                            const ThumbnailSize.square(150),
                                        thumbnailFormat: ThumbnailFormat.png,
                                      ),
                                    )),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapImage(entity, index) {
    setState(() {
      if (_selectedIndex == null) {
        _selectedIndex = index;
        ref.read(cameraControllerProvider).selectedEntity = entity;
        ref.read(pickedImageControllerProvider.state).state = entity;
      } else if (_selectedIndex != null) {
        if (_selectedIndex != index) {
          _selectedIndex = index;
          ref.read(cameraControllerProvider).selectedEntity = entity;
          ref.read(pickedImageControllerProvider.state).state = entity;
        }
        _selectedIndex = null;
        ref.read(cameraControllerProvider).selectedEntity = null;
        ref.read(pickedImageControllerProvider.state).state = null;
      }
    });
  }

  final double _offsetLeft = 7.0;
  final double _offsetRight = 7.0;
}
