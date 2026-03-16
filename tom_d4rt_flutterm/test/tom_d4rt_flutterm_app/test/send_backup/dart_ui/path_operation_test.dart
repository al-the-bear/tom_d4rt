import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PathOperation - boolean path operations.
/// Demonstrates union, intersect, xor, difference operations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PathOperation Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Path Operations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                _buildOpDemo(PathOperation.union, 'union', 'Combine both shapes'),
                _buildOpDemo(PathOperation.intersect, 'intersect', 'Common area only'),
                _buildOpDemo(PathOperation.xor, 'xor', 'Non-overlapping areas'),
                _buildOpDemo(PathOperation.difference, 'difference', 'First minus second'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOpDemo(PathOperation op, String name, String desc) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        Text('.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
        Expanded(child: CustomPaint(painter: _PathOpPainter(op), size: const Size(double.infinity, double.infinity))),
        Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
      ],
    ),
  );
}

class _PathOpPainter extends CustomPainter {
  final PathOperation op;
  _PathOpPainter(this.op);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final path1 = Path()..addOval(Rect.fromCenter(center: c - const Offset(15, 0), width: 50, height: 50));
    final path2 = Path()..addOval(Rect.fromCenter(center: c + const Offset(15, 0), width: 50, height: 50));
    
    final result = Path.combine(op, path1, path2);
    
    canvas.drawPath(path1, Paint()..color = Colors.blue.withValues(alpha: 0.2)..style = PaintingStyle.fill);
    canvas.drawPath(path2, Paint()..color = Colors.green.withValues(alpha: 0.2)..style = PaintingStyle.fill);
    canvas.drawPath(result, Paint()..color = Colors.purple..style = PaintingStyle.stroke..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
