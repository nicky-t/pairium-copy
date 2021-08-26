import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../firebase/firestore/converter/timestamp_converter.dart';
import '../../firebase/firestore/key/created_at_key.dart';
import '../../firebase/firestore/key/updated_at_key.dart';
import '../../firebase/firestore/storage_file/firebase_storage_file.dart';
import '../enums/weather.dart';
import 'day_diary_field.dart';

part 'day_diary.freezed.dart';
part 'day_diary.g.dart';

const dateKey = JsonKey(
  name: DayDiaryField.date,
  fromJson: TimestampConverter.timestampFromJson,
  toJson: TimestampConverter.timestampToJson,
);

@freezed
class DayDiary with _$DayDiary {
  const factory DayDiary({
    required DateTime date,
    required int year,
    required int month,
    required int day,
    required StorageFile mainImage,
    String? title,
    String? description,
    Weather? weather,
    String? tag,
    @Default(false) bool isFavorite,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _DayDiary;

  factory DayDiary.fromJson(Map<String, dynamic> json) =>
      _$DayDiaryFromJson(json);
}
