import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_bottom_modal_sheet.dart';
import '../../../../../../../constants/app_colors.dart';

import 'edit_profile_provider.dart';

class ProfilePicButton extends ConsumerWidget {
  ProfilePicButton({Key? key}) : super(key: key);

  _showBottomModalSheet(context, WidgetRef ref) {
    return showModalBottomSheet(
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => CameraBottonModalSheet(
              allowMultiple: false,
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedFile = ref.watch(pickedProfileImageProvider.state).state;
    return InkWell(
      onTap: () =>
          // context.pushNamed(AppRoute.imagegallery.name),

          _showBottomModalSheet(context, ref),
      highlightColor: kPrimaryHue,
      borderRadius: BorderRadius.circular(100),
      child: Stack(
        children: [
          ClipOval(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                  color: kGreyTransparent20,
                  child: pickedFile == null
                      ? const Icon(
                          Icons.person,
                          size: 80,
                          color: kGreyTransparent80,
                        )
                      : FittedBox(
                          fit: BoxFit.cover, child: Image.file(pickedFile))),
            ),
          ),
          const Positioned(
              bottom: 7,
              right: 10,
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: kBlack40,
                      child: Icon(
                        Icons.camera_alt_sharp,
                        size: 20,
                      )))),
        ],
      ),
    );
  }
}
