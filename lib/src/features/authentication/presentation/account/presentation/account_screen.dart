import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/account_widgets/favorites.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/account_widgets/settings_list.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/account_widgets/social_media.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/account_widgets/user_info_widget.dart';

import 'package:muraita_2_0/src/localization/string_hardcoded.dart';
import 'package:muraita_2_0/src/utils/async_value_ui.dart';
import '../../../../../common_widgets/action_text_button.dart';

import '../../../../../common_widgets/custom_body.dart';
import '../../../../../common_widgets/responsive_center.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../routing/app_router.dart';
import 'account_screen_controller.dart';

import 'package:go_router/go_router.dart';

/// Simple account screen showing some user info and a logout button.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account'.hardcoded,
        ),
        actions: [
          ActionTextButton(
              text: 'Edit profile',
              onPressed: () => context.pushNamed(AppRoute.editprofile.name)),
        ],
      ),
      body: CustomBody(
        child: ResponsiveCenter(
          child: Column(
            children: [
              const Divider(
                height: 0.5,
              ),
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                    child: Column(
                      children: const [
                        Expanded(flex: 20, child: UserInfoWidget()),
                        Divider(
                          height: 20,
                        ),
                        Expanded(flex: 12, child: Favorites()),
                        Divider(
                          height: 20,
                        ),
                        Expanded(flex: 12, child: SocialMedia()),
                        Divider(
                          height: 20,
                        ),
                        Expanded(flex: 56, child: SettingsList()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
