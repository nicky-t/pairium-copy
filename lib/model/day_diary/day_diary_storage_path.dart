import 'day_diary_document.dart';

class DayDiaryStoragePath {
  static String dayDiaryPartnerFilePath({
    required String partnerDocId,
  }) =>
      '${DayDiaryDocument.collectionReferencePartner(partnerDocId: partnerDocId).path}/DayDiary';

  static String dayDiaryUserFilePath({
    required String userId,
  }) =>
      '${DayDiaryDocument.collectionReferenceUser(userId: userId).path}/DayDiary';
}
