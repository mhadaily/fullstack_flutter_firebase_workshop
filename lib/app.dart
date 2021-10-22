import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mjcoffee/router.dart';
import 'package:mjcoffee/theme.dart';

class CoffeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: getTheme(),
    );
  }
}
