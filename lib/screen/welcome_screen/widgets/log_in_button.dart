import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LogInButton extends StatelessWidget {
  const LogInButton(
      {required this.buttonType, required this.text, required this.onPress});

  final Buttons buttonType;
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      buttonType,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: buttonType == Buttons.GoogleDark
          ? const EdgeInsets.symmetric(vertical: 4)
          : const EdgeInsets.symmetric(vertical: 10),
      elevation: 1,
      text: text,
      onPressed: onPress,
    );
  }
}
