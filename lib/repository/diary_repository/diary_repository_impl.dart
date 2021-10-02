import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entity/diary/diary.dart';
import '../../model/entity/diary/diary_document.dart';
import '../../model/entity/diary/diary_field.dart';
import '../../model/entity/diary/diary_image/diary_image.dart';
import '../../model/entity/diary/diary_storage_path.dart';
import '../../model/entity/partner/partner_document.dart';
import '../../model/enums/weather.dart';
import '../../model/type/user_id.dart';
import '../../services/firestorage/firebase_storage_file.dart';
import '../../services/firestore/firestore_field.dart';
import '../../services/storage/delete_storage_file.dart';
import '../../services/storage/save_storage_file.dart';
import '../../utility/generate_random_string.dart';
import 'diary_repository.dart';

final diaryRepositoryProvider = Provider(
  (ref) => const DiaryRepositoryImpl(),
);

class DiaryRepositoryImpl implements DiaryRepository {
  const DiaryRepositoryImpl();

  @override
  Future<List<DiaryDocument>> fetchDiaryListFromUser({
    required UserId uid,
    required int year,
    required int month,
  }) async {
    final snapshot = await DiaryDocument.collectionReferenceUser(userId: uid)
        .where(DiaryField.year, isEqualTo: year)
        .where(DiaryField.month, isEqualTo: month)
        .orderBy(DiaryField.day)
        .get();

    if (snapshot.docs.isEmpty) return [];

    final diaryDocs = <DiaryDocument>[];

    for (final doc in snapshot.docs) {
      if (doc.exists) {
        diaryDocs.add(
          DiaryDocument(
            entity: Diary.fromJson(doc.data()),
            ref: doc.reference,
          ),
        );
      }
    }

    return diaryDocs;
  }

  @override
  Future<List<DiaryDocument>> fetchDiaryListFromPartner({
    required String partnerDocumentId,
    required int year,
    required int month,
  }) async {
    final snapshot = await DiaryDocument.collectionReferencePartner(
            partnerDocId: partnerDocumentId)
        .where(DiaryField.year, isEqualTo: year)
        .where(DiaryField.month, isEqualTo: month)
        .orderBy(DiaryField.day)
        .get();

    if (snapshot.docs.isEmpty) return [];

    final diaryDocs = <DiaryDocument>[];

    for (final doc in snapshot.docs) {
      if (doc.exists) {
        diaryDocs.add(
          DiaryDocument(
            entity: Diary.fromJson(doc.data()),
            ref: doc.reference,
          ),
        );
      }
    }

    return diaryDocs;
  }

  @override
  Future<void> setDayDairyToUser({
    required UserId uid,
    required DateTime date,
    required File mainImage,
    String title = '',
    String description = '',
    Weather? weather,
    String? tag,
    bool isFavorite = false,
  }) async {
    StorageFile? mainStorageFile;

    mainStorageFile = await saveStorageFile(
      targetFilePath: '${DiaryStoragePath.diaryUserFilePath(
        userId: uid,
        year: date.year,
        month: date.month,
        day: date.day,
      )}/mainImage',
      imageFile: mainImage,
    );

    await DiaryDocument.collectionReferenceUser(userId: uid).add(
      Diary(
        date: date,
        month: date.month,
        year: date.year,
        day: date.day,
        weather: weather,
        mainImage: mainStorageFile,
        tag: tag,
        title: title,
        description: description,
        isFavorite: isFavorite,
        userIds: [uid],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );
  }

  @override
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
  }) async {
    final mainStorageFile = await saveStorageFile(
      targetFilePath: '${DiaryStoragePath.diaryPartnerFilePath(
        partnerDocId: partnerDoc.ref.id,
        year: date.year,
        month: date.month,
        day: date.day,
      )}/mainImage',
      imageFile: mainImage,
    );

    final pairId = partnerDoc.entity.userIds.firstWhere((id) => id != uid);

    await DiaryDocument.collectionReferencePartner(
            partnerDocId: partnerDoc.ref.id)
        .add(
      Diary(
        date: date,
        month: date.month,
        year: date.year,
        day: date.day,
        weather: weather,
        mainImage: mainStorageFile,
        tag: tag,
        title: title,
        description: description,
        isFavorite: isFavorite,
        userIds: [uid, pairId],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson(),
    );
  }

  @override
  Future<void> updateDayDairy({
    required DiaryDocument diaryDoc,
    String? title,
    String? description,
    File? mainImage,
    Weather? weather,
    String? tag,
    List<DiaryImage>? images,
    bool? isFavorite,
    List<String>? userIds,
  }) async {
    StorageFile? mainStorageFile;

    if (mainImage != null) {
      mainStorageFile = await saveStorageFile(
        targetFilePath: diaryDoc.entity.mainImage.path,
        imageFile: mainImage,
      );
    }

    final newDayDairy = diaryDoc.entity.copyWith(
      mainImage: mainStorageFile ?? diaryDoc.entity.mainImage,
      title: title ?? diaryDoc.entity.title,
      description: description ?? diaryDoc.entity.description,
      weather: weather ?? diaryDoc.entity.weather,
      tag: tag ?? diaryDoc.entity.tag,
      isFavorite: isFavorite ?? diaryDoc.entity.isFavorite,
      images: images ?? diaryDoc.entity.images,
      userIds: userIds ?? diaryDoc.entity.userIds,
    );

    await diaryDoc.ref.update(
      <String, dynamic>{
        ...newDayDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<void> addDiaryImage({
    required DiaryDocument diaryDoc,
    required File image,
  }) async {
    final targetPath =
        diaryDoc.entity.mainImage.path.replaceFirst('/mainImage', '');

    final storageFile = await saveStorageFile(
      targetFilePath:
          '$targetPath/${generateRandomString(12)}${diaryDoc.entity.images.length}',
      imageFile: image,
    );

    final newDayDairy = diaryDoc.entity.copyWith(
      images: [
        ...diaryDoc.entity.images,
        DiaryImage(
          image: storageFile,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
      ],
    );

    await diaryDoc.ref.update(
      <String, dynamic>{
        ...newDayDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<void> deleteDayDairyImages({
    required DiaryDocument diaryDoc,
    required List<DiaryImage> newImages,
    required List<DiaryImage> deleteImages,
  }) async {
    for (final monthImage in deleteImages) {
      unAwaitDeleteStorageFile(targetFilePath: monthImage.image.path);
    }

    final newDayDairy = diaryDoc.entity.copyWith(
      images: newImages,
    );

    await diaryDoc.ref.update(
      <String, dynamic>{
        ...newDayDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Future<void> deleteDiary({required DiaryDocument diaryDoc}) async {
    final diary = diaryDoc.entity;
    for (final monthImage in diary.images) {
      unAwaitDeleteStorageFile(targetFilePath: monthImage.image.path);
    }
    unAwaitDeleteStorageFile(targetFilePath: diary.mainImage.path);
    await diaryDoc.ref.delete();
  }
}
