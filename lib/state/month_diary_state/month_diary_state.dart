import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/month_diary/month_diary_document.dart';
import '../../model/user/user.dart';
import 'month_diary_stream.dart';

part 'month_diary_state.freezed.dart';

@freezed
class MonthDiaryState with _$MonthDiaryState {
  const factory MonthDiaryState({
    @Default(<MonthDiaryDocument>[]) List<MonthDiaryDocument?> monthDiaryDocs,
  }) = _MonthDiaryState;
}

class MonthDiaryStateNotifier extends StateNotifier<MonthDiaryState> {
  MonthDiaryStateNotifier(this._ref, this.user)
      : super(const MonthDiaryState()) {
    if (user != null) {
      _ref.read(monthDiaryStreamProvider(user!));
    }
  }

  final ProviderRefBase _ref;

  final User? user;

  void setMonthDiary(MonthDiaryDocument newMonthDiaryDoc) {
    state = state.copyWith(
      monthDiaryDocs: [
        newMonthDiaryDoc,
        ...state.monthDiaryDocs,
      ],
    );
  }
}
