import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  customer,
  admin,
  unknown,
}

extension UserRoleExtension on UserRole {
  String get name {
    return describeEnum(this);
  }
}
