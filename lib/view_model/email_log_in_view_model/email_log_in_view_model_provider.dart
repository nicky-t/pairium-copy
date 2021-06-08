import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'email_log_in_view_model.dart';

final emailLogInViewModelProvider = Provider.autoDispose(
  (ref) => EmailLogInViewModel(ref.read),
);
