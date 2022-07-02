import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/constants/strings.dart';

class StorageRopository {
  final storage = FirebaseStorage.instance.ref();
  // storageBucket: 'gs://muraita-app.appspot.com',

  final _user = FirebaseAuth.instance.currentUser;

  ///this function is use to upload an image in a File format.
  Future<bool> uploadImageFile(BuildContext context, File file) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      final userId = _user?.uid;
      final storageRef = storage.child('user/profile/$userId');
      await storageRef.putFile(file, metadata);

      return true;
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
          context: context, title: kOperationFailed, exception: e);
    }
    return false;
  }

  ///this function listens to state changes, errors and completion of the upload.
// Future<void> _uploadInProgress(UploadTask) async {
// UploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot){
// swicth (taskSnapshot.state){
//   case TaskState.runnung:
//   final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
// ///show upload in progress
// break;
//  case TaskState.paused:
//       print("Upload is paused.");
//       break;
//     case TaskState.canceled:
//       print("Upload was canceled");
//       break;
//     case TaskState.error:
//       // Handle unsuccessful uploads
//       break;
//     case TaskState.success:
//       // Handle successful uploads on complete
//       // ...
//       break;
// }
// });
// }

}
