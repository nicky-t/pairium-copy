// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Partner _$_$_PartnerFromJson(Map<String, dynamic> json) {
  return _$_Partner(
    userIds:
        (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
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
      'anniversary':
          NullableTimestampConverter.timestampToJson(instance.anniversary),
      'createdAt': TimestampConverter.timestampToJson(instance.createdAt),
      'updatedAt': TimestampConverter.timestampToJson(instance.updatedAt),
    };
