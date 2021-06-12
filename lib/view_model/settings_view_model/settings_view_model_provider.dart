import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'settings_view_model.dart';

final settingsViewModelProvider = Provider(
  (ref) => SettingsViewModel(ref.read),
);
