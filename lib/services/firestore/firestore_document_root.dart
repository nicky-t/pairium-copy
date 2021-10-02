import 'package:cloud_firestore/cloud_firestore.dart';

class _VersionConstant {
  static const String versionOne = 'v1';
}

class FirestoreDocumentRoot {
  static DocumentReference<Map<String, dynamic>> user() =>
      FirebaseFirestore.instance
          .collection('user')
          .doc(_VersionConstant.versionOne);
  static DocumentReference<Map<String, dynamic>> partner() =>
      FirebaseFirestore.instance
          .collection('partner')
          .doc(_VersionConstant.versionOne);
}
