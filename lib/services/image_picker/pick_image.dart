import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  final _picker = ImagePicker();
  XFile? _image;

  _image = await _picker.pickImage(source: ImageSource.gallery);
  if (_image == null) return null;
  return File(_image.path);
}
