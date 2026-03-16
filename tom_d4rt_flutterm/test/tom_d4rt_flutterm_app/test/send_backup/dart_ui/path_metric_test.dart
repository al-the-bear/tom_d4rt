import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PathMetric - measurements along path.
/// Demonstrates path length, position, and tangent queries.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PathMetric Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PathMetric', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _PathMetricPainter(),
              size: const Size(double.infinity, 200),
            ),
          ),
          const SizedBox(height: 24),
          _buildProp('length', 'Total length of contour'),
          _buildProp('isClosed', 'Whether contour is closed'),
          _buildProp('contourIndex', 'Index in path'),
          _buildProp('getTangentForOffset(d)', 'Position & direction at distance'),
          _buildProp('extractPath(start, end)', 'Extract sub-path'),
        ],
      ),
    ),
  );
}

Widget _buildProp(String name, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(6)),
    child: Row(children: [
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w500)),
      const SizedBox(width: 12),
      Expanded(child: Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey.shade700))),
    ]),
  );
}

class _PathMetricPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(20, size.height / 2)
      ..quadraticBezierTo(size.width / 2, 20, size.width - 20, size.height / 2);
    
    canvas.drawPath(path, Paint()..color = Colors.grey.shade400..style = PaintingStyle.stroke..strokeWidth = 3);
    
    final metric = path.computeMetrics().first;
    
    // Draw points along path
    for (double d = 0; d <= metric.length; d += metric.length / 8) {
      final tangent = metric.getTangentForOffset(d);
      if (tangent != null) {
        canvas.drawCircle(tangent.position, 6, Paint()..color = Colors.purple);
      }
    }
    
    // Label
    final tp = TextPainter(text: TextSpan(text: 'Length: ${metric.length.toInt()}px', style: const TextStyle(fontSize: 12)), textDirection: TextDirection.ltr)..layout();
    tp.paint(canvas, Offset(20, size.height - 30));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
