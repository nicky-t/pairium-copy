import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'register_user_profile_view_model.dart';

final registerUserProfileViewModel = Provider.autoDispose(
  (ref) => RegisterUserProfileViewModel(ref.read),
);
