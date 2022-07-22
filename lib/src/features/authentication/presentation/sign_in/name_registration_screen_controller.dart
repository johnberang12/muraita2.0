// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';

import '../../../../constants/strings.dart';
import '../../../../routing/app_router.dart';
import '../../../products/presentation/add_product/add_product_screen.dart';
import '../../data/auth_repository.dart';
import '../../data/users_repository.dart';
import '../../domain/app_user.dart';

class NameRegistrationScreenController {
  NameRegistrationScreenController({
    required this.ref,
  });
  Ref ref;

  Future<void> submitName() async {
    final state = SignInState();

    final auth = ref.watch(authRepositoryProvider);
    final name = ref.read(nameInputValueProvider.state).state;

    if (state.canSubmitName(name)) {
      await auth.currentUser?.updateDisplayName(name);
      await _saveUserData(name);
    }
  }

  Future<void> _saveUserData(String name) async {
    print('save user data');
    print('saving user data');
    final authRepository = ref.watch(authRepositoryProvider);
    final repository = ref.watch(userRepositoryProvider);
    final id = authRepository.currentUser?.uid ?? documentIdFromCurrentDate();
    final uid = authRepository.currentUser?.uid;
    final phone = authRepository.currentUser?.phoneNumber;

    final user = AppUser(
        id: id,
        uid: uid!,
        lastActive: currentDateTime(),
        displayName: name,
        phoneNumber: phone!,
        userLocation: kUserLocation);
    await repository.setUserIfExist(user);
  }

  void onNameEditing(String value) {
    ref.read(nameSubmittedProvider.state).state = false;
    ref.read(nameInputValueProvider.state).state = value;
  }

  void onEditingComplete(BuildContext context) {
    ref.read(nameSubmittedProvider.state).state = true;
    FocusScope.of(context).unfocus();
  }
}

final nameRegistrationControllerProvider =
    Provider<NameRegistrationScreenController>(
        (ref) => NameRegistrationScreenController(ref: ref));

///for name registration
final nameEditingControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());

final nameInputValueProvider = StateProvider.autoDispose<String>((ref) {
  final provider = ref.watch(nameEditingControllerProvider);
  return provider.text;
});

final nameSubmittedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
