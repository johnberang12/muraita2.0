// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class Listing {
  Listing(
      {required this.id,
      required this.image,
      required this.title,
      required this.category,
      required this.price,
      required this.description,
      required this.negotiable,
      required this.ownerId,
      required this.success});
  final String id;
  final File image;
  final String title;
  final String category;
  final int price;
  final String description;
  final bool negotiable;
  final String ownerId;
  final bool success;

  factory Listing.fromMap(Map<String, dynamic> map, String documentId) {
    return Listing(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      category: map['category'],
      price: map['price'],
      description: map['description'],
      negotiable: map['negotiable'],
      ownerId: map['ownerId'],
      success: map['success'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'category': category,
      'price': price,
      'description': description,
      'negotiable': negotiable,
      'ownerId': ownerId,
      'success': success,
    };
  }

  @override
  String toString() {
    return 'Listing(id: $id, image: $image, title: $title, category: $category, price: $price, description: $description, negotiable: $negotiable, ownerId: $ownerId, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Listing &&
        other.id == id &&
        other.image == image &&
        other.title == title &&
        other.category == category &&
        other.price == price &&
        other.description == description &&
        other.negotiable == negotiable &&
        other.ownerId == ownerId &&
        other.success == success;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        title.hashCode ^
        category.hashCode ^
        price.hashCode ^
        description.hashCode ^
        negotiable.hashCode ^
        ownerId.hashCode ^
        success.hashCode;
  }

  Listing copyWith({
    String? id,
    File? image,
    String? title,
    String? category,
    int? price,
    String? description,
    bool? negotiable,
    String? ownerId,
    bool? success,
  }) {
    return Listing(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      negotiable: negotiable ?? this.negotiable,
      ownerId: ownerId ?? this.ownerId,
      success: success ?? this.success,
    );
  }
}
