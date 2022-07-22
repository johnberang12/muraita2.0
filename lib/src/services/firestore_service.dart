import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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

  Future<void> mergeData(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: true));
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  // Future<void> deleteCollection({required String path}) async {
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   await reference.doc(getDoc(path: ))
  // }

  Future<void> addCollection(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.collection(path);
    await reference.add(data);
  }

  Future<void> updateDoc(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);
  }

  Future<void> getDoc({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.get();
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

  Stream<List<T>> filteredCollectionStream<T>(
      {required String path,
      required String fieldKey,
      required String fieldValue,
      required T Function(Map<String, dynamic> data, String documentId) builder,
      Query Function(Query? query)? queryBuilder,
      int Function(T lhs, T rhs)? sort}) {
    Query query = FirebaseFirestore.instance
        .collection(path)
        .where(fieldKey, isEqualTo: fieldValue);
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

  ///unimplemented///to be revised
  Stream<List<T>> filteredCollectionWidCondition<T>(
      {required String path,
      required String primaryFieldKey,
      required String primaryFieldValue,
      required String secondaryFieldKey,
      required String secondaryFieldValue,
      // required String sellerId,
      // required String productStatus,
      required T Function(Map<String, dynamic> data, String documentId) builder,
      Query Function(Query? query)? queryBuilder,
      int Function(T lhs, T rhs)? sort}) {
    Query query = FirebaseFirestore.instance
        .collection(path)
        .where(primaryFieldKey, isEqualTo: primaryFieldValue)
        .where(secondaryFieldKey, isEqualTo: secondaryFieldValue);
    // .where('sellerId', isEqualTo: sellerId)
    // .where('status', isEqualTo: productStatus);

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

      ///original working code
      // required T builder(Map<String, dynamic> data, String documentId)
      required T Function(Map<String, dynamic> data, String documentId)
          builder}) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()!, snapshot.id));
  }
}





  // Future<void> updateUserData({
  //   required String uid,
  //   String? displayName,
  //   String? phoneNumber,
  //   List? email,
  //   bool? emailVerified,
  //   String? photoUrl,
  //   String? birthDate,
  //   String? providedData,
  //   bool? success,
  // }) async {
  //   final authRepository = FirebaseAuthRepository();
  //   final reference = FirebaseFirestore.instance.doc(APIPath.user(uid));
  //   final userData = authRepository.currentUser;

  //   final user = AppUser(
  //     id: uid,
  //     uid: uid,
  //     displayName: displayName ?? userData?.displayName,
  //     phoneNumber: phoneNumber ?? userData!.phoneNumber!,
  //     userLocation: kUserLocation,
  //     email: email,
  //     //  ?? userData?.email ?? '',
  //     emailVerified: emailVerified ?? userData?.emailVerified ?? false,
  //     photoUrl: photoUrl ?? userData?.photoURL ?? '',
  //     birthDate: birthDate ?? '',
  //     providedData: providedData ?? '',
  //     success: success ?? true,
  //   );
  //   await reference.set(user.toMap());
  // }