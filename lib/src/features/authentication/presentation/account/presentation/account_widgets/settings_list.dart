import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/utils/async_value_ui.dart';
import '../../../../../../common_widgets/alert_dialogs.dart';
import '../../../../../../constants/app_sizes.dart';
import '../../../../../../constants/styles.dart';
import '../../../../../../routing/app_router.dart';
import '../account_screen_controller.dart';
import 'package:go_router/go_router.dart';

class SettingsList extends ConsumerWidget {
  const SettingsList({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final logout = await showAlertDialog(
      context: context,
      title: 'Are you sure?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (logout == true) {
      await ref.read(accountScreenControllerProvider.notifier).signOut();

      context.goNamed(AppRoute.welcome.name);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);
    return state.isLoading
        ? const CircularProgressIndicator()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SettingsTableRow(
                iconSize: height * .025,
                labelFontSize: height * .02,
                icon: Icons.settings,
                label: 'General settings',
                onTap: () {},
              ),
              _SettingsTableRow(
                iconSize: height * .025,
                labelFontSize: height * .02,
                icon: Icons.settings,
                label: 'General settings',
                onTap: () {},
              ),
              _SettingsTableRow(
                iconSize: height * .025,
                labelFontSize: height * .02,
                icon: Icons.settings,
                label: 'General settings',
                onTap: () {},
              ),
              _SettingsTableRow(
                iconSize: height * .025,
                labelFontSize: height * .02,
                icon: Icons.settings,
                label: 'General settings',
                onTap: () {},
              ),
              _SettingsTableRow(
                iconSize: height * .025,
                labelFontSize: height * .02,
                icon: Icons.logout_outlined,
                label: 'Logout',
                onTap: () => state.isLoading ? null : _logout(context, ref),
              ),
            ],
          );
  }
}

class _SettingsTableRow extends StatelessWidget {
  const _SettingsTableRow(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.iconSize = 22,
      this.labelFontSize = Sizes.p14})
      : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double iconSize;
  final double labelFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: iconSize,
        ),
        const SizedBox(
          width: Sizes.p8,
        ),
        TextButton(
            onPressed: onTap,
            child: Text(
              label,
              style: Styles.k14.copyWith(fontSize: labelFontSize),
            )),
      ],
    );
  }
}
