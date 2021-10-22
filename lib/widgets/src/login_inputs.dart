import 'package:flutter/material.dart';
import 'package:mjcoffee/helpers/helpers.dart';

import '../../const.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({
    Key? key,
    this.emailFieldController,
    this.passwordFieldController,
  }) : super(key: key);

  final emailFieldController;
  final passwordFieldController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          key: Key('email'),
          controller: emailFieldController,
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
        SizedBox(height: 30),
        TextFormField(
          key: Key('password'),
          controller: passwordFieldController,
          autocorrect: false,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'securepassword',
            labelText: 'Password',
            labelStyle: TextStyle(color: darkBrown),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: darkBrown),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: darkBrown),
            ),
          ),
          cursorColor: darkBrown,
          validator: Validators.validatePassword,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
