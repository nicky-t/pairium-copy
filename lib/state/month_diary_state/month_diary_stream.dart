import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/enums/request_status.dart';
import '../../model/month_diary/month_diary.dart';
import '../../model/month_diary/month_diary_document.dart';
import '../../model/month_diary/month_diary_field.dart';
import '../../model/user/user.dart';
import '../../repository/auth_repository.dart';
import '../../screen/home_screen/screen_state/home_state_provider.dart';
import 'month_diary_state_provider.dart';

final monthDiaryStreamProvider =
    StreamProvider.family<List<MonthDiaryDocument?>, User>((ref, user) {
  // TODO userをwatchして同じになるか確かめる（パートナー決定のとき）
  final uid = ref.read(authRepositoryProvider).getCurrentUser()?.uid;
  final partnerDocumentId = user.partnerDocumentId;
  final selectedYear = ref.watch(selectedYearStateProvider);

  if (partnerDocumentId == null ||
      partnerDocumentId.isEmpty ||
      user.partnerRequestStatus != RequestStatus.accept) {
    return MonthDiaryDocument.collectionReferenceUser(userId: uid ?? '')
        .where(MonthDiaryField.year, isEqualTo: selectedYear)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docChanges.map(
          (docChange) {
            if (docChange.doc.exists && docChange.doc.data()!.isNotEmpty) {
              final monthDoc = MonthDiaryDocument(
                entity: MonthDiary.fromJson(docChange.doc.data()!),
                ref: docChange.doc.reference,
              );

              ref
                  .read(monthDiaryStateProvider(user).notifier)
                  .setMonthDiary(monthDoc);
              return monthDoc;
            }
            return null;
          },
        ).toList();
      },
    );
  } else {
    return MonthDiaryDocument.collectionReferencePartner(
            partnerDocId: partnerDocumentId)
        .where(MonthDiaryField.year, isEqualTo: selectedYear)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docChanges.map(
          (docChange) {
            if (docChange.doc.exists && docChange.doc.data()!.isNotEmpty) {
              final monthDoc = MonthDiaryDocument(
                entity: MonthDiary.fromJson(docChange.doc.data()!),
                ref: docChange.doc.reference,
              );

              ref
                  .read(monthDiaryStateProvider(user).notifier)
                  .setMonthDiary(monthDoc);
              return monthDoc;
            }
            return null;
          },
        ).toList();
      },
    );
  }
});
