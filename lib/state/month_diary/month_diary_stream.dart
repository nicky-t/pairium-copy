import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/month_diary/month_diary.dart';
import '../../model/month_diary/month_diary_document.dart';
import '../../screen/home_screen/screen_state/home_state_provider.dart';
import '../user_state/user_state_provider.dart';
import 'month_diary_state_provider.dart';

final monthDiaryStreamProvider =
    StreamProvider<List<MonthDiaryDocument?>>((ref) {
  final partnerDocumentId = ref.read(userStateProvider).user?.partnerDocumentId;
  return MonthDiaryDocument.collectionReference(
          partnerDocId: partnerDocumentId ?? '')
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
            ref.read(monthDiaryStateProvider.notifier).setMonthDiary(monthDoc);
            return monthDoc;
          }
          return null;
        },
      ).toList();
    },
  );
});
