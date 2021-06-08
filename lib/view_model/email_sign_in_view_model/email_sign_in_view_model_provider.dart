import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'email_sign_in_view_model.dart';

final emailSignInViewModelProvider = Provider.autoDispose(
  (ref) => EmailSignInViewModel(ref.read),
);
