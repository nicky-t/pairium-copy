import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/user/user.dart';
import '../../../model/user/user_document.dart';
import '../../../repository/auth_repository/auth_repository_provider.dart';
import 'user_state_provider.dart';

final userStreamProvider = StreamProvider.autoDispose<UserDocument?>((ref) {
  final uid = ref.read(authRepositoryProvider).getCurrentUser()?.uid;
  return UserDocument.collectionReference().doc(uid).snapshots().map(
    (snapshot) {
      if (snapshot.exists && snapshot.data()!.isNotEmpty) {
        ref
            .read(userStateProvider.notifier)
            .setUser(User.fromJson(snapshot.data()!));
        return UserDocument(
            entity: User.fromJson(snapshot.data()!), ref: snapshot.reference);
      }
      return null;
    },
  );
});
