import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/primary_button.dart';

import '../constants/app_colors.dart';
import '../constants/styles.dart';
import '../features/authentication/presentation/account/presentation/edit_profile/presentation/image_profile_camera_controller.dart';
import '../features/products/presentation/add_product/add_product_camera_controller.dart';

Future<void> showCameraBottomModalSheet(
    BuildContext context, WidgetRef ref, bool allowMultiple) async {
  return showModalBottomSheet(
    backgroundColor: AppColors.black10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      final height = MediaQuery.of(context).size.height;
      final productController =
          ref.watch(productImagesCameraControllerProvider);

      final profileController = ref.watch(imageProfileCameraControllerProvider);
      return SizedBox(
        height: height * .30,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CameraModalButton(
                  buttonHeight: height * .06,
                  onTap: () => allowMultiple
                      ? productController.pickGalleryImages(context)
                      : profileController.pickFile(context),
                  title: 'Image Galley',
                  icon: Icons.image,
                ),
                CameraModalButton(
                  buttonHeight: height * .06,
                  onTap: () => allowMultiple
                      ? productController.takeCameraShot(context)
                      : profileController.captureImage(context),
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
    },
  );
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
    return Container(
      color: AppColors.primaryTint60,
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
