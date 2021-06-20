import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/enums/month.dart';
import 'state_of_flip_card.dart';

final reverseIconAngleProvider = StateProvider.autoDispose<double>((ref) => 0);

final januaryIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final februaryIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final marchIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final aprilIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final mayIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final juneIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final julyIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final augustIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final octoberIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final septemberIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final novemberIsOnTap = StateProvider((ref) => const StateOfFlipCard());
final decemberIsOnTap = StateProvider((ref) => const StateOfFlipCard());

final isOnTapFlipStates = {
  '${Month.january.name}': januaryIsOnTap,
  '${Month.february.name}': februaryIsOnTap,
  '${Month.march.name}': marchIsOnTap,
  '${Month.april.name}': aprilIsOnTap,
  '${Month.may.name}': mayIsOnTap,
  '${Month.june.name}': juneIsOnTap,
  '${Month.july.name}': julyIsOnTap,
  '${Month.august.name}': augustIsOnTap,
  '${Month.september.name}': septemberIsOnTap,
  '${Month.october.name}': octoberIsOnTap,
  '${Month.november.name}': novemberIsOnTap,
  '${Month.december.name}': decemberIsOnTap,
};
