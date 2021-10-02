import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer(
      {this.width = double.minPositive,
      this.height = double.minPositive,
      this.borderRadius = 16,
      this.linearGradient,
      this.border = 1.5,
      this.blur = 16,
      this.borderGradient,
      this.boxShadow,
      required this.child,
      Key? key})
      : super(key: key);

  final Widget? child;
  final double blur;
  final double width;
  final double height;
  final double border;
  final double borderRadius;
  final LinearGradient? linearGradient;
  final LinearGradient? borderGradient;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow ??
            [
              // BoxShadow(
              //   blurRadius: 24,
              //   spreadRadius: 16,
              //   color: Colors.black.withOpacity(0.2),
              // )
            ],
      ),
      child: GlassmorphicContainer(
        width: width,
        height: height,
        borderRadius: borderRadius,
        border: border,
        blur: blur,
        linearGradient: linearGradient ??
            LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.1),
                  const Color(0xFFFFFFFF).withOpacity(0.05),
                ],
                stops: const [
                  0.1,
                  1,
                ]),
        borderGradient: borderGradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.5),
                const Color(0xFFFFFFFF).withOpacity(0.5),
              ],
            ),
        child: child,
      ),
    );
  }
}
