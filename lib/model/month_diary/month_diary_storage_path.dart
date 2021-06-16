import 'month_diary_document.dart';

class MonthDiaryStoragePath {
  static String monthDiaryFilePath({
    required String partnerId,
  }) =>
      '${MonthDiaryDocument.collectionReference(partnerDocId: partnerId).path}/MonthDiary';
}
