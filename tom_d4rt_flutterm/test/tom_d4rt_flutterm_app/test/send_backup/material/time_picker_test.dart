import 'package:flutter/material.dart';
import 'dart:math';

/// Deep visual demo for TimePicker widget.
/// Material time picker for selecting hours and minutes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TimePicker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 160,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)]),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)),
                  child: const Text('09', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
                const Text(' : ', style: TextStyle(fontSize: 20)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                  child: const Text('45', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade100),
              child: CustomPaint(painter: _TimeClockPainter()),
            ),
          ],
        ),
      ),
    ],
  );
}

class _TimeClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    for (var i = 1; i <= 12; i++) {
      final angle = (i * 30 - 90) * pi / 180;
      final pos = center + Offset(cos(angle) * (radius - 12), sin(angle) * (radius - 12));
      final textPainter = TextPainter(text: TextSpan(text: '\$i', style: TextStyle(fontSize: 10, color: i == 9 ? Colors.white : Colors.black54)), textDirection: TextDirection.ltr);
      textPainter.layout();
      if (i == 9) canvas.drawCircle(pos, 12, Paint()..color = Colors.blue);
      textPainter.paint(canvas, pos - Offset(textPainter.width / 2, textPainter.height / 2));
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
