import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_of_flip_card.freezed.dart';

@freezed
class StateOfFlipCard with _$StateOfFlipCard {
  const factory StateOfFlipCard({
    @Default(false) bool isSelected,
    @Default(false) bool isOnTap,
    File? frontCacheImageFile,
    File? backCacheImageFile,
  }) = _StateOfFlipCard;
}
