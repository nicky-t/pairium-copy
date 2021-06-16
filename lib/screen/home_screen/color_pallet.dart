import 'package:flutter/material.dart';
import 'package:pairium/screen/home_screen/color_button.dart';

class ColorPallet extends StatelessWidget {
  const ColorPallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorList = <Color>[
      Colors.black,
      Colors.black12,
      Colors.black26,
      Colors.black45,
      Colors.black54,
      Colors.blue,
      Colors.blueAccent,
      Colors.blueGrey,
      Colors.black,
      Colors.black12,
      Colors.black26,
      Colors.black45,
      Colors.black54,
      Colors.blue,
      Colors.blueAccent,
      Colors.blueGrey,
      Colors.black,
      Colors.black12,
      Colors.black26,
      Colors.black45,
      Colors.black54,
      Colors.blue,
      Colors.blueAccent,
      Colors.blueGrey,
    ];
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
      ),
      itemCount: colorList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ColorButton(
            onTap: () {},
            color: colorList[index],
          ),
        );
      },
    );
  }
}
