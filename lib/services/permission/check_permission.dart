import 'package:permission_handler/permission_handler.dart';

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
