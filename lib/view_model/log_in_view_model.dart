import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../repository/auth_repository.dart';

final logInViewModelProvider = Provider.autoDispose(
  (ref) => LogInViewModel(ref.read),
);

class LogInViewModel {
  LogInViewModel(this._read);

  final Reader _read;

  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    String _infoText;
    if (EmailValidator.validate(email)) {
      _infoText = await _read(authRepositoryProvider)
          .emailLogIn(email: email, password: password);

      if (_infoText == kSuccessCode) {
        return kSuccessCode;
      }
      return _infoText;
    } else {
      return '入力されたアドレスはメール形式ではありません';
    }
  }

  Future<String> facebookLogin() {
    return _read(authRepositoryProvider).facebookSignIn();
  }

  Future<String> googleLogin() {
    return _read(authRepositoryProvider).googleSignIn();
  }
}
