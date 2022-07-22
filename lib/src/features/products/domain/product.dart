import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/strings.dart';

import 'package:muraita_2_0/src/features/products/data/products_repository.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

// typedef ProductID = String;

///to be added:
///seller location
class Product {
  Product({
    required this.id,
    required this.title,
    required this.photos,
    required this.category,
    required this.price,
    required this.description,
    required this.location,
    this.negotiable = false,
    required this.ownerId,
    this.followCount = 0,
    this.messageCount = 0,
    this.status = 'Active',
    this.success = true,
  });
  final String id;
  final String title;
  final List photos;
  final String category;
  final int price;
  final String? description;
  final String location;
  final bool? negotiable;
  final String ownerId;
  final int followCount;
  int messageCount;
  final String status;
  final bool success;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'photos': photos,
      'category': category,
      'price': price,
      'description': description,
      'location': location,
      'negotiable': negotiable,
      'ownerId': ownerId,
      'followCount': followCount,
      'messageCount': messageCount,
      'status': status,
      'success': success,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String productId) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      photos: List.from((map['photos'] as List)),
      category: map['category'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
      negotiable: map['negotiable'] != null ? map['negotiable'] as bool : null,
      location: map['location'] as String,
      ownerId: map['ownerId'] as String,
      followCount: map['followCount'] as int,
      messageCount: map['messageCount'] as int,
      status: map['status'] as String,
      success: map['success'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Product(id: $id, title: $title, photos: $photos, category: $category, price: $price, description: $description, location: $location, negotiable: $negotiable, ownerId: $ownerId, followCount: $followCount, messageCount: $messageCount, status: $status, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        listEquals(other.photos, photos) &&
        other.category == category &&
        other.price == price &&
        other.description == description &&
        other.location == location &&
        other.negotiable == negotiable &&
        other.ownerId == ownerId &&
        other.followCount == followCount &&
        other.messageCount == messageCount &&
        other.status == status &&
        other.success == success;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        photos.hashCode ^
        category.hashCode ^
        price.hashCode ^
        description.hashCode ^
        location.hashCode ^
        negotiable.hashCode ^
        ownerId.hashCode ^
        followCount.hashCode ^
        messageCount.hashCode ^
        status.hashCode ^
        success.hashCode;
  }

  Product copyWith({
    String? id,
    String? title,
    List? photos,
    String? category,
    int? price,
    String? description,
    String? location,
    bool? negotiable,
    String? ownerId,
    int? followCount,
    int? messageCount,
    String? status,
    bool? success,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      photos: photos ?? this.photos,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      location: location ?? this.location,
      negotiable: negotiable ?? this.negotiable,
      ownerId: ownerId ?? this.ownerId,
      followCount: followCount ?? this.followCount,
      messageCount: messageCount ?? this.messageCount,
      status: status ?? this.status,
      success: success ?? this.success,
    );
  }
}


// final productProvider = Provider<Product>((ref) => Product());