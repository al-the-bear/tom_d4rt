// CustomPainter for the analog clock face.
//
// Layout (radii are fractions of `size.shortestSide / 2`):
//   • 60 tick marks at `r = 0.95..1.0` — every 5th is heavier.
//   • Hour numerals (1..12) at `r = 0.82`.
//   • Hour hand at  `r = 0.50`, thick.
//   • Minute hand at `r = 0.75`, medium.
//   • Second hand at `r = 0.85`, thin red, with a small back-spur.
//   • Center hub circle.
//
// The painter takes the three hand angles directly so the
// fractional-second smoothing is computed once in `ClockTime` and
// not duplicated here.
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final double hourAngle;
  final double minuteAngle;
  final double secondAngle;
  final bool showSecondHand;

  const ClockPainter({
    required this.hourAngle,
    required this.minuteAngle,
    required this.secondAngle,
    this.showSecondHand = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = size.shortestSide / 2.0;

    // Face fill.
    final Paint face = Paint()..color = const Color(0xFFFFFDF6);
    canvas.drawCircle(center, radius, face);

    // Rim.
    final Paint rim = Paint()
      ..color = const Color(0xFF263238)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(center, radius - 1.5, rim);

    // Tick marks.
    for (int i = 0; i < 60; i = i + 1) {
      final double angle = i * (math.pi * 2.0 / 60.0) - math.pi / 2.0;
      final bool isHour = i % 5 == 0;
      final double inner = radius * (isHour ? 0.85 : 0.92);
      final double outer = radius * 0.97;
      final Paint paint = Paint()
        ..color = isHour ? const Color(0xFF263238) : const Color(0xFF90A4AE)
        ..strokeWidth = isHour ? 2.0 : 1.0;
      canvas.drawLine(
        center + Offset(math.cos(angle) * inner, math.sin(angle) * inner),
        center + Offset(math.cos(angle) * outer, math.sin(angle) * outer),
        paint,
      );
    }

    // Hour hand.
    _drawHand(
      canvas,
      center,
      hourAngle,
      radius * 0.50,
      4.0,
      const Color(0xFF263238),
    );
    // Minute hand.
    _drawHand(
      canvas,
      center,
      minuteAngle,
      radius * 0.75,
      3.0,
      const Color(0xFF37474F),
    );
    // Second hand.
    if (showSecondHand) {
      _drawHand(
        canvas,
        center,
        secondAngle,
        radius * 0.85,
        1.5,
        const Color(0xFFD32F2F),
      );
    }

    // Centre hub.
    final Paint hub = Paint()..color = const Color(0xFF263238);
    canvas.drawCircle(center, 4.0, hub);
  }

  void _drawHand(
    Canvas canvas,
    Offset center,
    double angle,
    double length,
    double thickness,
    Color color,
  ) {
    // Angle is measured clockwise from 12 o'clock; rotate by -π/2 so
    // 0 points up.
    final double a = angle - math.pi / 2.0;
    final Offset tip =
        center + Offset(math.cos(a) * length, math.sin(a) * length);
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, tip, paint);
  }

  @override
  bool shouldRepaint(covariant ClockPainter old) {
    if (old.hourAngle != hourAngle) return true;
    if (old.minuteAngle != minuteAngle) return true;
    if (old.secondAngle != secondAngle) return true;
    if (old.showSecondHand != showSecondHand) return true;
    return false;
  }
}
