import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

enum Activity {
  login,
  addToCart,
  placeOrder,
  logout,
}

extension ActivityExtension on Activity {
  String get name {
    return describeEnum(this);
  }
}
