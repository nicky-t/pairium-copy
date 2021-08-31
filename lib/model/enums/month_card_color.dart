import 'package:flutter/material.dart';

enum MonthCardColor {
  red,
  pink,
  purple,
  deepPurple,
  indigo,
  blue,
  lightBlue,
  cyan,
  teal,
  green,
  lightGreen,
  lime,
  yellow,
  amber,
  orange,
  deepOrange,
  brown,
  grey,
  blueGrey,
  white
}

extension MonthCardColorExtension on MonthCardColor {
  Color get color {
    switch (this) {
      case MonthCardColor.red:
        return Colors.red;
      case MonthCardColor.pink:
        return Colors.pink;
      case MonthCardColor.purple:
        return Colors.purple;
      case MonthCardColor.deepPurple:
        return Colors.deepPurple;
      case MonthCardColor.indigo:
        return Colors.indigo;
      case MonthCardColor.blue:
        return Colors.blue;
      case MonthCardColor.lightBlue:
        return Colors.lightBlue;
      case MonthCardColor.cyan:
        return Colors.cyan;
      case MonthCardColor.teal:
        return Colors.teal;
      case MonthCardColor.green:
        return Colors.green;
      case MonthCardColor.lightGreen:
        return Colors.lightGreen;
      case MonthCardColor.lime:
        return Colors.lime;
      case MonthCardColor.yellow:
        return Colors.yellow;
      case MonthCardColor.amber:
        return Colors.amber;
      case MonthCardColor.orange:
        return Colors.orange;
      case MonthCardColor.deepOrange:
        return Colors.deepOrange;
      case MonthCardColor.brown:
        return Colors.brown;
      case MonthCardColor.grey:
        return Colors.grey;
      case MonthCardColor.blueGrey:
        return Colors.blueGrey;
      case MonthCardColor.white:
        return Colors.white;
    }
  }
}
