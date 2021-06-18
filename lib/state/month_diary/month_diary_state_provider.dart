import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'month_diary_state.dart';

final monthDiaryStateProvider =
    StateNotifierProvider<MonthDiaryStateNotifier, MonthDiaryState>(
  (ref) => MonthDiaryStateNotifier(ref),
);
