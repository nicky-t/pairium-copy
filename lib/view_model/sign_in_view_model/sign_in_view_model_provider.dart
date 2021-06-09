import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'sign_in_view_model.dart';

final signInViewModelProvider = Provider.autoDispose(
  (ref) => SignInViewModel(ref.read),
);
