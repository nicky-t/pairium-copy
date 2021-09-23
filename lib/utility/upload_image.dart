import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';

import '../repository/image_picker_repository.dart';
import '../repository/permission_repository.dart';
import 'crop_image.dart';
import 'show_request_permission_dialog.dart';

Future<void> uploadImage({
  required BuildContext context,
  required void Function(File?) setFile,
  Future<void> Function()? uploadImage,
}) async {
  final permissionStatus =
      await const PermissionRepository().checkPhotoAccess();

  if (permissionStatus == PermissionStatus.granted) {
    await EasyLoading.show(status: '');
    final file = await const ImagePickerRepository().updateImage();

    if (file != null) {
      final croppedImage = await cropImage(context, file);

      if (croppedImage != null) {
        setFile(croppedImage);
      }
    }
    await uploadImage?.call();
    await EasyLoading.dismiss();
  } else if (permissionStatus == PermissionStatus.denied ||
      permissionStatus == PermissionStatus.permanentlyDenied) {
    await showRequestPermissionDialog(
      context,
      text: 'ライブラリへのアクセスを許可してください',
      description: '画像を設定するのにライブラリへのアクセスが必要です',
    );
  }
}
