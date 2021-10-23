import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mjcoffee/enums/enums.dart';
import 'package:mjcoffee/router.dart';
import 'package:mjcoffee/services/services.dart';
import 'package:mjcoffee/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Object? scaffoldKey});

  static String routeName = 'loginScreen';
  static Route<LoginScreen> route() {
    return MaterialPageRoute<LoginScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => const LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AnalyticsService _analyticsService = AnalyticsService.instance;
  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  StreamSubscription<User?>? _authChangeSubscription;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _authChangeSubscription = _authService.authStateChanges().listen(
      (User? user) async {
        if (user != null) {
          // which provider users is logged
          user.providerData.forEach((provider) {
            _analyticsService.logLogin(loginMethod: provider.providerId);
          });
          _analyticsService.setUserProperties(
            userId: user.uid,
            userRoles: [UserRole.customer],
          );

          _firestoreService.setUserLastLoginTimestamp(user.uid);

          await _firestoreService.addLog(
            activity: Activity.login,
            userId: user.uid,
          );

          GoRouter.of(context).push('menu');
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authChangeSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          Image.asset(
            "assets/logo.png",
            semanticLabel: 'logo',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                "assets/hotbeverage.svg",
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                semanticsLabel: 'MJ Coffee',
                fit: BoxFit.fitWidth,
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SignInButton.phone(onPressed: () {
                  //   _displayTextInputDialog(context);
                  // }),
                  // SizedBox(height: 20),
                  SignInButton.google(onPressed: () {
                    _authService.signInWithGoogle();
                  }),
                  SizedBox(height: 20),
                  FutureBuilder<bool>(
                    future: _authService.isAppleSignInAvailable(),
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      final bool isAvailable = snapshot.data ?? false;
                      if (isAvailable) {
                        return SignInButton.apple(onPressed: () {
                          _authService.signInWithApple();
                        });
                      }
                      return SizedBox();
                    },
                  ),
                  SizedBox(height: 20),
                  SignInButton.mail(onPressed: () {
                    GoRouter.of(context).goNamed('login_password');
                  }),
                  SizedBox(height: 20),
                  Center(child: Text('OR')),
                  SizedBox(height: 20),
                  CommonButton(
                    onPressed: _loading
                        ? null // disable button
                        : () async {
                            setState(() {
                              _loading = true;
                            });

                            await _authService.signInAnonymously();

                            setState(() {
                              _loading = false;
                            });
                            loginInfo.isLoggedIn = true;
                            GoRouter.of(context).goNamed('menu');
                          },
                    text: _loading
                        ? 'Please wait, Login...'
                        : 'Continue anonymously',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
