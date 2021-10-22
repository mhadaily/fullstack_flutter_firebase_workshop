import 'package:flutter/material.dart';

import '../../const.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    this.onPressed,
    this.highlighColor = false,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final bool highlighColor;

  Color get backgroundColor {
    return highlighColor ? darkBrown : Colors.white;
  }

  Color get textColor {
    return highlighColor ? Colors.white : darkBrown;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: key,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor,
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: darkBrown),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.fromLTRB(55, 15, 55, 15),
        ),
        shape: MaterialStateProperty.all(
          StadiumBorder(),
        ),
      ),
    );
  }
}
