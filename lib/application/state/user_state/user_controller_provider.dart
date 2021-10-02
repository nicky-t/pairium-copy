import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repository/user_repository/user_repository_impl.dart';
import '../auth_state/auth_controller_provider.dart';
import 'user_controller.dart';
import 'user_state.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<UserState?>>(
  (ref) {
    final uid = ref.read(authControllerProvider).authUser?.uid;
    return UserController(ref.read(userRepositoryProvider), uid: uid);
  },
);
