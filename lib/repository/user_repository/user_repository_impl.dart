import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/firestorage/firebase_storage_file.dart';
import '../../../services/firestore/firestore_field.dart';
import '../../../services/storage/save_storage_file.dart';
import '../../../utility/generate_random_string.dart';
import '../../model/entity/user/user.dart';
import '../../model/entity/user/user_document.dart';
import '../../model/entity/user/user_field.dart';
import '../../model/entity/user/user_storage_path.dart';
import '../../model/enums/gender.dart';
import '../../model/type/user_id.dart';
import 'user_repository.dart';

final userRepositoryProvider = Provider(
  (_) => const UserRepositoryImpl(),
);

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl();

  @override
  Future<UserDocument?> fetch({required UserId id}) async {
    final snapshot = await UserDocument.collectionReference().doc(id).get();

    if (!snapshot.exists) return null;
    final user = User.fromJson(snapshot.data()!);

    return UserDocument(entity: user, ref: snapshot.reference);
  }

  @override
  Future<void> setUserDoc({
    required String uid,
    required String displayName,
    required DateTime birthday,
    required Gender gender,
    required File? imageFile,
  }) async {
    StorageFile? storageFile;

    if (imageFile != null) {
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
  }

  @override
  Future<void> updateUserProfile({
    required UserDocument userDoc,
    String? displayName,
    DateTime? birthday,
    Gender? gender,
    File? imageFile,
    bool? isFinishedOnboarding,
  }) async {
    StorageFile? storageFile;

    final uid = userDoc.ref.id;

    final user = userDoc.entity;

    if (imageFile != null) {
      storageFile = await saveStorageFile(
        targetFilePath: UserStoragePath.avatarFilePath(uid: uid),
        imageFile: imageFile,
      );
    }

    final newUser = user.copyWith(
      displayName: displayName ?? user.displayName,
      birthday: birthday ?? user.birthday,
      gender: gender ?? user.gender,
      isFinishedOnboarding: isFinishedOnboarding ?? user.isFinishedOnboarding,
      mainProfileImage: storageFile ?? user.mainProfileImage,
    );

    await UserDocument.collectionReference().doc(uid).update(
      <String, dynamic>{
        ...newUser.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<UserId?> fetchByShareId({
    required String pairShareId,
  }) async {
    final doc = await UserDocument.collectionReference()
        .where(UserField.shareId, isEqualTo: pairShareId)
        .get();
    if (doc.docs.isEmpty || !doc.docs.first.exists) return null;
    return doc.docs.first.reference.id;
  }
}
