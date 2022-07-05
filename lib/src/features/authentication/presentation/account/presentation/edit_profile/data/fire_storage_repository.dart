import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/constants/strings.dart';

class FireStorageRopository {
  final storage = FirebaseStorage.instance.ref();
  final _user = FirebaseAuth.instance.currentUser;
  // storageBucket: 'gs://muraita-app.appspot.com',
  final metadata = SettableMetadata(contentType: 'image/jpeg');
  UploadTask? uploadTask;
  List<String>? listOfImageUrls;
  String? imageUrl;

  ///this function is use to upload an image taken from phone camera.
  Future<String> uploadFile(File file) async {
    final userId = _user?.uid;
    final storageRef =
        storage.child('user/profile/$userId${_user?.displayName}.jpg');

    uploadTask = storageRef.putFile(file, metadata);
    final snapshot = await uploadTask?.whenComplete(() {});
    final url = await snapshot!.ref.getDownloadURL();
    return imageUrl = url;
  }

  ///this uploads a list of files
  Future<void> uploadFunction(List<File> files) async {
    for (int i = 0; i < files.length; i++) {
      var url = await uploadFile(files[i]);
      listOfImageUrls?.add(url);
    }
  }
}

final fireStorageRopositoryProvider = Provider<FireStorageRopository>((ref) {
  return FireStorageRopository();
});

final uploadTaskProvider = StreamProvider.autoDispose<TaskSnapshot>((ref) {
  final controller = ref.watch(fireStorageRopositoryProvider);
  return controller.uploadTask!.snapshotEvents;
});
