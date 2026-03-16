import 'package:flutter/material.dart';

/// Deep visual demo for DropSliderValueIndicatorShape - drop-shaped value indicator.
/// Shows the teardrop indicator for single slider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Drop Slider Indicator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Drop indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
              child: const Text('50', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            CustomPaint(
              size: const Size(12, 8),
              painter: _DropPainter(Colors.green),
            ),
            const SizedBox(height: 4),
            // Slider track
            Container(
              height: 30,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(widthFactor: 0.5, child: Container(height: 4, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(2)))),
                  ),
                  Positioned(
                    left: 90,
                    child: Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Shows value in drop-shaped bubble', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DropPainter extends CustomPainter {
  final Color color;
  _DropPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..moveTo(0, 0)..lineTo(size.width / 2, size.height)..lineTo(size.width, 0)..close();
    canvas.drawPath(path, Paint()..color = color);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
