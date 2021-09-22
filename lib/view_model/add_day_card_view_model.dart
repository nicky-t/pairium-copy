import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/day_diary/day_diary_document.dart';
import '../model/enums/weather.dart';
import '../repository/day_diary_repository.dart';
import '../state/day_diary_state/day_diary_state_provider.dart';

final addDayCardViewModelProvider = Provider(
  (ref) => AddDayCardViewModel(ref.read),
);

class AddDayCardViewModel {
  AddDayCardViewModel(this._read);

  final Reader _read;

  bool isFilled({required File? mainImage, required String? title}) =>
      mainImage != null && title != null && title.isNotEmpty;

  Future<void> init() async {
    final date = DateTime.now();
    await _read(dayDiaryStateProvider.notifier)
        .fetchDayDiary(year: date.year, month: date.month, day: date.day);
  }

  Future<void> fetchDiary(DateTime date) async {
    await _read(dayDiaryStateProvider.notifier)
        .fetchDayDiary(year: date.year, month: date.month, day: date.day);
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
    await _read(dayDiaryRepositoryProvider).setDayDairy(
      date: date,
      title: title,
      description: description,
      mainImage: mainImage,
    );
  }

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
}
