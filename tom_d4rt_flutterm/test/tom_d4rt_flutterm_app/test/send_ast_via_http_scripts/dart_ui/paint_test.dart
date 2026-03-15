import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Paint - drawing style configuration.
/// Demonstrates color, strokeWidth, style, and shader properties.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Paint Demo')),
    body: Column(
      children: [
        Expanded(
          flex: 2,
          child: CustomPaint(
            painter: _PaintDemoPainter(),
            size: const Size(double.infinity, double.infinity),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: ListView(
              children: [
                _buildPaintProperty('color', 'Fill or stroke color'),
                _buildPaintProperty('style', 'fill or stroke'),
                _buildPaintProperty('strokeWidth', 'Line thickness'),
                _buildPaintProperty('strokeCap', 'Line end style'),
                _buildPaintProperty('strokeJoin', 'Line corner style'),
                _buildPaintProperty('shader', 'Gradient or image fill'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPaintProperty(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w500)),
        const SizedBox(width: 8),
        Text('- $desc', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    ),
  );
}

class _PaintDemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Fill style
    canvas.drawRect(Rect.fromLTWH(20, 20, 80, 60), Paint()..color = Colors.blue..style = PaintingStyle.fill);
    
    // Stroke style
    canvas.drawRect(Rect.fromLTWH(120, 20, 80, 60), Paint()..color = Colors.green..style = PaintingStyle.stroke..strokeWidth = 4);
    
    // Stroke caps
    canvas.drawLine(const Offset(230, 20), const Offset(230, 80), Paint()..color = Colors.orange..strokeWidth = 8..strokeCap = StrokeCap.round);
    canvas.drawLine(const Offset(260, 20), const Offset(260, 80), Paint()..color = Colors.orange..strokeWidth = 8..strokeCap = StrokeCap.square);
    
    // Gradient shader
    final rect = const Rect.fromLTWH(20, 100, 120, 60);
    canvas.drawRect(rect, Paint()..shader = const LinearGradient(colors: [Colors.purple, Colors.pink]).createShader(rect));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
