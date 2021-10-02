import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/firestorage/firebase_storage_file.dart';
import '../../../services/firestore/converter/timestamp_converter.dart';
import '../../../services/firestore/key/created_at_key.dart';
import '../../../services/firestore/key/updated_at_key.dart';
import '../../enums/weather.dart';
import 'diary_field.dart';
import 'diary_image/diary_image.dart';

part 'diary.freezed.dart';
part 'diary.g.dart';

const dateKey = JsonKey(
  name: DiaryField.date,
  fromJson: TimestampConverter.timestampFromJson,
  toJson: TimestampConverter.timestampToJson,
);

@freezed
class Diary with _$Diary {
  const factory Diary({
    @dateKey required DateTime date,
    required int year,
    required int month,
    required int day,
    required StorageFile mainImage,
    required List<String> userIds,
    @Default('') String title,
    @Default('') String description,
    Weather? weather,
    String? tag,
    @Default(<DiaryImage>[]) List<DiaryImage> images,
    @Default(false) bool isFavorite,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _Diary;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
}
