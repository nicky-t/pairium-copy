import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'permission_repository.dart';

final permissionRepositoryProvider = Provider.autoDispose(
  (ref) => const PermissionRepository(),
);
