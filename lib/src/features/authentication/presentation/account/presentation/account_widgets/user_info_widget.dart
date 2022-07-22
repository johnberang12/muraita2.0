import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';
import 'package:muraita_2_0/src/common_widgets/full_screen_image.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/data/users_repository.dart';

import '../../../../../../constants/app_sizes.dart';
import '../../../../../../constants/styles.dart';
import '../../../../data/auth_repository.dart';
import '../../../../domain/app_user.dart';
// import 'dart:developer' as dev;

class UserInfoWidget extends ConsumerWidget {
  const UserInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authRepositoryProvider);
    // final userId = auth.currentUser?.uid;
    final userInfoValue = ref.watch(appUserInfoProvider);

    // dev.debugger();
    return AsyncValueWidget<AppUser?>(
        value: userInfoValue,
        data: (user) => Row(
              children: [
                Expanded(
                  flex: 27,
                  child: ClipOval(
                    child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          color: AppColors.black20,
                          child: user!.photoUrl != ''
                              ? InkWell(
                                  onTap: () => Navigator.of(context,
                                          rootNavigator: true)
                                      .push(PageRouteBuilder(
                                          fullscreenDialog: true,
                                          pageBuilder: (context, _, __) =>
                                              FullScreenImage(
                                                  imageFile: user.photoUrl!))),
                                  child: Hero(
                                    tag: user.photoUrl!,
                                    child: CachedNetworkImage(
                                      imageUrl: user.photoUrl!,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                )
                              : ClipOval(
                                  child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.black40,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  kDefaultUserProfile)))),
                                )),

                          // const Icon(
                          //     Icons.person,
                          //     size: 50,
                          //     color: AppColors.kBlack40,
                          //   ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 73,
                  child: Container(
                    padding: const EdgeInsets.only(left: Sizes.p20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName ?? auth.currentUser!.displayName!,
                          style: Styles.k16Bold,
                        ),
                        gapH4,
                        const Text(
                          'Wangal',
                          style: Styles.k12Grey,
                        ),
                        gapH16,
                        Text(
                          user.phoneNumber,
                          style: Styles.k12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
