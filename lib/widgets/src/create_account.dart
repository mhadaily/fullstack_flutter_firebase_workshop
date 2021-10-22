import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../const.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don\'t have an account?",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).goNamed('home');
          },
          child: Text(
            " Register",
            style: TextStyle(
              color: darkBrown,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
