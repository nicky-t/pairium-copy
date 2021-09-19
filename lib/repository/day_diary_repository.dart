import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../firebase/firestore/firestore_field.dart';
import '../../firebase/firestore/storage_file/firebase_storage_file.dart';
import '../../firebase/storage/save_storage_file.dart';
import '../firebase/storage/delete_storage_file.dart';
import '../model/day_diary/day_diary.dart';
import '../model/day_diary/day_diary_document.dart';
import '../model/day_diary/day_diary_field.dart';
import '../model/day_diary/day_diary_image/day_diary_image.dart';
import '../model/day_diary/day_diary_storage_path.dart';
import '../model/enums/weather.dart';
import '../state/day_diary_state/day_diary_state_provider.dart';
import '../state/is_exist_partner_state/is_exist_partner_state_provider.dart';
import '../state/user_state/user_state_provider.dart';
import '../utility/generate_random_string.dart';
import 'auth_repository.dart';

final dayDiaryRepositoryProvider = Provider(
  (ref) => DayDiaryRepository(ref.read),
);

class DayDiaryRepository {
  const DayDiaryRepository(this._read);

  final Reader _read;

  Future<List<DayDiaryDocument?>> fetchDayDairies({
    required int year,
    required int month,
  }) async {
    List<DayDiaryDocument?> dayDiaryDocs;

    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    final user = _read(userStateProvider).user;
    if (user == null || uid == null) return [];

    final isExistPartner = _read(isExistPartnerStateProvider);

    if (!isExistPartner) {
      final snapshot =
          await DayDiaryDocument.collectionReferenceUser(userId: uid)
              .where(DayDiaryField.year, isEqualTo: year)
              .where(DayDiaryField.month, isEqualTo: month)
              .orderBy(DayDiaryField.day)
              .get();

      if (snapshot.docs.isEmpty) return [];

      dayDiaryDocs = snapshot.docs.map((doc) {
        if (doc.exists && doc.data().isNotEmpty) {
          return DayDiaryDocument(
            entity: DayDiary.fromJson(doc.data()),
            ref: doc.reference,
          );
        }
      }).toList();
    } else {
      final snapshot = await DayDiaryDocument.collectionReferencePartner(
              partnerDocId: user.partnerDocumentId!)
          .where(DayDiaryField.year, isEqualTo: year)
          .where(DayDiaryField.month, isEqualTo: month)
          .orderBy(DayDiaryField.day)
          .get();

      if (snapshot.docs.isEmpty) return [];

      dayDiaryDocs = snapshot.docs.map((doc) {
        if (doc.exists && doc.data().isNotEmpty) {
          return DayDiaryDocument(
            entity: DayDiary.fromJson(doc.data()),
            ref: doc.reference,
          );
        }
      }).toList();
    }

    return dayDiaryDocs;
  }

  Future<DayDiaryDocument?> fetchDayDairy({
    required int year,
    required int month,
    required int day,
  }) async {
    DayDiaryDocument? dayDiaryDoc;

    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    final user = _read(userStateProvider).user;
    if (user == null || uid == null) return null;

    final isExistPartner = _read(isExistPartnerStateProvider);

    if (!isExistPartner) {
      final snapshot =
          await DayDiaryDocument.collectionReferenceUser(userId: uid)
              .where(DayDiaryField.year, isEqualTo: year)
              .where(DayDiaryField.month, isEqualTo: month)
              .where(DayDiaryField.day, isEqualTo: day)
              .limit(1)
              .get();

      if (snapshot.docs.isEmpty) return null;

      dayDiaryDoc = DayDiaryDocument(
        entity: DayDiary.fromJson(snapshot.docs.first.data()),
        ref: snapshot.docs.first.reference,
      );
    } else {
      final snapshot = await DayDiaryDocument.collectionReferencePartner(
              partnerDocId: user.partnerDocumentId!)
          .where(DayDiaryField.year, isEqualTo: year)
          .where(DayDiaryField.month, isEqualTo: month)
          .where(DayDiaryField.day, isEqualTo: day)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      dayDiaryDoc = DayDiaryDocument(
        entity: DayDiary.fromJson(snapshot.docs.first.data()),
        ref: snapshot.docs.first.reference,
      );
    }

    return dayDiaryDoc;
  }

  Future<DayDiaryDocument> fetchDayDiaryFromDoc({
    required DayDiaryDocument dayDiaryDoc,
  }) async {
    final doc = await dayDiaryDoc.ref.get();

    return DayDiaryDocument(
        entity: DayDiary.fromJson(doc.data()!), ref: dayDiaryDoc.ref);
  }

  Future<void> setDayDairy({
    required DateTime date,
    required File mainImage,
    String title = '',
    String description = '',
    Weather? weather,
    String? tag,
    bool isFavorite = false,
  }) async {
    StorageFile? mainStorageFile;

    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    final user = _read(userStateProvider).user;
    if (user == null || uid == null) return;

    final isExistPartner = _read(isExistPartnerStateProvider);

    if (!isExistPartner) {
      mainStorageFile = await saveStorageFile(
        targetFilePath: '${DayDiaryStoragePath.dayDiaryUserFilePath(
          userId: uid,
          year: date.year,
          month: date.month,
          day: date.day,
        )}/mainImage',
        imageFile: mainImage,
      );

      await DayDiaryDocument.collectionReferenceUser(userId: uid).add(
        DayDiary(
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
    } else {
      mainStorageFile = await saveStorageFile(
        targetFilePath: '${DayDiaryStoragePath.dayDiaryPartnerFilePath(
          partnerDocId: user.partnerDocumentId!,
          year: date.year,
          month: date.month,
          day: date.day,
        )}/mainImage',
        imageFile: mainImage,
      );

      await DayDiaryDocument.collectionReferencePartner(
              partnerDocId: user.partnerDocumentId!)
          .add(
        DayDiary(
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
          userIds: [uid, user.pairId!],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).toJson(),
      );
    }
  }

  Future<void> updateDayDairy({
    required DayDiaryDocument dayDiaryDoc,
    String? title,
    String? description,
    File? mainImage,
    Weather? weather,
    String? tag,
    List<DayDiaryImage>? images,
    bool? isFavorite,
    List<String>? userIds,
  }) async {
    StorageFile? mainStorageFile;

    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    final user = _read(userStateProvider).user;
    if (user == null || uid == null) return;

    final date = dayDiaryDoc.entity.date;

    final isExistPartner = _read(isExistPartnerStateProvider);

    if (mainImage != null) {
      if (!isExistPartner) {
        mainStorageFile = await saveStorageFile(
          targetFilePath: '${DayDiaryStoragePath.dayDiaryUserFilePath(
            userId: uid,
            year: date.year,
            month: date.month,
            day: date.day,
          )}/mainImage',
          imageFile: mainImage,
        );
      } else {
        mainStorageFile = await saveStorageFile(
          targetFilePath: '${DayDiaryStoragePath.dayDiaryPartnerFilePath(
            partnerDocId: user.partnerDocumentId!,
            year: date.year,
            month: date.month,
            day: date.day,
          )}/mainImage',
          imageFile: mainImage,
        );
      }
    }

    final newDayDairy = dayDiaryDoc.entity.copyWith(
      mainImage: mainStorageFile ?? dayDiaryDoc.entity.mainImage,
      title: title ?? dayDiaryDoc.entity.title,
      description: description ?? dayDiaryDoc.entity.description,
      weather: weather ?? dayDiaryDoc.entity.weather,
      tag: tag ?? dayDiaryDoc.entity.tag,
      isFavorite: isFavorite ?? dayDiaryDoc.entity.isFavorite,
      images: images ?? dayDiaryDoc.entity.images,
      userIds: userIds ?? dayDiaryDoc.entity.userIds,
    );

    await dayDiaryDoc.ref.update(
      <String, dynamic>{
        ...newDayDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> addDayDiaryImage({
    required DayDiaryDocument dayDiaryDoc,
    required File? image,
  }) async {
    StorageFile? storageFile;

    final uid = _read(authRepositoryProvider).getCurrentUser()?.uid;
    final user = _read(userStateProvider).user;
    if (user == null || uid == null) return;

    final date = dayDiaryDoc.entity.date;

    final isExistPartner = _read(isExistPartnerStateProvider);

    if (image != null) {
      if (!isExistPartner) {
        storageFile = await saveStorageFile(
          targetFilePath: '${DayDiaryStoragePath.dayDiaryUserFilePath(
            userId: uid,
            year: date.year,
            month: date.month,
            day: date.day,
          )}/${generateRandomString(12)}${dayDiaryDoc.entity.images.length}',
          imageFile: image,
        );
      } else {
        storageFile = await saveStorageFile(
          targetFilePath: '${DayDiaryStoragePath.dayDiaryPartnerFilePath(
            partnerDocId: user.partnerDocumentId!,
            year: date.year,
            month: date.month,
            day: date.day,
          )}/${generateRandomString(12)}${dayDiaryDoc.entity.images.length}',
          imageFile: image,
        );
      }
    }

    final newDayDairy = dayDiaryDoc.entity.copyWith(
      images: [
        ...dayDiaryDoc.entity.images,
        DayDiaryImage(
          image: storageFile!,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
      ],
    );

    await dayDiaryDoc.ref.update(
      <String, dynamic>{
        ...newDayDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );

    await _read(dayDiaryStateProvider.notifier)
        .fetchDayDiaries(year: date.year, month: date.month);

    _read(selectedDayDiaryStateProvider.notifier).state = DayDiaryDocument(
      entity: newDayDairy,
      ref: dayDiaryDoc.ref,
    );
  }

  Future<void> deleteDayDairyImages({
    required DayDiaryDocument dayDiaryDoc,
    required List<DayDiaryImage> newImages,
    required List<DayDiaryImage> deleteImages,
  }) async {
    for (final monthImage in deleteImages) {
      unAwaitDeleteStorageFile(targetFilePath: monthImage.image.path);
    }

    final newDayDairy = dayDiaryDoc.entity.copyWith(
      images: newImages,
    );

    await dayDiaryDoc.ref.update(
      <String, dynamic>{
        ...newDayDairy.toJson(),
        FirestoreField.updatedAt: FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> deleteDayDiary({required DayDiaryDocument dayDiaryDoc}) async {
    final dayDiary = dayDiaryDoc.entity;
    for (final monthImage in dayDiary.images) {
      unAwaitDeleteStorageFile(targetFilePath: monthImage.image.path);
    }
    unAwaitDeleteStorageFile(targetFilePath: dayDiary.mainImage.path);
    await dayDiaryDoc.ref.delete();
  }
}
