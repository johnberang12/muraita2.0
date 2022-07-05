import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';

import '../../../services/api_path.dart';
import '../../../services/firestore_service.dart';
import '../domain/app_user.dart';

abstract class UsersDatabase {
  Future<void> setUser(AppUser user);
  Future<void> deleteUser(AppUser user);
  Future<void> updateDisplayName(String userId, String displayName);
  Future<void> updatePhoneNumber(String userId, String phoneNumber);
  Future<void> updateEmail(String userId, String email);
  Future<void> updateEmailVerified(String userId, bool emailVerified);
  Future<void> updatePhoto(String userId, String photoUrl);
  Future<void> updateBirthDate(String userId, String birthDate);
  Future<void> updateProvidedData(String userId, String providedData);
  Future<void> updateSuccess(String userId, bool success);
}

class UsersRepository implements UsersDatabase {
  final _service = FirestoreService.instance;
  final _auth = FirebaseAuthRepository();

  @override
  Future<void> setUser(AppUser user) => _service.setData(
        path: APIPath.user(user.id),
        data: user.toMap(),
      );

  @override
  Future<void> deleteUser(AppUser user) => _service.deleteData(
        path: APIPath.user(user.id),
      );

  @override
  Future<void> updateBirthDate(String userId, String birthDate) =>
      _service.updateUserData(uid: userId, birthDate: birthDate);

  @override
  Future<void> updateDisplayName(String userId, String displayName) =>
      _service.updateUserData(uid: userId, displayName: displayName);

  @override
  Future<void> updateEmail(String userId, String email) =>
      _service.updateUserData(uid: userId, email: email);

  @override
  Future<void> updateEmailVerified(String userId, bool emailVerified) =>
      _service.updateUserData(uid: userId, emailVerified: emailVerified);

  @override
  Future<void> updatePhoneNumber(String userId, String phoneNumber) =>
      _service.updateUserData(uid: userId, phoneNumber: phoneNumber);

  @override
  Future<void> updatePhoto(String userId, String photoUrl) =>
      _service.updateUserData(uid: userId, photoUrl: photoUrl);

  @override
  Future<void> updateProvidedData(String userId, String providedData) =>
      _service.updateUserData(uid: userId, providedData: providedData);
  @override
  Future<void> updateSuccess(String userId, bool success) =>
      _service.updateUserData(uid: userId, success: success);

  Stream<AppUser> watchUserInfo() => _service.documentStream<AppUser>(
      path: APIPath.user(_auth.currentUser!.uid),
      builder: (data, userId) => AppUser.fromMap(data, userId));
}

final userRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository();
});

final userInfoProvider = StreamProvider<AppUser?>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.watchUserInfo();
});
