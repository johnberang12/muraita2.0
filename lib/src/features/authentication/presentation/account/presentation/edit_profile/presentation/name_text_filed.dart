import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../common_widgets/outlined_text_field.dart';
import '../../../../../../../constants/app_colors.dart';
import '../../../../../../../constants/app_sizes.dart';
import '../../../../../../../constants/strings.dart';
import '../../../../sign_in/sign_in_state.dart';
import 'edit_profile_screen_controller.dart';

class NameTextField extends ConsumerWidget {
  const NameTextField({Key? key}) : super(key: key);

  void _onEditing(value, WidgetRef ref) {
    ref.read(isSubmittedProvider.state).state = false;
    ref.read(nameValueProvider.state).state = value;
  }

  ///has set
  void _onEditingComplete(context, WidgetRef ref) {
    ref.read(isSubmittedProvider.state).state = true;
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final state = SignInState();
    final nameProvider = ref.watch(nameValueProvider.state).state;
    final isSubmitted = ref.watch(isSubmittedProvider.state).state;
    final controller = ref.watch(editProfileControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        gapH64,
        const Text(
          'Name',
        ),
        gapH12,
        OutlinedTextField(
          textColor: AppColors.black80,
          fillColor: AppColors.black10,
          height: height * outlineInputHeight,
          initialValue: nameProvider,
          labelText: kNameInputLabel,
          hintText: kNameInputHint,
          validator: (name) => !isSubmitted ? null : state.nameErrorTExt(name!),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.name,
          onChange: (value) => controller.onNameEditing(value),
          onEditingComplete: () => controller.onEditingComplete(context),
        ),
      ]),
    );
  }
}
