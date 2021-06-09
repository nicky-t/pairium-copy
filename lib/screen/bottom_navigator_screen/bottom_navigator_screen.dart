import 'package:firebase_auth/firebase_auth.dart';
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
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: const Text('sign out'),
        ),
      ),
    );
  }
}
