import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/enums/month.dart';
import '../../../state/home_state/../../screen/home_screen/screen_state/state_of_flip_card.dart';

final reverseIconAngleProvider = StateProvider.autoDispose<double>((ref) => 0);

final januaryIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 1
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final februaryIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 2
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final marchIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 3
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final aprilIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 4
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final mayIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 5
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final juneIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 6
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final julyIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 7
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final augustIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 8
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final octoberIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 9
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final septemberIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 10
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final novemberIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 11
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);
final decemberIsOnTap = StateProvider(
  (ref) => DateTime.now().month == 12
      ? const StateOfFlipCard(isSelected: true)
      : const StateOfFlipCard(),
);

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

final isShowSelectYearPopupProvider = StateProvider((ref) => false);

final selectedYearStateProvider =
    StateProvider<int>((ref) => DateTime.now().year);

final selectedMonthStateProvider =
    StateNotifierProvider.autoDispose<MonthStateNotifier, Month>(
  (ref) => MonthStateNotifier(ref.read),
);

class MonthStateNotifier extends StateNotifier<Month> {
  MonthStateNotifier(this._read)
      : super(Month.values[DateTime.now().month - 1]);

  final Reader _read;

  void changeMonth(Month newMonth) {
    final beforeMonth = state;
    final beforePageState = _read(isOnTapFlipStates[beforeMonth.name]!).state;

    _read(isOnTapFlipStates[beforeMonth.name]!).state =
        beforePageState.copyWith(isSelected: false, isOnTap: false);

    final currentPageState = _read(isOnTapFlipStates[newMonth.name]!).state;

    _read(isOnTapFlipStates[newMonth.name]!).state =
        currentPageState.copyWith(isSelected: true);

    state = newMonth;
  }
}
