import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../repository/permission_repository/permission_repository_provider.dart';

final editPartnerViewModelProvider = Provider(
  (ref) => EditPartnerViewModel(ref.read),
);

class EditPartnerViewModel {
  const EditPartnerViewModel(this._read);

  final Reader _read;

  Future<PermissionStatus> checkCameraAccess() async {
    return _read(permissionRepositoryProvider).checkCameraAccess();
  }
}
