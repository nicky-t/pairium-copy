import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repository/auth_repository/auth_repository_provider.dart';

class WelcomeViewModel {
  const WelcomeViewModel(this._read);

  final Reader _read;

  Future<String> googleSignIn() {
    return _read(authRepositoryProvider).googleSignIn();
  }
}
