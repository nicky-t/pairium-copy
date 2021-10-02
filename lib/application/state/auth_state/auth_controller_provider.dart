import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repository/auth_repository/auth_repository_impl.dart';
import 'auth_controller.dart';
import 'auth_state.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>(
  (ref) => AuthController(
    ref.read(authRepositoryProvider),
    ref,
  ),
);
