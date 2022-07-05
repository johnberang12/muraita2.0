import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/common_widgets/custom_image.dart';
import 'package:muraita_2_0/src/common_widgets/grid_layout.dart';
import 'package:open_file/open_file.dart';

import '../../common_widgets/responsive_center.dart';

class FilesScreen extends StatelessWidget {
   FilesScreen({Key? key, required this.files,}) : super(key: key);
  List<PlatformFile> files;
  // void Function(PlatformFile) onOpenFile;
   final _scrollController = ScrollController();

   void openFile(PlatformFile file){
     OpenFile.open(file.path);
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ResponsiveSliverCenter(
            child: GridLayout(
              rowsCount: 4,
              itemCount: files.length,
              itemBuilder: (_,index){
                final image = files[index];
                return InkWell(
                  onTap: ()=> openFile(image),
                    child: CustomImage(imageUrl: image.path!));
              },
            ),
          )
        ],
      ),
    );
  }
}
