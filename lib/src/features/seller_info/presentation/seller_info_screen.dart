import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/async_value_widget.dart';
import '../../authentication/data/users_repository.dart';
import '../../authentication/domain/app_user.dart';

class SellerInfoScreen extends ConsumerWidget {
  const SellerInfoScreen({Key? key, required this.sellerId}) : super(key: key);
  final String sellerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellerInfoValue = ref.watch(sellerInfoProvider(sellerId));
    return Scaffold(
      appBar: AppBar(
        title: AsyncValueWidget<AppUser?>(
            value: sellerInfoValue,
            data: (seller) => Text(seller!.displayName!)),
      ),
      body: Center(
        child: Text('empty'),
      ),
    );
  }
}
