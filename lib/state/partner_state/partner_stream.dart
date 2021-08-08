import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/partner/partner.dart';
import '../../model/partner/partner_document.dart';
import 'partner_state_provider.dart';

final partnerStreamProvider = StreamProvider.family
    .autoDispose<PartnerDocument?, String>((ref, partnerDocumentId) {
  return PartnerDocument.collectionReference()
      .doc(partnerDocumentId)
      .snapshots()
      .map(
    (snapshot) {
      if (snapshot.exists && snapshot.data()!.isNotEmpty) {
        final partnerDoc = PartnerDocument(
            entity: Partner.fromJson(snapshot.data()!),
            ref: snapshot.reference);

        ref.read(partnerStateProvider.notifier).setPartner(partnerDoc);
        return partnerDoc;
      }
      return null;
    },
  );
});
