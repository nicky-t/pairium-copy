import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/user/user.dart';
import '../../model/user/user_document.dart';
import '../../repository/auth_repository_provider.dart';
import '../../repository/custom_exception.dart';
import '../user_state/user_state_provider.dart';

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
          final uid = firebaseUser.uid;
          print(uid);
          final userDoc =
              await UserDocument.collectionReference().doc(uid).get();
          if (!userDoc.exists || userDoc.data()!.isEmpty) {
            state = AuthState.onboarding;
            return;
          }
          ref
              .read(userStateProvider.notifier)
              .setUser(User.fromJson(userDoc.data()!));
          state = AuthState.login;
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
