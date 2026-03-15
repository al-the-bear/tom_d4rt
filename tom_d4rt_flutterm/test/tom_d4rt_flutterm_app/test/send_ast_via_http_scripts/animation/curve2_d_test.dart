import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Demonstrates Curve2D - parametric 2D curves that output Offset values.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      // Circle parametric: (cos(2πt), sin(2πt))
      final x = math.cos(t * 2 * math.pi);
      final y = math.sin(t * 2 * math.pi);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Curve2D Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 120, width: 120,
            child: CustomPaint(painter: _Circle2DPainter(progress: t, x: x, y: y)),
          ),
          const SizedBox(height: 12),
          Text('(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          const SizedBox(height: 8),
          const Text('Abstract base for 2D parametric curves', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}

class _Circle2DPainter extends CustomPainter {
  final double progress, x, y;
  _Circle2DPainter({required this.progress, required this.x, required this.y});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    canvas.drawCircle(center, radius, Paint()..color = Colors.blue.withOpacity(0.3)..style = PaintingStyle.stroke..strokeWidth = 2);
    final point = Offset(center.dx + x * radius * 0.9, center.dy + y * radius * 0.9);
    canvas.drawCircle(point, 8, Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant _Circle2DPainter old) => progress != old.progress;
}
