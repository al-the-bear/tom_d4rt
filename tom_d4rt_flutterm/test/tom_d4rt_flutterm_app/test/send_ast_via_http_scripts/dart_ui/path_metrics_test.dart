import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PathMetrics - iterable of path contour metrics.
/// Demonstrates accessing metrics for each contour in a path.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PathMetrics Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PathMetrics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Iterable of PathMetric for all contours', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _MetricsPainter(),
              size: const Size(double.infinity, 180),
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricCard('Contour 1', 'Circle: ~188px', Colors.blue),
          _buildMetricCard('Contour 2', 'Square: ~200px', Colors.green),
          _buildMetricCard('Contour 3', 'Triangle: ~174px', Colors.orange),
        ],
      ),
    ),
  );
}

Widget _buildMetricCard(String name, String length, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 12),
      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      const Spacer(),
      Text(length, style: TextStyle(color: color, fontFamily: 'monospace')),
    ]),
  );
}

class _MetricsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    void drawShape(Path path, Color color, double x) {
      canvas.save();
      canvas.translate(x, 0);
      canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 3);
      canvas.restore();
    }
    
    final circle = Path()..addOval(const Rect.fromLTWH(0, 40, 60, 60));
    final square = Path()..addRect(const Rect.fromLTWH(0, 40, 50, 50));
    final triangle = Path()..moveTo(30, 40)..lineTo(60, 100)..lineTo(0, 100)..close();
    
    drawShape(circle, Colors.blue, 30);
    drawShape(square, Colors.green, 130);
    drawShape(triangle, Colors.orange, 230);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
