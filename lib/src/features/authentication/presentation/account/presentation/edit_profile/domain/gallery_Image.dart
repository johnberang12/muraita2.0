// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:photo_manager/photo_manager.dart';

class GalleryImage {
  GalleryImage({
    required this.image,
    this.isSelected = false,
  });
  AssetEntityImage image;
  bool isSelected;

  toggleDone() {
    isSelected = !isSelected;
  }
}
