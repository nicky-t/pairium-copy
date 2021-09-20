import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../model/enums/card_color.dart';
import '../model/enums/month.dart';
import '../model/enums/month_card_color.dart';
import '../model/month_diary/month_diary_document.dart';
import '../repository/image_picker_repository.dart';
import '../repository/month_diary_repository.dart';
import '../repository/permission_repository.dart';

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
    MonthCardColor? backgroundColor,
    MonthCardColor? textColor,
  }) async {
    if (monthDiaryDoc == null) {
      return _read(monthDiaryRepositoryProvider).setMonthDairy(
        month: month,
        frontImage: frontImage,
        backImage: backImage,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
    } else {
      return _read(monthDiaryRepositoryProvider).updateMonthDairy(
        monthDiaryDoc: monthDiaryDoc,
        newFrontImage: frontImage,
        newBackImage: backImage,
        newBackgroundColor: backgroundColor,
        newTextColor: textColor,
      );
    }
  }
}
