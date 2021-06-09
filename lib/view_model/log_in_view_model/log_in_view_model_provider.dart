import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'log_in_view_model.dart';

final logInViewModelProvider = Provider.autoDispose(
  (ref) => LogInViewModel(ref.read),
);
