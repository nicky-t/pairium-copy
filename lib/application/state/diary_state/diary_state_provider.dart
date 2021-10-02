import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/diary_repository/diary_repository_impl.dart';
import '../../../model/entity/diary/diary_document.dart';
import '../../../utility/custom_exception.dart';
import '../auth_state/auth_controller_provider.dart';
import '../partner_state/partner_controller_provider.dart';
import 'diary_controller.dart';
import 'diary_state.dart';

final dayDiariesControllerProvider = StateNotifierProvider.family
    .autoDispose<DiaryController, AsyncValue<DiaryState>, DiaryStateParam>(
  (ref, param) {
    final uid = ref.watch(authControllerProvider).authUser?.uid;
    final partnerState = ref.watch(partnerControllerProvider);
    if (uid == null) {
      throw const CustomException(message: 'userIdがnullです');
    }
    return DiaryController(
      ref.read(diaryRepositoryProvider),
      uid: uid,
      partnerState: partnerState,
      year: param.year,
      month: param.month,
    );
  },
);

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

final selectedDiaryStateProvider =
    Provider.family.autoDispose<AsyncValue<DiaryDocument?>, DiaryStateParam>(
  (ref, diaryParam) => ref
      .watch(
        dayDiariesControllerProvider(
          diaryParam,
        ),
      )
      .when(
        data: (diaryState) => AsyncValue.data(
          diaryState.diaryDocs.firstWhereOrNull(
            (diaryDoc) => diaryDoc.entity.day == diaryParam.day,
          ),
        ),
        loading: () => const AsyncValue.loading(),
        error: (e, __) => AsyncValue.error(e),
      ),
);
