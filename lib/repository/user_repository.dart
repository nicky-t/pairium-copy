import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase/firestore/firestore_field.dart';
import '../../firebase/firestore/storage_file/firebase_storage_file.dart';
import '../../firebase/storage/save_storage_file.dart';
import '../../model/enums/gender.dart';
import '../../model/user/user.dart';
import '../../model/user/user_document.dart';
import '../../model/user/user_storage_path.dart';
import '../../state/user_state/user_state_provider.dart';
import '../model/enums/request_status.dart';
import '../model/user/user_field.dart';
import '../utility/generate_random_string.dart';
import 'auth_repository.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(ref.read),
);

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

    String? shareId;
    var flag = true;
    while (flag) {
      shareId = generateRandomString(8);

      final duplication = await UserDocument.collectionReference()
          .where(UserField.shareId, isEqualTo: shareId)
          .get();
      if (duplication.docs.isEmpty) flag = false;
    }

    final user = User(
      displayName: displayName,
      birthday: birthday,
      gender: gender,
      shareId: shareId!,
      mainProfileImage: storageFile,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await UserDocument.collectionReference().doc(uid).set(user.toJson());

    _read(userStateProvider.notifier).setUser(user);
  }

  Future<void> updateUserProfile({
    String? displayName,
    DateTime? birthday,
    Gender? gender,
    File? imageFile,
    bool? isFinishedOnboarding,
    String? pairId,
    String? partnerDocumentId,
    String? shareId,
    RequestStatus? partnerRequestStatus,
  }) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    StorageFile? storageFile;

    if (imageFile != null && uid != null) {
      storageFile = await saveStorageFile(
        targetFilePath: UserStoragePath.avatarFilePath(uid: uid),
        imageFile: imageFile,
      );
    }

    final oldUser = _read(userStateProvider).user;
    if (oldUser == null) return;

    final newUser = oldUser.copyWith(
      displayName: displayName ?? oldUser.displayName,
      birthday: birthday ?? oldUser.birthday,
      gender: gender ?? oldUser.gender,
      isFinishedOnboarding:
          isFinishedOnboarding ?? oldUser.isFinishedOnboarding,
      mainProfileImage: storageFile ?? oldUser.mainProfileImage,
      shareId: shareId ?? oldUser.shareId,
      pairId: pairId ?? oldUser.pairId,
      partnerDocumentId: partnerDocumentId ?? oldUser.partnerDocumentId,
      partnerRequestStatus:
          partnerRequestStatus ?? oldUser.partnerRequestStatus,
    );

    await UserDocument.collectionReference().doc(uid).update(
      <String, dynamic>{
        ...newUser.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }
}
