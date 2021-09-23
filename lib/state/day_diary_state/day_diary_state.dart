import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/day_diary/day_diary_document.dart';
import '../../repository/day_diary_repository.dart';

part 'day_diary_state.freezed.dart';

@freezed
class DayDiaryState with _$DayDiaryState {
  const factory DayDiaryState({
    @Default(<DayDiaryDocument>[]) List<DayDiaryDocument?> dayDiaryDocs,
    @Default(false) bool isFetching,
  }) = _DayDiaryState;
}

class DayDiaryStateNotifier extends StateNotifier<DayDiaryState> {
  DayDiaryStateNotifier(this._read) : super(const DayDiaryState());

  final Reader _read;

  void setDayDiary(List<DayDiaryDocument?> newDayDiaryDocs) {
    state = state.copyWith(dayDiaryDocs: newDayDiaryDocs);
  }

  Future<void> fetchDayDiaries({
    required int year,
    required int month,
  }) async {
    state = state.copyWith(isFetching: true);
    final dayDiaryDocs = await _read(dayDiaryRepositoryProvider)
        .fetchDayDairies(year: year, month: month);
    state = state.copyWith(
      dayDiaryDocs: dayDiaryDocs,
      isFetching: false,
    );
  }

  Future<void> fetchDayDiary({
    required int year,
    required int month,
    required int day,
  }) async {
    state = state.copyWith(isFetching: true);
    final dayDiaryDoc = await _read(dayDiaryRepositoryProvider)
        .fetchDayDairy(year: year, month: month, day: day);
    state = state.copyWith(
      dayDiaryDocs: [dayDiaryDoc],
      isFetching: false,
    );
  }

  Future<void> fetchDayDiaryFromDoc({
    required DayDiaryDocument dayDiaryDoc,
  }) async {
    state = state.copyWith(isFetching: true);
    final newDayDiaryDoc = await _read(dayDiaryRepositoryProvider)
        .fetchDayDiaryFromDoc(dayDiaryDoc: dayDiaryDoc);

    state = state.copyWith(
      dayDiaryDocs: [newDayDiaryDoc],
      isFetching: false,
    );
  }

  Future<void> deleteDayDiary({
    required DayDiaryDocument dayDiaryDoc,
    required int year,
    required int month,
  }) async {
    await _read(dayDiaryRepositoryProvider)
        .deleteDayDiary(dayDiaryDoc: dayDiaryDoc);

    await fetchDayDiaries(month: month, year: year);
  }
}
