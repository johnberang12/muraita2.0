import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/products/presentation/home_app_bar/shopping_cart_icon.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';

/// Custom [AppBar] widget that is reused by the [ProductsListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class HomeAppBar extends ConsumerWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * This widget is responsive.
    // * On large screen sizes, it shows all the actions in the app bar.
    // * On small screen sizes, it shows only the shopping cart icon and a
    // * [MoreMenuButton].
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    ///to be changed with location
    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    return AppBar(
      title: Text(userName!),
      actions: [
        InkWell(
            onTap: () => context.pushNamed(AppRoute.productsSearch.name),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
              child: Icon(Icons.search),
            )),
        InkWell(
            onTap: () => context.pushNamed(AppRoute.notifications.name),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
              child: Icon(Icons.notifications),
            )),
        // ignore: prefer_const_constructors
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
