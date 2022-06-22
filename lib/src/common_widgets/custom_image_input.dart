import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomImageInput extends StatelessWidget {
  const CustomImageInput({
    Key? key,
    required this.height,
    required this.onTap,
    this.verticalPadding = 0,
  }) : super(key: key);

  final double height;
  final VoidCallback onTap;
  final double verticalPadding;
  final int _imageTaken = 0;
  final int _maxImageCount = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: SizedBox(
            height: height,
            child: InkWell(
                onTap: onTap,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kBlack40),
                        borderRadius: BorderRadius.circular(8)),

                    ///change the icon if _imageTaken is not null
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                )),
          ),
        ),
        Text('$_imageTaken/$_maxImageCount'),
      ],
    );
  }
}
