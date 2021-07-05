import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/user/user.dart';
import '../../../model/user/user_document.dart';
import 'pair_state_provider.dart';

final pairStreamProvider =
    StreamProvider.family.autoDispose<UserDocument?, String>((ref, pairId) {
  return UserDocument.collectionReference().doc(pairId).snapshots().map(
    (snapshot) {
      if (snapshot.exists && snapshot.data()!.isNotEmpty) {
        ref
            .read(pairStateProvider.notifier)
            .setPair(User.fromJson(snapshot.data()!));
        return UserDocument(
            entity: User.fromJson(snapshot.data()!), ref: snapshot.reference);
      }
      return null;
    },
  );
});
