import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'image_picker_repository.dart';

final imagePickerRepositoryProvider = Provider.autoDispose(
  (ref) => const ImagePickerRepository(),
);
