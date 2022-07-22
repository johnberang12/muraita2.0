// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Favourite {
  Favourite({required this.productId, this.isFavourite = true});

  final String productId;
  final bool isFavourite;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'isFavourite': isFavourite,
    };
  }

  factory Favourite.fromMap(Map<String, dynamic> map, String documentId) {
    return Favourite(
      productId: map['productId'] as String,
      isFavourite: map['isFavourite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favourite.fromJson(String source, String documentId) =>
      Favourite.fromMap(
          json.decode(source) as Map<String, dynamic>, documentId);

  @override
  String toString() =>
      'Favourite(productId: $productId, isFavourite: $isFavourite)';

  @override
  bool operator ==(covariant Favourite other) {
    if (identical(this, other)) return true;

    return other.productId == productId && other.isFavourite == isFavourite;
  }

  @override
  int get hashCode => productId.hashCode ^ isFavourite.hashCode;

  Favourite copyWith({
    String? productId,
    bool? isFavourite,
  }) {
    return Favourite(
      productId: productId ?? this.productId,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
