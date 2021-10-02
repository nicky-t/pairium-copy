import 'package:flutter/material.dart';

class RoundBorderButton extends StatelessWidget {
  const RoundBorderButton({
    required this.onPressed,
    required this.text,
    this.height = 0,
    this.width = 0,
    this.borderWidth = 1,
    this.elevation = 1,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 26,
    ),
    this.radius = 10,
    this.borderColor,
    this.backgroundColor,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;
  final String text;
  final double borderWidth;
  final double height;
  final double width;
  final double elevation;
  final EdgeInsets padding;
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor ?? Theme.of(context).backgroundColor,
        padding: padding,
        side: BorderSide(
          color: onPressed == null
              ? Theme.of(context).disabledColor
              : borderColor ?? Theme.of(context).textTheme.bodyText1!.color!,
          width: borderWidth,
          style: BorderStyle.solid,
        ),
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        minimumSize: Size(width, height),
      ),
      child: Text(
        text,
        style: onPressed == null
            ? Theme.of(context).textTheme.button
            : textStyle ?? Theme.of(context).textTheme.button,
        textAlign: TextAlign.center,
      ),
    );
  }
}
