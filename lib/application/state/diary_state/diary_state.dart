import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/entity/diary/diary_document.dart';

part 'diary_state.freezed.dart';

@freezed
class DiaryState with _$DiaryState {
  const factory DiaryState({
    @Default(<DiaryDocument>[]) List<DiaryDocument> diaryDocs,
  }) = _DiaryState;
}

class DiaryStateParam {
  DiaryStateParam({
    required this.year,
    required this.month,
    this.day,
  });

  final int year;
  final int month;
  final int? day;
}
