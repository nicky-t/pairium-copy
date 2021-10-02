import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const CalendarScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('カレンダー画面です。\n現在開発中です。'));
  }
}
