import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/day_diary/day_diary_document.dart';
import '../model/day_diary/day_diary_image/day_diary_image.dart';
import '../repository/day_diary_repository.dart';

final dayDiaryViewModelProvider = Provider(
  (ref) => DayDiaryViewModel(ref.read),
);

class DayDiaryViewModel {
  DayDiaryViewModel(this._read);

  final Reader _read;

  Future<void> addImage({
    required DayDiaryDocument dayDiaryDoc,
    required File? file,
  }) async {
    await _read(dayDiaryRepositoryProvider)
        .addDayDiaryImage(dayDiaryDoc: dayDiaryDoc, image: file);
  }

  Future<void> deleteImages({
    required List<DayDiaryImage> newImages,
    required List<DayDiaryImage> deleteImages,
    required DayDiaryDocument dayDiaryDoc,
  }) async {
    await _read(dayDiaryRepositoryProvider).deleteDayDairyImages(
      dayDiaryDoc: dayDiaryDoc,
      newImages: newImages,
      deleteImages: deleteImages,
    );
  }

  Future<DayDiaryDocument> fetchDayDiaryDoc({
    required DayDiaryDocument dayDiaryDoc,
  }) async {
    return _read(dayDiaryRepositoryProvider)
        .fetchDayDiaryFromDoc(dayDiaryDoc: dayDiaryDoc);
  }
}
