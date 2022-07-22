import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/responsive_scrollable_card.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/data/users_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/edit_profile_screen_controller.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_button.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../common_widgets/outlined_text_field.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/styles.dart';
import '../../../../routing/app_router.dart';
import 'name_registration_screen_controller.dart';

class NameRegistrationScreen extends ConsumerWidget {
  NameRegistrationScreen({
    Key? key,
  }) : super(key: key);

  final _node = FocusScopeNode();

  Future<void> _submitName(BuildContext context, WidgetRef ref) async {
    EasyLoading.show();
    final controller = ref.watch(nameRegistrationControllerProvider);
    await controller.submitName();
    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    if (userName != null || userName != '') {
      EasyLoading.dismiss();
      context.goNamed(AppRoute.home.name);
    } else {
      EasyLoading.showError('error');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(nameRegistrationControllerProvider);
    final state = SignInState();
    final height = MediaQuery.of(context).size.height;
    final isSubmitted = ref.watch(nameSubmittedProvider.state).state;

    return Scaffold(
      body: Container(
        color: AppColors.primaryHue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    'Please register your name',
                    style: Styles.k24.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: FocusScope(
                  node: _node,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * .025),
                        child: OutlinedTextField(
                          height: height * outlineInputHeight,
                          controller: ref
                              .watch(nameEditingControllerProvider.state)
                              .state,
                          labelText: kNameInputLabel,
                          hintText: kNameInputHint,
                          validator: (name) =>
                              !isSubmitted ? null : state.nameErrorTExt(name!),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onChange: (value) => controller.onNameEditing(value),
                          onEditingComplete: () => _submitName(context, ref),
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      SignInButton(
                        height: height * .070,
                        width: double.infinity,
                        label: kSubmit,
                        onPressed: isSubmitted
                            ? null
                            : () => _submitName(context, ref),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
