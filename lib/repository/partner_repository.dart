import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase/firestore/firestore_field.dart';
import '../../model/user/user.dart';
import '../../model/user/user_document.dart';
import '../../state/user_state/user_state_provider.dart';
import '../constants.dart';
import '../model/enums/request_status.dart';
import '../model/partner/partner.dart';
import '../model/partner/partner_document.dart';
import '../model/user/user_field.dart';
import '../state/pair_state/pair_state_provider.dart';
import 'auth_repository_provider.dart';
import 'user_repository.dart';

final partnerRepositoryProvider = Provider(
  (ref) => PartnerRepository(ref.read),
);

class PartnerRepository {
  const PartnerRepository(this._read);

  final Reader _read;

  Future<String> requestPartner({
    required String pairShareId,
  }) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return kErrorCode;

    final doc = await UserDocument.collectionReference()
        .where(UserField.shareId, isEqualTo: pairShareId)
        .get();
    if (doc.docs.isEmpty || !doc.docs.first.exists) return kErrorCode;

    final pairDoc = UserDocument(
      entity: User.fromJson(doc.docs.first.data()),
      ref: doc.docs.first.reference,
    );
    if (pairDoc.entity.pairId != null) {
      return kErrorCode;
    }

    final partnerRef = await PartnerDocument.collectionReference().add(
      Partner(
        userIds: [uid, pairDoc.ref.id],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );

    final newPair = pairDoc.entity.copyWith(
      pairId: uid,
      partnerDocumentId: partnerRef.id,
      partnerRequestStatus: RequestStatus.requested,
    );

    await pairDoc.ref.update(
      <String, dynamic>{
        ...newPair.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );

    final oldUser = _read(userStateProvider).user;
    if (oldUser == null) return kErrorCode;
    await _read(userRepositoryProvider).updateUserProfile(
      partnerDocumentId: partnerRef.id,
      pairId: pairDoc.ref.id,
      partnerRequestStatus: RequestStatus.waiting,
    );

    return kSuccessCode;
  }

  Future<void> acceptPartner() async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return;

    final oldUser = _read(userStateProvider).user;
    if (oldUser == null) return;

    await _read(userRepositoryProvider).updateUserProfile(
      partnerRequestStatus: RequestStatus.accept,
      isFinishedOnboarding: true,
    );

    final oldPair = _read(pairStateProvider).pair;
    if (oldPair == null) return;

    final newPair = oldPair.copyWith(
      partnerRequestStatus: RequestStatus.accept,
      isFinishedOnboarding: true,
    );

    await UserDocument.collectionReference().doc(oldUser.pairId).update(
      <String, dynamic>{
        ...newPair.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> rejectPartner() async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return;

    final oldUser = _read(userStateProvider).user;
    if (oldUser == null) return;

    await PartnerDocument.collectionReference()
        .doc(oldUser.partnerDocumentId)
        .delete();

    final oldPair = _read(pairStateProvider).pair;
    if (oldPair == null) return;

    final newPair = oldPair.copyWith(
      partnerRequestStatus: RequestStatus.reject,
      pairId: null,
      partnerDocumentId: null,
    );

    await UserDocument.collectionReference().doc(oldUser.pairId).update(
      <String, dynamic>{
        ...newPair.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );

    final newUser = oldUser.copyWith(
      partnerRequestStatus: null,
      pairId: null,
      partnerDocumentId: null,
    );

    await UserDocument.collectionReference().doc(uid).update(
      <String, dynamic>{
        ...newUser.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> cancelRequest() async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return;

    final oldUser = _read(userStateProvider).user;
    if (oldUser == null) return;

    await PartnerDocument.collectionReference()
        .doc(oldUser.partnerDocumentId)
        .delete();

    final oldPair = _read(pairStateProvider).pair;

    if (oldPair == null) return;

    final newPair = oldPair.copyWith(
      partnerRequestStatus: null,
      pairId: null,
      partnerDocumentId: null,
    );

    await UserDocument.collectionReference().doc(oldUser.pairId).update(
      <String, dynamic>{
        ...newPair.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );

    final newUser = oldUser.copyWith(
      partnerRequestStatus: null,
      pairId: null,
      partnerDocumentId: null,
    );

    await UserDocument.collectionReference().doc(uid).update(
      <String, dynamic>{
        ...newUser.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }
}
