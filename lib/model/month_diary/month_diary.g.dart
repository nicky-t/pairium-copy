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
    frontImage: json['frontImage'] == null
        ? null
        : StorageFile.fromJson(json['frontImage'] as Map<String, dynamic>),
    backImage: json['backImage'] == null
        ? null
        : StorageFile.fromJson(json['backImage'] as Map<String, dynamic>),
    backgroundColor: _$enumDecodeNullable(
            _$MonthCardColorEnumMap, json['backgroundColor']) ??
        MonthCardColor.white,
    textColor:
        _$enumDecodeNullable(_$MonthCardColorEnumMap, json['textColor']) ??
            MonthCardColor.grey,
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
      'frontImage': instance.frontImage?.toJson(),
      'backImage': instance.backImage?.toJson(),
      'backgroundColor': _$MonthCardColorEnumMap[instance.backgroundColor],
      'textColor': _$MonthCardColorEnumMap[instance.textColor],
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

const _$MonthCardColorEnumMap = {
  MonthCardColor.red: 'red',
  MonthCardColor.pink: 'pink',
  MonthCardColor.purple: 'purple',
  MonthCardColor.deepPurple: 'deepPurple',
  MonthCardColor.indigo: 'indigo',
  MonthCardColor.blue: 'blue',
  MonthCardColor.lightBlue: 'lightBlue',
  MonthCardColor.cyan: 'cyan',
  MonthCardColor.teal: 'teal',
  MonthCardColor.green: 'green',
  MonthCardColor.lightGreen: 'lightGreen',
  MonthCardColor.lime: 'lime',
  MonthCardColor.yellow: 'yellow',
  MonthCardColor.amber: 'amber',
  MonthCardColor.orange: 'orange',
  MonthCardColor.deepOrange: 'deepOrange',
  MonthCardColor.brown: 'brown',
  MonthCardColor.grey: 'grey',
  MonthCardColor.blueGrey: 'blueGrey',
  MonthCardColor.white: 'white',
};
