import 'month_diary_document.dart';

class MonthDiaryStoragePath {
  static String monthDiaryPartnerFilePath({
    required String partnerDocId,
    required int year,
    required String monthName,
  }) =>
      '${MonthDiaryDocument.collectionReferencePartner(partnerDocId: partnerDocId).path}/$year/$monthName';

  static String monthDiaryUserFilePath({
    required String userId,
    required int year,
    required String monthName,
  }) =>
      '${MonthDiaryDocument.collectionReferenceUser(userId: userId).path}/$year/$monthName';
}
