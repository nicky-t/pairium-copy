import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/entity/month_diary/month_diary.dart';
import '../../../model/entity/month_diary/month_diary_document.dart';
import '../../../model/entity/month_diary/month_diary_field.dart';
import '../../../repository/auth_repository/auth_repository_impl.dart';
import '../../../ui/screen/home_screen/screen_state/home_state_provider.dart';
import '../partner_state/partner_state.dart';
import 'month_diary_state_provider.dart';

final monthDiaryStreamProvider =
    StreamProvider.family<List<MonthDiaryDocument?>, PartnerState?>(
        (ref, partnerState) {
  // TODO 違いう方法を考える
  final uid = ref.read(authRepositoryProvider).getCurrentUser()?.uid;
  final partnerDocumentId = partnerState?.ref.id;
  final selectedYear = ref.watch(selectedYearStateProvider);

  if (partnerDocumentId == null) {
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
                  .read(monthDiaryControllerProvider(partnerState).notifier)
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
                  .read(monthDiaryControllerProvider(partnerState).notifier)
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
