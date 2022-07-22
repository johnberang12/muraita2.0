import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authRepository = ref.watch(authRepositoryProvider);
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
