import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/month_diary/month_diary.dart';
import '../../model/month_diary/month_diary_document.dart';
import '../user_state/user_state_provider.dart';

final monthDairyStreamProvider =
    StreamProvider.autoDispose<List<MonthDiaryDocument?>>((ref) {
  final partnerDocumentId = ref.read(userStateProvider).user?.partnerDocumentId;
  return MonthDiaryDocument.collectionReference(
          partnerDocId: partnerDocumentId ?? '')
      .snapshots()
      .map(
    (snapshot) {
      return snapshot.docs.map(
        (doc) {
          if (doc.exists && doc.data().isNotEmpty) {
            return MonthDiaryDocument(
              entity: MonthDiary.fromJson(doc.data()),
              ref: doc.reference,
            );
          }
          return null;
        },
      ).toList();
    },
  );
});
