// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';

import '../../../services/api_path.dart';
import '../../../services/firestore_service.dart';
import '../domain/app_user.dart';

abstract class UsersDatabase {
  Future<void> setUser(AppUser user);
  Future<void> deleteUser(AppUser user);
  Future<void> updateDisplayName(String displayName);
  Future<void> updatePhoneNumber(String phoneNumber);
  Future<void> updateEmail(String email);
  Future<void> updateEmailVerified(bool emailVerified);
  Future<void> updatePhoto(String photoUrl);
  Future<void> updateBirthDate(String birthDate);
  Future<void> updateProvidedData(String providedData);
  Future<void> updateSuccess(bool success);
  Stream<AppUser> watchUserInfo(String userId);
  Stream<List<AppUser>> watchUsers();
}

class UsersRepository implements UsersDatabase {
  UsersRepository({
    required this.ref,
  });
  Ref ref;

  final _service = FirestoreService.instance;

  @override
  Future<void> setUser(AppUser user) => _service.setData(
        path: APIPath.user(user.id),
        data: user.toMap(),
      );

  Future<void> setUserIfExist(AppUser userData) async {
    final user = ref.watch(authRepositoryProvider).currentUser;
    final path = APIPath.user(user!.uid);
    final reference = FirebaseFirestore.instance.doc(path);
    print('set userdata');
    reference.get().then((value) async {
      if (!value.exists) {
        await setUser(userData);
      }
    });
  }

  @override
  Future<void> deleteUser(AppUser user) => _service.deleteData(
        path: APIPath.user(user.id),
      );

  @override
  Future<void> updateBirthDate(String birthDate) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.updateDoc(
        path: APIPath.user(user!.uid), data: {'birthDate': birthDate});
  }

  @override
  Future<void> updateDisplayName(String displayName) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.updateDoc(
        path: APIPath.user(user!.uid), data: {'displayName': displayName});
  }

  @override
  Future<void> updateEmail(String email) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service
        .updateDoc(path: APIPath.user(user!.uid), data: {'email': email});
  }

  @override
  Future<void> updateEmailVerified(bool emailVerified) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.updateDoc(
        path: APIPath.user(user!.uid), data: {'emailVerified': emailVerified});
  }

  @override
  Future<void> updatePhoneNumber(String phoneNumber) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.updateDoc(
        path: APIPath.user(user!.uid), data: {'phoneNumber': phoneNumber});
  }

  @override
  Future<void> updatePhoto(String photoUrl) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.updateDoc(
      path: APIPath.user(user!.uid),
      data: {'photoUrl': photoUrl},
    );
  }

  @override
  Future<void> updateProvidedData(String providedData) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.updateDoc(
        path: APIPath.user(user!.uid), data: {'providedData': providedData});
  }

  @override
  Future<void> updateSuccess(bool success) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service
        .updateDoc(path: APIPath.user(user!.uid), data: {'success': success});
  }

  Future<void> updateUserLastActive(String userId) async {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return _service.updateDoc(
        path: APIPath.user(user!.uid),
        data: {'lastActive': DateTime.now().toUtc()});
  }

  @override
  Stream<AppUser> watchUserInfo(String userId) {
    return _service.documentStream<AppUser>(
        path: APIPath.user(userId),
        builder: (data, documentId) => AppUser.fromMap(data, documentId));
  }

  Stream<AppUser> watchProductOwner(String ownerId) {
    return _service.documentStream<AppUser>(
        path: APIPath.user(ownerId),
        builder: (data, documentId) => AppUser.fromMap(data, documentId));
  }

  @override
  Stream<List<AppUser>> watchUsers() => _service.collectionStream<AppUser>(
        path: APIPath.users(),
        builder: (data, documentId) => AppUser.fromMap(data, documentId),
      );
}

final userRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository(ref: ref);
});

final appUserInfoProvider = StreamProvider<AppUser?>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  final user = ref.watch(authRepositoryProvider).currentUser;
  return repository.watchUserInfo(user!.uid);
});

final usersListStreamProvider =
    StreamProvider.autoDispose<List<AppUser>>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.watchUsers();
});

final sellerInfoProvider =
    StreamProvider.family<AppUser, String>((ref, sellerId) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.watchProductOwner(sellerId);
});
