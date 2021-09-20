import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

final resetPasswordViewModel = Provider(
  (ref) => ResetPasswordViewModel(ref.read),
);

class ResetPasswordViewModel {
  ResetPasswordViewModel(this._read);

  final Reader _read;

  Future<String> resetPassword({required String email}) {
    return _read(authRepositoryProvider).sendPasswordResetEmail(email: email);
  }
}
