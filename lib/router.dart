import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mjcoffee/screens/cart.dart';
import 'package:mjcoffee/screens/forgot_password.dart';
import 'package:mjcoffee/screens/login_email.dart';
import 'package:mjcoffee/screens/profile.dart';
import 'package:mjcoffee/services/src/analytics.dart';

import 'const.dart';
import 'models/models.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/menu.dart';
import 'screens/menu_detail.dart';
import 'screens/splash.dart';
import 'services/src/auth.dart';

class LoginInfo extends ChangeNotifier {
  var _isLoggedIn = AuthService.instance.currentUser != null;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

final loginInfo = LoginInfo();

Coffee _coffeeFrom(String s) {
  return coffees.where((coffee) => coffee.id.toString() == s).first;
}

final router = GoRouter(
  redirect: (GoRouterState state) {
    final loggedIn = loginInfo.isLoggedIn;
    final isLogging = state.location == '/login';
    if (!loggedIn && !isLogging) return '/login';
    if (loggedIn && isLogging) return '/';
    return null;
  },
  observers: <NavigatorObserver>[AnalyticsService.observer],
  refreshListenable: loginInfo,
  urlPathStrategy: UrlPathStrategy.path,
  debugLogDiagnostics: false,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'spalsh',
      path: '/splash',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      name: 'home',
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      name: 'login_password',
      path: '/login_password',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginEmailScreen(),
      ),
    ),
    GoRoute(
      name: 'cart',
      path: '/cart',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: CartScreen(),
      ),
    ),
    GoRoute(
      name: 'forgot_password',
      path: '/forgot_password',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ProfileScreen(),
      ),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder: (context, state) {
        final scaffoldKey = state.extra;
        return MaterialPage(
          key: state.pageKey,
          child: LoginScreen(
            scaffoldKey: scaffoldKey,
          ),
        );
      },
    ),
    GoRoute(
      name: 'menu',
      path: '/menu',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MenuScreen(),
      ),
      routes: [
        GoRoute(
          name: 'details',
          path: ':id', // e.g. /menu/1002
          pageBuilder: (context, state) {
            final coffee = state.params['id']!;
            return MaterialPage(
              key: state.pageKey,
              child: MenuDetails(id: coffee),
            );
          },
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
