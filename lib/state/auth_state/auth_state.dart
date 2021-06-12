import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repository/auth_repository/auth_repository_provider.dart';
import '../../repository/custom_exception.dart';

enum AuthState {
  loading,
  noLogin,
  onboarding,
  login,
  error,
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier({required this.ref}) : super(AuthState.loading) {
    try {
      ref.watch(authStreamProvider).whenData(
        (firebaseUser) async {
          if (firebaseUser == null) {
            state = AuthState.noLogin;
            return;
          }
          state = AuthState.onboarding;
          // state = AuthState.login;
          return;
        },
      );
    } on Exception catch (e) {
      print(e);
      state = AuthState.error;
      CustomException(message: e.toString());
    }
  }

  final AutoDisposeProviderReference ref;

  void setSAuthState(AuthState authState) {
    state = authState;
    return;
  }
}
