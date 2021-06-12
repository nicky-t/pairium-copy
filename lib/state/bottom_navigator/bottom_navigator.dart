import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../screen/home_screen/home_screen.dart';
import '../../screen/settings_screen/settings_screen.dart';

enum BottomNavigatorType {
  home,
  plus,
  setting,
}

extension BottomNavigationTypeEx on BottomNavigatorType {
  Widget get screen {
    switch (this) {
      case BottomNavigatorType.home:
        return const HomeScreen();
      case BottomNavigatorType.plus:
        return const Scaffold();
      case BottomNavigatorType.setting:
        return const SettingsScreen();
    }
  }

  IconData get iconData {
    switch (this) {
      case BottomNavigatorType.home:
        return Icons.photo_album;
      case BottomNavigatorType.plus:
        return Icons.add;
      case BottomNavigatorType.setting:
        return Icons.person;
    }
  }
}

class BottomNavigatorStateNotifier extends StateNotifier<BottomNavigatorType> {
  BottomNavigatorStateNotifier() : super(BottomNavigatorType.home);

  void setCurrentBottomNavigator(int index) =>
      state = BottomNavigatorType.values[index];
}
