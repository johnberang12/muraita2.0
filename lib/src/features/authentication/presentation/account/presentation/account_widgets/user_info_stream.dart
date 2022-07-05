import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/async_value_widget.dart';
import 'package:muraita_2_0/src/features/authentication/data/users_repository.dart';

import '../../../../../../common_widgets/custom_image.dart';
import '../../../../../../constants/app_sizes.dart';
import '../../../../../../constants/styles.dart';
import '../../../../data/auth_repository.dart';
import '../../../../domain/app_user.dart';
import 'dart:developer' as dev;

class UserInfoStream extends ConsumerWidget {
  const UserInfoStream({
    Key? key,
  }) : super(key: key);
  final String _profileImage = 'assets/products/pasta-plate.jpg';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authRepositoryProvider);
    final userId = auth.currentUser?.uid;
    final userInfo = ref.watch(userInfoProvider);
    print(userId);
    print('this user id is =====> $userId');
    print('this user display name is ');
    dev.log('message',
        name: 'userInfoStream', error: {'data': 'error data or other data'});
    // dev.debugger();
    return AsyncValueWidget<AppUser?>(
        value: userInfo,
        data: (user) => Row(
              children: [
                Expanded(
                  flex: 27,
                  child: ClipOval(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: CustomImage(
                        imageUrl: user!.photoUrl ?? '',
                      ),
                    ),
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
                          user.displayName ?? '',
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
