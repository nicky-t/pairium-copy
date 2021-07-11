import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/user/user.dart';
import 'month_diary_state.dart';

final monthDiaryStateProvider = StateNotifierProvider.family<
    MonthDiaryStateNotifier, MonthDiaryState, User?>(
  (ref, user) => MonthDiaryStateNotifier(ref, user),
);
