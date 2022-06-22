import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/chats/chats_screen.dart';
import 'package:muraita_2_0/src/features/neighbors/neighborhood_screen.dart';
import '../features/authentication/data/fake_auth_repository.dart';
import '../features/authentication/presentation/account/account_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import '../features/products/presentation/home_app_bar/notifications/notifications_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import '../features/search/presentation/home_search_bar/product_search_screen.dart';
import '../landing_page.dart';
import 'bottom_navigation_bar/home_page.dart';
import 'not_found_screen.dart';

enum AppRoute {
  landingPage,
  signInWithPhone,
  home,
  productListings,
  product,
  leaveReview,
  orders,
  account,
  signIn,
  neighborhood,
  chats,
  profile,
  productsSearch,
  notifications,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.location == '/signIn') {
          return '/';
        }
      } else {
        if (state.location == '/account' || state.location == '/orders') {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.landingPage.name,
        builder: (context, state) => LandingPage(),
        routes: [
          ///Home page is the default page that returns ProductListingsScreen
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
                path: 'productsSearch',
                name: AppRoute.productsSearch.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: ProductSearchScreen(),
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
                path: 'account',
                name: AppRoute.account.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const AccountScreen(),
                ),
              ),
              // GoRoute(
              //   path: 'signIn',
              //   name: AppRoute.signIn.name,
              //   pageBuilder: (context, state) => MaterialPage(
              //     key: state.pageKey,
              //     fullscreenDialog: true,
              //     child: const EmailPasswordSignInScreen(
              //       formType: EmailPasswordSignInFormType.signIn,
              //     ),
              //   ),
              // ),

              ///neighborhood screen
              GoRoute(
                path: 'neighborhood',
                name: AppRoute.neighborhood.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const NeighborhoodScreen(),
                ),
              ),

              ///chats screen
              GoRoute(
                path: 'chats',
                name: AppRoute.chats.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const ChatsScreen(),
                ),
              ),
            ],
          ),

          ///SignIn WIth phone screen
          GoRoute(
            path: 'signInWithPhone',
            name: AppRoute.signInWithPhone.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.register,
              ),
            ),
          )
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
