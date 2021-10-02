import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../services/firestorage/firebase_storage_file.dart';
import '../../../../services/firestore/converter/timestamp_converter.dart';
import '../../../../services/firestore/key/created_at_key.dart';
import '../../../../services/firestore/key/updated_at_key.dart';

part 'diary_image.freezed.dart';
part 'diary_image.g.dart';

@freezed
class DiaryImage with _$DiaryImage {
  const factory DiaryImage({
    required StorageFile image,
    @Default(1) int width,
    @Default(1) int height,
    @Default(false) bool isFavorite,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _DiaryImage;

  factory DiaryImage.fromJson(Map<String, dynamic> json) =>
      _$DiaryImageFromJson(json);
}
