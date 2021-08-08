import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_state.dart';

final userStateProvider = StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(),
);
