import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/type/user_id.dart';
import '../../../../repository/diary_repository/diary_repository_impl.dart';
import '../../../model/entity/diary/diary_document.dart';
import '../../../model/entity/diary/diary_image/diary_image.dart';
import '../../../model/entity/partner/partner_document.dart';
import '../../../model/enums/weather.dart';
import '../partner_state/partner_state.dart';
import 'diary_state.dart';

class DiaryController extends StateNotifier<AsyncValue<DiaryState>> {
  DiaryController(
    this._diaryRepository, {
    required this.year,
    required this.month,
    required this.uid,
    required this.partnerState,
  }) : super(const AsyncValue.loading()) {
    _initState();
  }

  final DiaryRepositoryImpl _diaryRepository;
  final int year;
  final int month;
  final UserId uid;
  final PartnerState? partnerState;
  bool initStateCalled = false;

  void setDiary(List<DiaryDocument> newDiaryDocs) {
    state = AsyncValue.data(DiaryState(diaryDocs: newDiaryDocs));
  }

  Future<void> _initState() async {
    if (initStateCalled) {
      return;
    }
    await _fetch();
    initStateCalled = true;
  }

  Future<void> _fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (partnerState == null) {
        final diaryDocs = await _diaryRepository.fetchDiaryListFromUser(
          uid: uid,
          year: year,
          month: month,
        );
        return DiaryState(diaryDocs: diaryDocs);
      } else {
        final diaryDocs = await _diaryRepository.fetchDiaryListFromPartner(
          partnerDocumentId: partnerState!.ref.id,
          year: year,
          month: month,
        );
        return DiaryState(diaryDocs: diaryDocs);
      }
    });
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
    if (partnerState == null) {
      await _diaryRepository.setDayDairyToUser(
        uid: uid,
        date: date,
        title: title,
        description: description,
        mainImage: mainImage,
      );
    } else {
      await _diaryRepository.setDayDairyToPartner(
        uid: uid,
        partnerDoc: PartnerDocument(
          entity: partnerState!.entity,
          ref: partnerState!.ref,
        ),
        date: date,
        title: title,
        description: description,
        mainImage: mainImage,
      );
    }

    if (mounted) {
      await _fetch();
    }
  }

  Future<void> updateDayDairy({
    required DiaryDocument selectedDiaryDoc,
    String? title,
    String? description,
    File? mainImage,
    Weather? weather,
    String? tag,
    bool isFavorite = false,
  }) async {
    await _diaryRepository.updateDayDairy(
      diaryDoc: selectedDiaryDoc,
      title: title,
      description: description,
      mainImage: mainImage,
    );

    await _fetch();
  }

  Future<void> addImage({
    required DiaryDocument diaryDoc,
    required File? file,
  }) async {
    if (file == null) return;
    await _diaryRepository.addDiaryImage(
      diaryDoc: diaryDoc,
      image: file,
    );

    await _fetch();
  }

  Future<void> deleteImages({
    required List<DiaryImage> newImages,
    required List<DiaryImage> deleteImages,
    required DiaryDocument diaryDoc,
  }) async {
    await _diaryRepository.deleteDayDairyImages(
      diaryDoc: diaryDoc,
      newImages: newImages,
      deleteImages: deleteImages,
    );

    await _fetch();
  }

  Future<void> deleteDiary({
    required DiaryDocument diaryDoc,
  }) async {
    await _diaryRepository.deleteDiary(diaryDoc: diaryDoc);

    await _fetch();
  }
}
