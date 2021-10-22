// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUser _$FirestoreUserFromJson(Map<String, dynamic> json) =>
    FirestoreUser(
      roles: (json['roles'] as List<dynamic>)
          .map((e) => _$enumDecode(_$UserRoleEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$FirestoreUserToJson(FirestoreUser instance) =>
    <String, dynamic>{
      'roles': instance.roles.map((e) => _$UserRoleEnumMap[e]).toList(),
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

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.admin: 'admin',
  UserRole.unknown: 'unknown',
};
