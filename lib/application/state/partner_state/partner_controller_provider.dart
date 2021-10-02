import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repository/partner_repository/partner_repository_impl.dart';
import 'partner_controller.dart';
import 'partner_state.dart';

final partnerControllerProvider =
    StateNotifierProvider<PartnerController, PartnerState?>(
  (ref) => PartnerController(ref.read(partnerRepositoryProvider)),
);
