import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedYearStateProvider =
    StateNotifierProvider<StateController<int>, int>(
  (ref) => StateController(DateTime.now().year),
);
