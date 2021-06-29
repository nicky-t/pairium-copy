import 'month_diary_document.dart';

class MonthDiaryStoragePath {
  static String monthDiaryFilePath({
    required String partnerDocId,
  }) =>
      '${MonthDiaryDocument.collectionReference(partnerDocId: partnerDocId).path}/MonthDiary';
}
