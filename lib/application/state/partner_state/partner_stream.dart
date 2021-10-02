import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/entity/partner/partner.dart';
import '../../../model/entity/partner/partner_document.dart';
import '../../../model/entity/partner/partner_field.dart';
import '../../../repository/auth_repository/auth_repository_impl.dart';
import 'partner_controller_provider.dart';
import 'partner_state.dart';

final partnerStreamProvider = StreamProvider<PartnerState?>((ref) {
  final uid = ref.watch(authRepositoryProvider).getCurrentUser()?.uid;
  return PartnerDocument.collectionReference()
      .where(PartnerField.userIds, arrayContains: uid)
      .limit(1)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map(
          (doc) {
            if (doc.exists && doc.data().isNotEmpty) {
              final partnerState = PartnerState(
                entity: Partner.fromJson(doc.data()),
                ref: doc.reference,
              );

              ref
                  .read(partnerControllerProvider.notifier)
                  .setState(partnerState);
              return partnerState;
            }

            return null;
          },
        )
        .toList()
        .first;
  });
});
// TODO 消す
// final oldpartnerStreamProvider = StreamProvider.family
//     .autoDispose<PartnerDocument?, String>((ref, partnerDocumentId) {
//   if (partnerDocumentId.isEmpty) {
//     return const Stream.empty();
//   }
//   return PartnerDocument.collectionReference()
//       .doc(partnerDocumentId)
//       .snapshots()
//       .map(
//     (snapshot) {
//       if (snapshot.exists && snapshot.data()!.isNotEmpty) {
//         final partnerDoc = PartnerDocument(
//             entity: Partner.fromJson(snapshot.data()!),
//             ref: snapshot.reference);

//         ref.read(partnerStateProvider.notifier).setPartner(partnerDoc);
//         return partnerDoc;
//       }
//       return null;
//     },
//   );
// });
