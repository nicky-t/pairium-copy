import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/month_diary/month_diary_document.dart';
import 'month_diary_stream.dart';

part 'month_diary_state.freezed.dart';

@freezed
class MonthDiaryState with _$MonthDiaryState {
  const factory MonthDiaryState({
    @Default(<MonthDiaryDocument>[]) List<MonthDiaryDocument?> monthDiaryDocs,
  }) = _MonthDiaryState;
}

class MonthDiaryStateNotifier extends StateNotifier<MonthDiaryState> {
  MonthDiaryStateNotifier(this._ref) : super(const MonthDiaryState()) {
    _ref.read(monthDiaryStreamProvider);
  }

  final ProviderReference _ref;

  void setMonthDiary(MonthDiaryDocument newMonthDiaryDoc) {
    state = state.copyWith(
      monthDiaryDocs: [
        newMonthDiaryDoc,
        ...state.monthDiaryDocs,
      ],
    );
  }
}
