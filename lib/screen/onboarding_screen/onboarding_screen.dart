import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const OnboardingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
