import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/entity/partner/partner.dart';
import '../../../model/entity/user/user.dart';
import '../../../repository/user_repository/user_repository_impl.dart';
import '../../../utility/custom_exception.dart';
import '../../state/auth_state/auth_controller_provider.dart';

final fetchPairUserDataProvider = Provider(
  (ref) => FetchPairUserData(ref.read),
);

class FetchPairUserData {
  FetchPairUserData(this._read);

  final Reader _read;

  Future<User> fetchPairUserData({required Partner partner}) async {
    final uid = _read(authControllerProvider).authUser?.uid;
    final id = partner.userIds.firstWhere((id) => id != uid);

    final userDoc = await _read(userRepositoryProvider).fetch(id: id);
    if (userDoc == null) {
      throw const CustomException(message: 'パートナーのユーザーデータが見つかりませんでした。');
    }
    return userDoc.entity;
  }
}
