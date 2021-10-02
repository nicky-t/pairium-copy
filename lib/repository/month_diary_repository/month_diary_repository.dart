import 'dart:io';

import '../../model/entity/month_diary/month_diary_document.dart';

import '../../model/entity/partner/partner_document.dart';
import '../../model/enums/month.dart';
import '../../model/enums/month_card_color.dart';
import '../../model/type/user_id.dart';

abstract class MonthDairyRepository {
  Future<void> setMonthDairyToUser({
    required UserId uid,
    required Month month,
    required int year,
    File? frontImage,
    File? backImage,
    MonthCardColor? backgroundColor,
    MonthCardColor? textColor,
  });

  Future<void> setMonthDairyToPartner({
    required UserId uid,
    required PartnerDocument partnerDoc,
    required Month month,
    required int year,
    File? frontImage,
    File? backImage,
    MonthCardColor? backgroundColor,
    MonthCardColor? textColor,
  });

  Future<void> updateMonthDairyToUser({
    required UserId uid,
    required MonthDiaryDocument monthDiaryDoc,
    File? newFrontImage,
    File? newBackImage,
    MonthCardColor? newBackgroundColor,
    MonthCardColor? newTextColor,
    List<String>? userIds,
  });

  Future<void> updateMonthDairyToPartner({
    required String partnerDocumentId,
    required MonthDiaryDocument monthDiaryDoc,
    File? newFrontImage,
    File? newBackImage,
    MonthCardColor? newBackgroundColor,
    MonthCardColor? newTextColor,
    List<String>? userIds,
  });
}
