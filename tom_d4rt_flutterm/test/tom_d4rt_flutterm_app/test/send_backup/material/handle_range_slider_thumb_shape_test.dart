import 'package:flutter/material.dart';

/// Deep visual demo for HandleRangeSliderThumbShape (M3).
/// Shows handle-style thumbs for range slider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Handle Range Thumb', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Track with handle thumbs
            CustomPaint(
              size: const Size(160, 40),
              painter: _HandleRangeThumbPainter(),
            ),
            const SizedBox(height: 8),
            const Text('Handle-shaped thumbs', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThumbStyle('Round', false),
          const SizedBox(width: 16),
          _ThumbStyle('Handle', true),
        ],
      ),
    ],
  );
}

class _ThumbStyle extends StatelessWidget {
  final String label;
  final bool isHandle;
  const _ThumbStyle(this.label, this.isHandle);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isHandle ? 8 : 20,
          height: isHandle ? 28 : 20,
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(isHandle ? 4 : 10)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class _HandleRangeThumbPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()..color = Colors.grey.shade300..strokeWidth = 4..strokeCap = StrokeCap.round;
    final activePaint = Paint()..color = Colors.blue..strokeWidth = 4..strokeCap = StrokeCap.round;
    final centerY = size.height / 2;
    canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), trackPaint);
    canvas.drawLine(Offset(size.width * 0.3, centerY), Offset(size.width * 0.7, centerY), activePaint);
    // Handle thumbs
    final handlePaint = Paint()..color = Colors.blue;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.3, centerY), width: 8, height: 24), const Radius.circular(4)), handlePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.7, centerY), width: 8, height: 24), const Radius.circular(4)), handlePaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
