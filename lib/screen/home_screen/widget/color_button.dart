import 'package:flutter/material.dart';

import '../../../model/enums/month_card_color.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    required this.monthCardColor,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  final MonthCardColor monthCardColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: monthCardColor.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                color: monthCardColor.color.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(2, 2))
          ],
        ),
      ),
    );
  }
}
