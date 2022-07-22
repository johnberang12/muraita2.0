// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:muraita_2_0/src/common_widgets/custom_app_bar.dart';
// import 'package:muraita_2_0/src/common_widgets/custom_body.dart';

// import 'package:muraita_2_0/src/common_widgets/grid_layout.dart';
// import 'package:muraita_2_0/src/common_widgets/responsive_center.dart';
// import 'package:muraita_2_0/photo_manager/take_image_button.dart';
// import 'package:muraita_2_0/src/constants/app_colors.dart';
// import 'package:muraita_2_0/src/constants/strings.dart';

// import 'package:photo_manager/photo_manager.dart';
// import '../src/common_widgets/alert_dialogs.dart';

// import '../src/constants/app_sizes.dart';
// import '../src/constants/styles.dart';
// import 'photo_gallery_repository.dart';

// class ImageGalleryScreen extends ConsumerStatefulWidget {
//   const ImageGalleryScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   ConsumerState<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
// }

// class _ImageGalleryScreenState extends ConsumerState<ImageGalleryScreen> {
//   final _scrollController = ScrollController();
//   int? _selectedIndex;

//   // int _imageLength = 10;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() async {
//     await _getImages();
//     super.didChangeDependencies();
//   }

//   Future<void> _getImages() async {
//     // ref.read(loadingProvider.state).state = true;
//     final controller = ref.watch(cameraControllerProvider);
//     await controller.getUserPermission();
//     if (!controller.isPermissionGranted) {
//       _permissionDenied();
//     }
//     await controller.getAssetPathList();
//     if (controller.isPathEmpty) {
//       _pathIsEmpty();
//     }
//     await controller.getAssetEntities();
//     ref.read(imageListControllerProvider.state).state = controller.entities;
//     ref
//         .read(imageListControllerProvider.state)
//         .state!
//         .insert(0, controller.entities![0]);
//   }

//   void _pathIsEmpty() {
//     // ref.read(loadingProvider.state).state = false;
//     showExceptionAlertDialog(
//         context: context,
//         title: kOperationFailed,
//         exception: 'No gallery found in your device.');
//   }

//   void _permissionDenied() {
//     // ref.read(loadingProvider.state).state = false;
//     // ref.read(loadingProvider.state).state = false;
//     showExceptionAlertDialog(
//         context: context,
//         title: kOperationFailed,
//         exception: 'Please grant access to your camera');
//   }

//   void _onCloseGallery() {
//     _selectedIndex = null;
//     ref.read(cameraControllerProvider).selectedEntity = null;
//     ref.read(pickedImageControllerProvider.state).state = null;
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(cameraControllerProvider);
//     final selectedImage = ref.watch(pickedImageControllerProvider.state).state;
//     // final loading = ref.watch(loadingProvider.state).state;
//     // final imageTaken = ref.watch(imageTakenProvider.state).state?.path;
//     // final imageTaken = File(state.imageTaken!.path);

//     final images = (ref.watch(imageListControllerProvider));
//     // final assetToFile = File(selectedImage.toString());
//     print('path is empty is =======> ${state.isPathEmpty}');
//     print('state.isLoading is =====> ${state.isLoading}');
//     final isPathEmpty = ref.watch(pathIsEmptyProvider.state).state;
//     return Scaffold(
//       appBar: CustomAppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => _onCloseGallery(),
//         ),
//         title: const Text(
//           'Pick image',
//           style: Styles.k16,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Done'),
//           ),
//         ],
//       ),
//       body: CustomBody(
//         padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
//         child: Center(
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 10,
//                 child: Row(
//                   children: [
//                     selectedImage == null
//                         ? const SizedBox()
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 8.0, right: 8),
//                             child: AspectRatio(
//                               aspectRatio: 1.0,
//                               child: Container(
//                                   color: kGreyTransparent20,
//                                   child: state.selectedEntity == null
//                                       ? const Icon(
//                                           Icons.person,
//                                           size: 80,
//                                           color: kGreyTransparent80,
//                                         )
//                                       : FittedBox(
//                                           fit: BoxFit.fill,
//                                           child:
//                                               AssetEntityImage(selectedImage))),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//               const Divider(),
//               state.path == null || state.isPathEmpty || images!.isEmpty
//                   ? Expanded(
//                       flex: 90,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               alignment: Alignment.topLeft,
//                               height: 80,
//                               child: const TakeImageButton()),
//                           Expanded(
//                             child: Center(
//                                 child: Text(state.isPathEmpty
//                                     ? 'No image gallery found on your device'
//                                     : 'Image galley is empty')),
//                           ),
//                           const Expanded(
//                             child: SizedBox(),
//                           )
//                         ],
//                       ),
//                     )
//                   : Expanded(
//                       flex: 90,
//                       child: CustomScrollView(
//                         controller: _scrollController,
//                         slivers: [
//                           ResponsiveSliverCenter(
//                             child: GridLayout(
//                               rowsCount: 4,
//                               itemCount: images.length,
//                               itemBuilder: (_, index) {
//                                 final image = images[index];
//                                 print('entered build logic section');

//                                 if (index == 0) {
//                                   return TakeImageButton();
//                                 }

//                                 return InkWell(
//                                   onTap: () {
//                                     _onTapImage(image, index);
//                                   },
//                                   child: AspectRatio(
//                                     aspectRatio: 1.0,
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 width: index == _selectedIndex
//                                                     ? 3
//                                                     : 0.0,
//                                                 color: kPrimaryHue),
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   color: kPrimaryShade60,
//                                                   blurRadius: 2,
//                                                   offset: Offset(
//                                                     index == _selectedIndex
//                                                         ? _offsetLeft
//                                                         : 0.0,
//                                                     index == _selectedIndex
//                                                         ? _offsetRight
//                                                         : 0.0,
//                                                   ))
//                                             ]),
//                                         height: 100,
//                                         child: FittedBox(
//                                           fit: BoxFit.fill,
//                                           child: AssetEntityImage(
//                                             image,
//                                             thumbnailSize:
//                                                 const ThumbnailSize.square(150),
//                                             thumbnailFormat:
//                                                 ThumbnailFormat.png,
//                                           ),
//                                         )),
//                                   ),
//                                 );
//                               },
//                             ),
//                           )
//                         ],
//                       )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onTapImage(entity, index) {
//     print('selected entity is => $entity');
//     setState(() {
//       if (_selectedIndex == null) {
//         _selectedIndex = index;
//         ref.read(cameraControllerProvider).selectedEntity = entity;
//         ref.read(pickedImageControllerProvider.state).state = entity;
//       } else if (_selectedIndex != null) {
//         if (_selectedIndex != index) {
//           _selectedIndex = index;
//           ref.read(cameraControllerProvider).selectedEntity = entity;
//           ref.read(pickedImageControllerProvider.state).state = entity;
//         }
//         // _selectedIndex = null;
//         // ref.read(cameraControllerProvider).selectedEntity = null;
//         // ref.read(pickedImageControllerProvider.state).state = null;
//         // _selectedIndex = index;
//         // ref.read(cameraControllerProvider).selectedEntity = entity;
//         // ref.read(pickedImageControllerProvider.state).state = entity;
//       }
//     });
//   }

//   final double _offsetLeft = 7.0;
//   final double _offsetRight = 7.0;
// }
