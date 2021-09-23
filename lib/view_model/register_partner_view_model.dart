import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/partner_repository.dart';
import '../repository/user_repository.dart';
import '../state/auth_state/auth_state.dart';
import '../state/auth_state/auth_state_provider.dart';

final registerPartnerViewModelProvider = Provider.autoDispose(
  (ref) => RegisterPartnerViewModel(ref.read),
);

class RegisterPartnerViewModel {
  RegisterPartnerViewModel(this._read);

  final Reader _read;

  Future<void> startAppOne() async {
    await _read(userRepositoryProvider)
        .updateUserProfile(isFinishedOnboarding: true);

    _read(authStateProvider.notifier).setSAuthState(AuthState.login);
  }

  Future<String> requestPartner({required String pairShareId}) async {
    return _read(partnerRepositoryProvider)
        .requestPartner(pairShareId: pairShareId);
  }

  Future<void> acceptPartner({bool? isMe}) async {
    await _read(partnerRepositoryProvider).acceptPartner(isMe: isMe);
  }

  Future<void> rejectPartner() async {
    await _read(partnerRepositoryProvider).rejectPartner();
  }

  Future<void> cancelRequest() async {
    await _read(partnerRepositoryProvider).cancelRequest();
  }
}
