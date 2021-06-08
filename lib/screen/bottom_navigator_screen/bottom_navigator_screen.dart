import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BottomNavigatorScreen extends HookWidget {
  const BottomNavigatorScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const BottomNavigatorScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
