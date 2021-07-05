import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pair_state.dart';

final pairStateProvider = StateNotifierProvider<PairStateNotifier, PairState>(
  (ref) => PairStateNotifier(),
);
