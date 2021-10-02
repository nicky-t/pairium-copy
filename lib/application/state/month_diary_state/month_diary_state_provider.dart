import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utility/custom_exception.dart';
import '../auth_state/auth_controller_provider.dart';
import '../partner_state/partner_state.dart';
import 'month_diary_controller.dart';
import 'month_diary_state.dart';

// autoDisposeをつけない
final monthDiaryControllerProvider = StateNotifierProvider.family<
    MonthDiaryController, MonthDiaryState, PartnerState?>(
  (ref, partnerState) {
    final uid = ref.read(authControllerProvider).authUser?.uid;

    if (uid == null) {
      throw const CustomException(message: 'userIdがnullです');
    }
    return MonthDiaryController(
      ref.read,
      partnerState: partnerState,
      uid: uid,
    );
  },
);
