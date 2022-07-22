import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key? key, required this.imageFile}) : super(key: key);

  final String imageFile;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Hero(
        tag: imageFile,
        child: PhotoView(
          imageProvider: NetworkImage(imageFile),
        ),
      ),
    );
  }
}
