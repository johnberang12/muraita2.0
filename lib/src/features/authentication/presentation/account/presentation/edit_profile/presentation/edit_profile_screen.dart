import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/action_text_button.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/common_widgets/outlined_text_field.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/edit_profile_provider.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/profile_pic_button.dart';
import '../../../../../../../common_widgets/custom_body.dart';
import '../../../../../data/users_repository.dart';
import '../../../../sign_in/sign_in_state.dart';

import '../data/fire_storage_repository.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  ///has set
  Future<void> _onSaveData(context, WidgetRef ref) async {
    ref.read(isSubmittedProvider.state).state = true;

    final ok = await showAlertDialog(
      context: context,
      title: 'Are you sure you want to save changes?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Ok',
    );
    if (ok == true) {
      ref.read(saveLoadingProvider.state).state = true;
      final state = SignInState();
      final name = ref.watch(nameStringProvider.state).state;
      final profileImage = ref.watch(pickedProfileImageProvider.state).state;
      if (state.canSubmitName(name!)) {
        _updateName(context, ref);
        if (profileImage != null) {
          final controller = ref.watch(fireStorageRopositoryProvider);
          await controller.uploadFile(profileImage);
          final imageUrl = controller.imageUrl;
          final auth = ref.watch(authRepositoryProvider);
          final user = ref.watch(userRepositoryProvider);
          await auth.currentUser?.updatePhotoURL(imageUrl);
          final updatedPhoto = auth.currentUser?.photoURL;
          await user.updatePhoto(auth.currentUser!.uid, updatedPhoto!);

          ///TODO: needs further verification if upload is successful then show snackbar
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Image profile successfully updated')));
          ref.read(saveLoadingProvider.state).state = false;
        }
        ref.read(saveLoadingProvider.state).state = false;
        Navigator.of(context).pop();
      }
    }
  }

  Future<bool> _updateName(context, WidgetRef ref) async {
    final state = SignInState();
    final name = ref.watch(nameStringProvider.state).state;
    final auth = ref.watch(authRepositoryProvider);
    final user = ref.watch(userRepositoryProvider);
    final userId = auth.currentUser?.uid;
    if (name != auth.currentUser?.displayName) {
      await auth.currentUser?.updateDisplayName(name);
      await user.updateDisplayName(userId!, name!);
    }

    if (name == auth.currentUser?.displayName) {
      return true;
    }
    return false;
  }

  ///has set
  Future<void> _onCloseScreen(context, WidgetRef ref) async {
    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    final userPhoto = auth.currentUser?.photoURL;
    final name = ref.watch(nameStringProvider.state).state;
    final pickedPhoto = ref.watch(pickedProfileImageProvider.state).state;

    ///TODO: to be fixed (pickedPhoto == userPhoto)
    if (name == userName && pickedPhoto.toString() == userPhoto) {
      Navigator.of(context).pop();
    } else if (name != userName || pickedPhoto.toString() != userPhoto) {
      final close = await showAlertDialog(
        context: context,
        title: 'Your changes haven\'t saved.',
        content: 'Are you sure you want to exit?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Exit',
      );
      if (close == true) {
        Navigator.of(context).pop();
      }
    } else {}
  }

  ///has set
  void _onEditing(value, WidgetRef ref) {
    ref.read(isSubmittedProvider.state).state = false;
    ref.read(nameStringProvider.state).state = value;
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
    final name = ref.watch(nameStringProvider.state).state;
    final isSubmitted = ref.watch(isSubmittedProvider.state).state;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _onCloseScreen(context, ref),
          ),
          title: const Text('Edit profile'),
          actions: [
            ActionTextButton(
              text: 'Save',
              onPressed: () => _onSaveData(context, ref),
            )
          ],
        ),
        body: CustomBody(
          child: Column(
            children: [
              const Divider(
                height: 0.5,
              ),
              Expanded(flex: 5, child: Container()),
              Expanded(flex: 15, child: ProfilePicButton()),
              Expanded(
                  flex: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapH64,
                          const Text(
                            'Name',
                          ),
                          gapH12,
                          OutlinedTextField(
                            height: height * outlineInputHeight,
                            initialValue: name,
                            labelText: kNameInputLabel,
                            hintText: kNameInputHint,
                            validator: (name) => !isSubmitted
                                ? null
                                : state.nameErrorTExt(name!),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.name,
                            onChange: (value) => _onEditing(value, ref),
                            onEditingComplete: () =>
                                _onEditingComplete(context, ref),
                          ),
                        ]),
                  )),
            ],
          ),
        ));
  }
}
