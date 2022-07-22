// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../products/domain/product.dart';

class ProductCustomerModel {
  ProductCustomerModel({
    required this.product,
    required this.customerId,
  });
  final Product product;
  final String customerId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'customerId': customerId,
    };
  }

  factory ProductCustomerModel.fromMap(Map<String, dynamic> map) {
    return ProductCustomerModel(
      product: map['product'],
      customerId: map['customerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCustomerModel.fromJson(String source) =>
      ProductCustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductCustomerModel(product: $product, customerId: $customerId)';

  @override
  bool operator ==(covariant ProductCustomerModel other) {
    if (identical(this, other)) return true;

    return other.product == product && other.customerId == customerId;
  }

  @override
  int get hashCode => product.hashCode ^ customerId.hashCode;

  ProductCustomerModel copyWith({
    Product? product,
    String? customerId,
  }) {
    return ProductCustomerModel(
      product: product ?? this.product,
      customerId: customerId ?? this.customerId,
    );
  }
}
