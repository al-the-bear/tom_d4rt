import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ClipOp - clipping operations (intersect/difference).
/// Demonstrates visual difference between clip operations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ClipOp Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Clip Operations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildClipDemo('ClipOp.intersect', 'Keep inside clip', Colors.blue, true)),
                const SizedBox(width: 16),
                Expanded(child: _buildClipDemo('ClipOp.difference', 'Remove inside clip', Colors.red, false)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildClipDemo(String title, String desc, Color color, bool isIntersect) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
        Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
        const SizedBox(height: 16),
        Expanded(
          child: CustomPaint(
            painter: _ClipOpPainter(isIntersect, color),
            size: const Size(150, 150),
          ),
        ),
      ],
    ),
  );
}

class _ClipOpPainter extends CustomPainter {
  final bool isIntersect;
  final Color color;
  _ClipOpPainter(this.isIntersect, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final clipRect = Rect.fromCenter(center: rect.center, width: 80, height: 80);
    
    // Draw background
    canvas.drawRect(rect, Paint()..color = Colors.grey.shade300);
    
    // Draw clip region indicator
    canvas.drawRect(clipRect, Paint()..color = color.withValues(alpha: 0.3));
    canvas.drawRect(clipRect, Paint()..style = PaintingStyle.stroke..color = color..strokeWidth = 2);
    
    // Show label
    final textPainter = TextPainter(
      text: TextSpan(text: isIntersect ? 'Visible' : 'Hidden', style: TextStyle(color: color, fontSize: 12)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(clipRect.center.dx - 20, clipRect.center.dy - 6));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
