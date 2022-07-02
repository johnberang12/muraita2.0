// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

// typedef ProductID = String;

///to be added:
///seller location
class Product {
  Product({
    required this.id,
    this.title,
    this.photo,
    this.category,
    this.price,
    this.description,
    this.negotiable,
    required this.ownerId,
    this.avgRating = 0,
    this.numRatings = 0,
    this.success = true,
  });
  final String id;
  final String? title;
  final String? photo;
  final String? category;
  final int? price;
  final String? description;
  final bool? negotiable;
  final String ownerId;
  final int avgRating;
  final int numRatings;
  final bool success;

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: map['id'],
      title: map['title'],
      photo: map['photo'],
      category: map['category'],
      price: map['price'],
      description: map['description'],
      negotiable: map['negotiable'],
      ownerId: map['ownerId'],
      avgRating: map['avgRating'],
      numRatings: map['numRatings'],
      success: map['success'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'photo': photo,
      'category': category,
      'price': price,
      'description': description,
      'negotiable': negotiable,
      'ownerId': ownerId,
      'avgRating': avgRating,
      'numRatings': numRatings,
      'success': success,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, title: $title, photo: $photo, category: $category, price: $price, description: $description, negotiable: $negotiable, ownerId: $ownerId, avgRating: $avgRating, numRatings: $numRatings, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.photo == photo &&
        other.category == category &&
        other.price == price &&
        other.description == description &&
        other.negotiable == negotiable &&
        other.ownerId == ownerId &&
        other.avgRating == avgRating &&
        other.numRatings == numRatings &&
        other.success == success;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        photo.hashCode ^
        category.hashCode ^
        price.hashCode ^
        description.hashCode ^
        negotiable.hashCode ^
        ownerId.hashCode ^
        avgRating.hashCode ^
        numRatings.hashCode ^
        success.hashCode;
  }

  Product copyWith({
    String? id,
    String? title,
    String? photo,
    String? category,
    int? price,
    String? description,
    bool? negotiable,
    String? ownerId,
    int? avgRating,
    int? numRatings,
    bool? success,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      photo: photo ?? this.photo,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      negotiable: negotiable ?? this.negotiable,
      ownerId: ownerId ?? this.ownerId,
      avgRating: avgRating ?? this.avgRating,
      numRatings: numRatings ?? this.numRatings,
      success: success ?? this.success,
    );
  }
}
