import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../firebase/firestore/converter/timestamp_converter.dart';
import '../../../firebase/firestore/key/created_at_key.dart';
import '../../../firebase/firestore/key/updated_at_key.dart';
import '../../../firebase/firestore/storage_file/firebase_storage_file.dart';
import '../enums/card_color.dart';
import '../enums/month.dart';

part 'month_diary.freezed.dart';
part 'month_diary.g.dart';

@freezed
class MonthDiary with _$MonthDiary {
  const factory MonthDiary({
    required Month month,
    required int monthNumber,
    @Default(CardColor.black) CardColor cardColor,
    StorageFile? frontImage,
    StorageFile? backImage,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _MonthDiary;

  factory MonthDiary.fromJson(Map<String, dynamic> json) =>
      _$MonthDiaryFromJson(json);
}
