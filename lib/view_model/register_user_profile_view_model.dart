import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/enums/gender.dart';
import '../../state/auth_state/auth_state.dart';
import '../../state/auth_state/auth_state_provider.dart';
import '../repository/image_picker_repository_provider.dart';
import '../repository/permission_repository.dart';
import '../repository/user_repository.dart';

final registerUserProfileViewModel = Provider.autoDispose(
  (ref) => RegisterUserProfileViewModel(ref.read),
);

class RegisterUserProfileViewModel {
  const RegisterUserProfileViewModel(this._read);

  final Reader _read;

  bool canRegister({
    required String? displayName,
    required DateTime? birthday,
    required Gender? gender,
  }) {
    return (displayName?.isNotEmpty ?? false) &&
        birthday != null &&
        gender != null;
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
    await _read(userRepositoryProvider).setInitProfile(
      displayName: displayName,
      birthday: birthday,
      gender: gender,
      imageFile: imageFile,
    );
    _read(authStateProvider.notifier).setSAuthState(AuthState.registerPartner);
  }
}
