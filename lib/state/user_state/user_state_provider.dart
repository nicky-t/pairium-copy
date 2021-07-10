import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'user_state.dart';

final userStateProvider = StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(),
);
