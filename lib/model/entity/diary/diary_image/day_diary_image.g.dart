// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DiaryImage _$_$_DiaryImageFromJson(Map<String, dynamic> json) {
  return _$_DiaryImage(
    image: StorageFile.fromJson(json['image'] as Map<String, dynamic>),
    width: json['width'] as int? ?? 1,
    height: json['height'] as int? ?? 1,
    isFavorite: json['isFavorite'] as bool? ?? false,
    createdAt:
        TimestampConverter.timestampFromJson(json['createdAt'] as Timestamp),
    updatedAt:
        TimestampConverter.timestampFromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_DiaryImageToJson(_$_DiaryImage instance) =>
    <String, dynamic>{
      'image': instance.image.toJson(),
      'width': instance.width,
      'height': instance.height,
      'isFavorite': instance.isFavorite,
      'createdAt': TimestampConverter.timestampToJson(instance.createdAt),
      'updatedAt': TimestampConverter.timestampToJson(instance.updatedAt),
    };
