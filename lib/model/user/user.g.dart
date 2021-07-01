// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    displayName: json['displayName'] as String,
    birthday:
        TimestampConverter.timestampFromJson(json['birthday'] as Timestamp),
    gender: _$enumDecode(_$GenderEnumMap, json['gender']),
    isFinishedOnboarding: json['isFinishedOnboarding'] as bool? ?? false,
    mainProfileImage: json['mainProfileImage'] == null
        ? null
        : StorageFile.fromJson(
            json['mainProfileImage'] as Map<String, dynamic>),
    pairId: json['pairId'] as String?,
    partnerDocumentId: json['partnerDocumentId'] as String?,
    createdAt:
        TimestampConverter.timestampFromJson(json['createdAt'] as Timestamp),
    updatedAt:
        TimestampConverter.timestampFromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'birthday': TimestampConverter.timestampToJson(instance.birthday),
      'gender': _$GenderEnumMap[instance.gender],
      'isFinishedOnboarding': instance.isFinishedOnboarding,
      'mainProfileImage': instance.mainProfileImage?.toJson(),
      'pairId': instance.pairId,
      'partnerDocumentId': instance.partnerDocumentId,
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

const _$GenderEnumMap = {
  Gender.man: 'man',
  Gender.woman: 'woman',
  Gender.other: 'other',
};
