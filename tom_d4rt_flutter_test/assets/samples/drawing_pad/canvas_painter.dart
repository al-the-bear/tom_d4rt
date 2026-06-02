// CustomPainter that renders every committed stroke plus the
// current in-progress stroke.
//
// Each stroke is drawn as a `Path` of `lineTo` segments — simple
// straight-line interpolation between samples works well for
// `onPanUpdate`'s ~16 ms cadence on desktop and is plenty smooth
// for the interpreter's frame budget. The single-sample case
// (user taps without dragging far enough to register a second
// point) falls back to a filled circle so a tap still leaves a
// visible dot.
//
// `shouldRepaint` pessimistically returns `true`. A more efficient
// implementation would compare lengths and identities, but this
// painter is cheap and the host already gates rebuilds through
// `setState`, so always repainting is the simpler and more
// correct contract.
import 'package:flutter/material.dart';

import 'stroke.dart';

class CanvasPainter extends CustomPainter {
  /// Completed strokes, painted bottom-up in the order they were
  /// drawn. The list is owned by the host — the painter must
  /// treat it as read-only.
  final List<Stroke> strokes;

  /// The stroke currently under the user's pointer. `null` when
  /// no drag is active.
  final Stroke? inProgress;

  const CanvasPainter({
    required this.strokes,
    required this.inProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      _paintStroke(canvas, stroke);
    }
    if (inProgress != null && inProgress!.isNotEmpty) {
      _paintStroke(canvas, inProgress!);
    }
  }

  void _paintStroke(Canvas canvas, Stroke stroke) {
    if (stroke.isEmpty) return;

    // One-sample stroke = a single tap. Render as a filled dot so
    // it stays visible.
    if (stroke.points.length == 1) {
      final dotPaint = Paint()
        ..color = stroke.color
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;
      canvas.drawCircle(stroke.points[0], stroke.width / 2, dotPaint);
      return;
    }

    final strokePaint = Paint()
      ..color = stroke.color
      ..strokeWidth = stroke.width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    final path = Path();
    path.moveTo(stroke.points[0].dx, stroke.points[0].dy);
    for (var i = 1; i < stroke.points.length; i++) {
      path.lineTo(stroke.points[i].dx, stroke.points[i].dy);
    }
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) {
    // Repaint unconditionally — the painter is cheap and the host
    // only constructs a new instance when its setState actually
    // moved the underlying state forward.
    return true;
  }
}
