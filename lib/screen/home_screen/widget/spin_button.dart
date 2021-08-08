import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screen_state/home_state_provider.dart';

class SpinButton extends ConsumerWidget {
  const SpinButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reverseIconAngle = ref.watch(reverseIconAngleProvider).state;

    return Transform.rotate(
      angle: reverseIconAngle,
      child: IconButton(
        onPressed: () {
          onPressed();
          ref.read(reverseIconAngleProvider).state += 3.14 / 2;
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
