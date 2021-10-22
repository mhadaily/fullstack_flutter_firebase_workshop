// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['id'] as String?,
      coffee: Coffee.fromJson(json['coffee'] as Map<String, dynamic>),
      size: _$enumDecode(_$CoffeeCupSizeEnumMap, json['size']),
      quantity: json['quantity'] as int,
      sugar: _$enumDecode(_$CoffeeSugarCubeEnumMap, json['sugar']),
      additions: (json['additions'] as List<dynamic>)
          .map((e) => _$enumDecode(_$CoffeeAdditionEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'coffee': instance.coffee.toJson(),
      'size': _$CoffeeCupSizeEnumMap[instance.size],
      'sugar': _$CoffeeSugarCubeEnumMap[instance.sugar],
      'quantity': instance.quantity,
      'additions':
          instance.additions.map((e) => _$CoffeeAdditionEnumMap[e]).toList(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$CoffeeCupSizeEnumMap = {
  CoffeeCupSize.small: 'small',
  CoffeeCupSize.medium: 'medium',
  CoffeeCupSize.large: 'large',
};

const _$CoffeeSugarCubeEnumMap = {
  CoffeeSugarCube.no: 'no',
  CoffeeSugarCube.one: 'one',
  CoffeeSugarCube.two: 'two',
};

const _$CoffeeAdditionEnumMap = {
  CoffeeAddition.cake: 'cake',
  CoffeeAddition.icecream: 'icecream',
  CoffeeAddition.cheese: 'cheese',
};
