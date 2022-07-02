import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/data/auth_repository.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Text('onBoarding screen'),
          TextButton(
            child: const Text('Skip'),
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}
