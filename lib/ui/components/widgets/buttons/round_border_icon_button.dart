import 'package:flutter/material.dart';

import '../../../../constants.dart';

class RoundBorderIconButton extends StatelessWidget {
  const RoundBorderIconButton({
    required this.onPressed,
    required this.text,
    required this.icon,
    this.height = 0,
    this.width = 0,
    this.padding = const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 26,
    ),
    this.iconSize = 30,
    this.iconColor = Colors.white,
    this.radius = 15,
    this.borderColor = IColors.kBlack,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final Color borderColor;
  final double height;
  final double width;
  final EdgeInsets padding;
  final double radius;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).backgroundColor,
        onPrimary: IColors.kBlack,
        padding: padding,
        side: BorderSide(
          color: borderColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        minimumSize: Size(width, height),
      ),
      icon: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      label: Text(
        text,
        style: textStyle ?? Theme.of(context).textTheme.button,
        textAlign: TextAlign.center,
      ),
    );
  }
}
