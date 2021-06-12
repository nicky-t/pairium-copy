import 'user_document.dart';

class UserStoragePath {
  static String avatarFilePath({
    required String uid,
  }) =>
      '${UserDocument.collectionReference().doc(uid).path}/avatar';
}
