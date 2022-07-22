import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import '../../../../constants/strings.dart';
import '../../../../routing/app_router.dart';
import '../../../products/presentation/add_product/add_product_screen.dart';
import '../../data/auth_repository.dart';
import '../../data/users_repository.dart';
import '../../domain/app_user.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController({
    required this.ref,
    required SignInFormType formType,
    required this.authRepository,
  }) : super(SignInState(formType: formType));
  Ref ref;

  final AuthRepository authRepository;
  late Timer timer;

  void _startTimer() {
    ref.read(counterControllerProvider.state).state = 120;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      int value = ref.read(counterControllerProvider.state).state--;
      if (value <= 0) {
        timer.cancel();
      }
    });
  }

  // Future<void> setUserData(BuildContext context) async {
  //   await _saveUserData();
  // onSignedIn?.call();
  // context.goNamed(AppRoute.home.name);
  // if (mounted) Navigator.of(context).pop();
  // final authRepository = ref.watch(authRepositoryProvider);
  // final user = authRepository.currentUser;
  // final verified = authRepository.currentUser != null;
  // final hasName =
  //     user?.displayName != null && user?.displayName != kEmptyString;
  // if (verified && !hasName) {
  //   context.pushNamed(AppRoute.nameregisrtation.name);
  // } else {
  //   onSignedIn?.call();
  //   context.go(AppRoute.home.name);
  //   print('signed in success');
  //   // if (mounted) {
  //   //   print('mounted navigate to home');
  //   // }
  // }
  // }

  void _codeSent() {
    updateFormType(state.secondaryActionFormType);
    _startTimer();
  }

  void updateFormType(SignInFormType formType) {
    state = state.copyWith(formType: formType);
    // _numberController.clear();
  }

  Future<bool> submitPhoneNumber(
      BuildContext context, String phoneNumber) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => authRepository
        .registerWithPhoneNumber(context, phoneNumber, _codeSent));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<bool> submitOtpCode(
      BuildContext buildContext, String otpCode, VoidCallback signIn) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(
        () => authRepository.verifyOtpCode(buildContext, otpCode, signIn));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }
}

///Provider for [SignInController]

final signInControllerProvider = StateNotifierProvider.autoDispose
    .family<SignInController, SignInState, SignInFormType>((ref, formType) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInController(
    ref: ref,
    authRepository: authRepository,
    formType: formType,
  );
});

final counterControllerProvider = StateProvider.autoDispose<int>((ref) {
  return 60;
});

final otpTextEditingController =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final optValueProvider = StateProvider.autoDispose<String>((ref) {
  final controller = ref.watch(otpTextEditingController);
  return controller.text;
});
