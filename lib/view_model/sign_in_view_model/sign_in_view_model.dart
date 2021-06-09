import 'package:email_validator/email_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../repository/auth_repository/auth_repository_provider.dart';

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
