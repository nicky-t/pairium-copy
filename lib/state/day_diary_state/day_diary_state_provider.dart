import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/day_diary/day_diary_document.dart';

import 'day_diary_state.dart';

final dayDiaryStateProvider =
    StateNotifierProvider.autoDispose<DayDiaryStateNotifier, DayDiaryState>(
  (ref) => DayDiaryStateNotifier(ref.read),
);

final selectedDayDiaryStateProvider = StateNotifierProvider<
    StateController<DayDiaryDocument?>, DayDiaryDocument?>(
  (ref) => StateController(null),
);
