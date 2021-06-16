import 'package:flutter/material.dart';

class SpinButton extends StatelessWidget {
  const SpinButton({
    Key? key,
    required this.reverseIconAngle,
    required this.onPressed,
  }) : super(key: key);

  final double reverseIconAngle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Transform.rotate(
      angle: reverseIconAngle,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.autorenew_outlined,
          size: 32,
          color: theme.accentColor,
        ),
      ),
    );
  }
}
