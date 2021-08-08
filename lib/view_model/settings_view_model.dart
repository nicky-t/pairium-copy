import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

final settingsViewModelProvider = Provider(
  (ref) => SettingsViewModel(ref.read),
);

class SettingsViewModel {
  SettingsViewModel(this._read);

  final Reader _read;

  Future<void> logout() async {
    await _read(authRepositoryProvider).signOut();
  }
}
