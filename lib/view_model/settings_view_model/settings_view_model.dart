import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repository/auth_repository/auth_repository_provider.dart';

class SettingsViewModel {
  SettingsViewModel(this._read);

  final Reader _read;

  Future<void> logout() async {
    await _read(authRepositoryProvider).signOut();
  }
}
