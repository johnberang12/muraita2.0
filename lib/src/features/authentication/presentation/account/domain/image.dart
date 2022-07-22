// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Image {
//   Image({
//     required this.id,
//     required this.imageUrl,
//     this.success = true,
//   });
//   final String id;
//   final String imageUrl;
//   final bool success;

//   factory Image.fromMap(Map<String, dynamic> map, String imageId) {
//     return Image(
//       id: map['id'],
//       imageUrl: map['imageUrl'],
//       success: map['success'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'imageUrl': imageUrl,
//       'success': success,
//     };
//   }

//   @override
//   String toString() => 'Image(id: $id, imageUrl: $imageUrl, success: $success)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Image &&
//         other.id == id &&
//         other.imageUrl == imageUrl &&
//         other.success == success;
//   }

//   @override
//   int get hashCode => id.hashCode ^ imageUrl.hashCode ^ success.hashCode;

//   Image copyWith({
//     String? id,
//     String? imageUrl,
//     bool? success,
//   }) {
//     return Image(
//       id: id ?? this.id,
//       imageUrl: imageUrl ?? this.imageUrl,
//       success: success ?? this.success,
//     );
//   }
// }
