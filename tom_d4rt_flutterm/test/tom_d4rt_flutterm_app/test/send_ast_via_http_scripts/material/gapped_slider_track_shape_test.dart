import 'package:flutter/material.dart';

/// Deep visual demo for GappedSliderTrackShape (M3).
/// Shows single slider track with gap at thumb.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('GappedSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Gapped track visualization
            CustomPaint(
              size: const Size(180, 24),
              painter: _GappedSliderTrackPainter(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('0', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('Value: 40', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('100', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('M3 track with gap around thumb', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _GappedSliderTrackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final inactivePaint = Paint()..color = Colors.grey.shade300..strokeWidth = 4..strokeCap = StrokeCap.round;
    final activePaint = Paint()..color = Colors.blue..strokeWidth = 4..strokeCap = StrokeCap.round;
    final centerY = size.height / 2;
    final thumbX = size.width * 0.4;
    // Active track (left of thumb with gap)
    canvas.drawLine(Offset(0, centerY), Offset(thumbX - 10, centerY), activePaint);
    // Inactive track (right of thumb with gap)
    canvas.drawLine(Offset(thumbX + 10, centerY), Offset(size.width, centerY), inactivePaint);
    // Thumb
    canvas.drawCircle(Offset(thumbX, centerY), 10, Paint()..color = Colors.blue);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
