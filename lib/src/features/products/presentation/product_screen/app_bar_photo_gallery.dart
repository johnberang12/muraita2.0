import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/products/data/products_repository.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../common_widgets/full_screen_image.dart';
import '../../domain/product.dart';

class AppBarPhotoGallery extends StatefulWidget {
  const AppBarPhotoGallery({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<AppBarPhotoGallery> createState() => _AppBarPhotoGalleryState();
}

class _AppBarPhotoGalleryState extends State<AppBarPhotoGallery> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Hero(
      tag: widget.product.id,
      child: PhotoViewGallery.builder(
        customSize: Size.fromHeight(width),
        itemCount: widget.product.photos.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
              onTapUp: (context, details, controllerValue) =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FullScreenImage(
                          imageFile: widget.product.photos[index]))),
              tightMode: true,
              imageProvider: NetworkImage(
                widget.product.photos[index],
              ));
        },
      ),
    );
  }
}
