import 'package:flutter/material.dart';
import 'package:mjcoffee/router.dart';

Future<void> showAlertDialog(String message, [String? title]) async {
  return showDialog<void>(
    context: router.routerDelegate.navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? 'Error!'),
        content: Text(message),
      );
    },
  );
}
