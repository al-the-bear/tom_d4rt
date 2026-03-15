import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PaintingStyle - fill vs stroke painting.
/// Demonstrates visual difference between fill and stroke.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PaintingStyle Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Painting Styles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildStyleDemo(PaintingStyle.fill, 'fill', 'Fills the interior', Colors.blue)),
                const SizedBox(width: 24),
                Expanded(child: _buildStyleDemo(PaintingStyle.stroke, 'stroke', 'Draws the outline', Colors.green)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStyleDemo(PaintingStyle style, String name, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5), width: 2), borderRadius: BorderRadius.circular(16)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          painter: _StylePainter(style, color),
          size: const Size(120, 120),
        ),
        const SizedBox(height: 16),
        Text('PaintingStyle.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        Text(desc, style: TextStyle(color: Colors.grey.shade600)),
      ],
    ),
  );
}

class _StylePainter extends CustomPainter {
  final PaintingStyle style;
  final Color color;
  _StylePainter(this.style, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = style..strokeWidth = 6;
    
    canvas.drawRect(Rect.fromLTWH(10, 10, size.width - 20, size.height - 20), paint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
