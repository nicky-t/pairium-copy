import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'partner_state.dart';

final partnerStateProvider =
    StateNotifierProvider<PartnerStateNotifier, PartnerState>(
  (_) => PartnerStateNotifier(),
);
