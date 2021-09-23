import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/enums/request_status.dart';
import '../user_state/user_state_provider.dart';

final isExistPartnerStateProvider =
    StateNotifierProvider<StateController<bool>, bool>(
  (ref) {
    final user = ref.watch(userStateProvider).user;
    if (user == null) return StateController(false);

    if (user.partnerDocumentId == null ||
        user.partnerDocumentId!.isEmpty ||
        user.partnerRequestStatus != RequestStatus.accept) {
      return StateController(false);
    }
    return StateController(true);
  },
);
