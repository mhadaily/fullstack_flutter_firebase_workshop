import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coffee.g.dart';

@JsonSerializable()
class Coffee {
  const Coffee({
    required this.icon,
    required this.id,
    required this.name,
    required this.price,
  });

  IconData get iconData => IconData(
        icon,
        fontFamily: 'FontAwesomeSolid',
        fontPackage: 'font_awesome_flutter',
      );

  final String id;
  final int icon;
  final String name;
  final int price;

  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);
  Map<String, dynamic> toJson() => _$CoffeeToJson(this);
}
