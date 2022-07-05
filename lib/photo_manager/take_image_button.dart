import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/constants/app_colors.dart';
import '../src/features/authentication/presentation/account/presentation/edit_profile/presentation/camera_bottom_modal_sheet.dart';

class TakeImageButton extends ConsumerWidget {
  const TakeImageButton({Key? key}) : super(key: key);

  _showModalBottomSheet(context) {
    return showModalBottomSheet(
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => CameraBottonModalSheet(
              allowMultiple: true,
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => _showModalBottomSheet(context),
      highlightColor: kPrimaryHue,
      child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: kBlack20,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: kBlack60)),
          child: const AspectRatio(
            aspectRatio: 1.0,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 30,
              color: kBlack60,
            ),
          )),
    );
  }
}
