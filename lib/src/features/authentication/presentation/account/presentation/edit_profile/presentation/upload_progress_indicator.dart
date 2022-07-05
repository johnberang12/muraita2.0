import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/data/fire_storage_repository.dart';

import '../../../../../../../constants/styles.dart';

class UploadProgressIndicator extends ConsumerWidget {
  const UploadProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(fireStorageRopositoryProvider);
    return StreamBuilder<TaskSnapshot>(
        stream: controller.uploadTask!.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 20,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: kBlack40,
                    color: kPrimaryHue,
                  ),
                  Center(
                      child: Text(
                    '${(100 * progress).roundToDouble()}',
                    style: Styles.k16Bold.copyWith(color: Colors.white),
                  ))
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
