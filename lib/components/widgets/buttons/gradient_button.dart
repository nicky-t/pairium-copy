import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.padding,
    this.gradient,
    this.radius,
    this.icon,
    this.iconColor,
    this.elevation,
    this.isStretch = false,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final LinearGradient? gradient;
  final double? radius;
  final IconData? icon;
  final Color? iconColor;
  final double? elevation;
  // ColumnのCrossAxisAlignment.stretchで表示が崩れた場合、このisStretchをtrueに指定
  final bool isStretch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
        elevation: elevation ?? 4,
      ),
      onPressed: onPressed,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 28,
            ),
        decoration: BoxDecoration(
          gradient: onPressed == null
              ? null
              : gradient ??
                  LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      theme.primaryColor,
                      theme.colorScheme.primaryVariant,
                    ],
                  ),
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
        alignment: isStretch ? Alignment.center : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? theme.backgroundColor,
              ),
            const SizedBox(width: 4),
            Text(
              text,
              style: textStyle ??
                  theme.textTheme.subtitle1?.copyWith(
                    color: theme.backgroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
