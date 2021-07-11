import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'partner_state.dart';

final partnerStateProvider =
    StateNotifierProvider<PartnerStateNotifier, PartnerState>(
  (_) => PartnerStateNotifier(),
);
