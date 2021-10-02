import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/entity/partner/partner_document.dart';
import '../../../repository/partner_repository/partner_repository_impl.dart';
import 'partner_state.dart';

class PartnerController extends StateNotifier<PartnerState?> {
  PartnerController(this.partnerRepository) : super(null);

  final PartnerRepositoryImpl partnerRepository;

  void setState(PartnerState partnerState) {
    state = partnerState;
  }

  Future<void> updateAnniversary(DateTime? anniversary) async {
    if (state == null) return;
    await partnerRepository.updatePartnerDoc(
      partnerDoc: PartnerDocument(entity: state!.entity, ref: state!.ref),
      anniversary: anniversary,
    );
  }
}
