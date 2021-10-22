// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLog _$UserLogFromJson(Map<String, dynamic> json) => UserLog(
      id: json['id'] as String?,
      activity: _$enumDecode(_$ActivityEnumMap, json['activity']),
      created: UserLog._fromJson(json['created'] as Timestamp),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$UserLogToJson(UserLog instance) => <String, dynamic>{
      'activity': _$ActivityEnumMap[instance.activity],
      'created': UserLog._toJson(instance.created),
      'id': instance.id,
      'userId': instance.userId,
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

const _$ActivityEnumMap = {
  Activity.login: 'login',
  Activity.addToCart: 'addToCart',
  Activity.placeOrder: 'placeOrder',
  Activity.logout: 'logout',
};
