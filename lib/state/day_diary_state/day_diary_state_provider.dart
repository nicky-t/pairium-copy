import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'day_diary_state.dart';

final dayDiaryStateProvider =
    StateNotifierProvider.autoDispose<DayDiaryStateNotifier, DayDiaryState>(
  (ref) => DayDiaryStateNotifier(ref.read),
);
