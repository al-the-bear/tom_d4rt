import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Deep visual demo for Velocity class.
/// Shows velocity vector representation.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Velocity')),
    body: Center(child: _VelocityDemo()),
  );
}

class _VelocityDemo extends StatefulWidget {
  @override
  State<_VelocityDemo> createState() => _VelocityDemoState();
}

class _VelocityDemoState extends State<_VelocityDemo> {
  Offset _velocity = Offset.zero;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Drag to see velocity vector', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        GestureDetector(
          onPanStart: (_) => setState(() => _isDragging = true),
          onPanUpdate: (d) => setState(() => _velocity = d.delta * 10),
          onPanEnd: (d) => setState(() {
            _isDragging = false;
            _velocity = d.velocity.pixelsPerSecond / 100;
          }),
          child: Container(
            width: 250, height: 250,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(
              painter: _VectorPainter(_velocity, _isDragging),
              child: const Center(child: Icon(Icons.add, color: Colors.grey)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Text('Velocity(dx: \${_velocity.dx.toStringAsFixed(1)}, dy: \${_velocity.dy.toStringAsFixed(1)})'),
              const SizedBox(height: 4),
              Text('Magnitude: \${_velocity.distance.toStringAsFixed(1)} px/s'),
            ],
          ),
        ),
      ],
    );
  }
}

class _VectorPainter extends CustomPainter {
  final Offset velocity;
  final bool isDragging;
  _VectorPainter(this.velocity, this.isDragging);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final end = center + velocity.scale(0.5, 0.5);
    final paint = Paint()..color = isDragging ? Colors.orange : Colors.blue..strokeWidth = 3..strokeCap = StrokeCap.round;
    canvas.drawLine(center, end, paint);
    // Arrow head
    if (velocity.distance > 10) {
      final angle = velocity.direction;
      final arrowPaint = Paint()..color = paint.color..style = PaintingStyle.fill;
      final path = Path();
      path.moveTo(end.dx, end.dy);
      path.lineTo(end.dx - 10 * math.cos(angle - 0.4), end.dy - 10 * math.sin(angle - 0.4));
      path.lineTo(end.dx - 10 * math.cos(angle + 0.4), end.dy - 10 * math.sin(angle + 0.4));
      path.close();
      canvas.drawPath(path, arrowPaint);
    }
  }
  @override
  bool shouldRepaint(covariant _VectorPainter old) => old.velocity != velocity;
}
