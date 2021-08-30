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
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(2, 2))
          ],
        ),
      ),
    );
  }
}
