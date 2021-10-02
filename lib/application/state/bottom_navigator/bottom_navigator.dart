import 'package:flutter/material.dart';

import '../../../ui/screen/calender_screen.dart/calendar_screen.dart';
import '../../../ui/screen/favorite_screen/favorite_screen.dart';
import '../../../ui/screen/home_screen/home_screen.dart';
import '../../../ui/screen/settings_screen/settings_screen.dart';

enum BottomNavigatorType {
  home,
  setting,
  calendar,
  favorite,
}

extension BottomNavigationTypeEx on BottomNavigatorType {
  Widget get screen {
    switch (this) {
      case BottomNavigatorType.home:
        return const HomeScreen();
      case BottomNavigatorType.setting:
        return const SettingsScreen();
      case BottomNavigatorType.calendar:
        return const CalendarScreen();
      case BottomNavigatorType.favorite:
        return const FavoriteScreen();
    }
  }

  IconData get iconData {
    switch (this) {
      case BottomNavigatorType.home:
        return Icons.home;
      case BottomNavigatorType.setting:
        return Icons.person;
      case BottomNavigatorType.calendar:
        return Icons.calendar_view_day_rounded;
      case BottomNavigatorType.favorite:
        return Icons.favorite;
    }
  }

  String get label {
    switch (this) {
      case BottomNavigatorType.home:
        return 'home';
      case BottomNavigatorType.setting:
        return 'account';
      case BottomNavigatorType.calendar:
        return 'calendar';
      case BottomNavigatorType.favorite:
        return 'favorite';
    }
  }
}
