import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/modal_bottom_sheet.dart';
import '../../../../constants/app_colors.dart';

class TakeImageButton extends ConsumerWidget {
  const TakeImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => showCameraBottomModalSheet(context, ref, true),
      highlightColor: AppColors.primaryHue,
      child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: AppColors.black20,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.black60)),
          child: const AspectRatio(
            aspectRatio: 1.0,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 30,
              color: AppColors.black60,
            ),
          )),
    );
  }
}
