import 'day_diary_document.dart';

class DayDiaryStoragePath {
  static String dayDiaryPartnerFilePath({
    required String partnerDocId,
    required int year,
    required int month,
    required int day,
  }) =>
      '${DayDiaryDocument.collectionReferencePartner(partnerDocId: partnerDocId).path}/$year/$month/$day';

  static String dayDiaryUserFilePath({
    required String userId,
    required int year,
    required int month,
    required int day,
  }) =>
      '${DayDiaryDocument.collectionReferenceUser(userId: userId).path}/$year/$month/$day';
}
