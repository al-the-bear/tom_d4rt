import 'package:flutter/material.dart';

/// Deep visual demo for TextSelectionToolbarAnchors class.
/// Anchor positions for text selection toolbar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextSelectionToolbarAnchors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            const Positioned(left: 20, top: 50, child: Text('Hello ', style: TextStyle(fontSize: 12))),
            Positioned(
              left: 60,
              top: 50,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: Colors.blue.shade100,
                child: const Text('World', style: TextStyle(fontSize: 12)),
              ),
            ),
            Positioned(
              left: 40,
              top: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Cut', style: TextStyle(color: Colors.white, fontSize: 10)),
                    SizedBox(width: 8),
                    Text('Copy', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 68,
              top: 28,
              child: CustomPaint(
                painter: _ArrowPainter(),
                size: const Size(8, 8),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('primaryAnchor, secondaryAnchor', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey.shade800;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
