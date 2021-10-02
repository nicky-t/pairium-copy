import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const FavoriteScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Center(child: Text('お気に入り画面です。\n現在開発途中です')));
  }
}
