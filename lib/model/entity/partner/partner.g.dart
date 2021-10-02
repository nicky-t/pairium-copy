// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Partner _$_$_PartnerFromJson(Map<String, dynamic> json) {
  return _$_Partner(
    userIds:
        (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
    submitRequestUser: json['submitRequestUser'] as String?,
    receiveRequestUser: json['receiveRequestUser'] as String?,
    requestStatus:
        _$enumDecodeNullable(_$RequestStatusEnumMap, json['requestStatus']),
    anniversary: NullableTimestampConverter.timestampFromJson(
        json['anniversary'] as Timestamp?),
    createdAt:
        TimestampConverter.timestampFromJson(json['createdAt'] as Timestamp),
    updatedAt:
        TimestampConverter.timestampFromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_PartnerToJson(_$_Partner instance) =>
    <String, dynamic>{
      'userIds': instance.userIds,
      'submitRequestUser': instance.submitRequestUser,
      'receiveRequestUser': instance.receiveRequestUser,
      'requestStatus': _$RequestStatusEnumMap[instance.requestStatus],
      'anniversary':
          NullableTimestampConverter.timestampToJson(instance.anniversary),
      'createdAt': TimestampConverter.timestampToJson(instance.createdAt),
      'updatedAt': TimestampConverter.timestampToJson(instance.updatedAt),
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

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$RequestStatusEnumMap = {
  RequestStatus.waiting: 'waiting',
  RequestStatus.accept: 'accept',
  RequestStatus.reject: 'reject',
};
