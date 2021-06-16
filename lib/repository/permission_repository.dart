import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionRepositoryProvider = Provider.autoDispose(
  (ref) => const PermissionRepository(),
);

class PermissionRepository {
  const PermissionRepository();

  Future<PermissionStatus> checkPhotoAccess() async {
    final permissionStatus = await Permission.photos.request();
    print(await Permission.photos.status);
    return permissionStatus;
  }

  Future<PermissionStatus> checkCameraAccess() async {
    await Permission.camera.request();
    final permissionStatus = await Permission.photos.status;
    return permissionStatus;
  }
}
