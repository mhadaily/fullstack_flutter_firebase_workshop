import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mjcoffee/app.dart';
import 'helpers/src/handle_background_message.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  // assert(inDebugMode = true);
  return inDebugMode;
}

Future<void> main() async {
  // You only need to call this method if you need the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded<Future<void>>(() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    runApp(CoffeeApp());

    //
  }, (error, stackTrace) async {
    if (isInDebugMode) {
      // in development, print error and stack trace
      // ignore: avoid_print
      print('$error');
      // ignore: avoid_print
      print('$stackTrace');
    } else {
      // report to a error tracking system in production
    }
  });

  // You only need to call this method if you need the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    final dynamic exception = details.exception;
    final StackTrace? stackTrace = details.stack;
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone
      if (stackTrace != null) {
        Zone.current.handleUncaughtError(exception, stackTrace);
      }
    }
  };
}
