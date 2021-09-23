import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_navigator.dart';

final currentBottomNavigatorStateProvider =
    StateNotifierProvider<BottomNavigatorStateNotifier, BottomNavigatorType>(
  (ref) => BottomNavigatorStateNotifier(),
);
