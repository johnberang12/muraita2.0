// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireStorageRopository {
  FireStorageRopository({
    required this.ref,
  });
  Ref ref;
  TaskSnapshot? taskSnapshot;
  final storage = FirebaseStorage.instance.ref();
  final _user = FirebaseAuth.instance.currentUser;
  // storageBucket: 'gs://muraita-app.appspot.com',
  final metadata = SettableMetadata(contentType: 'image/jpeg');
  UploadTask? uploadTask;

  ///this is a list of image urls extracted from uploading images to fire storage
  List<String> listOfImageUrls = [];

  ///thid is used to store extracted photoUrl from uploading images
  String? imageUrl;
  File? _cahedImageFile;

  ///this function is use to upload an users profile image
  Future<String> uploadImageFile(File file, String path) async {
    final storageRef = storage.child(path);

    final uploadTask = storageRef.putFile(file, metadata);
    taskSnapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await taskSnapshot!.ref.getDownloadURL();

    ///snapshot will be used to display upload progress in the UI
    return imageUrl;
  }

  ///This is a function used to upload product images to firebase
  // Future<String> uploadProductImages(File file, String path) async {
  //   final productCategory = ref.read(productCategoryProvider.state).state;

  //   final storageRef = storage.child(path);

  //   final uploadTask = storageRef.putFile(file, metadata);
  //   final snapshot = await uploadTask.whenComplete(() {});
  //   final url = await snapshot.ref.getDownloadURL();
  //   return imageUrl = url;
  // }

  // /this uploads a list of files

  Future<List<String>> uploadFunction(List<File> files, String path) async {
    List<String> urls = [];
    for (int i = 0; i < files.length; i++) {
      var url = await uploadImageFile(files[i], path);
      urls.add(url);
    }
    return urls;
  }

  ///upload with caching
  Future<void> uploadImage(String filepath) async {
    final userId = _user?.uid;
    final ByteData bytes = await rootBundle.load(filepath);
    final Directory tempDir = Directory.systemTemp;
    final String fileName = '$userId/${Random().nextInt(10000)}.jpg';
    final File file = File('${tempDir.path}/$fileName');
    file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

    final UploadTask uploadTask = storage.child(fileName).putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
  }

  Future<File> downloadFile(String downloadUrl) async {
    final RegExp regExp = RegExp('[^?/]*\.(jpg)');
    final String? fileName = regExp.stringMatch(downloadUrl);
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$fileName');

    final downloadTask = await storage.child(fileName!).writeToFile(file);

    ///user downloadTask to show download progress in the UI
    print(downloadTask);
    _cahedImageFile = file;
    return file;
  }
}

final fireStorageRopositoryProvider = Provider<FireStorageRopository>((ref) {
  return FireStorageRopository(ref: ref);
});

final uploadTaskProvider = StreamProvider.autoDispose<TaskSnapshot>((ref) {
  final controller = ref.watch(fireStorageRopositoryProvider);
  return controller.uploadTask!.snapshotEvents;
});

final cachedImageFileProvider = StateProvider<File>((ref) {
  final storage = ref.watch(fireStorageRopositoryProvider);
  return storage._cahedImageFile!;
});

final uploadSnapshotProvider = StateProvider<double>((ref) {
  final snapshot =
      ref.watch(fireStorageRopositoryProvider).uploadTask?.snapshot;
  final progress = snapshot!.bytesTransferred / snapshot.totalBytes;
  return progress;
});
