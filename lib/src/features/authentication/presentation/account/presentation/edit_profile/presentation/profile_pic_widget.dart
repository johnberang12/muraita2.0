import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';

import '../../../../../../../common_widgets/modal_bottom_sheet.dart';
import '../../../../../../../constants/app_sizes.dart';
import '../../../../../../../constants/strings.dart';
import '../../../../../data/users_repository.dart';
import '../../../../../domain/app_user.dart';
import '../../../../../../../constants/app_colors.dart';

// import 'dart:developer' as dev;

import 'image_profile_camera_controller.dart';

class ProfilePicWidget extends ConsumerWidget {
  const ProfilePicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedImage = ref.watch(pickedProfileImageProvider.state).state;

    // final auth = ref.watch(authRepositoryProvider);
    // final photoUrl = auth.currentUser?.photoURL;
    // print('user photoUrl is ${auth.currentUser!.photoURL}');
    // dev.debugger();
    final userInfo = ref.watch(appUserInfoProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p24),
      child: InkWell(
        onTap: () => showCameraBottomModalSheet(context, ref, false),
        highlightColor: AppColors.primaryHue,
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          children: [
            ClipOval(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.black40,
                        image: DecorationImage(
                            image: AssetImage(kDefaultUserProfile))),
                    child: pickedImage == null
                        ? AsyncValueWidget<AppUser?>(
                            value: userInfo,
                            data: (user) => user!.photoUrl == ''
                                ? const SizedBox()
                                : CachedNetworkImage(
                                    imageUrl: user.photoUrl!,
                                    fit: BoxFit.cover,
                                  ))
                        : Image.file(
                            pickedImage,
                            fit: BoxFit.cover,
                          )),
              ),
            ),
            const Positioned(
                bottom: 7,
                right: 10,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.black40,
                        child: Icon(
                          Icons.camera_alt_sharp,
                          size: 20,
                        )))),
          ],
        ),
      ),
    );
  }
}
