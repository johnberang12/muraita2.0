import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_state.dart';
import '../../../common_widgets/alert_dialogs.dart';
import '../../../constants/strings.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';
import '../domain/app_user.dart';

abstract class AuthRepository<T> {
  User? get currentUser;
  Stream<T?> authStateChanges();
  Future<void> registerWithPhoneNumber(
    BuildContext context,
    String phoneNumber,
    VoidCallback codeSent,
  );
  Future<void> verifyOtpCode(BuildContext context, String name, String otpCode,
      VoidCallback onSignedIn);
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  final _authInstance = FirebaseAuth.instance;
  late String _verificationID = kEmptyString;
  late PhoneNumberSignInFormType formType;

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Stream<User?> authStateChanges() => _authInstance.authStateChanges();

  @override
  Future<void> registerWithPhoneNumber(
      BuildContext context, String phoneNumber, VoidCallback codeSent) async {
    await _authInstance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('entered verification complete');

        ///execute this when verification is complete
      },
      verificationFailed: (FirebaseAuthException exception) async {
        formType = PhoneNumberSignInFormType.register;

        ///execute this when verification failed
        showExceptionAlertDialog(
            context: context,
            title: kOperationFailed,
            exception: exception.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        print('entered code sent');

        ///verificationId is generated here when code is sent to the phone number
        _verificationID = verificationId;
        codeSent();
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        print('entered code auto retrival');
        _verificationID = verificationId;
      },
      // timeout: const Duration(seconds: 120),
    );
  }

  @override
  Future<void> verifyOtpCode(BuildContext context, String name, String otpCode,
      VoidCallback onSignedIn) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationID,
      smsCode: otpCode,
    );

    print(_verificationID);
    await _authInstance.signInWithCredential(credential).then((value) {
      ///call this function if authentication is successful
      _onSignedInSuccess(name, onSignedIn);
    }).whenComplete(() {
      ///thread enteres this block whether or not there is an arror
    }).onError((FirebaseAuthException error, stackTrace) {
      showExceptionAlertDialog(
          context: context, title: kOperationFailed, exception: error.message);
    }).catchError((onError) {
      showExceptionAlertDialog(
          context: context, title: kOperationFailed, exception: onError);
    });
  }

  @override
  Future<void> signOut() async {
    _authInstance.signOut();
  }

  Future<void> _onSignedInSuccess(name, onSignedIn) async {
    await currentUser?.updateDisplayName(name);
    onSignedIn();
  }
}

final authRepositoryProvider = Provider<FirebaseAuthRepository>((ref) {
  final auth = FirebaseAuthRepository();
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
