import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/enums/gender.dart';
import '../../repository/image_picker_repository/image_picker_repository_provider.dart';
import '../../repository/permission_repository/permission_repository_provider.dart';
import '../../repository/user_repository/user_provider.dart';

extension _Filled on String? {
  bool get filled => this?.isNotEmpty ?? false;
}

class EditUserProfileViewModel {
  const EditUserProfileViewModel(this._read);

  final Reader _read;

  bool canRegister({
    required String? displayName,
    required DateTime? birthday,
    required Gender? gender,
  }) {
    return displayName.filled && birthday != null && gender != null;
  }

  Future<PermissionStatus> checkPhotoAccess() async {
    return _read(permissionRepositoryProvider).checkPhotoAccess();
  }

  Future<File?> updateImage() async {
    return _read(imagePickerRepositoryProvider).updateImage();
  }

  Future<void> setUserProfile({
    required String displayName,
    required DateTime birthday,
    required Gender gender,
    File? imageFile,
  }) async {
    await _read(userRepositoryProvider).updateUserProfile(
      displayName: displayName,
      birthday: birthday,
      gender: gender,
      imageFile: imageFile,
    );
  }
}
