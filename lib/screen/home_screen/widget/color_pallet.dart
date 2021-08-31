import 'package:flutter/material.dart';

import '../../../model/enums/month_card_color.dart';
import 'color_button.dart';

class ColorPallet extends StatelessWidget {
  const ColorPallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
      ),
      itemCount: MonthCardColor.values.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ColorButton(
            onTap: () {},
            monthCardColor: MonthCardColor.values[index],
          ),
        );
      },
    );
  }
}
