import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final permissionStatus = await Permission.camera.request();
    print(await Permission.photos.status);
    return permissionStatus;
  }
}
