// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_storage_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StorageFile _$_$_StorageFileFromJson(Map<String, dynamic> json) {
  return _$_StorageFile(
    mimeType: json['mimeType'] as String? ?? '',
    path: json['path'] as String,
    url: json['url'] as String,
    metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e as Object),
        ) ??
        {},
  );
}

Map<String, dynamic> _$_$_StorageFileToJson(_$_StorageFile instance) =>
    <String, dynamic>{
      'mimeType': instance.mimeType,
      'path': instance.path,
      'url': instance.url,
      'metadata': instance.metadata,
    };
