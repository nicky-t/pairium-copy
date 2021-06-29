import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase/firestore/firestore_document.dart';
import '../partner/partner_document.dart';
import 'month_diary.dart';

class MonthDiaryDocument extends FirestoreDocument<MonthDiary> {
  MonthDiaryDocument({
    required this.entity,
    required this.ref,
  });

  @override
  final MonthDiary entity;

  @override
  final DocumentReference<Map<String, dynamic>> ref;

  static CollectionReference<Map<String, dynamic>> collectionReference({
    required String partnerDocId,
  }) =>
      PartnerDocument.collectionReference()
          .doc(partnerDocId)
          .collection('monthDiary');
}
