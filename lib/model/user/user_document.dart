import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase/firestore/firestore_document.dart';
import '../../firebase/firestore/firestore_document_root.dart';
import 'user.dart';

class UserDocument extends FirestoreDocument<User> {
  UserDocument({
    required this.entity,
    required this.ref,
  });

  @override
  final User entity;

  @override
  final DocumentReference<Map<String, dynamic>> ref;

  static CollectionReference<Map<String, dynamic>> collectionReference() =>
      FirebaseFirestore.instance.collection(
        '${FirestoreDocumentRoot.user}/users',
      );
}
