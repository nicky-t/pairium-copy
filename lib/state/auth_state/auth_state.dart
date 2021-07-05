import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/user/user.dart';
import '../../model/user/user_document.dart';
import '../../repository/auth_repository_provider.dart';
import '../../repository/custom_exception.dart';
import '../user_state/user_state_provider.dart';

enum AuthState {
  loading,
  noLogin,
  userProfile,
  registerPartner,
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
          print('userId: $uid');

          final userDoc =
              await UserDocument.collectionReference().doc(uid).get();

          if (!userDoc.exists || userDoc.data()!.isEmpty) {
            state = AuthState.userProfile;
            return;
          }

          final user = User.fromJson(userDoc.data()!);

          ref.read(userStateProvider.notifier).setUser(user);
          if (!user.isFinishedOnboarding) {
            state = AuthState.registerPartner;
          } else {
            state = AuthState.login;
          }

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
