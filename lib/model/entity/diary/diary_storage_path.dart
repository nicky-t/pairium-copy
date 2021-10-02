import 'diary_document.dart';

class DiaryStoragePath {
  static String diaryPartnerFilePath({
    required String partnerDocId,
    required int year,
    required int month,
    required int day,
  }) =>
      '${DiaryDocument.collectionReferencePartner(partnerDocId: partnerDocId).path}/$year/$month/$day';

  static String diaryUserFilePath({
    required String userId,
    required int year,
    required int month,
    required int day,
  }) =>
      '${DiaryDocument.collectionReferenceUser(userId: userId).path}/$year/$month/$day';
}
