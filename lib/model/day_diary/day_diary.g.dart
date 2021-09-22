// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_diary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DayDiary _$_$_DayDiaryFromJson(Map<String, dynamic> json) {
  return _$_DayDiary(
    date: TimestampConverter.timestampFromJson(json['date'] as Timestamp),
    year: json['year'] as int,
    month: json['month'] as int,
    day: json['day'] as int,
    mainImage: StorageFile.fromJson(json['mainImage'] as Map<String, dynamic>),
    userIds:
        (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    weather: _$enumDecodeNullable(_$WeatherEnumMap, json['weather']),
    tag: json['tag'] as String?,
    images: (json['images'] as List<dynamic>?)
            ?.map((e) => DayDiaryImage.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    isFavorite: json['isFavorite'] as bool? ?? false,
    createdAt:
        TimestampConverter.timestampFromJson(json['createdAt'] as Timestamp),
    updatedAt:
        TimestampConverter.timestampFromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_DayDiaryToJson(_$_DayDiary instance) =>
    <String, dynamic>{
      'date': TimestampConverter.timestampToJson(instance.date),
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'mainImage': instance.mainImage.toJson(),
      'userIds': instance.userIds,
      'title': instance.title,
      'description': instance.description,
      'weather': _$WeatherEnumMap[instance.weather],
      'tag': instance.tag,
      'images': instance.images.map((e) => e.toJson()).toList(),
      'isFavorite': instance.isFavorite,
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

const _$WeatherEnumMap = {
  Weather.sunny: 'sunny',
  Weather.cloudy: 'cloudy',
  Weather.rainy: 'rainy',
  Weather.snow: 'snow',
  Weather.thunder: 'thunder',
};
