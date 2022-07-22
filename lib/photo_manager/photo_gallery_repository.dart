// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:photo_manager/photo_manager.dart';

// class PhotoGalleryRepository {
//   final int _sizePerPage = 50;

//   ///gallery path
//   AssetPathEntity? path;

//   List<AssetEntity> _imagePaths = [];
//   List<AssetEntity>? get imagePaths => _imagePaths;

//   ///list of images extracted from gallery
//   List<AssetEntity> _entities = [];
//   List<AssetEntity>? get entities => _entities;

//   bool isLoading = false;

//   ///selectedImage from gallery;
//   AssetEntity? selectedEntity;
//   //captured from camera
//   File? capturedImage;

//   int _totalEntitiesCount = 0;

//   int _page = 0;

//   bool isLoadingMore = false;

//   bool hasMoreToLoad = true;
//   bool isPermissionGranted = true;
//   bool isPathEmpty = false;

//   final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
//     imageOption: const FilterOption(
//       sizeConstraint: SizeConstraint(ignoreSize: true),
//     ),
//   );

//   Future<void> getUserPermission() async {
//     isLoading = true;
//     // Request permissions.
//     final PermissionState ps = await PhotoManager.requestPermissionExtend();

//     // Further requests can be only procceed with authorized or limited.
//     if (ps != PermissionState.authorized && ps != PermissionState.limited) {
//       isLoading = false;
//       isPermissionGranted = false;

//       print('permission denied');

//       return;
//     }
//     print('permission granted');
//   }

//   Future<void> getAssetPathList() async {
//     final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
//       onlyAll: true,
//       hasAll: true,
//       filterOption: _filterOptionGroup,
//     );
//     print('getting path list');

//     // Return if not paths found.
//     if (paths.isEmpty) {
//       print('path is empty');
//       isLoading = false;
//       isPathEmpty = true;
//     }

//     path = paths.first;
//     print('path is not empty and path is => $path');

//     // for (var i = 0; i < path!.assetCount; i++) {
//     //   final path = paths[i];
//     //   final AssetEntity? imageEntityWithPath = await PhotoManager.editor
//     //       .saveImageWithPath(path.toString(), title: path.id);
//     //   imagePaths?.add(imageEntityWithPath!);
//     // }

//     _totalEntitiesCount = path!.assetCount;
//     print('total entities count is $_totalEntitiesCount');
//   }

//   Future<void> getAssetEntities() async {
//     print('asset requested');

//     // Obtain assets using the path entity.

//     final List<AssetEntity> entities = await path!.getAssetListPaged(
//       page: 0,
//       size: _sizePerPage,
//     );
//     print('getting assetList paged');

//     _entities = entities;
//     isLoading = false;
//     hasMoreToLoad = _entities.length < _totalEntitiesCount;
//   }

//   ///implement this on pull refresh
//   Future<void> loadMoreAsset() async {
//     final List<AssetEntity> entities = await path!.getAssetListPaged(
//       page: _page + 1,
//       size: _sizePerPage,
//     );
//     // if (!mounted) {
//     //   return;
//     // }

//     _entities.addAll(entities);
//     _entities.insert(0, entities[1]);
//     _page++;
//     hasMoreToLoad = _entities.length < _totalEntitiesCount;
//     isLoadingMore = false;
//   }
// }

// final cameraControllerProvider = Provider<PhotoGalleryRepository>((ref) {
//   return PhotoGalleryRepository();
// });

// final cameraControllerStateProvider =
//     StateProvider<PhotoGalleryRepository>((ref) {
//   return PhotoGalleryRepository();
// });

// final capturedImageControllerProvider = StateProvider.autoDispose<File?>((ref) {
//   final cameraController = ref.watch(cameraControllerProvider);
//   return cameraController.capturedImage;
// });

// final pickedImageControllerProvider =
//     StateProvider.autoDispose<AssetEntity?>((ref) {
//   final cameraController = ref.watch(cameraControllerProvider);
//   return cameraController.selectedEntity;
// });

// final imageListControllerProvider =
//     StateProvider.autoDispose<List<AssetEntity>?>((ref) {
//   final cameraController = ref.watch(cameraControllerProvider);
//   return cameraController.entities;
// });

// final pathIsEmptyProvider = StateProvider<bool>((ref) {
//   final cameraController = ref.watch(cameraControllerProvider);
//   return cameraController.isPathEmpty;
// });
