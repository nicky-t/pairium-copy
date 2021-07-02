import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/enums/card_color.dart';
import '../model/enums/month.dart';
import '../model/month_diary/month_diary_document.dart';
import '../repository/image_picker_repository_provider.dart';
import '../repository/month_diary_repository.dart';
import '../repository/permission_repository.dart';
import '../state/user_state/user_state_provider.dart';

final homeViewModel = Provider.autoDispose(
  (ref) => HomeViewModel(ref.read),
);

class HomeViewModel {
  const HomeViewModel(this._read);

  final Reader _read;

  Future<PermissionStatus> checkPhotoAccess() async {
    return _read(permissionRepositoryProvider).checkPhotoAccess();
  }

  Future<File?> updateImage() async {
    return _read(imagePickerRepositoryProvider).updateImage();
  }

  Future<void> updateMonthDairy({
    required Month month,
    MonthDiaryDocument? monthDiaryDoc,
    File? frontImage,
    File? backImage,
    CardColor? cardColor,
  }) async {
    if (monthDiaryDoc == null) {
      return _read(monthDiaryRepositoryProvider).setMonthDairy(
        month: month,
        frontImage: frontImage,
        backImage: backImage,
        cardColor: cardColor,
      );
    } else {
      return _read(monthDiaryRepositoryProvider).updateMonthDairy(
        monthDiaryDoc: monthDiaryDoc,
        newFrontImage: frontImage,
        newBackImage: backImage,
        newCardColor: cardColor,
      );
    }
  }
}
