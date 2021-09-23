import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../firebase/firestore/firestore_field.dart';
import '../../model/user/user.dart';
import '../../model/user/user_document.dart';
import '../../state/user_state/user_state_provider.dart';
import '../constants.dart';
import '../model/day_diary/day_diary_document.dart';
import '../model/enums/request_status.dart';
import '../model/month_diary/month_diary.dart';
import '../model/month_diary/month_diary_document.dart';
import '../model/partner/partner.dart';
import '../model/partner/partner_document.dart';
import '../model/user/user_field.dart';
import '../state/pair_state/pair_state_provider.dart';
import '../state/partner_state/partner_state_provider.dart';
import 'auth_repository.dart';
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

  Future<void> _moveDiariesToPartner({required bool isUserDiary}) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()!.uid;

    final user = _read(userStateProvider).user;
    if (user == null) return;

    if (isUserDiary) {
      // userにあったmonthDiaryをPartnerに移植
      final batch = MonthDiaryDocument.batch;

      final snapshotMonthDiaries =
          await MonthDiaryDocument.collectionReferenceUser(userId: uid).get();

      if (snapshotMonthDiaries.docs.isNotEmpty) {
        final monthDiaries = snapshotMonthDiaries.docs
            .map((monthDiaryDoc) => MonthDiary.fromJson(monthDiaryDoc.data()))
            .toList();

        for (final monthDiary in monthDiaries) {
          final docRef = MonthDiaryDocument.collectionReferencePartner(
                  partnerDocId: user.partnerDocumentId!)
              .doc();
          final newMonthDiary =
              monthDiary.copyWith(userIds: [uid, user.pairId!]);
          batch.set(
            docRef,
            newMonthDiary.toJson(),
          );
        }
        await batch.commit();
      }

      final dayDiarySnapshots =
          await DayDiaryDocument.collectionReferenceUser(userId: uid).get();
      if (dayDiarySnapshots.docs.isNotEmpty) {
        final batch = DayDiaryDocument.batch;

        final dayDiaries = dayDiarySnapshots.docs
            .map((dayDiaryDoc) => MonthDiary.fromJson(dayDiaryDoc.data()))
            .toList();

        for (final dayDiary in dayDiaries) {
          final docRef = DayDiaryDocument.collectionReferencePartner(
                  partnerDocId: user.partnerDocumentId!)
              .doc();

          final newDayDiary = dayDiary.copyWith(userIds: [uid, user.pairId!]);
          batch.set(
            docRef,
            newDayDiary.toJson(),
          );
        }
        await batch.commit();
      }
    } else {
      final pair = _read(pairStateProvider).pair;
      if (pair == null) return;

      if (pair.partnerDocumentId == null) return;
      final monthDiaryDocs =
          await MonthDiaryDocument.collectionReferenceUser(userId: user.pairId!)
              .get();
      if (monthDiaryDocs.docs.isNotEmpty) {
        final monthDiaries = monthDiaryDocs.docs
            .map((monthDiaryDoc) => MonthDiary.fromJson(monthDiaryDoc.data()))
            .toList();

        final batch = MonthDiaryDocument.batch;

        for (final monthDiary in monthDiaries) {
          final docRef = MonthDiaryDocument.collectionReferencePartner(
                  partnerDocId: pair.partnerDocumentId!)
              .doc();
          final newMonthDiary =
              monthDiary.copyWith(userIds: [uid, user.pairId!]);
          batch.set(
            docRef,
            newMonthDiary.toJson(),
          );
        }
        await batch.commit();
      }

      final dayDiarySnapshots =
          await DayDiaryDocument.collectionReferenceUser(userId: user.pairId!)
              .get();
      if (dayDiarySnapshots.docs.isNotEmpty) {
        final batch = DayDiaryDocument.batch;

        final dayDiaries = dayDiarySnapshots.docs
            .map((dayDiaryDoc) => MonthDiary.fromJson(dayDiaryDoc.data()))
            .toList();

        for (final dayDiary in dayDiaries) {
          final docRef = DayDiaryDocument.collectionReferencePartner(
                  partnerDocId: user.partnerDocumentId!)
              .doc();

          final newDayDiary = dayDiary.copyWith(userIds: [uid, user.pairId!]);
          batch.set(
            docRef,
            newDayDiary.toJson(),
          );
        }
        await batch.commit();
      }
    }
  }

  Future<void> acceptPartner({bool? isMe}) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return;

    final user = _read(userStateProvider).user;
    if (user == null) return;

    final pair = _read(pairStateProvider).pair;
    if (pair == null) return;

    if (isMe == null) {
      if (user.isFinishedOnboarding) {
        await _moveDiariesToPartner(isUserDiary: true);
      } else if (pair.isFinishedOnboarding) {
        await _moveDiariesToPartner(isUserDiary: false);
      }
      await _read(userRepositoryProvider).updateUserProfile(
        partnerRequestStatus: RequestStatus.accept,
        isFinishedOnboarding: true,
      );

      final newPair = pair.copyWith(
        partnerRequestStatus: RequestStatus.accept,
        isFinishedOnboarding: true,
      );
      await UserDocument.collectionReference().doc(user.pairId).update(
        <String, dynamic>{
          ...newPair.toJson(),
          FirestoreField.updatedAt: FieldValue.serverTimestamp(),
        },
      );
    } else if (isMe) {
      await _moveDiariesToPartner(isUserDiary: true);

      await _read(userRepositoryProvider).updateUserProfile(
        partnerRequestStatus: RequestStatus.accept,
      );

      final newPair = pair.copyWith(
        partnerRequestStatus: RequestStatus.accept,
      );
      await UserDocument.collectionReference().doc(user.pairId).update(
        <String, dynamic>{
          ...newPair.toJson(),
          FirestoreField.updatedAt: FieldValue.serverTimestamp(),
        },
      );
    } else {
      await _moveDiariesToPartner(isUserDiary: false);

      await _read(userRepositoryProvider).updateUserProfile(
        partnerRequestStatus: RequestStatus.accept,
      );

      final newPair = pair.copyWith(
        partnerRequestStatus: RequestStatus.accept,
      );
      await UserDocument.collectionReference().doc(user.pairId).update(
        <String, dynamic>{
          ...newPair.toJson(),
          FirestoreField.updatedAt: FieldValue.serverTimestamp(),
        },
      );
    }
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

  Future<void> updatePartner(DateTime? anniversary) async {
    final partnerDoc = _read(partnerStateProvider).partnerDoc;
    if (partnerDoc == null) return;

    final newPartner = partnerDoc.entity
        .copyWith(anniversary: anniversary ?? partnerDoc.entity.anniversary);

    await partnerDoc.ref.update(
      <String, dynamic>{
        ...newPartner.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }
}
