import 'package:flutter/material.dart';

/// Deep visual demo for FabCenterOffsetX - mixin for centering FAB horizontally.
/// Shows how the FAB is positioned at horizontal center.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FabCenterOffsetX', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // Center markers
            Positioned.fill(
              child: CustomPaint(
                painter: _CenterLinePainter(),
              ),
            ),
            // FAB at center
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
            // Label
            const Positioned(
              top: 8,
              left: 8,
              child: Text('offsetX: center', style: TextStyle(fontSize: 9, color: Colors.grey)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Positions FAB at horizontal center', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _CenterLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue.withAlpha(100)..strokeWidth = 1;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
