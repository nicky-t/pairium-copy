import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'welcome_view_model.dart';

final welcomeViewModelProvider = Provider(
  (ref) => WelcomeViewModel(ref.read),
);
