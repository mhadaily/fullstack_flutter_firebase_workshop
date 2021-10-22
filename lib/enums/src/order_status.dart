import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  pending,
  preparing,
  ready,
  delivered,
  canceled,
}

extension OrderStatuseExtension on OrderStatus {
  String get name {
    return describeEnum(this);
  }

  IconData get iconData {
    switch (this) {
      case OrderStatus.pending:
        return FontAwesomeIcons.truckLoading;
      case OrderStatus.preparing:
        return FontAwesomeIcons.clock;
      case OrderStatus.ready:
        return FontAwesomeIcons.truckPickup;
      case OrderStatus.delivered:
        return FontAwesomeIcons.userCheck;
      case OrderStatus.canceled:
        return FontAwesomeIcons.windowClose;
      default:
        return Icons.close;
    }
  }
}
