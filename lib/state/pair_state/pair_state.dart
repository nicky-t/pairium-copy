import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user/user.dart';

part 'pair_state.freezed.dart';

@freezed
class PairState with _$PairState {
  const factory PairState({
    User? pair,
  }) = _PairState;
}

class PairStateNotifier extends StateNotifier<PairState> {
  PairStateNotifier() : super(const PairState());

  void setPair(User user) {
    state = state.copyWith(pair: user);
  }
}
