// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coffee _$CoffeeFromJson(Map<String, dynamic> json) => Coffee(
      icon: json['icon'] as int,
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$CoffeeToJson(Coffee instance) => <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.name,
      'price': instance.price,
    };
