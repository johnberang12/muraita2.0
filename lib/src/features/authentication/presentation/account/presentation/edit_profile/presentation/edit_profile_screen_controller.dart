// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/data/fire_storage_repository.dart';
import 'package:muraita_2_0/src/services/api_path.dart';

import '../../../../../../../common_widgets/alert_dialogs.dart';
import '../../../../../data/users_repository.dart';
import '../../../../sign_in/sign_in_state.dart';
import 'image_profile_camera_controller.dart';

class EditProfileScreenController {
  EditProfileScreenController({
    required this.ref,
  });

  Ref ref;

  Future<void> onSaveData(context) async {
    ref.read(isSubmittedProvider.state).state = true;

    final ok = await showAlertDialog(
      context: context,
      title: 'Are you sure you want to save changes?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Ok',
    );
    if (ok == true) {
      EasyLoading.show(status: 'Updating...');
      final state = SignInState();
      final name = ref.read(nameValueProvider.state).state;
      final profileImage = ref.read(pickedProfileImageProvider.state).state;
      if (state.canSubmitName(name!)) {
        await updateName(context);
        if (profileImage != null) {
          final userId = ref.read(authRepositoryProvider).currentUser?.uid;
          final controller = ref.read(fireStorageRopositoryProvider);
          final imageUrl = await controller.uploadImageFile(
              profileImage, APIPath.profileImagePath(userId!));

          final auth = ref.watch(authRepositoryProvider);
          final user = ref.watch(userRepositoryProvider);
          await auth.currentUser?.updatePhotoURL(imageUrl);
          final updatedPhoto = auth.currentUser?.photoURL;
          await user.updatePhoto(updatedPhoto!);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Image profile successfully updated')));
        }
        EasyLoading.showSuccess('Success');
        Navigator.of(context).pop();
      } else {
        EasyLoading.showError('Name is too short');
      }
    }
  }

  Future<void> updateName(context) async {
    // final state = SignInState();
    final name = ref.read(nameValueProvider.state).state;
    final auth = ref.read(authRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);

    if (name != auth.currentUser?.displayName) {
      print('updating name');
      await auth.currentUser?.updateDisplayName(name);
      await userRepository.updateDisplayName(name!);
    }
  }

  Future<void> onCloseScreen(BuildContext context) async {
    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    // final userPhoto = auth.currentUser?.photoURL;
    final name = ref.read(nameValueProvider.state).state;

    // /TODO: to be fixed (pickedPhoto == userPhoto)
    if (name == userName) {
      Navigator.of(context).pop();
    } else if (name != userName) {
      print(' $name is === $userName');
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
    }
  }

  void onNameEditing(String value) {
    ref.read(isSubmittedProvider.state).state = false;
    ref.read(nameValueProvider.state).state = value;
  }

  void onEditingComplete(BuildContext context) {
    ref.read(isSubmittedProvider.state).state = true;
    FocusScope.of(context).unfocus();
  }
}

final editProfileControllerProvider =
    Provider<EditProfileScreenController>((ref) {
  return EditProfileScreenController(ref: ref);
});

///for name updating
final nameValueProvider = StateProvider.autoDispose<String?>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  final name = auth.currentUser?.displayName;
  return name;
});

final isSubmittedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
