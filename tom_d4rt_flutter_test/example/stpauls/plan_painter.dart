import 'package:flutter/material.dart';

import 'hotspots.dart';

class PlanPainter extends CustomPainter {
  final String? selectedId;
  final String? hoveredId;

  PlanPainter({this.selectedId, this.hoveredId});

  @override
  void paint(Canvas canvas, Size size) {
    // Scale design space (kPlanW x kPlanH) to actual size.
    final sx = size.width / kPlanW;
    final sy = size.height / kPlanH;
    canvas.save();
    canvas.scale(sx, sy);

    _paintBackground(canvas);
    _paintGardens(canvas);
    _paintCloister(canvas);
    _paintQuadriporticus(canvas);
    _paintNarthex(canvas);
    _paintNave(canvas);
    _paintTransept(canvas);
    _paintApse(canvas);
    _paintBaldachin(canvas);
    _paintBellTower(canvas);
    _paintStatue(canvas);
    _paintCompass(canvas);
    _paintScale(canvas);
    _paintHighlights(canvas);

    canvas.restore();
  }

  void _paintBackground(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFF5EBD6);
    canvas.drawRect(const Rect.fromLTWH(0, 0, kPlanW, kPlanH), paint);

    // subtle paving lines
    final line = Paint()
      ..color = const Color(0xFFE9DDC2)
      ..strokeWidth = 1;
    for (double x = 0; x < kPlanW; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, kPlanH), line);
    }
    for (double y = 0; y < kPlanH; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(kPlanW, y), line);
    }
  }

  void _paintGardens(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFCFE3B5);
    canvas.drawRect(const Rect.fromLTWH(80, 540, 340, 120), paint);
    _label(canvas, 'Monastery Gardens', const Offset(250, 600), 18,
        color: const Color(0xFF4A6B2C));

    // Via Ostiense strip along the bottom
    final road = Paint()..color = const Color(0xFFDDD3BD);
    canvas.drawRect(const Rect.fromLTWH(0, 670, kPlanW, 30), road);
    _label(canvas, 'Via Ostiense  →  Tiber',
        const Offset(kPlanW / 2, 685), 12,
        color: const Color(0xFF7A6A4A));
  }

  void _paintQuadriporticus(Canvas canvas) {
    final wall = Paint()
      ..color = const Color(0xFFEFE3C6)
      ..style = PaintingStyle.fill;
    final outline = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const rect = Rect.fromLTWH(80, 150, 240, 380);
    canvas.drawRect(rect, wall);
    canvas.drawRect(rect, outline);

    // Inner courtyard
    const inner = Rect.fromLTWH(110, 180, 180, 320);
    final court = Paint()..color = const Color(0xFFE6D6B0);
    canvas.drawRect(inner, court);
    canvas.drawRect(inner, outline);

    // Colonnade dots
    final col = Paint()..color = const Color(0xFF8B6F3F);
    _colonnadeRow(canvas, 110, 290, 180, 14, col); // top edge
    _colonnadeRow(canvas, 110, 490, 180, 14, col); // bottom edge
    _colonnadeCol(canvas, 110, 180, 320, 24, col); // left edge
    _colonnadeCol(canvas, 290, 180, 320, 24, col); // right edge

    _label(canvas, 'Quadriporticus', const Offset(200, 165), 14,
        color: const Color(0xFF5A4520));
  }

  void _colonnadeRow(
      Canvas canvas, double x, double y, double w, int n, Paint p) {
    final step = w / (n - 1);
    for (int i = 0; i < n; i++) {
      canvas.drawCircle(Offset(x + i * step, y), 3, p);
    }
  }

  void _colonnadeCol(
      Canvas canvas, double x, double y, double h, int n, Paint p) {
    final step = h / (n - 1);
    for (int i = 0; i < n; i++) {
      canvas.drawCircle(Offset(x, y + i * step), 3, p);
    }
  }

  void _paintStatue(Canvas canvas) {
    final p = Paint()..color = const Color(0xFF8B6F3F);
    canvas.drawCircle(const Offset(200, 340), 10, p);
    final inner = Paint()..color = const Color(0xFFEFE3C6);
    canvas.drawCircle(const Offset(200, 340), 5, inner);
  }

  void _paintNarthex(Canvas canvas) {
    final wall = Paint()..color = const Color(0xFFE5D2A3);
    final outline = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const rect = Rect.fromLTWH(330, 200, 60, 280);
    canvas.drawRect(rect, wall);
    canvas.drawRect(rect, outline);

    // Holy Door indicator
    final door = Paint()..color = const Color(0xFFB8862C);
    canvas.drawRect(const Rect.fromLTWH(386, 320, 8, 40), door);
  }

  void _paintNave(Canvas canvas) {
    final wall = Paint()..color = const Color(0xFFEFE3C6);
    final outline = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const rect = Rect.fromLTWH(400, 200, 280, 280);
    canvas.drawRect(rect, wall);
    canvas.drawRect(rect, outline);

    // Five aisles -> four rows of columns dividing them.
    final col = Paint()..color = const Color(0xFF8B6F3F);
    final aisleLine = Paint()
      ..color = const Color(0xFFD7C089)
      ..strokeWidth = 1;
    for (int row = 1; row <= 4; row++) {
      final y = 200 + (row * 280 / 5);
      canvas.drawLine(Offset(400, y), Offset(680, y), aisleLine);
      // Column dots along the row
      for (int i = 0; i < 20; i++) {
        final x = 410 + i * 14.0;
        canvas.drawCircle(Offset(x, y), 2.6, col);
      }
    }

    _label(canvas, 'Nave', const Offset(540, 215), 14,
        color: const Color(0xFF5A4520));
  }

  void _paintTransept(Canvas canvas) {
    final wall = Paint()..color = const Color(0xFFE5D2A3);
    final outline = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const rect = Rect.fromLTWH(690, 150, 70, 380);
    canvas.drawRect(rect, wall);
    canvas.drawRect(rect, outline);
  }

  void _paintApse(Canvas canvas) {
    final wall = Paint()..color = const Color(0xFFE9D2A0);
    final outline = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(780, 250)
      ..lineTo(780, 430)
      ..arcToPoint(const Offset(780, 250),
          radius: const Radius.circular(90), clockwise: false);
    canvas.drawPath(path, wall);
    canvas.drawPath(path, outline);

    // mosaic hint — gold gradient circle
    final gold = Paint()..color = const Color(0xFFD9B255);
    canvas.drawCircle(const Offset(830, 340), 26, gold);
    final goldRing = Paint()
      ..color = const Color(0xFFB8862C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(const Offset(830, 340), 26, goldRing);
  }

  void _paintBaldachin(Canvas canvas) {
    final base = Paint()..color = const Color(0xFFB8862C);
    canvas.drawRect(const Rect.fromLTWH(720, 310, 60, 60), base);
    final top = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(const Rect.fromLTWH(720, 310, 60, 60), top);
    // four canopy columns
    final col = Paint()..color = const Color(0xFF5A4520);
    canvas.drawCircle(const Offset(728, 318), 3, col);
    canvas.drawCircle(const Offset(772, 318), 3, col);
    canvas.drawCircle(const Offset(728, 362), 3, col);
    canvas.drawCircle(const Offset(772, 362), 3, col);
  }

  void _paintBellTower(Canvas canvas) {
    final p = Paint()..color = const Color(0xFFD9C28E);
    canvas.drawRect(const Rect.fromLTWH(700, 40, 60, 90), p);
    final outline = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(const Rect.fromLTWH(700, 40, 60, 90), outline);
    // bell symbol
    canvas.drawCircle(const Offset(730, 85), 8, outline);
  }

  void _paintCloister(Canvas canvas) {
    final wall = Paint()..color = const Color(0xFFEEDFB7);
    final outline = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const rect = Rect.fromLTWH(440, 520, 240, 140);
    canvas.drawRect(rect, wall);
    canvas.drawRect(rect, outline);

    // Inner garth
    const inner = Rect.fromLTWH(470, 545, 180, 90);
    final garth = Paint()..color = const Color(0xFFCFE3B5);
    canvas.drawRect(inner, garth);
    canvas.drawRect(inner, outline);

    // Twisted columns of the cosmatesque arcade
    final col = Paint()..color = const Color(0xFF8B6F3F);
    _colonnadeRow(canvas, 470, 543, 180, 13, col);
    _colonnadeRow(canvas, 470, 637, 180, 13, col);
    _colonnadeCol(canvas, 470, 545, 90, 7, col);
    _colonnadeCol(canvas, 650, 545, 90, 7, col);

    _label(canvas, 'Cloister', const Offset(560, 535), 12,
        color: const Color(0xFF5A4520));
  }

  void _paintCompass(Canvas canvas) {
    // top-right compass; in the real basilica entrance faces east,
    // apse faces west, so "right" on the plan is west.
    const c = Offset(940, 60);
    final ring = Paint()
      ..color = const Color(0xFF6B5530)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(c, 26, ring);

    final arrow = Paint()..color = const Color(0xFFB8862C);
    final path = Path()
      ..moveTo(c.dx, c.dy - 22)
      ..lineTo(c.dx - 6, c.dy + 4)
      ..lineTo(c.dx, c.dy - 2)
      ..lineTo(c.dx + 6, c.dy + 4)
      ..close();
    canvas.drawPath(path, arrow);
    _label(canvas, 'N', Offset(c.dx, c.dy + 16), 11,
        color: const Color(0xFF5A4520));
  }

  void _paintScale(Canvas canvas) {
    // Approximate scale bar — basilica is ~131 m long internally.
    final bar = Paint()
      ..color = const Color(0xFF5A4520)
      ..strokeWidth = 3;
    canvas.drawLine(const Offset(40, 50), const Offset(140, 50), bar);
    canvas.drawLine(const Offset(40, 45), const Offset(40, 55), bar);
    canvas.drawLine(const Offset(140, 45), const Offset(140, 55), bar);
    _label(canvas, '~ 25 m', const Offset(90, 38), 11,
        color: const Color(0xFF5A4520));
  }

  void _paintHighlights(Canvas canvas) {
    for (final h in kHotspots) {
      final isSelected = h.id == selectedId;
      final isHovered = h.id == hoveredId;
      if (!isSelected && !isHovered) continue;

      final paint = Paint()
        ..color = isSelected
            ? const Color(0x553B82F6) // blue glow when selected
            : const Color(0x33B8862C)
        ..style = PaintingStyle.fill;
      canvas.drawRect(h.rect, paint);

      final stroke = Paint()
        ..color = isSelected
            ? const Color(0xFF3B82F6)
            : const Color(0xFFB8862C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 2.5 : 1.5;
      canvas.drawRect(h.rect, stroke);
    }
  }

  void _label(Canvas canvas, String text, Offset center, double size,
      {Color color = Colors.black}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas,
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant PlanPainter old) {
    return old.selectedId != selectedId || old.hoveredId != hoveredId;
  }
}
