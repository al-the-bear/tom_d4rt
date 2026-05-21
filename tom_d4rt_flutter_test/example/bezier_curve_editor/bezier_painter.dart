// CustomPainter for the cubic-Bezier editor.
//
// Layers, drawn back-to-front:
//   1. Editor background (white-ish, with a faint grid).
//   2. (optional) Construction polygon — straight lines connecting
//      p0→p1→p2→p3, used to visualise the control net.
//   3. Smooth curve via `Path.cubicTo`.
//   4. Sampled polyline using `resolution` segments (drawn in a
//      semi-transparent colour over the smooth curve so the user
//      can see where the samples land).
//   5. Filled circles for the four control points (p0/p3 in one
//      colour, p1/p2 in another to distinguish endpoints from
//      tangent handles).
//   6. The preview dot at `pointAt(previewT)`.
//
// The painter uses normalised coordinates from `BezierModel` and
// converts to pixel space using a fixed inset padding.
import 'package:flutter/material.dart';

import 'bezier_model.dart';

/// Padding (in pixels) between the canvas edge and the editor's
/// `[0, 1] × [0, 1]` normalised area. Exposed so `Home` can use
/// the same value when translating pointer positions back to
/// normalised coords.
const double kBezierInset = 24.0;

class BezierPainter extends CustomPainter {
  final BezierModel model;

  BezierPainter(this.model) : super(repaint: model);

  /// Convert a normalised offset into pixel space inside the
  /// inset rectangle.
  Offset _toPx(Offset n, Size size) {
    final double w = size.width - 2.0 * kBezierInset;
    final double h = size.height - 2.0 * kBezierInset;
    return Offset(kBezierInset + n.dx * w, kBezierInset + n.dy * h);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Background.
    final Paint bg = Paint()..color = const Color(0xFFFAFAFA);
    canvas.drawRect(Offset.zero & size, bg);

    // Faint grid.
    final Paint gridPaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..strokeWidth = 1.0;
    const int gridSteps = 4;
    for (int i = 0; i <= gridSteps; i += 1) {
      final double t = i / gridSteps;
      final Offset top = _toPx(Offset(t, 0.0), size);
      final Offset bot = _toPx(Offset(t, 1.0), size);
      canvas.drawLine(top, bot, gridPaint);
      final Offset left = _toPx(Offset(0.0, t), size);
      final Offset right = _toPx(Offset(1.0, t), size);
      canvas.drawLine(left, right, gridPaint);
    }

    final Offset p0 = _toPx(model.points[0], size);
    final Offset p1 = _toPx(model.points[1], size);
    final Offset p2 = _toPx(model.points[2], size);
    final Offset p3 = _toPx(model.points[3], size);

    // 2. Construction polygon.
    if (model.showConstruction) {
      final Paint polyPaint = Paint()
        ..color = Colors.orange.withValues(alpha: 0.75)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      final Path poly = Path()
        ..moveTo(p0.dx, p0.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy);
      canvas.drawPath(poly, polyPaint);
    }

    // 3. Smooth curve via Path.cubicTo.
    final Paint curvePaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    final Path curve = Path()
      ..moveTo(p0.dx, p0.dy)
      ..cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    canvas.drawPath(curve, curvePaint);

    // 4. Sampled polyline at `resolution` segments.
    final Paint samplePaint = Paint()
      ..color = Colors.deepPurple.withValues(alpha: 0.55)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Path sampled = Path();
    final int n = model.resolution;
    sampled.moveTo(p0.dx, p0.dy);
    for (int i = 1; i <= n; i += 1) {
      final double t = i / n;
      final Offset sn = model.pointAt(t);
      final Offset sp = _toPx(sn, size);
      sampled.lineTo(sp.dx, sp.dy);
    }
    canvas.drawPath(sampled, samplePaint);

    // 5. Control point circles. p0/p3 are filled squares (endpoint
    //    markers); p1/p2 are filled circles (tangent handles).
    final Paint endpointPaint = Paint()..color = Colors.blueAccent;
    final Paint handlePaint = Paint()..color = Colors.orange;
    canvas.drawRect(
      Rect.fromCenter(center: p0, width: 12.0, height: 12.0),
      endpointPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: p3, width: 12.0, height: 12.0),
      endpointPaint,
    );
    canvas.drawCircle(p1, 7.0, handlePaint);
    canvas.drawCircle(p2, 7.0, handlePaint);

    // 6. Preview dot.
    final Offset preview = _toPx(model.pointAt(model.previewT), size);
    final Paint dotShadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.3);
    canvas.drawCircle(preview.translate(0.0, 1.5), 7.0, dotShadow);
    final Paint dotPaint = Paint()..color = Colors.redAccent;
    canvas.drawCircle(preview, 6.0, dotPaint);
  }

  @override
  bool shouldRepaint(BezierPainter oldDelegate) =>
      oldDelegate.model != model;
}
