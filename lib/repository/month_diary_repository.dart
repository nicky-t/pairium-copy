import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../firebase/firestore/firestore_field.dart';
import '../../firebase/firestore/storage_file/firebase_storage_file.dart';
import '../../firebase/storage/save_storage_file.dart';
import '../model/enums/card_color.dart';
import '../model/enums/month.dart';
import '../model/month_diary/month_diary.dart';
import '../model/month_diary/month_diary_document.dart';
import '../model/month_diary/month_diary_storage_path.dart';
import '../screen/home_screen/screen_state/home_state_provider.dart';
import '../state/user_state/user_state_provider.dart';
import 'auth_repository.dart';

final monthDiaryRepositoryProvider = Provider(
  (ref) => MonthDairyRepository(ref.read),
);

class MonthDairyRepository {
  const MonthDairyRepository(this._read);

  final Reader _read;

  Future<void> setMonthDairy({
    required Month month,
    File? frontImage,
    File? backImage,
    CardColor? cardColor,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;

    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    final user = _read(userStateProvider).user;
    if (user == null || uid == null) return;

    final selectedYear = _read(selectedYearStateProvider);

    if (user.partnerDocumentId == null || user.partnerDocumentId!.isEmpty) {
      if (frontImage != null) {
        frontStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryUserFilePath(
            userId: uid,
            year: selectedYear,
            monthName: month.name,
          )}/front',
          imageFile: frontImage,
        );
      }

      if (backImage != null) {
        backStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryUserFilePath(
            userId: uid,
            year: selectedYear,
            monthName: month.name,
          )}/back',
          imageFile: backImage,
        );
      }

      await MonthDiaryDocument.collectionReferenceUser(userId: uid).add(
        MonthDiary(
          month: month,
          monthNumber: month.number,
          year: selectedYear,
          frontImage: frontStorageFile,
          backImage: backStorageFile,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).toJson(),
      );
    } else {
      if (frontImage != null) {
        frontStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
            partnerDocId: user.partnerDocumentId!,
            year: selectedYear,
            monthName: month.name,
          )}/front',
          imageFile: frontImage,
        );
      }

      if (backImage != null) {
        backStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
            partnerDocId: user.partnerDocumentId!,
            year: selectedYear,
            monthName: month.name,
          )}/back',
          imageFile: backImage,
        );
      }

      await MonthDiaryDocument.collectionReferencePartner(
              partnerDocId: user.partnerDocumentId!)
          .add(
        MonthDiary(
          month: month,
          monthNumber: month.number,
          year: selectedYear,
          frontImage: frontStorageFile,
          backImage: backStorageFile,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).toJson(),
      );
    }
  }

  Future<void> updateMonthDairy({
    required MonthDiaryDocument monthDiaryDoc,
    File? newFrontImage,
    File? newBackImage,
    CardColor? newCardColor,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;

    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    final user = _read(userStateProvider).user;
    if (user == null || uid == null) return;

    if (user.partnerDocumentId == null || user.partnerDocumentId!.isEmpty) {
      if (newFrontImage != null) {
        frontStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryUserFilePath(
            userId: uid,
            year: monthDiaryDoc.entity.year,
            monthName: monthDiaryDoc.entity.month.name,
          )}/front',
          imageFile: newFrontImage,
        );
      }

      if (newBackImage != null) {
        backStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryUserFilePath(
            userId: uid,
            year: monthDiaryDoc.entity.year,
            monthName: monthDiaryDoc.entity.month.name,
          )}/back',
          imageFile: newBackImage,
        );
      }
    } else {
      if (newFrontImage != null) {
        frontStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
            partnerDocId: user.partnerDocumentId!,
            year: monthDiaryDoc.entity.year,
            monthName: monthDiaryDoc.entity.month.name,
          )}/front',
          imageFile: newFrontImage,
        );
      }

      if (newBackImage != null) {
        backStorageFile = await saveStorageFile(
          targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
            partnerDocId: user.partnerDocumentId!,
            year: monthDiaryDoc.entity.year,
            monthName: monthDiaryDoc.entity.month.name,
          )}/back',
          imageFile: newBackImage,
        );
      }
    }

    final newMonthDairy = monthDiaryDoc.entity.copyWith(
      frontImage: frontStorageFile ?? monthDiaryDoc.entity.frontImage,
      backImage: backStorageFile ?? monthDiaryDoc.entity.backImage,
      cardColor: newCardColor ?? monthDiaryDoc.entity.cardColor,
    );

    await monthDiaryDoc.ref.update(
      <String, dynamic>{
        ...newMonthDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }
}
