import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/app.dart';
import 'package:muraita_2_0/src/localization/string_hardcoded.dart';

///this is my model project pushed at "muraita2.0" repo
void main() async {
  // * For more info on error handling, see:
  // * https://docs.flutter.dev/testing/errors
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await runZonedGuarded(() async {
    // turn off the # in the URLs on the web
    GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
    // * Entry point of the app
    runApp(const ProviderScope(child: MyApp()));

    // * This code will present some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text('An error occurred'),
          ),
          body: Center(child: Text(details.toString())),
        ),
      );
    };
  }, (Object error, StackTrace stack) {
    // * Log any errors to console
    debugPrint(error.toString());
  });
}
