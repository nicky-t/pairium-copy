import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({this.errorText, Key? key}) : super(key: key);

  static Route<void> route({String? errorText}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => ErrorScreen(
        errorText: errorText,
      ),
    );
  }

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        errorText ?? 'アプリを再起動してもう一度お試しください。',
        style: const TextStyle(fontSize: 16),
      )),
    );
  }
}
