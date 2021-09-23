import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/day_diary_state/day_diary_state_provider.dart';

final dayCardListViewModelProvider = Provider(
  (ref) => DayCardListViewModel(ref.read),
);

class DayCardListViewModel {
  DayCardListViewModel(this._read);

  final Reader _read;

  Future<void> init({
    required int year,
    required int month,
  }) async {
    await _read(dayDiaryStateProvider.notifier)
        .fetchDayDiaries(year: year, month: month);
  }
}
