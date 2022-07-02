import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/styles.dart';

import '../../../../../../common_widgets/async_value_widget.dart';
import '../../../../../../common_widgets/custom_image.dart';
import '../../../../../../constants/app_sizes.dart';
import '../../../../../products/domain/product.dart';
import '../../../../../products/presentation/product_screen/product_average_rating.dart';
import '../../../../data/auth_repository.dart';
import '../../../../domain/app_user.dart';

/// Simple user data table showing the uid and email
class ProfileInfo extends ConsumerWidget {
  const ProfileInfo({super.key});

  final String _profileImage = 'assets/products/pasta-plate.jpg';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme.subtitle2!;

    ///this is use to listen to log out;
    // final user = ref.watch(authStateChangesProvider).value;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    final phonNumber = auth.currentUser?.phoneNumber;
    return userName == null
        ? const CircularProgressIndicator()
        : Row(
            children: [
              Expanded(
                flex: 27,
                child: ClipOval(
                  child: CustomImage(
                    imageUrl: _profileImage,
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
                        phonNumber!,
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
