import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase/firestore/firestore_field.dart';
import '../../firebase/firestore/storage_file/firebase_storage_file.dart';
import '../../firebase/storage/save_storage_file.dart';
import '../model/enums/card_color.dart';
import '../model/enums/month.dart';
import '../model/month_diary/month_diary.dart';
import '../model/month_diary/month_diary_document.dart';
import '../model/month_diary/month_diary_storage_path.dart';

final monthDairyRepositoryProvider = Provider(
  (ref) => const MonthDairyRepository(),
);

class MonthDairyRepository {
  const MonthDairyRepository();

  Future<void> setMonthDairy({
    required String partnerDocId,
    required Month month,
    File? frontImage,
    File? backImage,
    CardColor? cardColor,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;

    if (frontImage != null) {
      frontStorageFile = await saveStorageFile(
        targetFilePath:
            '${MonthDiaryStoragePath.monthDiaryFilePath(partnerDocId: partnerDocId)}/${month.name}/front',
        imageFile: frontImage,
      );
    }

    if (backImage != null) {
      backStorageFile = await saveStorageFile(
        targetFilePath:
            '${MonthDiaryStoragePath.monthDiaryFilePath(partnerDocId: partnerDocId)}/${month.name}/back',
        imageFile: backImage,
      );
    }

    await MonthDiaryDocument.collectionReference(partnerDocId: partnerDocId)
        .add(
      MonthDiary(
        month: month,
        monthNumber: month.number,
        frontImage: frontStorageFile,
        backImage: backStorageFile,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );
  }

  Future<void> updateMonthDairy({
    required String partnerDocId,
    required MonthDiaryDocument monthDiaryDoc,
    File? newFrontImage,
    File? newBackImage,
    CardColor? newCardColor,
  }) async {
    StorageFile? frontStorageFile;
    StorageFile? backStorageFile;

    if (newFrontImage != null) {
      frontStorageFile = await saveStorageFile(
        targetFilePath:
            '${MonthDiaryStoragePath.monthDiaryFilePath(partnerDocId: partnerDocId)}/${monthDiaryDoc.entity.month.name}/front',
        imageFile: newFrontImage,
      );
    }

    if (newBackImage != null) {
      backStorageFile = await saveStorageFile(
        targetFilePath:
            '${MonthDiaryStoragePath.monthDiaryFilePath(partnerDocId: partnerDocId)}/${monthDiaryDoc.entity.month.name}/back',
        imageFile: newBackImage,
      );
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
