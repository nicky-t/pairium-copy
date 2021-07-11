import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/partner_repository.dart';

final partnerInfoViewModelProvider = Provider(
  (ref) => PartnerInfoViewModel(ref.read),
);

class PartnerInfoViewModel {
  PartnerInfoViewModel(this._read);

  final Reader _read;

  Future<void> updateAnniversary(DateTime? anniversary) async {
    await _read(partnerRepositoryProvider).updatePartner(anniversary);
  }
}
