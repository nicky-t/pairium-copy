import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../firestore/storage_file/firebase_storage_file.dart';

Future<StorageFile> saveStorageFile({
  required String targetFilePath,
  required File imageFile,
}) async {
  final ref = FirebaseStorage.instance.ref(targetFilePath);
  final uploadTask = await ref.putFile(imageFile);
  final downLoadUrl = await uploadTask.ref.getDownloadURL();

  return StorageFile(
    path: targetFilePath,
    url: downLoadUrl,
  );
}
