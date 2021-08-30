import 'package:flutter/material.dart';

class SpinButton extends StatefulWidget {
  const SpinButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  _SpinButtonState createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController!.reset();
      }
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return RotationTransition(
          turns:
              Tween<double>(begin: 0, end: 0.5).animate(animationController!),
          child: IconButton(
            onPressed: () {
              widget.onPressed();
              animationController!.forward();
            },
            icon: Icon(
              Icons.autorenew_outlined,
              size: 32,
              color: theme.accentColor,
            ),
          ),
        );
      },
    );
  }
}
