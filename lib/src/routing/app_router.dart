import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_screen.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_state.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/welcome_screen.dart';
import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/account/account_screen.dart';
import '../features/chats/chats_screen.dart';
import '../features/products/presentation/add_listing/add_listing_screen.dart';
import '../features/products/presentation/add_listing/listings_screen.dart';
import '../features/products/presentation/home_app_bar/notifications/notifications_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import '../features/search/presentation/home_search_bar/product_search_screen.dart';
import '../landing_page.dart';
import 'bottom_navigation_bar/home_page.dart';
import 'not_found_screen.dart';

enum AppRoute {
  landingPage,
  phonesignin,
  welcome,
  home,
  productListings,
  product,
  listings,
  leaveReview,
  orders,
  account,
  signIn,
  addListing,
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
    debugLogDiagnostics: true,
    redirect: (state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.location == '/welcome/phonesingin') {
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
        builder: (context, state) => const LandingPage(),
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
                path: 'addListing',
                name: AppRoute.addListing.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: AddListingScreen(),
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
              GoRoute(
                path: 'listings',
                name: AppRoute.listings.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const ListingsScreen(),
                  );
                },
              ),

              ///temporarily inserted listings screen
              // GoRoute(
              //   path: 'neighborhood',
              //   name: AppRoute.neighborhood.name,
              //   pageBuilder: (context, state) => MaterialPage(
              //     key: state.pageKey,
              //     fullscreenDialog: true,
              //     child: const NeighborhoodScreen(),
              //   ),
              // ),

              ///chats screen
              GoRoute(
                path: 'chats',
                name: AppRoute.chats.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: ChatsScreen(),
                ),
              ),
            ],
          ),

          ///SignIn WIth phone screen
          GoRoute(
              path: 'welcome',
              name: AppRoute.welcome.name,
              pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const WelcomePage(),
                  ),
              routes: [
                GoRoute(
                  path: 'phonesingin',
                  name: AppRoute.phonesignin.name,
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const PhoneNumberSignInScreen(
                      formType: PhoneNumberSignInFormType.register,
                    ),
                  ),
                )
              ])
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
