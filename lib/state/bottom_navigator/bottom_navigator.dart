import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screen/home_screen/home_screen.dart';
import '../../screen/settings_screen/settings_screen.dart';

enum BottomNavigatorType {
  home,
  setting,
}

extension BottomNavigationTypeEx on BottomNavigatorType {
  Widget get screen {
    switch (this) {
      case BottomNavigatorType.home:
        return HomeScreen();
      case BottomNavigatorType.setting:
        return const SettingsScreen();
    }
  }

  IconData get iconData {
    switch (this) {
      case BottomNavigatorType.home:
        return Icons.home;
      case BottomNavigatorType.setting:
        return Icons.person;
    }
  }

  String get label {
    switch (this) {
      case BottomNavigatorType.home:
        return 'home';
      case BottomNavigatorType.setting:
        return 'account';
    }
  }
}

class BottomNavigatorStateNotifier extends StateNotifier<BottomNavigatorType> {
  BottomNavigatorStateNotifier() : super(BottomNavigatorType.home);

  void setCurrentBottomNavigator(int index) =>
      state = BottomNavigatorType.values[index];
}
