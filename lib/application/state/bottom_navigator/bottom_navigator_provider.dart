import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_navigator.dart';
import 'bottom_navigator_controller.dart';

final currentBottomNavigatorControllerProvider =
    StateNotifierProvider<BottomNavigatorStateNotifier, BottomNavigatorType>(
  (ref) => BottomNavigatorStateNotifier(),
);
