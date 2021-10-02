import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../../services/firestore/firestore_field.dart';
import '../../model/entity/partner/partner.dart';
import '../../model/entity/partner/partner_document.dart';
import '../../model/entity/partner/partner_field.dart';
import '../../model/enums/request_status.dart';
import '../../model/type/user_id.dart';
import 'partner_repository.dart';

final partnerRepositoryProvider = Provider(
  (ref) => const PartnerRepositoryImpl(),
);

class PartnerRepositoryImpl implements PartnerRepository {
  const PartnerRepositoryImpl();

  @override
  Future<List<PartnerDocument>> fetchPartnerDocsByMyId({
    required UserId uid,
  }) async {
    final snapshot = await PartnerDocument.collectionReference()
        .where(PartnerField.userIds, arrayContains: uid)
        .get();

    final partnerStateList = <PartnerDocument>[];
    if (snapshot.docs.isEmpty) return [];
    for (final doc in snapshot.docs) {
      if (doc.exists) {
        partnerStateList.add(
          PartnerDocument(
            entity: Partner.fromJson(doc.data()),
            ref: doc.reference,
          ),
        );
      }
    }
    return partnerStateList;
  }

  @override
  Future<String> createPartnerDoc({
    required UserId uid,
    required UserId pairDocId,
  }) async {
    await PartnerDocument.collectionReference().add(
      Partner(
        userIds: [uid, pairDocId],
        submitRequestUser: uid,
        receiveRequestUser: pairDocId,
        requestStatus: RequestStatus.waiting,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );

    return kSuccessCode;
  }

  @override
  Future<void> updatePartnerDoc({
    required PartnerDocument partnerDoc,
    DateTime? anniversary,
    UserId? submitRequestUser,
    UserId? receiveRequestUser,
    RequestStatus? requestStatus,
  }) async {
    final partner = partnerDoc.entity;

    final newPartner = partner.copyWith(
      anniversary: anniversary ?? partner.anniversary,
      submitRequestUser: submitRequestUser ?? partner.submitRequestUser,
      receiveRequestUser: receiveRequestUser ?? partner.receiveRequestUser,
      requestStatus: requestStatus ?? partner.requestStatus,
    );

    await partnerDoc.ref.update(
      <String, dynamic>{
        ...newPartner.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<void> deletePartnerDoc({
    required PartnerDocument partnerDoc,
  }) async {
    await partnerDoc.ref.delete();
  }
}
