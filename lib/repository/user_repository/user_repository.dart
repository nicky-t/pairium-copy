import 'dart:io';

import '../../../model/type/user_id.dart';
import '../../model/entity/user/user_document.dart';
import '../../model/enums/gender.dart';

abstract class UserRepository {
  Future<UserDocument?> fetch({required UserId id});

  Future<void> setUserDoc({
    required String uid,
    required String displayName,
    required DateTime birthday,
    required Gender gender,
    required File? imageFile,
  });

  Future<void> updateUserProfile({
    required UserDocument userDoc,
    String? displayName,
    DateTime? birthday,
    Gender? gender,
    File? imageFile,
    bool? isFinishedOnboarding,
  });

  Future<UserId?> fetchByShareId({
    required String pairShareId,
  });
}
