import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/enums/request_status.dart';
import '../../model/month_diary/month_diary.dart';
import '../../model/month_diary/month_diary_document.dart';
import '../../model/user/user.dart';
import '../../repository/auth_repository.dart';
import '../../screen/home_screen/screen_state/home_state_provider.dart';
import 'month_diary_state_provider.dart';

final monthDiaryStreamProvider =
    StreamProvider.family<List<MonthDiaryDocument?>, User>((ref, user) {
  final uid = ref.read(authRepositoryProvider).getCurrentUser()?.uid;
  final partnerDocumentId = user.partnerDocumentId;
  if (partnerDocumentId == null ||
      partnerDocumentId.isEmpty ||
      user.partnerRequestStatus != RequestStatus.accept) {
    return MonthDiaryDocument.collectionReferenceUser(userId: uid ?? '')
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
              final selectedYear = ref.read(selectedYearStateProvider).state;

              if (monthDoc.entity.year != selectedYear) return null;
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
              final selectedYear = ref.read(selectedYearStateProvider).state;

              if (monthDoc.entity.year != selectedYear) return null;
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
