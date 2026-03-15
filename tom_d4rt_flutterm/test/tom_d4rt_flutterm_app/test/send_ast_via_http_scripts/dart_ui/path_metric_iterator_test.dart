import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PathMetricIterator - iterates path contours.
/// Demonstrates iteration over path metrics.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PathMetricIterator Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PathMetricIterator', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Iterates through path contours', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _PathIteratorPainter(),
              size: const Size(double.infinity, 200),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('final metrics = path.computeMetrics();', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('for (PathMetric metric in metrics) {', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('  // Each contour in the path', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('}', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _PathIteratorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [Colors.red, Colors.green, Colors.blue];
    
    // Draw 3 separate contours
    for (int i = 0; i < 3; i++) {
      final path = Path()
        ..addOval(Rect.fromCenter(center: Offset(60 + i * 100, size.height / 2), width: 60, height: 60));
      canvas.drawPath(path, Paint()..color = colors[i]..style = PaintingStyle.stroke..strokeWidth = 4);
      
      final tp = TextPainter(
        text: TextSpan(text: 'Contour ${i + 1}', style: TextStyle(fontSize: 10, color: colors[i])),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(35 + i * 100, size.height / 2 + 40));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
