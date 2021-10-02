import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/entity/month_diary/month_diary_document.dart';

part 'month_diary_state.freezed.dart';

@freezed
class MonthDiaryState with _$MonthDiaryState {
  const factory MonthDiaryState({
    @Default(<MonthDiaryDocument>[]) List<MonthDiaryDocument?> monthDiaryDocs,
  }) = _MonthDiaryState;
}
