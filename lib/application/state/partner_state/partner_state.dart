import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/entity/partner/partner.dart';

part 'partner_state.freezed.dart';

@freezed
class PartnerState with _$PartnerState {
  const factory PartnerState({
    required Partner entity,
    required DocumentReference<Map<String, dynamic>> ref,
  }) = _PartnerState;
}
