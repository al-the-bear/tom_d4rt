import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Rect - axis-aligned rectangle.
/// Demonstrates Rect constructors and properties.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Rect Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rect', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _RectPainter(),
              size: const Size(double.infinity, 180),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Constructors:', style: TextStyle(fontWeight: FontWeight.bold)),
          _buildConstructor('fromLTRB', 'left, top, right, bottom'),
          _buildConstructor('fromLTWH', 'left, top, width, height'),
          _buildConstructor('fromCenter', 'center, width, height'),
          _buildConstructor('fromCircle', 'center, radius'),
          _buildConstructor('fromPoints', 'two corners'),
          const SizedBox(height: 16),
          const Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: ['left', 'top', 'right', 'bottom', 'width', 'height', 'center', 'size'].map((p) =>
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                child: Text(p, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)))).toList(),
          ),
        ],
      ),
    ),
  );
}

Widget _buildConstructor(String name, String params) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Text('Rect.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w500)),
      const SizedBox(width: 8),
      Text('($params)', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
    ]),
  );
}

class _RectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(40, 20, 180, 120);
    
    canvas.drawRect(rect, Paint()..color = Colors.blue.withValues(alpha: 0.3));
    canvas.drawRect(rect, Paint()..color = Colors.blue..style = PaintingStyle.stroke..strokeWidth = 2);
    
    // Labels
    void label(String text, Offset pos) {
      final tp = TextPainter(text: TextSpan(text: text, style: const TextStyle(fontSize: 10, color: Colors.blue)), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, pos);
    }
    
    label('left=${rect.left.toInt()}', Offset(rect.left - 35, rect.center.dy));
    label('right=${rect.right.toInt()}', Offset(rect.right + 5, rect.center.dy));
    label('top=${rect.top.toInt()}', Offset(rect.center.dx, rect.top - 15));
    label('bottom=${rect.bottom.toInt()}', Offset(rect.center.dx, rect.bottom + 5));
    canvas.drawCircle(rect.center, 4, Paint()..color = Colors.red);
    label('center', rect.center + const Offset(8, -5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
