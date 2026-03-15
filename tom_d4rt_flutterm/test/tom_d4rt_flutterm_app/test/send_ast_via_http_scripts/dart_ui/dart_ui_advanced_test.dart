import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for dart:ui advanced features.
/// Demonstrates Canvas, Paint, Path, and other low-level APIs.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('dart:ui Advanced Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('dart:ui APIs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _AdvancedPainter(),
              size: const Size(double.infinity, 200),
            ),
          ),
          const SizedBox(height: 24),
          _buildApiCard('Canvas', 'Drawing surface for 2D graphics', Icons.brush),
          const SizedBox(height: 8),
          _buildApiCard('Paint', 'Style configuration for drawing', Icons.palette),
          const SizedBox(height: 8),
          _buildApiCard('Path', 'Vector shapes and curves', Icons.timeline),
          const SizedBox(height: 8),
          _buildApiCard('Picture', 'Recorded drawing commands', Icons.image),
        ],
      ),
    ),
  );
}

Widget _buildApiCard(String name, String desc, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ],
    ),
  );
}

class _AdvancedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.grey.shade200);
    
    // Circle with gradient
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 60, Paint()..color = Colors.blue..style = PaintingStyle.fill);
    canvas.drawCircle(center, 60, Paint()..color = Colors.blue.shade900..style = PaintingStyle.stroke..strokeWidth = 3);
    
    // Text
    final textPainter = TextPainter(
      text: const TextSpan(text: 'Canvas', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(center.dx - 25, center.dy - 8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
