import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color,
      ),
    );
  }
}
