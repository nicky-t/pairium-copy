import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerRepository {
  const ImagePickerRepository();

  Future<File?> updateImage() async {
    final _picker = ImagePicker();
    PickedFile? _image;

    _image = await _picker.getImage(source: ImageSource.gallery);
    if (_image == null) return null;
    return File(_image.path);
  }
}
