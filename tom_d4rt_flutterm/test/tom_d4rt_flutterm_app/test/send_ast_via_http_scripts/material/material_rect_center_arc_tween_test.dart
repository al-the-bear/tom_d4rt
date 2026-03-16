import 'package:flutter/material.dart';

/// Deep visual demo for MaterialRectCenterArcTween.
/// Animates Rect by moving its center along an arc.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialRectCenterArcTween', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Arc path
            CustomPaint(size: const Size(200, 120), painter: _CenterArcPainter()),
            // Start rect
            Positioned(
              left: 20,
              top: 70,
              child: Container(width: 30, height: 30,
                decoration: BoxDecoration(color: Colors.blue.withAlpha(150), border: Border.all(color: Colors.blue, width: 2)),
                child: const Center(child: Icon(Icons.crop_square, size: 14)),
              ),
            ),
            // End rect
            Positioned(
              right: 20,
              top: 20,
              child: Container(width: 50, height: 50,
                decoration: BoxDecoration(color: Colors.green.withAlpha(150), border: Border.all(color: Colors.green, width: 2)),
                child: const Center(child: Icon(Icons.crop_square, size: 20)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Center follows arc, size interpolates', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _CenterArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.orange..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path()..moveTo(35, 85)..quadraticBezierTo(100, 100, 155, 45);
    canvas.drawPath(path, paint);
    canvas.drawCircle(const Offset(35, 85), 4, Paint()..color = Colors.blue);
    canvas.drawCircle(const Offset(155, 45), 4, Paint()..color = Colors.green);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
