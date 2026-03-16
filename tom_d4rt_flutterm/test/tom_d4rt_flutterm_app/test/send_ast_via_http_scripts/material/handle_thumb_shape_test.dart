import 'package:flutter/material.dart';

/// Deep visual demo for HandleSliderThumbShape (M3).
/// Shows handle-style thumb for single slider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Handle Slider Thumb', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Track with handle thumb
            CustomPaint(
              size: const Size(160, 40),
              painter: _HandleThumbPainter(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('0', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('60', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('100', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('M3 vertical handle thumb', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _HandleThumbPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()..color = Colors.grey.shade300..strokeWidth = 4..strokeCap = StrokeCap.round;
    final activePaint = Paint()..color = Colors.blue..strokeWidth = 4..strokeCap = StrokeCap.round;
    final centerY = size.height / 2;
    final thumbX = size.width * 0.6;
    canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), trackPaint);
    canvas.drawLine(Offset(0, centerY), Offset(thumbX, centerY), activePaint);
    // Handle thumb
    final handlePaint = Paint()..color = Colors.blue;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(thumbX, centerY), width: 8, height: 28), const Radius.circular(4)), handlePaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
