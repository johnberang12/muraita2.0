import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/domain/app_user.dart';
import 'package:muraita_2_0/src/features/sign_in_with_phone/sign_in_with_phone.dart';
import 'package:muraita_2_0/src/routing/bottom_navigation_bar/home_page.dart';

import 'features/authentication/data/auth_repository.dart';
import 'features/authentication/data/fake_auth_repository.dart';

class LandingPage extends ConsumerWidget {
  LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final isLoggedIn = authRepository.currentUser != null;
    print('entered landing page');

    if (isLoggedIn) return const HomePage();
    return const SignUpWithPhone();
  }
}
