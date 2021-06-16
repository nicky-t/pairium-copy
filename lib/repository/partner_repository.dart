import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase/firestore/firestore_field.dart';
import '../../model/user/user.dart';
import '../../model/user/user_document.dart';
import '../../state/user_state/user_state_provider.dart';
import '../model/partner/partner.dart';
import '../model/partner/partner_document.dart';
import 'auth_repository_provider.dart';

final partnerRepositoryProvider = Provider(
  (ref) => PartnerRepository(ref.read),
);

class PartnerRepository {
  const PartnerRepository(this._read);

  final Reader _read;

  Future<void> setInitPartnerOne({
    DateTime? anniversary,
  }) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return;

    final partnerDoc = await PartnerDocument.collectionReference().add(
      Partner(
        userIds: [uid],
        anniversary: anniversary,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );

    final oldUser = _read(userStateProvider).user;
    if (oldUser == null) return;
    final newUser = oldUser.copyWith(partnerDocumentId: partnerDoc.id);

    await UserDocument.collectionReference().doc(uid).update(
      <String, dynamic>{
        ...newUser.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> setInitPartner({
    required String pairId,
    DateTime? anniversary,
  }) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return;

    final partnerDoc = await PartnerDocument.collectionReference().add(
      Partner(
        userIds: [uid, pairId],
        anniversary: anniversary,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );

    final oldUser = _read(userStateProvider).user;
    if (oldUser == null) return;
    final newUser = oldUser.copyWith(partnerDocumentId: partnerDoc.id);

    final partnerData =
        await UserDocument.collectionReference().doc(pairId).get();
    if (!partnerData.exists || partnerData.data()!.isNotEmpty) return;
    final oldPartner = User.fromJson(partnerData.data()!);
    final newPartner = oldPartner.copyWith(partnerDocumentId: partnerDoc.id);

    await UserDocument.collectionReference().doc(uid).update(
      <String, dynamic>{
        ...newUser.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );

    await UserDocument.collectionReference().doc(pairId).update(
      <String, dynamic>{
        ...newPartner.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }
}
