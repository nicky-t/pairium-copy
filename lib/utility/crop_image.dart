import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<File?> cropImage(BuildContext context, File imageFile) async {
  final croppedFile = await ImageCropper.cropImage(
    sourcePath: imageFile.path,
    androidUiSettings: const AndroidUiSettings(
      statusBarColor: Colors.black,
      toolbarTitle: '',
      toolbarColor: Colors.black,
      toolbarWidgetColor: Colors.white,
      backgroundColor: Colors.black,
      cropFrameColor: Colors.transparent,
      showCropGrid: false,
      hideBottomControls: true,
      initAspectRatio: CropAspectRatioPreset.original,
    ),
    iosUiSettings: const IOSUiSettings(
      hidesNavigationBar: true,
      aspectRatioPickerButtonHidden: true,
      doneButtonTitle: '完了',
      cancelButtonTitle: 'キャンセル',
    ),
  );
  return croppedFile;
}
