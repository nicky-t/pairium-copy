import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase/firestore/firestore_document.dart';
import '../partner/partner_document.dart';
import '../user/user_document.dart';
import 'day_diary.dart';

class DayDiaryDocument extends FirestoreDocument<DayDiary> {
  DayDiaryDocument({
    required this.entity,
    required this.ref,
  });

  @override
  final DayDiary entity;

  @override
  final DocumentReference<Map<String, dynamic>> ref;

  static WriteBatch batch = FirebaseFirestore.instance.batch();

  static CollectionReference<Map<String, dynamic>> collectionReferencePartner({
    required String partnerDocId,
  }) =>
      PartnerDocument.collectionReference()
          .doc(partnerDocId)
          .collection('dayDiary');

  static CollectionReference<Map<String, dynamic>> collectionReferenceUser({
    required String userId,
  }) =>
      UserDocument.collectionReference().doc(userId).collection('dayDiary');
}
