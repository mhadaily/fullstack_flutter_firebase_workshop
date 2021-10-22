// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      status: _$enumDecode(_$OrderStatusEnumMap, json['status']),
      userId: json['userId'] as String,
      created: Order._fromJson(json['created'] as Timestamp),
      updated: Order._fromJson(json['updated'] as Timestamp),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'status': _$OrderStatusEnumMap[instance.status],
      'id': instance.id,
      'userId': instance.userId,
      'created': Order._toJson(instance.created),
      'updated': Order._toJson(instance.updated),
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

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.preparing: 'preparing',
  OrderStatus.ready: 'ready',
  OrderStatus.delivered: 'delivered',
  OrderStatus.canceled: 'canceled',
};
