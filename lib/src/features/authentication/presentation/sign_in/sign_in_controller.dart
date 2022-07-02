import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import '../../data/auth_repository.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController({
    required SignInFormType formType,
    required this.authRepository,
    this.onSignedIn,
  }) : super(SignInState(formType: formType));
  final VoidCallback? onSignedIn;
  final AuthRepository authRepository;

  Future<bool> submitPhoneNumber(
      BuildContext context, String phoneNumber, VoidCallback codeSent) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() =>
        authRepository.registerWithPhoneNumber(context, phoneNumber, codeSent));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<bool> submitOtpCode(
      BuildContext context, String otpCode, VoidCallback onSignedIn) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(
        () => authRepository.verifyOtpCode(context, otpCode, onSignedIn));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  void updateFormType(SignInFormType formType) {
    state = state.copyWith(formType: formType);
  }
}

///Provider for [SignInController]

final signInControllerProvider = StateNotifierProvider.autoDispose
    .family<SignInController, SignInState, SignInFormType>((ref, formType) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInController(
    authRepository: authRepository,
    formType: formType,
  );
});

final counterControllerProvider = StateProvider.autoDispose<int>((ref) {
  return 60;
});
