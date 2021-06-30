import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screen_state/home_state_provider.dart';

class SpinButton extends HookWidget {
  const SpinButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reverseIconAngle = useProvider(reverseIconAngleProvider).state;

    return Transform.rotate(
      angle: reverseIconAngle,
      child: IconButton(
        onPressed: () {
          onPressed();
          context.read(reverseIconAngleProvider).state += 3.14 / 2;
        },
        icon: Icon(
          Icons.autorenew_outlined,
          size: 32,
          color: theme.accentColor,
        ),
      ),
    );
  }
}
