import 'package:flutter/material.dart';

/// Deep visual demo for GappedRangeSliderTrackShape (M3).
/// Shows track with gap between thumbs.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('GappedRangeSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
              painter: _GappedTrackPainter(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('0', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('20 - - 60', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('100', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('M3 track with gap between thumbs', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _GappedTrackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final inactivePaint = Paint()..color = Colors.grey.shade300..strokeWidth = 4..strokeCap = StrokeCap.round;
    final activePaint = Paint()..color = Colors.blue..strokeWidth = 4..strokeCap = StrokeCap.round;
    final centerY = size.height / 2;
    // Inactive track (left)
    canvas.drawLine(Offset(0, centerY), Offset(size.width * 0.2, centerY), inactivePaint);
    // Active track (with gap)
    canvas.drawLine(Offset(size.width * 0.25, centerY), Offset(size.width * 0.55, centerY), activePaint);
    // Inactive track (right)
    canvas.drawLine(Offset(size.width * 0.6, centerY), Offset(size.width, centerY), inactivePaint);
    // Thumbs
    canvas.drawCircle(Offset(size.width * 0.2, centerY), 10, Paint()..color = Colors.blue);
    canvas.drawCircle(Offset(size.width * 0.6, centerY), 10, Paint()..color = Colors.blue);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
