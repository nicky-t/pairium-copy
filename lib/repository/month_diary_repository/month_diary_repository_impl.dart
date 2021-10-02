import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entity/month_diary/month_diary.dart';
import '../../model/entity/month_diary/month_diary_document.dart';
import '../../model/entity/month_diary/month_diary_storage_path.dart';
import '../../model/entity/partner/partner_document.dart';
import '../../model/enums/month.dart';
import '../../model/enums/month_card_color.dart';
import '../../model/type/user_id.dart';
import '../../services/firestorage/firebase_storage_file.dart';
import '../../services/firestore/firestore_field.dart';
import '../../services/storage/save_storage_file.dart';
import 'month_diary_repository.dart';

final monthDiaryRepositoryProvider = Provider(
  (ref) => const MonthDairyRepositoryImpl(),
);

class MonthDairyRepositoryImpl implements MonthDairyRepository {
  const MonthDairyRepositoryImpl();

  @override
  Future<void> setMonthDairyToUser({
    required UserId uid,
    required Month month,
    required int year,
    File? frontImage,
    File? backImage,
    MonthCardColor? backgroundColor,
    MonthCardColor? textColor,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;

    backgroundColor ??= MonthCardColor.white;
    textColor ??= MonthCardColor.grey;

    if (frontImage != null) {
      frontStorageFile = await saveStorageFile(
        targetFilePath: '${MonthDiaryStoragePath.monthDiaryUserFilePath(
          userId: uid,
          year: year,
          monthName: month.name,
        )}/front',
        imageFile: frontImage,
      );
    }

    if (backImage != null) {
      backStorageFile = await saveStorageFile(
        targetFilePath: '${MonthDiaryStoragePath.monthDiaryUserFilePath(
          userId: uid,
          year: year,
          monthName: month.name,
        )}/back',
        imageFile: backImage,
      );
    }

    await MonthDiaryDocument.collectionReferenceUser(userId: uid).add(
      MonthDiary(
        month: month,
        monthNumber: month.number,
        year: year,
        frontImage: frontStorageFile,
        backImage: backStorageFile,
        backgroundColor: backgroundColor,
        textColor: textColor,
        userIds: [uid],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );
  }

  @override
  Future<void> setMonthDairyToPartner({
    required UserId uid,
    required PartnerDocument partnerDoc,
    required Month month,
    required int year,
    File? frontImage,
    File? backImage,
    MonthCardColor? backgroundColor,
    MonthCardColor? textColor,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;

    backgroundColor ??= MonthCardColor.white;
    textColor ??= MonthCardColor.grey;

    if (frontImage != null) {
      frontStorageFile = await saveStorageFile(
        targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
          partnerDocId: partnerDoc.ref.id,
          year: year,
          monthName: month.name,
        )}/front',
        imageFile: frontImage,
      );
    }

    if (backImage != null) {
      backStorageFile = await saveStorageFile(
        targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
          partnerDocId: partnerDoc.ref.id,
          year: year,
          monthName: month.name,
        )}/back',
        imageFile: backImage,
      );
    }

    final pairId = partnerDoc.entity.userIds.firstWhere((id) => id != uid);

    await MonthDiaryDocument.collectionReferencePartner(
      partnerDocId: partnerDoc.ref.id,
    ).add(
      MonthDiary(
        month: month,
        monthNumber: month.number,
        year: year,
        userIds: [uid, pairId],
        frontImage: frontStorageFile,
        backImage: backStorageFile,
        backgroundColor: backgroundColor,
        textColor: textColor,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );
  }

  @override
  Future<void> updateMonthDairyToUser({
    required UserId uid,
    required MonthDiaryDocument monthDiaryDoc,
    File? newFrontImage,
    File? newBackImage,
    MonthCardColor? newBackgroundColor,
    MonthCardColor? newTextColor,
    List<String>? userIds,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;
    MonthCardColor? backgroundColor;
    MonthCardColor? textColor;

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

    if (newBackgroundColor != null) {
      backgroundColor = newBackgroundColor;
    }
    if (newTextColor != null) {
      textColor = newTextColor;
    }

    final newMonthDairy = monthDiaryDoc.entity.copyWith(
      frontImage: frontStorageFile ?? monthDiaryDoc.entity.frontImage,
      backImage: backStorageFile ?? monthDiaryDoc.entity.backImage,
      backgroundColor: backgroundColor ?? monthDiaryDoc.entity.backgroundColor,
      textColor: textColor ?? monthDiaryDoc.entity.textColor,
      userIds: userIds ?? monthDiaryDoc.entity.userIds,
    );

    await monthDiaryDoc.ref.update(
      <String, dynamic>{
        ...newMonthDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<void> updateMonthDairyToPartner({
    required String partnerDocumentId,
    required MonthDiaryDocument monthDiaryDoc,
    File? newFrontImage,
    File? newBackImage,
    MonthCardColor? newBackgroundColor,
    MonthCardColor? newTextColor,
    List<String>? userIds,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;
    MonthCardColor? backgroundColor;
    MonthCardColor? textColor;

    if (newFrontImage != null) {
      frontStorageFile = await saveStorageFile(
        targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
          partnerDocId: partnerDocumentId,
          year: monthDiaryDoc.entity.year,
          monthName: monthDiaryDoc.entity.month.name,
        )}/front',
        imageFile: newFrontImage,
      );
    }

    if (newBackImage != null) {
      backStorageFile = await saveStorageFile(
        targetFilePath: '${MonthDiaryStoragePath.monthDiaryPartnerFilePath(
          partnerDocId: partnerDocumentId,
          year: monthDiaryDoc.entity.year,
          monthName: monthDiaryDoc.entity.month.name,
        )}/back',
        imageFile: newBackImage,
      );
    }

    if (newBackgroundColor != null) {
      backgroundColor = newBackgroundColor;
    }
    if (newTextColor != null) {
      textColor = newTextColor;
    }

    final newMonthDairy = monthDiaryDoc.entity.copyWith(
      frontImage: frontStorageFile ?? monthDiaryDoc.entity.frontImage,
      backImage: backStorageFile ?? monthDiaryDoc.entity.backImage,
      backgroundColor: backgroundColor ?? monthDiaryDoc.entity.backgroundColor,
      textColor: textColor ?? monthDiaryDoc.entity.textColor,
      userIds: userIds ?? monthDiaryDoc.entity.userIds,
    );

    await monthDiaryDoc.ref.update(
      <String, dynamic>{
        ...newMonthDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }
}
