import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/data/users_repository.dart';
import 'package:muraita_2_0/src/services/api_path.dart';

import '../features/authentication/domain/app_user.dart';
import '../features/products/presentation/add_product/add_product_screen.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  ///this is a general purpose method to get a document from firestore

  /// used to add and edit data in database
  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Future<void> updateUserData({
    required String uid,
    String? displayName,
    String? phoneNumber,
    String? email,
    bool? emailVerified,
    String? photoUrl,
    String? birthDate,
    String? providedData,
    bool? success,
  }) async {
    final authRepository = FirebaseAuthRepository();
    final reference = FirebaseFirestore.instance.doc(APIPath.user(uid));
    final userData = authRepository.currentUser;

    final user = AppUser(
      id: uid,
      uid: uid,
      displayName: displayName ?? userData?.displayName,
      phoneNumber: phoneNumber ?? userData!.phoneNumber!,
      email: email ?? userData?.email ?? '',
      emailVerified: emailVerified ?? userData?.emailVerified ?? false,
      photoUrl: photoUrl ?? userData?.photoURL ?? '',
      birthDate: birthDate ?? '',
      providedData: providedData ?? '',
      success: success ?? true,
    );
    await reference.set(user.toMap());
  }

  Stream<List<T>> collectionStream<T>(
      {required String path,
      required T Function(Map<String, dynamic> data, String documentId) builder,
      Query Function(Query? query)? queryBuilder,
      int Function(T lhs, T rhs)? sort}) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>(
      {required String path,
      required T builder(Map<String, dynamic> data, String documentId)}) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()!, snapshot.id));
  }
}
