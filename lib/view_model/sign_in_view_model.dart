import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../repository/auth_repository.dart';

final signInViewModelProvider = Provider.autoDispose(
  (ref) => SignInViewModel(ref.read),
);

class SignInViewModel {
  SignInViewModel(this._read);

  final Reader _read;

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    String _infoText;
    if (EmailValidator.validate(email)) {
      _infoText = await _read(authRepositoryProvider)
          .emailSignUp(email: email, password: password);

      if (_infoText == kSuccessCode) {
        return kSuccessCode;
      }
      return _infoText;
    } else {
      return '入力されたアドレスはメール形式ではありません';
    }
  }

  Future<String> facebookSignIn() {
    return _read(authRepositoryProvider).facebookSignIn();
  }

  Future<String> googleSignIn() {
    return _read(authRepositoryProvider).googleSignIn();
  }
}
