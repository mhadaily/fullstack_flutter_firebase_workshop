import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum CoffeeSugarCube {
  no,
  one,
  two,
}

extension CoffeeSugarCubeExtension on CoffeeSugarCube {
  IconData get iconData {
    switch (this) {
      case CoffeeSugarCube.no:
        return Icons.close;
      case CoffeeSugarCube.one:
        return Icons.check_box_outline_blank;
      case CoffeeSugarCube.two:
        return Icons.check_box_outline_blank;
      default:
        return Icons.close;
    }
  }
}
