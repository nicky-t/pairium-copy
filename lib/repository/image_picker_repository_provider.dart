import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerRepositoryProvider = Provider.autoDispose(
  (ref) => const ImagePickerRepository(),
);

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
