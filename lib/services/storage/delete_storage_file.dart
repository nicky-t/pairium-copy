import 'package:firebase_storage/firebase_storage.dart';

Future<void> deleteStorageFile({
  required String targetFilePath,
}) async {
  await FirebaseStorage.instance.ref(targetFilePath).delete();
}

void unAwaitDeleteStorageFile({
  required String targetFilePath,
}) {
  FirebaseStorage.instance.ref(targetFilePath).delete();
}
