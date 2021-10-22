import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mjcoffee/helpers/helpers.dart';
import 'package:mjcoffee/services/services.dart';
import 'package:mjcoffee/widgets/widgets.dart';

import '../const.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = 'ForgotPasswordScreen';
  static Route<ForgotPasswordScreen> route() {
    return MaterialPageRoute<ForgotPasswordScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => ForgotPasswordScreen(),
    );
  }

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();

  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
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
                TextFormField(
                  key: Key('email'),
                  controller: _emailFieldController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'me@majidhajian.com',
                    labelStyle: TextStyle(color: darkBrown),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: darkBrown),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: darkBrown),
                    ),
                  ),
                  cursorColor: darkBrown,
                  validator: Validators.validateEmail,
                ),
                CommonButton(
                  onPressed: _onSubmitLoginButton,
                  text: 'Submit',
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

  _onSubmitLoginButton() async {
    if (_isFormValidated()) {
      ScaffoldMessenger.of(context).showSnackBar(
        loadingSnackBar(
          text: " Wait please...",
        ),
      );

      await _authService.sendPasswordResetEmail(
        email: _emailFieldController.text,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please check your email!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      GoRouter.of(context).goNamed('home');
    }
  }
}
