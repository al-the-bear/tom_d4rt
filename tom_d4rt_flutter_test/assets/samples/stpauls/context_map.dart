import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Tiny inset map showing the basilica's position in Rome relative
/// to the Vatican and the Tiber. Schematic, not geographically exact.
class ContextMap extends StatelessWidget {
  const ContextMap({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomPaint(
          painter: _ContextPainter(),
        ),
      ),
    );
  }
}

class _ContextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background — pale ochre, the colour of Rome.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFFF1E6CC),
    );

    // The Tiber — a curved blue ribbon meandering down.
    final river = Path()
      ..moveTo(w * 0.18, 0)
      ..cubicTo(w * 0.28, h * 0.25, w * 0.10, h * 0.55, w * 0.30, h * 0.75)
      ..cubicTo(w * 0.40, h * 0.88, w * 0.55, h * 0.92, w * 0.70, h);
    final riverPaint = Paint()
      ..color = const Color(0xFF89B6D9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.05
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(river, riverPaint);

    // Aurelian walls — dashed circle around the historic centre.
    final wallPaint = Paint()
      ..color = const Color(0xFF8B6F3F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    _dashedCircle(canvas, Offset(w * 0.55, h * 0.50), w * 0.30, wallPaint);

    // Vatican / St. Peter's — north-west of centre, outside the walls.
    _placeDot(canvas, Offset(w * 0.22, h * 0.30),
        const Color(0xFFC9A227), "St. Peter's\n(Vatican)");

    _label(canvas, 'Rome', Offset(w * 0.55, h * 0.48), 10,
        color: const Color(0xFF6B5530));

    // San Paolo fuori le Mura — to the south, OUTSIDE the walls.
    _placeDot(canvas, Offset(w * 0.78, h * 0.85),
        const Color(0xFF3B82F6), "St. Paul's\nOutside the Walls");

    _label(canvas, 'Tiber', Offset(w * 0.15, h * 0.45), 9,
        color: const Color(0xFF3F6A8C));

    _label(canvas, 'Context — Rome', Offset(w * 0.5, h * 0.07), 11,
        color: const Color(0xFF5A4520), bold: true);
  }

  void _dashedCircle(Canvas canvas, Offset c, double r, Paint p) {
    const segs = 48;
    for (int i = 0; i < segs; i += 2) {
      final a0 = (i / segs) * 2 * math.pi;
      final a1 = ((i + 1) / segs) * 2 * math.pi;
      final p0 = Offset(c.dx + r * math.cos(a0), c.dy + r * math.sin(a0));
      final p1 = Offset(c.dx + r * math.cos(a1), c.dy + r * math.sin(a1));
      canvas.drawLine(p0, p1, p);
    }
  }

  void _placeDot(Canvas canvas, Offset pos, Color color, String label) {
    final glow = Paint()..color = color.withValues(alpha: 0.25);
    canvas.drawCircle(pos, 12, glow);
    final dot = Paint()..color = color;
    canvas.drawCircle(pos, 6, dot);
    final ring = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(pos, 6, ring);
    _label(canvas, label, Offset(pos.dx, pos.dy + 22), 9,
        color: const Color(0xFF3A2C12), bold: true);
  }

  void _label(Canvas canvas, String text, Offset center, double size,
      {Color color = Colors.black, bool bold = false}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas,
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _ContextPainter old) => false;
}
