import 'dart:io';

import '../../model/entity/diary/diary_document.dart';
import '../../model/entity/diary/diary_image/diary_image.dart';
import '../../model/entity/partner/partner_document.dart';
import '../../model/enums/weather.dart';
import '../../model/type/user_id.dart';

abstract class DiaryRepository {
  Future<List<DiaryDocument>> fetchDiaryListFromUser({
    required UserId uid,
    required int year,
    required int month,
  });
  Future<List<DiaryDocument>> fetchDiaryListFromPartner({
    required String partnerDocumentId,
    required int year,
    required int month,
  });

  Future<void> setDayDairyToUser({
    required UserId uid,
    required DateTime date,
    required File mainImage,
    String title = '',
    String description = '',
    Weather? weather,
    String? tag,
    bool isFavorite = false,
  });

  Future<void> setDayDairyToPartner({
    required UserId uid,
    required PartnerDocument partnerDoc,
    required DateTime date,
    required File mainImage,
    String title = '',
    String description = '',
    Weather? weather,
    String? tag,
    bool isFavorite = false,
  });

  Future<void> updateDayDairy({
    required DiaryDocument diaryDoc,
    File? mainImage,
    String? title,
    String? description,
    Weather? weather,
    String? tag,
    bool isFavorite = false,
  });

  Future<void> deleteDiary({required DiaryDocument diaryDoc});

  Future<void> addDiaryImage({
    required DiaryDocument diaryDoc,
    required File image,
  });

  Future<void> deleteDayDairyImages({
    required DiaryDocument diaryDoc,
    required List<DiaryImage> newImages,
    required List<DiaryImage> deleteImages,
  });
}
