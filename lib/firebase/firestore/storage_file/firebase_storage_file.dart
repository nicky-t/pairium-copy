import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_storage_file.freezed.dart';
part 'firebase_storage_file.g.dart';

@freezed
class StorageFile with _$StorageFile {
  const factory StorageFile({
    @Default('') String mimeType,
    required String path,
    required String url,
    @Default(<String, Object>{}) Map<String, Object> metadata,
  }) = _StorageFile;

  factory StorageFile.fromJson(Map<String, dynamic> json) =>
      _$StorageFileFromJson(json);
}
