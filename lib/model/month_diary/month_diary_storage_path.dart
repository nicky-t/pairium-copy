import 'month_diary_document.dart';

class MonthDiaryStoragePath {
  static String monthDiaryPartnerFilePath({
    required String partnerDocId,
  }) =>
      MonthDiaryDocument.collectionReferencePartner(partnerDocId: partnerDocId)
          .path;

  static String monthDiaryUserFilePath({
    required String userId,
  }) =>
      MonthDiaryDocument.collectionReferenceUser(userId: userId).path;
}
