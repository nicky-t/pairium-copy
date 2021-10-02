import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/entity/user/user_document.dart';
import '../../../model/enums/gender.dart';
import '../../../model/type/user_id.dart';
import '../../../repository/user_repository/user_repository_impl.dart';
import '../../../utility/custom_exception.dart';
import 'user_state.dart';

class UserController extends StateNotifier<AsyncValue<UserState>> {
  UserController(
    this._userRepository, {
    required this.uid,
  }) : super(const AsyncValue.loading()) {
    _fetch();
  }

  final UserRepositoryImpl _userRepository;
  final UserId? uid;

  void setState(UserState userState) {
    state = AsyncValue.data(userState);
  }

  Future<void> _fetch() async {
    if (uid == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userDoc = await _userRepository.fetch(id: uid!);
      if (userDoc == null) {
        throw const CustomException(message: 'UserDocumentが取得できませんでした。');
      }
      return UserState(entity: userDoc.entity, ref: userDoc.ref);
    });
  }

  Future<void> setUserProfile({
    required String uid,
    required String displayName,
    required DateTime birthday,
    required Gender gender,
    File? imageFile,
  }) async {
    await _userRepository.setUserDoc(
      uid: uid,
      displayName: displayName,
      birthday: birthday,
      gender: gender,
      imageFile: imageFile,
    );

    await _fetch();
  }

  Future<void> updateUserProfile({
    required String displayName,
    required DateTime birthday,
    required Gender gender,
    File? imageFile,
  }) async {
    final userState = state.data?.value;
    if (userState == null) throw const CustomException();

    await _userRepository.updateUserProfile(
      userDoc: UserDocument(entity: userState.entity, ref: userState.ref),
      displayName: displayName,
      birthday: birthday,
      gender: gender,
      imageFile: imageFile,
    );

    await _fetch();
  }

  Future<void> startAppOne() async {
    final userState = state.data?.value;
    if (userState == null) throw const CustomException();

    await _userRepository.updateUserProfile(
      userDoc: UserDocument(entity: userState.entity, ref: userState.ref),
      isFinishedOnboarding: true,
    );

    await _fetch();
  }
}
