import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'landmarks.dart';

/// Paints a schematic plan of the Vatican / St. Peter's area.
///
/// All drawing is done in NORMALIZED 0..1 coordinates and then scaled to
/// the actual canvas size, so the same coordinates can be used by the
/// hit-test in [Landmark.hitRect].
class PlanPainter extends CustomPainter {
  final String? highlightId;

  PlanPainter({this.highlightId});

  // --- palette -------------------------------------------------------------
  static const _ground = Color(0xFFEFE4C8);
  static const _gardens = Color(0xFFB7CFA0);
  static const _gardensDark = Color(0xFF8AB071);
  static const _stone = Color(0xFFD9C7A0);
  static const _stoneEdge = Color(0xFF8C7448);
  static const _basilica = Color(0xFFE7D4A6);
  static const _basilicaEdge = Color(0xFF7A5E2A);
  static const _road = Color(0xFFE8DDC2);
  static const _roadEdge = Color(0xFFB5A074);
  static const _river = Color(0xFF8FB8D8);
  static const _riverEdge = Color(0xFF4A7C9E);
  static const _label = Color(0xFF3D2F14);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    Offset p(double nx, double ny) => Offset(nx * w, ny * h);
    Rect rN(Rect r) => Rect.fromLTWH(
        r.left * w, r.top * h, r.width * w, r.height * h);

    // Ground / parchment
    canvas.drawRect(Offset.zero & size, Paint()..color = _ground);
    _drawParchmentGrid(canvas, size);

    // ----- Vatican gardens (west half) -------------------------------------
    _fillRRect(canvas, rN(const Rect.fromLTWH(0.01, 0.04, 0.24, 0.72)),
        12, _gardens, _gardensDark);
    _drawTrees(canvas, size);

    // City blocks east of the colonnade (Borgo area)
    _fillRRect(canvas, rN(const Rect.fromLTWH(0.69, 0.10, 0.18, 0.30)),
        6, const Color(0xFFE3D2A6), _stoneEdge);
    _fillRRect(canvas, rN(const Rect.fromLTWH(0.69, 0.60, 0.18, 0.30)),
        6, const Color(0xFFE3D2A6), _stoneEdge);

    // ----- River Tiber (right edge) ---------------------------------------
    _drawRiver(canvas, size);

    // ----- Via della Conciliazione ----------------------------------------
    final road = rN(const Rect.fromLTWH(0.68, 0.46, 0.30, 0.08));
    _fillRect(canvas, road, _road, _roadEdge);
    // dashed centre line
    final dashPaint = Paint()
      ..color = _roadEdge
      ..strokeWidth = 1.2;
    for (double x = road.left + 6; x < road.right - 4; x += 10) {
      canvas.drawLine(
          Offset(x, road.center.dy), Offset(x + 5, road.center.dy), dashPaint);
    }

    // ----- Castel Sant'Angelo (pentagon) ----------------------------------
    _drawCastel(canvas, size);

    // ----- St. Peter's Square (the piazza floor) --------------------------
    final squareCenter = p(0.535, 0.495);
    final squareRX = 0.135 * w;
    final squareRY = 0.18 * h;
    canvas.drawOval(
      Rect.fromCenter(
          center: squareCenter, width: squareRX * 2, height: squareRY * 2),
      Paint()..color = _stone,
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: squareCenter, width: squareRX * 2, height: squareRY * 2),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = _stoneEdge,
    );

    // Cobblestone radial lines from the obelisk
    final radialPaint = Paint()
      ..color = _stoneEdge.withOpacity(0.35)
      ..strokeWidth = 0.6;
    for (int i = 0; i < 16; i++) {
      final a = (i / 16) * 2 * math.pi;
      final ex = squareCenter.dx + math.cos(a) * squareRX;
      final ey = squareCenter.dy + math.sin(a) * squareRY;
      canvas.drawLine(squareCenter, Offset(ex, ey), radialPaint);
    }

    // ----- Bernini colonnades (two arcs of dots) --------------------------
    _drawColonnade(canvas, squareCenter, squareRX, squareRY, top: true);
    _drawColonnade(canvas, squareCenter, squareRX, squareRY, top: false);

    // Trapezoidal piazza retta connecting square to basilica
    final piazzaRetta = Path()
      ..moveTo(p(0.40, 0.42).dx, p(0.40, 0.42).dy)
      ..lineTo(p(0.38, 0.36).dx, p(0.38, 0.36).dy)
      ..lineTo(p(0.38, 0.63).dx, p(0.38, 0.63).dy)
      ..lineTo(p(0.40, 0.57).dx, p(0.40, 0.57).dy)
      ..close();
    canvas.drawPath(piazzaRetta, Paint()..color = _stone);
    canvas.drawPath(
        piazzaRetta,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = _stoneEdge);

    // ----- Fountains -------------------------------------------------------
    _drawFountain(canvas, p(0.475, 0.415));
    _drawFountain(canvas, p(0.598, 0.575));

    // ----- Obelisk --------------------------------------------------------
    // square base + tiny pointed top + shadow line
    final obeliskBase = Rect.fromCenter(
        center: squareCenter, width: 0.018 * w, height: 0.018 * w);
    canvas.drawRect(obeliskBase, Paint()..color = const Color(0xFF6B5A33));
    canvas.drawRect(
        obeliskBase,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8
          ..color = Colors.black54);
    // shadow line indicating obelisk projecting upward
    canvas.drawLine(
        squareCenter,
        Offset(squareCenter.dx + 0.025 * w, squareCenter.dy + 0.025 * w),
        Paint()
          ..color = Colors.black26
          ..strokeWidth = 1.5);

    // ----- Basilica -------------------------------------------------------
    _drawBasilica(canvas, size);

    // ----- Vatican Museums + Sistine + Palace (north of basilica) ---------
    _fillRRect(canvas, rN(const Rect.fromLTWH(0.25, 0.13, 0.18, 0.10)),
        4, const Color(0xFFE8D6A8), _basilicaEdge);
    _fillRRect(canvas, rN(const Rect.fromLTWH(0.30, 0.24, 0.14, 0.10)),
        4, const Color(0xFFE8D6A8), _basilicaEdge);
    _fillRRect(canvas, rN(const Rect.fromLTWH(0.16, 0.20, 0.08, 0.10)),
        4, const Color(0xFFE0CE9C), _basilicaEdge);

    // Casa Santa Marta
    _fillRRect(canvas, rN(const Rect.fromLTWH(0.13, 0.60, 0.10, 0.07)),
        4, const Color(0xFFE8D6A8), _basilicaEdge);

    // ----- Labels ---------------------------------------------------------
    _drawLabels(canvas, size);

    // ----- Highlight ring around selected landmark ------------------------
    if (highlightId != null) {
      final lm = kLandmarks.firstWhere(
        (l) => l.id == highlightId,
        orElse: () => kLandmarks.first,
      );
      if (lm.id == highlightId) {
        final r = rN(lm.hitRect).inflate(4);
        final ring = Paint()
          ..color = Colors.redAccent.withOpacity(0.9)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;
        canvas.drawRRect(
            RRect.fromRectAndRadius(r, const Radius.circular(8)), ring);
      }
    }

    // ----- Frame + compass + scale ----------------------------------------
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = _stoneEdge,
    );
    _drawCompass(canvas, size);
    _drawScale(canvas, size);
  }

  // -------------------------------------------------------------------------
  // helpers
  // -------------------------------------------------------------------------

  void _fillRect(Canvas c, Rect r, Color fill, Color edge) {
    c.drawRect(r, Paint()..color = fill);
    c.drawRect(
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = edge);
  }

  void _fillRRect(Canvas c, Rect r, double radius, Color fill, Color edge) {
    final rr = RRect.fromRectAndRadius(r, Radius.circular(radius));
    c.drawRRect(rr, Paint()..color = fill);
    c.drawRRect(
        rr,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = edge);
  }

  void _drawParchmentGrid(Canvas c, Size s) {
    final paint = Paint()
      ..color = const Color(0xFFB5A074).withOpacity(0.10)
      ..strokeWidth = 0.5;
    const step = 24.0;
    for (double x = 0; x < s.width; x += step) {
      c.drawLine(Offset(x, 0), Offset(x, s.height), paint);
    }
    for (double y = 0; y < s.height; y += step) {
      c.drawLine(Offset(0, y), Offset(s.width, y), paint);
    }
  }

  void _drawTrees(Canvas c, Size s) {
    final rng = math.Random(7);
    final trunk = Paint()..color = const Color(0xFF6B4A24);
    final leaf = Paint()..color = _gardensDark;
    for (int i = 0; i < 38; i++) {
      final x = (0.025 + rng.nextDouble() * 0.21) * s.width;
      final y = (0.06 + rng.nextDouble() * 0.68) * s.height;
      c.drawCircle(Offset(x, y), 3.5, leaf);
      c.drawCircle(Offset(x, y), 1.0, trunk);
    }
  }

  void _drawRiver(Canvas c, Size s) {
    // wavy band from top to bottom on the right
    final path = Path();
    final left = 0.88 * s.width;
    final right = s.width;
    path.moveTo(left, 0);
    for (double y = 0; y <= s.height; y += 12) {
      final dx = math.sin(y / 22) * 6;
      path.lineTo(left + dx, y);
    }
    path.lineTo(right, s.height);
    path.lineTo(right, 0);
    path.close();
    c.drawPath(path, Paint()..color = _river);
    // edge line
    final edge = Path();
    edge.moveTo(left, 0);
    for (double y = 0; y <= s.height; y += 12) {
      final dx = math.sin(y / 22) * 6;
      edge.lineTo(left + dx, y);
    }
    c.drawPath(
        edge,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _riverEdge);
    // little ripples
    final ripple = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    final rng = math.Random(3);
    for (int i = 0; i < 22; i++) {
      final y = rng.nextDouble() * s.height;
      final x = left + 12 + rng.nextDouble() * (right - left - 16);
      c.drawArc(
          Rect.fromCenter(center: Offset(x, y), width: 8, height: 3),
          math.pi,
          math.pi,
          false,
          ripple);
    }
  }

  void _drawCastel(Canvas c, Size s) {
    final center = Offset(0.87 * s.width, 0.47 * s.height);
    final r = 0.045 * s.width;
    // outer star-fort pentagon
    final outer = Path();
    for (int i = 0; i < 5; i++) {
      final a = -math.pi / 2 + i * 2 * math.pi / 5;
      final pt = Offset(center.dx + math.cos(a) * r, center.dy + math.sin(a) * r);
      if (i == 0) {
        outer.moveTo(pt.dx, pt.dy);
      } else {
        outer.lineTo(pt.dx, pt.dy);
      }
    }
    outer.close();
    c.drawPath(outer, Paint()..color = const Color(0xFFC9B07E));
    c.drawPath(
        outer,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _stoneEdge);
    // inner cylindrical keep
    c.drawCircle(center, r * 0.5, Paint()..color = const Color(0xFFD9C088));
    c.drawCircle(
        center,
        r * 0.5,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = _stoneEdge);
    // angel on top — small triangle
    final ang = Path()
      ..moveTo(center.dx, center.dy - 4)
      ..lineTo(center.dx - 3, center.dy + 2)
      ..lineTo(center.dx + 3, center.dy + 2)
      ..close();
    c.drawPath(ang, Paint()..color = const Color(0xFF8A6E2E));
  }

  void _drawColonnade(Canvas c, Offset center, double rx, double ry,
      {required bool top}) {
    // Bernini's colonnades are roughly two semi-ellipses just outside the
    // piazza floor; we render them as four concentric rings of dots
    // (representing the four rows of columns).
    final start = top ? math.pi : 0.0;
    final sweep = math.pi;
    for (int row = 0; row < 4; row++) {
      final rrx = rx + 4 + row * 4.0;
      final rry = ry + 4 + row * 4.0;
      const steps = 28;
      for (int i = 0; i <= steps; i++) {
        final t = i / steps;
        final a = start + sweep * t;
        final pt = Offset(
            center.dx + math.cos(a) * rrx, center.dy + math.sin(a) * rry);
        c.drawCircle(pt, 1.4, Paint()..color = _stoneEdge);
      }
    }
  }

  void _drawFountain(Canvas c, Offset center) {
    c.drawCircle(center, 6, Paint()..color = _river);
    c.drawCircle(
        center,
        6,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = _riverEdge);
    c.drawCircle(center, 2, Paint()..color = Colors.white);
  }

  void _drawBasilica(Canvas c, Size s) {
    Offset p(double nx, double ny) => Offset(nx * s.width, ny * s.height);

    // The basilica is a Latin cross. Long axis runs west(apse) -> east(facade).
    // Nave (long rectangle)
    final nave = Rect.fromLTRB(
        p(0.10, 0.42).dx, p(0.10, 0.42).dy,
        p(0.35, 0.50).dx, p(0.35, 0.50).dy);
    c.drawRect(nave, Paint()..color = _basilica);
    c.drawRect(
        nave,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _basilicaEdge);

    // Transept (perpendicular arms across the crossing at x≈0.28)
    final transept = Rect.fromLTRB(
        p(0.245, 0.36).dx, p(0.245, 0.36).dy,
        p(0.315, 0.56).dx, p(0.315, 0.56).dy);
    c.drawRect(transept, Paint()..color = _basilica);
    c.drawRect(
        transept,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _basilicaEdge);

    // Apse on the west end (semicircle bulging west / left)
    final apseCenter = p(0.10, 0.46);
    c.drawArc(
        Rect.fromCenter(
            center: apseCenter, width: 0.045 * s.width, height: 0.08 * s.height),
        math.pi / 2,
        math.pi,
        true,
        Paint()..color = _basilica);
    c.drawArc(
        Rect.fromCenter(
            center: apseCenter, width: 0.045 * s.width, height: 0.08 * s.height),
        math.pi / 2,
        math.pi,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _basilicaEdge);

    // Facade (Maderno) — slightly wider block at east end
    final facade = Rect.fromLTRB(
        p(0.345, 0.405).dx, p(0.345, 0.405).dy,
        p(0.380, 0.535).dx, p(0.380, 0.535).dy);
    c.drawRect(facade, Paint()..color = _basilica);
    c.drawRect(
        facade,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _basilicaEdge);

    // Dome — big circle at the crossing
    final domeCenter = p(0.28, 0.46);
    final domeR = 0.038 * s.width;
    c.drawCircle(domeCenter, domeR,
        Paint()..color = const Color(0xFFB8A06A));
    c.drawCircle(
        domeCenter,
        domeR,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = _basilicaEdge);
    // inner circle (drum)
    c.drawCircle(domeCenter, domeR * 0.65,
        Paint()..color = const Color(0xFFD8C089));
    c.drawCircle(
        domeCenter,
        domeR * 0.65,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.9
          ..color = _basilicaEdge);
    // lantern
    c.drawCircle(domeCenter, domeR * 0.18,
        Paint()..color = const Color(0xFF8A6E2E));
    // cross on top
    final crossPaint = Paint()
      ..color = const Color(0xFF4A3713)
      ..strokeWidth = 1.5;
    c.drawLine(Offset(domeCenter.dx, domeCenter.dy - domeR * 0.35),
        Offset(domeCenter.dx, domeCenter.dy - domeR * 0.05), crossPaint);
    c.drawLine(Offset(domeCenter.dx - domeR * 0.1, domeCenter.dy - domeR * 0.25),
        Offset(domeCenter.dx + domeR * 0.1, domeCenter.dy - domeR * 0.25),
        crossPaint);

    // Two smaller side domes (over the chapels of the transept)
    c.drawCircle(p(0.235, 0.39), 6, Paint()..color = const Color(0xFFC9B07E));
    c.drawCircle(
        p(0.235, 0.39),
        6,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.9
          ..color = _basilicaEdge);
    c.drawCircle(p(0.235, 0.53), 6, Paint()..color = const Color(0xFFC9B07E));
    c.drawCircle(
        p(0.235, 0.53),
        6,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.9
          ..color = _basilicaEdge);
  }

  void _drawLabels(Canvas c, Size s) {
    void label(String txt, Offset center, {double size = 9, bool italic = false}) {
      final tp = TextPainter(
        text: TextSpan(
          text: txt,
          style: TextStyle(
            color: _label,
            fontSize: size,
            fontWeight: FontWeight.w600,
            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            letterSpacing: 0.5,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();
      tp.paint(c, center - Offset(tp.width / 2, tp.height / 2));
    }

    label("BASILICA DI SAN PIETRO", Offset(0.225 * s.width, 0.585 * s.height));
    label("Piazza San Pietro", Offset(0.535 * s.width, 0.495 * s.height),
        size: 10);
    label("Via della Conciliazione",
        Offset(0.83 * s.width, 0.50 * s.height), size: 8);
    label("TEVERE", Offset(0.93 * s.width, 0.92 * s.height),
        size: 9, italic: true);
    label("Castel\nSant'Angelo", Offset(0.87 * s.width, 0.55 * s.height),
        size: 7);
    label("Giardini Vaticani", Offset(0.13 * s.width, 0.40 * s.height),
        size: 9, italic: true);
    label("Musei", Offset(0.34 * s.width, 0.18 * s.height), size: 8);
    label("Palazzo Apostolico",
        Offset(0.37 * s.width, 0.29 * s.height), size: 7);
    label("Sistina", Offset(0.20 * s.width, 0.25 * s.height), size: 7);
    label("S. Marta", Offset(0.18 * s.width, 0.635 * s.height), size: 7);
  }

  void _drawCompass(Canvas c, Size s) {
    final center = Offset(s.width - 26, 26);
    c.drawCircle(center, 14, Paint()..color = Colors.white.withOpacity(0.85));
    c.drawCircle(
        center,
        14,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = _stoneEdge);
    final n = Path()
      ..moveTo(center.dx, center.dy - 11)
      ..lineTo(center.dx - 4, center.dy + 2)
      ..lineTo(center.dx + 4, center.dy + 2)
      ..close();
    c.drawPath(n, Paint()..color = const Color(0xFF8A2E2E));
    final sArr = Path()
      ..moveTo(center.dx, center.dy + 11)
      ..lineTo(center.dx - 4, center.dy - 2)
      ..lineTo(center.dx + 4, center.dy - 2)
      ..close();
    c.drawPath(sArr, Paint()..color = _label);
    final tp = TextPainter(
      text: const TextSpan(
          text: 'N',
          style: TextStyle(
              color: _label, fontSize: 9, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(c, Offset(center.dx - tp.width / 2, center.dy - 25));
  }

  void _drawScale(Canvas c, Size s) {
    // Decorative scale bar: ~100 m. The actual square is ~240 m across in
    // reality, our square ellipse is ~0.27 * width, so 100 m ≈ 0.11 * width.
    final left = 12.0;
    final y = s.height - 16;
    final segLen = 0.055 * s.width;
    for (int i = 0; i < 2; i++) {
      final r = Rect.fromLTWH(left + i * segLen, y, segLen, 5);
      c.drawRect(
          r, Paint()..color = i.isEven ? _label : Colors.white);
      c.drawRect(
          r,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.7
            ..color = _label);
    }
    final tp = TextPainter(
      text: const TextSpan(
          text: '0      50      100 m',
          style: TextStyle(color: _label, fontSize: 8)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(c, Offset(left, y - 11));
  }

  @override
  bool shouldRepaint(covariant PlanPainter old) =>
      old.highlightId != highlightId;
}
