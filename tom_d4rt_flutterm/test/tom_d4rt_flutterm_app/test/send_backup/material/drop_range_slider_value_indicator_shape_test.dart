import 'package:flutter/material.dart';

/// Deep visual demo for DropRangeSliderValueIndicatorShape - drop-shaped value indicators.
/// Shows the teardrop indicator shape for range sliders.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Drop Range Slider Indicator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // Slider visualization
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Value indicators (drops)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DropIndicator(25, Colors.blue),
                const SizedBox(width: 60),
                _DropIndicator(75, Colors.blue),
              ],
            ),
            const SizedBox(height: 8),
            // Track with thumbs
            Container(
              height: 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                  Positioned(left: 40, right: 40, child: Container(height: 4, color: Colors.blue)),
                  Positioned(left: 35, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
                  Positioned(right: 35, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Teardrop shape points to thumb', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DropIndicator extends StatelessWidget {
  final int value;
  final Color color;
  const _DropIndicator(this.value, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          child: Text('$value', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        CustomPaint(
          size: const Size(10, 6),
          painter: _TrianglePainter(color),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
