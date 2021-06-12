import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase/firestore/storage_file/firebase_storage_file.dart';
import '../../firebase/storage/save_storage_file.dart';
import '../../model/enums/gender.dart';
import '../../model/user/user.dart';
import '../../model/user/user_document.dart';
import '../../model/user/user_storage_path.dart';
import '../auth_repository/auth_repository_provider.dart';

class UserRepository {
  const UserRepository(this._read);

  final Reader _read;

  Future<void> setInitProfile({
    required String displayName,
    required DateTime birthday,
    required Gender gender,
    required File? imageFile,
  }) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    StorageFile? storageFile;

    if (imageFile != null && uid != null) {
      storageFile = await saveStorageFile(
        targetFilePath: UserStoragePath.avatarFilePath(uid: uid),
        imageFile: imageFile,
      );
    }

    await UserDocument.collectionReference().doc(uid).set(
          User(
            displayName: displayName,
            birthday: birthday,
            gender: gender,
            mainProfileImage: storageFile,
            isFinishedOnboarding: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ).toJson(),
        );
  }
}
