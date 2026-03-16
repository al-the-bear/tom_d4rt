import 'package:flutter/material.dart';
import 'dart:math';

/// Deep visual demo for showTimePicker function.
/// Shows a Material time picker dialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showTimePicker()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)]),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Select time', style: TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)),
                  child: const Text('10', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
                const Text(' : ', style: TextStyle(fontSize: 24)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                  child: const Text('30', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('AM', style: TextStyle(fontSize: 10, color: Colors.blue))),
                    const SizedBox(height: 2),
                    const Text('PM', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: CustomPaint(painter: _ClockPainter()),
            ),
          ],
        ),
      ),
    ],
  );
}

class _ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    for (var i = 1; i <= 12; i++) {
      final angle = (i * 30 - 90) * pi / 180;
      final pos = center + Offset(cos(angle) * (radius - 12), sin(angle) * (radius - 12));
      final textPainter = TextPainter(text: TextSpan(text: '\$i', style: TextStyle(fontSize: 10, color: i == 10 ? Colors.white : Colors.black54)), textDirection: TextDirection.ltr);
      textPainter.layout();
      if (i == 10) {
        canvas.drawCircle(pos, 12, Paint()..color = Colors.blue);
      }
      textPainter.paint(canvas, pos - Offset(textPainter.width / 2, textPainter.height / 2));
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
