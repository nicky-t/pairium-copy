import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.text,
    required this.onPress,
    this.textStyle,
    this.padding,
    this.gradient,
    this.radius,
    this.icon,
    this.iconColor,
  });

  final String text;
  final void Function() onPress;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final LinearGradient? gradient;
  final double? radius;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
      ),
      onPressed: onPress,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 28,
            ),
        decoration: BoxDecoration(
          gradient: gradient ??
              LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                colors: [
                  theme.colorScheme.primaryVariant,
                  theme.primaryColor.withOpacity(0.8),
                ],
              ),
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
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
