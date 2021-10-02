import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.loading) AuthStatus status,
    User? authUser,
  }) = _AuthState;
}

enum AuthStatus {
  loading,
  noLogin,
  userProfile,
  registerPartner,
  login,
  error,
}
