import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PathFillType - fill rules for paths.
/// Demonstrates nonZero vs evenOdd fill rules.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PathFillType Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Path Fill Types', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildFillDemo(PathFillType.nonZero, 'nonZero', 'Fill based on winding number')),
                const SizedBox(width: 16),
                Expanded(child: _buildFillDemo(PathFillType.evenOdd, 'evenOdd', 'Alternate fill on crossings')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Fill type determines which regions are inside the path for overlapping shapes.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFillDemo(PathFillType fillType, String name, String desc) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        Text('PathFillType.$name', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Expanded(
          child: CustomPaint(
            painter: _FillTypePainter(fillType),
            size: const Size(double.infinity, double.infinity),
          ),
        ),
        const SizedBox(height: 8),
        Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600), textAlign: TextAlign.center),
      ],
    ),
  );
}

class _FillTypePainter extends CustomPainter {
  final PathFillType fillType;
  _FillTypePainter(this.fillType);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..fillType = fillType;
    final center = Offset(size.width / 2, size.height / 2);
    path.addOval(Rect.fromCenter(center: center, width: 100, height: 100));
    path.addOval(Rect.fromCenter(center: center + const Offset(40, 0), width: 80, height: 80));
    
    canvas.drawPath(path, Paint()..color = Colors.blue..style = PaintingStyle.fill);
    canvas.drawPath(path, Paint()..color = Colors.blue.shade900..style = PaintingStyle.stroke..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
