import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_state.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';
import '../domain/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  Future<void> registerWithPhoneNumber(String name, String phoneNumber);
  Future<void> verifyOtpCode(String otpCode);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() {
    throw UnimplementedError();
  }

  @override
  Future<void> registerWithPhoneNumber(String name, String phoneNumber) {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtpCode(String otpCode) async {
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true, this.formType});
  final bool addDelay;
  final _authState = InMemoryStore<AppUser?>(null);
  PhoneNumberSignInFormType? formType;

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> registerWithPhoneNumber(String name, String phoneNumber) async {
    await delay(addDelay);

    formType = PhoneNumberSignInFormType.otpVerification;
  }

  @override
  Future<void> verifyOtpCode(String otpCode) async {
    await delay(addDelay);

    _createNewUser(otpCode);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);

    _createNewUser(email);
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await delay(addDelay);
    _createNewUser(email);
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  void dispose() => _authState.close();

  void _createNewUser(String email) {
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
