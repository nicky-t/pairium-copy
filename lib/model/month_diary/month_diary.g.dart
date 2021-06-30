// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_diary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MonthDiary _$_$_MonthDiaryFromJson(Map<String, dynamic> json) {
  return _$_MonthDiary(
    month: _$enumDecode(_$MonthEnumMap, json['month']),
    monthNumber: json['monthNumber'] as int,
    year: json['year'] as int,
    cardColor: _$enumDecodeNullable(_$CardColorEnumMap, json['cardColor']) ??
        CardColor.black,
    frontImage: json['frontImage'] == null
        ? null
        : StorageFile.fromJson(json['frontImage'] as Map<String, dynamic>),
    backImage: json['backImage'] == null
        ? null
        : StorageFile.fromJson(json['backImage'] as Map<String, dynamic>),
    createdAt:
        TimestampConverter.timestampFromJson(json['createdAt'] as Timestamp),
    updatedAt:
        TimestampConverter.timestampFromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_MonthDiaryToJson(_$_MonthDiary instance) =>
    <String, dynamic>{
      'month': _$MonthEnumMap[instance.month],
      'monthNumber': instance.monthNumber,
      'year': instance.year,
      'cardColor': _$CardColorEnumMap[instance.cardColor],
      'frontImage': instance.frontImage?.toJson(),
      'backImage': instance.backImage?.toJson(),
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

const _$MonthEnumMap = {
  Month.january: 'january',
  Month.february: 'february',
  Month.march: 'march',
  Month.april: 'april',
  Month.may: 'may',
  Month.june: 'june',
  Month.july: 'july',
  Month.august: 'august',
  Month.september: 'september',
  Month.october: 'october',
  Month.november: 'november',
  Month.december: 'december',
};

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

const _$CardColorEnumMap = {
  CardColor.black: 'black',
  CardColor.red: 'red',
  CardColor.blue: 'blue',
};
