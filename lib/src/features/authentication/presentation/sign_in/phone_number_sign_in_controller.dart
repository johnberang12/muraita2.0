import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_state.dart';

import '../../data/auth_repository.dart';
import '../../data/fake_auth_repository.dart';
import '../../domain/app_user.dart';

class PhoneNumberSignInController
    extends StateNotifier<PhoneNumberSignInState> {
  PhoneNumberSignInController({
    required PhoneNumberSignInFormType formType,
    required this.authRepository,
  }) : super(PhoneNumberSignInState(formType: formType));
  final FakeAuthRepository authRepository;

  Future<bool> submitPhoneNumber(String name, String phoneNumber) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(
        () => _authenticate(name: name, phoneNumber: phoneNumber));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<bool> submitOtpCode(String otpCode) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => _authenticate(otpCode: otpCode));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> _authenticate(
      {String? name, String? phoneNumber, String? otpCode}) {
    switch (state.formType) {
      case PhoneNumberSignInFormType.register:
        return authRepository.registerWithPhoneNumber(name!, phoneNumber!);
      case PhoneNumberSignInFormType.otpVerification:
        return authRepository.verifyOtpCode(otpCode!);
    }
  }

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
