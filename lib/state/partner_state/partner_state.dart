import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/partner/partner_document.dart';

part 'partner_state.freezed.dart';

@freezed
class PartnerState with _$PartnerState {
  const factory PartnerState({
    PartnerDocument? partnerDoc,
  }) = _PartnerState;
}

class PartnerStateNotifier extends StateNotifier<PartnerState> {
  PartnerStateNotifier() : super(const PartnerState());

  void setPartner(PartnerDocument partnerDoc) {
    state = state.copyWith(partnerDoc: partnerDoc);
  }
}
