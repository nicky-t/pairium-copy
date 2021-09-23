import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pair_state.dart';

final pairStateProvider = StateNotifierProvider<PairStateNotifier, PairState>(
  (ref) => PairStateNotifier(),
);
