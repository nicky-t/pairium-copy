import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/day_diary/day_diary_document.dart';
import '../model/enums/weather.dart';
import '../repository/day_diary_repository.dart';
import '../state/day_diary_state/day_diary_state_provider.dart';

final editDayDiaryViewModelProvider = Provider(
  (ref) => EditDayDiaryViewModel(ref.read),
);

class EditDayDiaryViewModel {
  EditDayDiaryViewModel(this._read);

  final Reader _read;

  Future<void> updateDayDairy({
    required DayDiaryDocument dayDiaryDoc,
    String? title,
    String? description,
    File? mainImage,
    Weather? weather,
    String? tag,
    bool isFavorite = false,
  }) async {
    await _read(dayDiaryRepositoryProvider).updateDayDairy(
      dayDiaryDoc: dayDiaryDoc,
      title: title,
      description: description,
      mainImage: mainImage,
    );
  }

  Future<void> fetchDayDiary({required DayDiaryDocument dayDiaryDoc}) async {
    _read(selectedDayDiaryStateProvider.notifier).state =
        await _read(dayDiaryRepositoryProvider)
            .fetchDayDiaryFromDoc(dayDiaryDoc: dayDiaryDoc);
  }
}
