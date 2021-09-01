import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/day_diary/day_diary_document.dart';
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
}
