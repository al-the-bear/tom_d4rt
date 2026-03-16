import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Offset - 2D point/vector.
/// Demonstrates offset operations and usage.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Offset Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Offset', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _OffsetPainter(),
              size: const Size(double.infinity, 200),
            ),
          ),
          const SizedBox(height: 24),
          _buildOffsetOp('Offset(10, 20)', 'Create from dx, dy'),
          _buildOffsetOp('Offset.fromDirection(angle, dist)', 'Polar coordinates'),
          _buildOffsetOp('offset1 + offset2', 'Add offsets'),
          _buildOffsetOp('offset1 - offset2', 'Subtract offsets'),
          _buildOffsetOp('offset * factor', 'Scale offset'),
          _buildOffsetOp('offset.distance', 'Distance from origin'),
          _buildOffsetOp('offset.direction', 'Angle from x-axis'),
        ],
      ),
    ),
  );
}

Widget _buildOffsetOp(String code, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Expanded(child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
        Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
      ],
    ),
  );
}

class _OffsetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw axes
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), Paint()..color = Colors.grey.shade400);
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), Paint()..color = Colors.grey.shade400);
    
    // Draw point
    final point = center + const Offset(80, -50);
    canvas.drawCircle(point, 8, Paint()..color = Colors.blue);
    canvas.drawLine(center, point, Paint()..color = Colors.blue..strokeWidth = 2);
    
    final tp = TextPainter(text: const TextSpan(text: 'Offset(80, -50)', style: TextStyle(fontSize: 11, color: Colors.blue)), textDirection: TextDirection.ltr)..layout();
    tp.paint(canvas, point + const Offset(10, -20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
