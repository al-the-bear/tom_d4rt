import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for dart:ui Paint and Canvas operations.
/// Demonstrates drawing with Paint styles and Canvas methods.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Paint & Canvas Demo')),
    body: Column(
      children: [
        Expanded(
          flex: 2,
          child: CustomPaint(
            painter: _PaintCanvasPainter(),
            size: const Size(double.infinity, double.infinity),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                _buildStyleChip('Fill', Colors.blue),
                _buildStyleChip('Stroke', Colors.green),
                _buildStyleChip('Gradient', Colors.orange),
                _buildStyleChip('Shadow', Colors.purple),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStyleChip(String label, Color color) {
  return Container(
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))),
  );
}

class _PaintCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()..color = Colors.blue..style = PaintingStyle.fill;
    final strokePaint = Paint()..color = Colors.green..style = PaintingStyle.stroke..strokeWidth = 4;
    
    canvas.drawRect(Rect.fromLTWH(20, 20, 100, 60), fillPaint);
    canvas.drawRect(Rect.fromLTWH(140, 20, 100, 60), strokePaint);
    canvas.drawCircle(Offset(70, 130), 40, fillPaint);
    canvas.drawOval(Rect.fromLTWH(140, 100, 100, 60), strokePaint);
    
    final path = Path()
      ..moveTo(20, 200)
      ..lineTo(70, 240)
      ..lineTo(120, 200)
      ..close();
    canvas.drawPath(path, Paint()..color = Colors.orange);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
