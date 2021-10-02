import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../../model/entity/user/user.dart';
import '../../../model/entity/user/user_document.dart';
import '../../../repository/auth_repository/auth_repository.dart';
import '../../../repository/auth_repository/auth_repository_impl.dart';
import '../../../utility/custom_exception.dart';
import '../user_state/user_controller_provider.dart';
import '../user_state/user_state.dart';
import 'auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(
    this._authRepository,
    this._ref,
  ) : super(const AuthState()) {
    try {
      _ref.watch(authStreamProvider).whenData((firebaseUser) async {
        if (firebaseUser == null) {
          state = state.copyWith(status: AuthStatus.noLogin);
          return;
        }
        final uid = firebaseUser.uid;
        print('userId: $uid');

        final userDoc = await UserDocument.collectionReference().doc(uid).get();

        if (!userDoc.exists || userDoc.data()!.isEmpty) {
          state = state.copyWith(
            status: AuthStatus.userProfile,
            authUser: firebaseUser,
          );
          return;
        }

        final user = User.fromJson(userDoc.data()!);

        if (!user.isFinishedOnboarding) {
          state = state.copyWith(
            status: AuthStatus.registerPartner,
            authUser: firebaseUser,
          );
        } else {
          state = state.copyWith(
            status: AuthStatus.login,
            authUser: firebaseUser,
          );
        }

        _ref
            .read(userControllerProvider.notifier)
            .setState(UserState(entity: user, ref: userDoc.reference));

        return;
      });
    } on Exception catch (e) {
      print(e);
      state = state.copyWith(
        status: AuthStatus.error,
      );
      CustomException(message: e.toString());
    }
  }

  final AuthRepository _authRepository;
  final ProviderRefBase _ref;

  void setAuthState(AuthStatus authStatus) {
    state = state.copyWith(status: authStatus);
    return;
  }

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    String _infoText;
    if (EmailValidator.validate(email)) {
      _infoText = await _authRepository.emailSignUp(
        email: email,
        password: password,
      );

      if (_infoText == kSuccessCode) {
        return kSuccessCode;
      }
      return _infoText;
    } else {
      return '入力されたアドレスはメール形式ではありません';
    }
  }

  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    String _infoText;
    if (EmailValidator.validate(email)) {
      _infoText = await _authRepository.emailLogIn(
        email: email,
        password: password,
      );

      if (_infoText == kSuccessCode) {
        return kSuccessCode;
      }
      return _infoText;
    } else {
      return '入力されたアドレスはメール形式ではありません';
    }
  }

  Future<String> resetPassword({required String email}) {
    return _authRepository.sendPasswordResetEmail(email: email);
  }

  Future<String> facebookSignIn() {
    return _authRepository.facebookSignIn();
  }

  Future<String> googleSignIn() {
    return _authRepository.googleSignIn();
  }

  Future<String> appleSignIn() {
    return _authRepository.appleSignIn();
  }

  Future<void> logout() {
    return _authRepository.signOut();
  }
}
