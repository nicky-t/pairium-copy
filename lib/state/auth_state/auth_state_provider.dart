import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';

final authStateProvider =
    StateNotifierProvider.autoDispose<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(
    ref: ref,
  ),
);
