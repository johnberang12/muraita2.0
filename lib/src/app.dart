// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/localization/string_hardcoded.dart';
import 'package:muraita_2_0/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
    // required this.client,
    // required this.channel,
  });
  // final StreamChatClient client;
  // final Channel channel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
        routerDelegate: goRouter.routerDelegate,
        routeInformationParser: goRouter.routeInformationParser,
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        onGenerateTitle: (BuildContext context) => 'My Shop'.hardcoded,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(
            backgroundColor: appBackground,
            foregroundColor: AppColors.black80,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffffbf00), // background (button) color
              onPrimary: Colors.white, // foreground (text) color
            ),
          ),
        ),
        builder: EasyLoading.init());
  }
}
