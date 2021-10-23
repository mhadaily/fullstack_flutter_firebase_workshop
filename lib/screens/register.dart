import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mjcoffee/enums/enums.dart';
import 'package:mjcoffee/services/services.dart';
import 'package:mjcoffee/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  final AnalyticsService _analyticsService = AnalyticsService.instance;
  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        actions: [
          Image.asset(
            "assets/logo.png",
            semanticLabel: 'logo',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LoginInputs(
                  emailFieldController: _emailFieldController,
                  passwordFieldController: _passwordFieldController,
                ),
                CommonButton(
                  onPressed: () {
                    _onSubmitLoginButton(context);
                  },
                  text: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isFormValidated() {
    final FormState form = formKey.currentState!;
    return form.validate();
  }

  _onSubmitLoginButton(context) async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: " Creating user...",
        ),
      );

      final User? user = await _authService.createUserWithEmailAndPassword(
        email: _emailFieldController.text,
        password: _passwordFieldController.text,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (user != null) {
        _analyticsService.logLogin();

        _analyticsService.setUserProperties(
          userId: user.uid,
          userRoles: [UserRole.customer],
        );

        await _firestoreService.setUserRoles(user.uid, [UserRole.customer]);

        GoRouter.of(context).goNamed('menu');
      }
    }
  }
}
