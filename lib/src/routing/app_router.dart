import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/edit_profile_screen.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/welcome_screen.dart';
import 'package:muraita_2_0/src/features/products/presentation/seller_products_list/seller_products_list_screen.dart';
import 'package:muraita_2_0/src/features/settings/presentation/settings_screen.dart';
import '../features/authentication/data/auth_repository.dart';

import '../../photo_manager/image_gallery_screen.dart';
import '../features/authentication/presentation/account/presentation/favorites/favourites_list_screen.dart';
import '../features/authentication/presentation/sign_in/name_registration_screen.dart';

import '../features/chats/presentation/chat/chat_screen.dart';
import '../features/products/domain/product.dart';
import '../features/products/presentation/add_product/add_product_screen.dart';
import '../features/products/presentation/home_app_bar/notifications/notifications_screen.dart';
import '../features/products/presentation/home_app_bar/search/presentation/home_search_bar/product_search_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import '../features/seller_info/presentation/seller_info_screen.dart';
import '../landing_page.dart';
import 'bottom_navigation_bar/home_page.dart';
import 'not_found_screen.dart';

enum AppRoute {
  landing,
  welcome,
  signin,
  nameregisrtation,
  home,
  product,
  myproducts,
  productsSearch,
  addProduct,
  notifications,
  editprofile,
  chat,
  sellerinfo,
  settings,
  favourites,
  // orders,
  // account,

  // imagegallery,
  // signIn,

  // neighborhood,

  // profile,

  // productList,
  // products,
  leaveReview,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    // initialLocation: '/home',
    // debugLogDiagnostics: true,
    // redirect: (state) {
    //   final isLoggedIn = authRepository.currentUser != null;

    //   if (!isLoggedIn) {
    //     return '/welcome';
    //   }

    //   return null;
    // },
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
          path: '/',
          name: AppRoute.landing.name,
          builder: (context, state) => const LandingPage(),
          routes: [
            GoRoute(
                path: 'welcome',
                name: AppRoute.welcome.name,
                pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const WelcomePage()),
                routes: [
                  GoRoute(
                      path: 'singin',
                      name: AppRoute.signin.name,
                      pageBuilder: (context, state) => MaterialPage(
                            key: state.pageKey,
                            fullscreenDialog: true,
                            child: SignInScreen(
                              formType: SignInFormType.register,
                            ),
                          ),
                      routes: [
                        GoRoute(
                          path: 'nameregistration',
                          name: AppRoute.nameregisrtation.name,
                          pageBuilder: (context, state) => MaterialPage(
                            key: state.pageKey,
                            fullscreenDialog: true,
                            child: NameRegistrationScreen(),
                          ),
                        ),
                      ]),
                ]),

            // /Home page is the default page that returns ProductListingsScreen
            GoRoute(
              path: 'home',
              name: AppRoute.home.name,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'product/:id',
                  name: AppRoute.product.name,
                  builder: (context, state) {
                    final productId = state.params['id']!;
                    return ProductScreen(productId: productId);
                  },
                  routes: [
                    GoRoute(
                      path: 'review',
                      name: AppRoute.leaveReview.name,
                      pageBuilder: (context, state) {
                        final productId = state.params['id']!;
                        return MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: LeaveReviewScreen(productId: productId),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: 'sellerinfo/:sellerId',
                  name: AppRoute.sellerinfo.name,
                  builder: (context, state) {
                    final sellerId = state.params['sellerId'];
                    return SellerInfoScreen(
                      sellerId: sellerId!,
                    );
                  },
                ),
                GoRoute(
                  path: 'myproducts/:ownerId',
                  name: AppRoute.myproducts.name,
                  builder: (context, state) {
                    final ownerId = state.params['ownerId'];
                    return SellerProductsListScreen(
                      userId: ownerId!,
                    );
                  },
                ),
                GoRoute(
                  path: 'productsSearch',
                  name: AppRoute.productsSearch.name,
                  pageBuilder: (context, state) => CupertinoPage(
                    key: state.pageKey,
                    child: const ProductSearchScreen(),
                  ),
                ),
                GoRoute(
                    path: 'chat/:customerId',
                    name: AppRoute.chat.name,
                    pageBuilder: (context, state) {
                      final product = state.extra! as Product;
                      final customerId = state.params['customerId'];
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: ChatScreen(
                          customerId: customerId!,
                          product: product,
                        ),
                      );
                    },
                    routes: []),
                GoRoute(
                  path: 'addListing',
                  name: AppRoute.addProduct.name,
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: AddProductScreen(),
                  ),
                ),
                GoRoute(
                  path: 'notifications',
                  name: AppRoute.notifications.name,
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: const NotificationsScreen(),
                  ),
                ),
                GoRoute(
                    path: 'editprofile',
                    name: AppRoute.editprofile.name,
                    pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: const EditProfileScreen(),
                        )),
                GoRoute(
                    path: 'settings',
                    name: AppRoute.settings.name,
                    pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: const SettingsScreen(),
                        )),
                GoRoute(
                    path: 'favourites',
                    name: AppRoute.favourites.name,
                    pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: const FavouriteListScreen(),
                        )),
              ],
            ),

            ///SignIn WIth phone screen
          ]),
    ],
    errorBuilder: (context, state) =>
        NotFoundScreen(errorMessage: state.error.toString()),
  );
});
