import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Geometry - geometric primitives in dart:ui.
/// Demonstrates Offset, Size, Rect, RRect, and Radius.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Geometry Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Geometric Primitives', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _GeometryPainter(),
              size: const Size(double.infinity, 200),
            ),
          ),
          const SizedBox(height: 24),
          _buildGeometryCard('Offset', 'Point in 2D space', 'Offset(10, 20)', Colors.blue),
          _buildGeometryCard('Size', 'Width and height', 'Size(100, 50)', Colors.green),
          _buildGeometryCard('Rect', 'Rectangle bounds', 'Rect.fromLTWH(...)', Colors.orange),
          _buildGeometryCard('RRect', 'Rounded rectangle', 'RRect.fromRectAndRadius(...)', Colors.purple),
          _buildGeometryCard('Radius', 'Corner radius', 'Radius.circular(8)', Colors.red),
        ],
      ),
    ),
  );
}

Widget _buildGeometryCard(String name, String desc, String example, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border(left: BorderSide(color: color, width: 4)), color: color.withValues(alpha: 0.1)),
    child: Row(
      children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.category, color: Colors.white)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              Text(example, style: const TextStyle(fontFamily: 'monospace', fontSize: 10)),
            ],
          ),
        ),
      ],
    ),
  );
}

class _GeometryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Rect
    canvas.drawRect(Rect.fromLTWH(10, 10, 80, 60), Paint()..color = Colors.blue.withValues(alpha: 0.5));
    canvas.drawRect(Rect.fromLTWH(10, 10, 80, 60), Paint()..color = Colors.blue..style = PaintingStyle.stroke..strokeWidth = 2);
    
    // RRect
    canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(110, 10, 80, 60), const Radius.circular(12)), Paint()..color = Colors.green.withValues(alpha: 0.5));
    
    // Circle (from center Offset)
    canvas.drawCircle(const Offset(260, 40), 30, Paint()..color = Colors.orange.withValues(alpha: 0.5));
    
    // Point
    canvas.drawCircle(const Offset(50, 130), 6, Paint()..color = Colors.red);
    final tp = TextPainter(text: const TextSpan(text: 'Offset(50, 130)', style: TextStyle(fontSize: 10)), textDirection: TextDirection.ltr)..layout();
    tp.paint(canvas, const Offset(65, 125));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
