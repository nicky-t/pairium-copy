import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/firestore/firestore_document.dart';
import '../partner/partner_document.dart';
import '../user/user_document.dart';
import 'diary.dart';

class DiaryDocument extends FirestoreDocument<Diary> {
  DiaryDocument({
    required this.entity,
    required this.ref,
  });

  @override
  final Diary entity;

  @override
  final DocumentReference<Map<String, dynamic>> ref;

  static WriteBatch batch = FirebaseFirestore.instance.batch();

  static CollectionReference<Map<String, dynamic>> collectionReferencePartner({
    required String partnerDocId,
  }) =>
      PartnerDocument.collectionReference()
          .doc(partnerDocId)
          .collection('diary');

  static CollectionReference<Map<String, dynamic>> collectionReferenceUser({
    required String userId,
  }) =>
      UserDocument.collectionReference().doc(userId).collection('diary');
}
