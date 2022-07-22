// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../domain/product.dart';

class ProductUserFavourite {
  ProductUserFavourite({
    required this.product,
    required this.isFavourite,
  });
  final Product product;
  final bool isFavourite;
}
