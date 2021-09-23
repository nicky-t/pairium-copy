import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../firebase/firestore/converter/timestamp_converter.dart';
import '../../../firebase/firestore/key/created_at_key.dart';
import '../../../firebase/firestore/key/updated_at_key.dart';
import '../../../firebase/firestore/storage_file/firebase_storage_file.dart';

part 'day_diary_image.freezed.dart';
part 'day_diary_image.g.dart';

@freezed
class DayDiaryImage with _$DayDiaryImage {
  const factory DayDiaryImage({
    required StorageFile image,
    @Default(1) int width,
    @Default(1) int height,
    @Default(false) bool isFavorite,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _DayDiaryImage;

  factory DayDiaryImage.fromJson(Map<String, dynamic> json) =>
      _$DayDiaryImageFromJson(json);
}
