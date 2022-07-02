import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/edit_profile_screen.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/welcome_screen.dart';
import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/account/presentation/account_screen.dart';
import '../features/authentication/presentation/account/presentation/edit_profile/presentation/image_gallery_screen.dart';
import '../features/authentication/presentation/sign_in/name_registration_screen.dart';
import '../features/chats/presentation/chat_screen.dart';
import '../features/products/presentation/add_product/add_product_screen.dart';
import '../features/products/presentation/home_app_bar/notifications/notifications_screen.dart';
import '../features/products/presentation/home_app_bar/search/presentation/home_search_bar/product_search_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import '../landing_page.dart';
import 'bottom_navigation_bar/home_page.dart';
import 'not_found_screen.dart';

enum AppRoute {
  landingPage,
  welcome,
  phonesignin,
  nameregisrtation,
  home,
  productList,
  product,
  products,
  leaveReview,
  orders,
  account,
  editprofile,
  imagegallery,
  signIn,
  addProduct,
  neighborhood,
  chat,
  profile,
  productsSearch,
  notifications,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    // initialLocation: '/',
    debugLogDiagnostics: true,
    // redirect: (state) {
    //   final userName = authRepository.currentUser?.displayName;
    //   final isLoggedIn = authRepository.currentUser != null;
    //   final hasName = userName != null && userName != kEmptyString;

    //   // if (isLoggedIn) {
    //   //   if (state.location == '/welcome/phonesingin/nameregistration') {
    //   //     return '/home';
    //   //   }
    //   // }

    //   return null;
    // },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
          path: '/',
          name: AppRoute.landingPage.name,
          builder: (context, state) => const LandingPage(),
          routes: [
            GoRoute(
                path: 'welcome',
                name: AppRoute.welcome.name,
                pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: WelcomePage()),
                routes: [
                  GoRoute(
                      path: 'phonesingin',
                      name: AppRoute.phonesignin.name,
                      pageBuilder: (context, state) => MaterialPage(
                            key: state.pageKey,
                            fullscreenDialog: true,
                            child: const SignInScreen(
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
                            child: const NameRegistrationScreen(),
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
                  path: 'productsSearch',
                  name: AppRoute.productsSearch.name,
                  pageBuilder: (context, state) => CupertinoPage(
                    key: state.pageKey,
                    child: const ProductSearchScreen(),
                  ),
                ),
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
                        ),
                    routes: [
                      GoRoute(
                          path: 'imagegallery',
                          name: AppRoute.imagegallery.name,
                          pageBuilder: (context, state) {
                            return MaterialPage(
                              key: state.pageKey,
                              fullscreenDialog: true,
                              child: const ImageGalleryScreen(),
                            );
                          },
                          routes: []),
                    ]),
              ],
            ),

            ///SignIn WIth phone screen
          ]),
    ],
    errorBuilder: (context, state) =>
        NotFoundScreen(errorMessage: state.error.toString()),
  );
});
