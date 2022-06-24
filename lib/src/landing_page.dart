import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/domain/app_user.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/welcome_screen.dart';
import 'package:muraita_2_0/src/routing/bottom_navigation_bar/home_page.dart';
import 'features/authentication/data/auth_repository.dart';
import 'dart:async';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authChanges = ref.watch(authStateChangesProvider);
    final authRepository = ref.watch(authRepositoryProvider);
    final isLoggedIn = authRepository.currentUser != null;

    print('entered landing page');

    if (isLoggedIn) return const HomePage();
    return const WelcomePage();
  }
}
