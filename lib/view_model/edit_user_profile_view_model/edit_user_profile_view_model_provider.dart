import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'edit_user_profile_view_model.dart';

final editUserProfileViewModelProvider = Provider(
  (ref) => EditUserProfileViewModel(ref.read),
);
