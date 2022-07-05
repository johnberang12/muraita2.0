import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'files_screen.dart';


class NeighborhoodScreen extends StatefulWidget {
   NeighborhoodScreen({Key? key}) : super(key: key);


  @override
  State<NeighborhoodScreen> createState() => _NeighborhoodScreenState();
}

class _NeighborhoodScreenState extends State<NeighborhoodScreen> {
  List<File>? _pickedImages;
  bool _isLoading = false;



  Future<void> _pickImage() async {
    print('getting results...');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
     withReadStream: true,
      // allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if(result == null ) return;
    print('results are $result');

    final file = result.files.first;
    // openFile(file);
    print('name: ${file.name}');
    print('bytes: ${file.bytes}');
    print('extension: ${file.extension}');
    print('path: ${file.path}');

    List<File> files = result.paths.map((path) => File(path!)).toList();
    setState(() {
      _pickedImages = files;

    });

    openFiles(result.files);

    final newFile = await saveFilePermanently(file);




      // User canceled the picker



  }

  void openFiles(List<PlatformFile> files) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => FilesScreen(
    files: files,

  )));

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
        child: ElevatedButton(
            onPressed: ()=> _pickImage(),
            child: Text('pick image')),
      ),
    );
  }
}
