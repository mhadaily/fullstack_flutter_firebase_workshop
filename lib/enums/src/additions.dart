import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

enum CoffeeAddition {
  cake,
  icecream,
  cheese,
}

extension CoffeeAdditionExtension on CoffeeAddition {
  IconData get iconData {
    switch (this) {
      case CoffeeAddition.cake:
        return Icons.cake;
      case CoffeeAddition.icecream:
        return FontAwesomeIcons.iceCream;
      case CoffeeAddition.cheese:
        return FontAwesomeIcons.cheese;
      default:
        return Icons.close;
    }
  }
}
