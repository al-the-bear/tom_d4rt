import 'package:flutter/material.dart';

/// Deep visual demo for MaterialPointArcTween.
/// Animates between two points along a circular arc.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialPointArcTween', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: _ArcPainter(),
          child: Stack(
            children: [
              // Start point
              Positioned(
                left: 20,
                top: 80,
                child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: const Center(child: Text('A', style: TextStyle(color: Colors.white, fontSize: 8)))),
              ),
              // End point
              Positioned(
                right: 20,
                top: 20,
                child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: const Center(child: Text('B', style: TextStyle(color: Colors.white, fontSize: 8)))),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      const Text('Arc path between two Offsets', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(28, 88);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.8, size.width - 28, 28);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
