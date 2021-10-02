import 'dart:math';

import 'package:flutter/material.dart';

class StickyNote extends StatelessWidget {
  const StickyNote({
    this.child,
    required this.width,
    required this.height,
    this.isPin = true,
    this.color = const Color(0xffffff00),
    this.angle = -0.01,
    Key? key,
  }) : super(key: key);

  final Widget? child;
  final Color color;
  final double width;
  final double height;
  final bool isPin;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: SizedBox(
              width: width - 20,
              height: height - 20,
              child: Center(
                child: Transform.rotate(
                  angle: angle * pi,
                  child: CustomPaint(
                      painter: StickyNotePainter(color: color),
                      child: Center(child: child)),
                ),
              ),
            ),
          ),
          if (isPin)
            Positioned(
              top: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                  gradient: RadialGradient(
                    colors: [Colors.red.shade50, Colors.red],
                    center: const Alignment(0.1, -0.13),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: Offset(-7, 10),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class StickyNotePainter extends CustomPainter {
  StickyNotePainter({required this.color});

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    _drawShadow(size, canvas);
    final gradientPaint = _createGradientPaint(size);
    _drawNote(size, canvas, gradientPaint);
  }

  void _drawNote(Size size, Canvas canvas, Paint gradientPaint) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height);

    const foldAmount = 0.12;
    path
      ..lineTo(size.width * 3 / 4, size.height)
      ..quadraticBezierTo(size.width * foldAmount * 2, size.height,
          size.width * foldAmount, size.height - (size.height * foldAmount))
      ..quadraticBezierTo(
          0, size.height - (size.height * foldAmount * 1.5), 0, size.height / 4)
      ..lineTo(0, 0);

    canvas.drawPath(path, gradientPaint);
  }

  Paint _createGradientPaint(Size size) {
    final paint = Paint();

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = RadialGradient(
        colors: [brighten(color), color],
        radius: 1,
        stops: const [0.5, 1.0],
        center: Alignment.bottomLeft);
    paint.shader = gradient.createShader(rect);
    return paint;
  }

  void _drawShadow(Size size, Canvas canvas) {
    final shadowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..color = Colors.black.withOpacity(0.26);
    final shadowPath = Path()
      ..moveTo(0, 24)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 6, size.height)
      ..quadraticBezierTo(
          -2, size.height + 2, 0, size.height - (size.width / 6))
      ..lineTo(0, 0);
    final rect = Rect.fromLTWH(12, 12, size.width - 24, size.height - 24);
    final path = Path()..addRect(rect);
    canvas
      ..drawPath(shadowPath, shadowPaint)
      ..drawShadow(path, Colors.black.withOpacity(0.5), 12, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

Color brighten(Color c, [int percent = 30]) {
  final p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round());
}
