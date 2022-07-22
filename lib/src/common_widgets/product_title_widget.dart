import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/app_colors.dart';
import '../constants/strings.dart';
import '../constants/styles.dart';
import '../features/products/domain/product.dart';

class ProductTitleWidget extends StatelessWidget {
  const ProductTitleWidget(
      {Key? key, required this.product, this.style = Styles.k14Bold})
      : super(key: key);

  final Product? product;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Text('Product not fount')
        : Row(
            children: [
              product!.status == kProductStatus[0] ||
                      product!.status == kProductStatus[1]
                  ? const SizedBox()
                  : Text(
                      '[${product!.status}] ',
                      style: style.copyWith(
                          color: product!.status == kProductStatus[2]
                              ? Colors.green
                              : AppColors.black40),
                    ),
              Expanded(
                child: Text(
                  product!.title,
                  // 'adfhr adfh adfh adfh adfh afdsh adfh adfh adfh adfh adfh ',
                  style: style,
                  // softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
  }
}
