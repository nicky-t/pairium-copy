import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/entity/user/user.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    required User entity,
    required DocumentReference<Map<String, dynamic>> ref,
  }) = _UserState;
}
