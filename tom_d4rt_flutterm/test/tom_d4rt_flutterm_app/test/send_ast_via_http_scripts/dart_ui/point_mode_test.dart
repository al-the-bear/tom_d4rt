import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PointMode - how to draw point lists.
/// Demonstrates points, lines, and polygon modes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointMode Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Point Modes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildModeDemo(PointMode.points, 'points', 'Individual points')),
                const SizedBox(width: 12),
                Expanded(child: _buildModeDemo(PointMode.lines, 'lines', 'Point pairs as lines')),
                const SizedBox(width: 12),
                Expanded(child: _buildModeDemo(PointMode.polygon, 'polygon', 'Connected path')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildModeDemo(PointMode mode, String name, String desc) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        Text('.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        Expanded(
          child: CustomPaint(
            painter: _PointModePainter(mode),
            size: const Size(double.infinity, double.infinity),
          ),
        ),
        Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 10), textAlign: TextAlign.center),
      ],
    ),
  );
}

class _PointModePainter extends CustomPainter {
  final PointMode mode;
  _PointModePainter(this.mode);

  @override
  void paint(Canvas canvas, Size size) {
    final points = <Offset>[
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width * 0.7, size.height * 0.7),
      Offset(size.width * 0.3, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.3),
    ];
    
    canvas.drawPoints(mode, points, Paint()
      ..color = Colors.blue
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
