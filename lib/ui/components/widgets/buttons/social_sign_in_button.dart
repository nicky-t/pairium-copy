import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    required this.imagePath,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(
              color: Theme.of(context).disabledColor.withOpacity(0.2),
              width: 1,
              style: BorderStyle.solid,
            ),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}
