import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/styles.dart';

import '../../../../../../common_widgets/custom_image.dart';
import '../../../../../../constants/app_sizes.dart';

import '../../../../data/auth_repository.dart';

/// Simple user data table showing the uid and email
class ProfileInfo extends ConsumerWidget {
  const ProfileInfo({super.key});

  final String _profileImage = 'assets/products/pasta-plate.jpg';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final style = Theme.of(context).textTheme.subtitle2!;

    ///this is use to listen to log out;
    // final user = ref.watch(authStateChangesProvider).value;
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    final phoneNumber = auth.currentUser?.phoneNumber;
    final photoUrl = auth.currentUser?.photoURL;

    return userName == null
        ? const CircularProgressIndicator()
        : Row(
            children: [
              Expanded(
                flex: 27,
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: CustomImage(
                      imageUrl: photoUrl ?? _profileImage,
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
                        userName,
                        style: Styles.k16Bold,
                      ),
                      gapH4,
                      const Text(
                        'Wangal',
                        style: Styles.k12Grey,
                      ),
                      gapH16,
                      Text(
                        phoneNumber!,
                        style: Styles.k12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
