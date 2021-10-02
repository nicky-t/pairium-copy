import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_navigator.dart';

class BottomNavigatorStateNotifier extends StateNotifier<BottomNavigatorType> {
  BottomNavigatorStateNotifier() : super(BottomNavigatorType.home);

  void setCurrentBottomNavigator(int index) =>
      state = BottomNavigatorType.values[index];
}
