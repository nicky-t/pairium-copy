import 'package:flutter/material.dart';

import '../../../model/enums/month_card_color.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    required this.monthCardColor,
    required this.onSelected,
    required this.selected,
    Key? key,
  }) : super(key: key);

  final bool selected;
  final Function(bool) onSelected;
  final MonthCardColor monthCardColor;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      selectedColor: monthCardColor.color,
      disabledColor: monthCardColor.color,
      selected: selected,
      onSelected: onSelected,
      label: Container(
        decoration: BoxDecoration(
          color: monthCardColor.color,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: monthCardColor.color.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(3, 3),
            )
          ],
        ),
        child: Center(
          child: selected
              ? Icon(
                  Icons.check,
                  color: monthCardColor.color == Colors.white
                      ? Colors.grey
                      : Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
