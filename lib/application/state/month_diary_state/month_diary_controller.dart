import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/entity/month_diary/month_diary_document.dart';
import '../../../model/entity/partner/partner_document.dart';
import '../../../model/enums/month.dart';
import '../../../model/enums/month_card_color.dart';
import '../../../model/type/user_id.dart';
import '../../../repository/month_diary_repository/month_diary_repository_impl.dart';
import '../partner_state/partner_state.dart';
import 'month_diary_state.dart';
import 'month_diary_stream.dart';

class MonthDiaryController extends StateNotifier<MonthDiaryState> {
  MonthDiaryController(
    this._read, {
    required this.uid,
    required this.partnerState,
  }) : super(const MonthDiaryState()) {
    _read(monthDiaryStreamProvider(partnerState));
  }

  final Reader _read;

  final UserId uid;
  final PartnerState? partnerState;

  void setMonthDiary(MonthDiaryDocument newMonthDiaryDoc) {
    state = state.copyWith(
      monthDiaryDocs: [
        newMonthDiaryDoc,
        ...state.monthDiaryDocs,
      ],
    );
  }

  Future<void> setMonthDairyDoc({
    required Month month,
    required int year,
    MonthDiaryDocument? monthDiaryDoc,
    File? frontImage,
    File? backImage,
    MonthCardColor? backgroundColor,
    MonthCardColor? textColor,
  }) async {
    if (partnerState == null) {
      return _read(monthDiaryRepositoryProvider).setMonthDairyToUser(
        uid: uid,
        year: year,
        month: month,
        frontImage: frontImage,
        backImage: backImage,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
    } else {
      return _read(monthDiaryRepositoryProvider).setMonthDairyToPartner(
        uid: uid,
        year: year,
        partnerDoc: PartnerDocument(
          entity: partnerState!.entity,
          ref: partnerState!.ref,
        ),
        month: month,
        frontImage: frontImage,
        backImage: backImage,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
    }
  }

  Future<void> updateMonthDairyDoc({
    required Month month,
    required MonthDiaryDocument monthDiaryDoc,
    File? frontImage,
    File? backImage,
    MonthCardColor? backgroundColor,
    MonthCardColor? textColor,
  }) async {
    if (partnerState == null) {
      return _read(monthDiaryRepositoryProvider).updateMonthDairyToUser(
        uid: uid,
        monthDiaryDoc: monthDiaryDoc,
        newFrontImage: frontImage,
        newBackImage: backImage,
        newBackgroundColor: backgroundColor,
        newTextColor: textColor,
      );
    } else {
      return _read(monthDiaryRepositoryProvider).updateMonthDairyToPartner(
        partnerDocumentId: partnerState!.ref.id,
        monthDiaryDoc: monthDiaryDoc,
        newFrontImage: frontImage,
        newBackImage: backImage,
        newBackgroundColor: backgroundColor,
        newTextColor: textColor,
      );
    }
  }
}
