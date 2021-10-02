import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../../model/entity/diary/diary.dart';
import '../../../model/entity/diary/diary_document.dart';
import '../../../model/entity/month_diary/month_diary.dart';
import '../../../model/entity/month_diary/month_diary_document.dart';
import '../../../model/entity/partner/partner_document.dart';
import '../../../model/entity/user/user_document.dart';
import '../../../model/enums/request_status.dart';
import '../../../model/type/user_id.dart';
import '../../../repository/auth_repository/auth_repository_impl.dart';
import '../../../repository/partner_repository/partner_repository_impl.dart';
import '../../../repository/user_repository/user_repository_impl.dart';
import '../../../utility/custom_exception.dart';
import '../../state/auth_state/auth_controller_provider.dart';
import '../../state/partner_state/partner_controller_provider.dart';
import '../../state/partner_state/partner_state.dart';
import '../../state/user_state/user_controller_provider.dart';
import '../../state/user_state/user_state.dart';

final registerPartnerUseCaseProvider = Provider(
  (ref) => RegisterPartner(ref.read),
);

class RegisterPartner {
  RegisterPartner(this._read);

  final Reader _read;

  Future<UserId?> _fetchPairUserId({
    required String pairShareId,
  }) async {
    return _read(userRepositoryProvider)
        .fetchByShareId(pairShareId: pairShareId);
  }

  Future<UserState> fetchPairUserData({required UserId id}) async {
    final userDoc = await _read(userRepositoryProvider).fetch(id: id);
    if (userDoc == null) {
      throw const CustomException(message: 'パートナーのユーザーデータが見つかりませんでした。');
    }
    return UserState(entity: userDoc.entity, ref: userDoc.ref);
  }

  Future<String> requestPartner({required String pairShareId}) async {
    final uid = _read(authControllerProvider).authUser?.uid;
    final pairDocId = await _fetchPairUserId(pairShareId: pairShareId);
    if (pairDocId == null || uid == null) return kErrorCode;

    final partnerDocs =
        await _read(partnerRepositoryProvider).fetchPartnerDocsByMyId(uid: uid);

    if (partnerDocs.isNotEmpty) {
      for (final partnerDoc in partnerDocs) {
        await _read(partnerRepositoryProvider)
            .deletePartnerDoc(partnerDoc: partnerDoc);
      }
    }

    await _read(partnerRepositoryProvider).createPartnerDoc(
      uid: uid,
      pairDocId: pairDocId,
    );
    return kSuccessCode;
  }

  Future<void> acceptPartner({
    required PartnerState partnerState,
    required UserState userState,
    bool? isSelectedMySelfData,
  }) async {
    final partner = partnerState.entity;
    final user = userState.entity;

    final pairId =
        partnerState.entity.userIds.firstWhere((id) => id != userState.ref.id);
    final pairUserDoc = await fetchPairUserData(id: pairId);

    // isSelectedSelfDataがnullの場合２人ともがアプリを開始してはいない
    if (isSelectedMySelfData == null) {
      if (user.isFinishedOnboarding) {
        await _moveDiariesToPartner(isUserDiary: true);

        //TODO 相手のフィールド変換するのはCloudFunctionsに書く
        await _read(userRepositoryProvider).updateUserProfile(
          userDoc: UserDocument(
            entity: pairUserDoc.entity,
            ref: pairUserDoc.ref,
          ),
          isFinishedOnboarding: true,
        );
      } else if (pairUserDoc.entity.isFinishedOnboarding) {
        await _moveDiariesToPartner(isUserDiary: false);

        await _read(userRepositoryProvider).updateUserProfile(
          userDoc: UserDocument(
            entity: userState.entity,
            ref: userState.ref,
          ),
          isFinishedOnboarding: true,
        );
      } else {
        await _read(userRepositoryProvider).updateUserProfile(
          userDoc: UserDocument(
            entity: userState.entity,
            ref: userState.ref,
          ),
          isFinishedOnboarding: true,
        );
        await _read(userRepositoryProvider).updateUserProfile(
          userDoc: UserDocument(
            entity: pairUserDoc.entity,
            ref: pairUserDoc.ref,
          ),
          isFinishedOnboarding: true,
        );
      }
    } else {
      // どちもアプリを開始している場合
      if (isSelectedMySelfData) {
        await _moveDiariesToPartner(isUserDiary: true);
      } else {
        await _moveDiariesToPartner(isUserDiary: false);
      }
    }
    await _read(partnerRepositoryProvider).updatePartnerDoc(
      partnerDoc: PartnerDocument(entity: partner, ref: partnerState.ref),
      requestStatus: RequestStatus.accept,
    );
  }

  Future<void> rejectPartner({
    required PartnerState partnerState,
  }) async {
    await _read(partnerRepositoryProvider).updatePartnerDoc(
      partnerDoc: PartnerDocument(
        entity: partnerState.entity,
        ref: partnerState.ref,
      ),
      requestStatus: RequestStatus.reject,
    );
  }

  Future<void> cancelRequest({
    required PartnerState partnerState,
  }) async {
    // TODO キャンセルとアクセプトを同時に押した場合エラーが起きないか検証する。

    await _read(partnerRepositoryProvider).deletePartnerDoc(
      partnerDoc: PartnerDocument(
        entity: partnerState.entity,
        ref: partnerState.ref,
      ),
    );
  }

  Future<void> _moveDiariesToPartner({required bool isUserDiary}) async {
    final uid = _read(authRepositoryProvider).getCurrentUser()!.uid;

    final user = _read(userControllerProvider).data?.value;
    if (user == null) return;

    final partnerState = _read(partnerControllerProvider);
    if (partnerState == null) return;

    final pairId = partnerState.entity.userIds.firstWhere((id) => id != uid);

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
                  partnerDocId: partnerState.ref.id)
              .doc();
          final newMonthDiary = monthDiary.copyWith(userIds: [uid, pairId]);
          batch.set(
            docRef,
            newMonthDiary.toJson(),
          );
        }
        await batch.commit();
      }

      final diarySnapshots =
          await DiaryDocument.collectionReferenceUser(userId: uid).get();
      if (diarySnapshots.docs.isNotEmpty) {
        final batch = DiaryDocument.batch;

        final dayDiaries = diarySnapshots.docs
            .map((diaryDoc) => Diary.fromJson(diaryDoc.data()))
            .toList();

        for (final diary in dayDiaries) {
          final docRef = DiaryDocument.collectionReferencePartner(
                  partnerDocId: partnerState.ref.id)
              .doc();

          final newDiary = diary.copyWith(userIds: [uid, pairId]);
          batch.set(
            docRef,
            newDiary.toJson(),
          );
        }
        await batch.commit();
      }
    } else {
      final monthDiaryDocs =
          await MonthDiaryDocument.collectionReferenceUser(userId: pairId)
              .get();
      if (monthDiaryDocs.docs.isNotEmpty) {
        final monthDiaries = monthDiaryDocs.docs
            .map((monthDiaryDoc) => MonthDiary.fromJson(monthDiaryDoc.data()))
            .toList();

        final batch = MonthDiaryDocument.batch;

        for (final monthDiary in monthDiaries) {
          final docRef = MonthDiaryDocument.collectionReferencePartner(
                  partnerDocId: partnerState.ref.id)
              .doc();
          final newMonthDiary = monthDiary.copyWith(userIds: [uid, pairId]);
          batch.set(
            docRef,
            newMonthDiary.toJson(),
          );
        }
        await batch.commit();
      }

      final diarySnapshots =
          await DiaryDocument.collectionReferenceUser(userId: pairId).get();
      if (diarySnapshots.docs.isNotEmpty) {
        final batch = DiaryDocument.batch;

        final dayDiaries = diarySnapshots.docs
            .map((diaryDoc) => Diary.fromJson(diaryDoc.data()))
            .toList();

        for (final diary in dayDiaries) {
          final docRef = DiaryDocument.collectionReferencePartner(
                  partnerDocId: partnerState.ref.id)
              .doc();

          final newDiary = diary.copyWith(userIds: [uid, pairId]);
          batch.set(
            docRef,
            newDiary.toJson(),
          );
        }
        await batch.commit();
      }
    }
  }
}
