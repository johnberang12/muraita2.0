import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_state.dart';
import '../../data/auth_repository.dart';

class PhoneNumberSignInController
    extends StateNotifier<PhoneNumberSignInState> {
  PhoneNumberSignInController({
    required PhoneNumberSignInFormType formType,
    required this.authRepository,
    this.onSignedIn,
  }) : super(PhoneNumberSignInState(formType: formType));
  final VoidCallback? onSignedIn;
  final AuthRepository authRepository;
  final int seconds = 120;

  Future<bool> submitPhoneNumber(
      BuildContext context, String phoneNumber, VoidCallback codeSent) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() =>
        authRepository.registerWithPhoneNumber(context, phoneNumber, codeSent));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<bool> submitOtpCode(BuildContext context, String name, String otpCode,
      VoidCallback onSignedIn) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(
        () => authRepository.verifyOtpCode(context, name, otpCode, onSignedIn));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  // Future<void> _authenticate(
  //     {String? name, String? phoneNumber, String? otpCode}) {
  //   switch (state.formType) {
  //     case PhoneNumberSignInFormType.register:
  //       return authRepository.registerWithPhoneNumber(name!, phoneNumber!);
  //     case PhoneNumberSignInFormType.otpVerification:
  //       return authRepository.verifyOtpCode(otpCode!);
  //   }
  // }

  void updateFormType(PhoneNumberSignInFormType formType) {
    state = state.copyWith(formType: formType);
  }
}

///Provider for [PhoneNumberSignInController]

final phoneNumberSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<PhoneNumberSignInController, PhoneNumberSignInState,
        PhoneNumberSignInFormType>((ref, formType) {
  final authRepository = ref.watch(authRepositoryProvider);
  return PhoneNumberSignInController(
    authRepository: authRepository,
    formType: formType,
  );
});

final counterControllerProvider = StateProvider.autoDispose<int>((ref) {
  return 60;
});
