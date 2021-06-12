import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'user_repository.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(ref.read),
);
