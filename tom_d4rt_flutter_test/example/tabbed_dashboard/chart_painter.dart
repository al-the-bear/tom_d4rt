// CustomPainter for the Chart tab.
//
// Draws a polyline of the supplied `values` rescaled to fit the
// canvas vertically. Min/max are recomputed each paint so a single
// outlier doesn't flatten the rest of the line into a horizontal
// stripe.
import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter {
  final List<double> values;
  const ChartPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAFAFA);
    canvas.drawRect(Offset.zero & size, bg);
    if (values.isEmpty) return;

    double maxV = values[0];
    double minV = values[0];
    for (int i = 1; i < values.length; i += 1) {
      final double v = values[i];
      if (v > maxV) maxV = v;
      if (v < minV) minV = v;
    }
    // Guard against a degenerate range (all points equal).
    final double span = maxV - minV;
    final double range = span.abs() < 0.0001 ? 1.0 : span;

    final Paint linePaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final Path path = Path();
    final int n = values.length;
    for (int i = 0; i < n; i += 1) {
      final double t = n == 1 ? 0.5 : (i / (n - 1));
      final double x = t * size.width;
      final double norm = (values[i] - minV) / range;
      final double y = size.height - (norm * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(ChartPainter old) =>
      old.values != values || old.values.length != values.length;
}
