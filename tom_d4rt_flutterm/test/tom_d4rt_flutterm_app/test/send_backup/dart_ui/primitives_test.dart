import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for primitives in dart:ui.
/// Demonstrates basic geometric primitives and their usage.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Primitives Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('UI Primitives', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: CustomPaint(
              painter: _PrimitivesPainter(),
              size: const Size(double.infinity, double.infinity),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPrimLabel('Rect', Colors.blue),
              _buildPrimLabel('RRect', Colors.green),
              _buildPrimLabel('Offset', Colors.purple),
              _buildPrimLabel('Size', Colors.orange),
              _buildPrimLabel('Color', Colors.red),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildPrimLabel(String name, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
    child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: color, fontWeight: FontWeight.bold)),
  );
}

class _PrimitivesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Rect
    canvas.drawRect(const Rect.fromLTWH(20, 20, 80, 60), Paint()..color = Colors.blue);
    
    // RRect
    canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(120, 20, 80, 60), const Radius.circular(12)), Paint()..color = Colors.green);
    
    // Circle (from Offset and radius)
    canvas.drawCircle(const Offset(260, 50), 30, Paint()..color = Colors.purple);
    
    // Oval (uses Size implicitly)
    canvas.drawOval(const Rect.fromLTWH(20, 100, 100, 60), Paint()..color = Colors.orange);
    
    // Line (between Offsets)
    canvas.drawLine(const Offset(140, 100), const Offset(240, 160), Paint()..color = Colors.red..strokeWidth = 4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
