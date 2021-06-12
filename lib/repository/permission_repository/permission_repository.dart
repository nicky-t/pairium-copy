import 'package:permission_handler/permission_handler.dart';

class PermissionRepository {
  const PermissionRepository();

  Future<PermissionStatus> checkPhotoAccess() async {
    final permissionStatus = await Permission.photos.request();
    print(await Permission.photos.status);
    return permissionStatus;
  }
}
