import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';

import '../../../../../../common_widgets/alert_dialogs.dart';
import '../../../../../../routing/app_router.dart';
import 'labeled_icon.dart';

class Favorites extends ConsumerWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final user = ref.watch(authRepositoryProvider).currentUser;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LabeledIcon(
          icon: (Icons.thumb_up_alt_outlined),
          onTap: () => context.pushNamed(AppRoute.favourites.name),
          label: 'favourites',
          iconSize: height * .025,
          avatarRadius: height * .025,
          labelFontSize: height * .018,
        ),
        LabeledIcon(
          icon: (Icons.shopping_bag_outlined),
          onTap: () =>
              showAlertDialog(context: context, title: 'UnImplemented'),
          label: 'purchases',
          iconSize: height * .025,
          avatarRadius: height * .025,
          labelFontSize: height * .018,
        ),
        LabeledIcon(
          icon: (Icons.list_outlined),
          onTap: () => context.pushNamed(
            AppRoute.myproducts.name,
            params: {'ownerId': user!.uid},
          ),
          label: 'listings',
          iconSize: height * .025,
          avatarRadius: height * .025,
          labelFontSize: height * .018,
        ),
      ],
    );
  }
}
