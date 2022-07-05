// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../routing/app_router.dart';

class FilePickerRepository {
  File? pickedFileState;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;
    final file = File(result.files.first.path!);
    // final newFile = await saveFilePermanently(file);
    pickedFileState = file;
  }

  Future<void> pickeMultiFiles(List<File>? pickedFiles) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result == null) return;

    List<File> files = result.paths.map((path) => File(path!)).toList();
    List<File>? newFiles;
    for (var i = 0; i < files.length; i++) {
      final newFile = await saveFilePermanently(files[i]);
      newFiles!.add(newFile);
    }
    pickedFiles = newFiles!;
  }

  Future<void> pickDocuments(List<File>? pickedDocs) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result == null) return;
    List<File> files = result.paths.map((path) => File(path!)).toList();
    pickedDocs = files;
  }

  // Future<File> saveFilePermanently(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File('${appStorage.path}/${file.name}');
  //   return File(file.path!).copy(newFile.path);
  // }
  Future<File> saveFilePermanently(File file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = '$appStorage/$file';
    return File(file.path).copy(newFile);
  }

  void openFile(
          {required BuildContext context,
          required File file,
          required String route}) =>
      context.goNamed(route);
}

final filePickerRepositoryProvider =
    Provider<FilePickerRepository>((ref) => FilePickerRepository());
