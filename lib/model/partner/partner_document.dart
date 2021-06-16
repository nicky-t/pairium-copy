import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase/firestore/firestore_document.dart';
import '../../firebase/firestore/firestore_document_root.dart';
import 'partner.dart';

class PartnerDocument extends FirestoreDocument<Partner> {
  PartnerDocument({
    required this.entity,
    required this.ref,
  });

  @override
  final Partner entity;

  @override
  final DocumentReference<Map<String, dynamic>> ref;

  static CollectionReference<Map<String, dynamic>> collectionReference() =>
      FirebaseFirestore.instance.collection(
        '${FirestoreDocumentRoot.partner}/partners',
      );
}
