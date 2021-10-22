import 'package:flutter/material.dart';

import 'const.dart';

ThemeData getTheme() {
  return ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(color: darkBrown),
      headline2: TextStyle(color: darkBrown),
      headline3: TextStyle(color: darkBrown),
      headline4: TextStyle(color: darkBrown),
      headline5: TextStyle(color: darkBrown),
      headline6: TextStyle(color: darkBrown),
      caption: TextStyle(color: darkBrown),
      bodyText1: TextStyle(color: darkBrown),
      subtitle1: TextStyle(color: darkBrown),
      subtitle2: TextStyle(color: darkBrown),
      bodyText2: TextStyle(color: darkBrown),
      overline: TextStyle(color: darkBrown),
      button: TextStyle(color: darkBrown),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Raleway',
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.brown),
      color: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.brown,
      ),
      toolbarTextStyle: TextStyle(
        color: Colors.brown,
      ),
    ),
  );
}
