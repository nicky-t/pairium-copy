import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/firestorage/firebase_storage_file.dart';
import '../../../services/firestore/converter/timestamp_converter.dart';
import '../../../services/firestore/key/created_at_key.dart';
import '../../../services/firestore/key/updated_at_key.dart';
import '../../enums/gender.dart';
import 'user_field.dart';

part 'user.freezed.dart';
part 'user.g.dart';

const birthdayKey = JsonKey(
  name: UserField.birthday,
  fromJson: TimestampConverter.timestampFromJson,
  toJson: TimestampConverter.timestampToJson,
);

@freezed
class User with _$User {
  const factory User({
    required String displayName,
    @birthdayKey required DateTime birthday,
    required Gender gender,
    @Default(false) bool isFinishedOnboarding,
    required String shareId,
    StorageFile? mainProfileImage,
    @createdAtKey required DateTime createdAt,
    @updatedAtKey required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
