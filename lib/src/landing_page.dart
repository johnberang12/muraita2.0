import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/name_registration_screen.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/welcome_screen.dart';
import 'package:muraita_2_0/src/routing/bottom_navigation_bar/home_page.dart';
import 'features/authentication/data/auth_repository.dart';
import 'dart:async';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userName = authRepository.currentUser?.displayName;
    final isLoggedIn = authRepository.currentUser != null;
    final hasName = userName != null && userName != kEmptyString;

    print('entered landing page');

    if (isLoggedIn && hasName) {
      return const HomePage();
    } else if (isLoggedIn && !hasName) {
      return const NameRegistrationScreen();
    } else {
      return const WelcomePage();
    }
  }
}
