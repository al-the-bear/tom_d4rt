import 'package:flutter/material.dart';

/// Demonstrates RectTween - interpolates between two rectangles.
dynamic build(BuildContext context) {
  final tween = RectTween(
    begin: const Rect.fromLTWH(0, 0, 50, 50),
    end: const Rect.fromLTWH(100, 50, 150, 100),
  );

  return TweenAnimationBuilder<Rect?>(
    tween: tween,
    duration: const Duration(seconds: 2),
    builder: (context, rect, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('RectTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        SizedBox(
          height: 180, width: 280,
          child: CustomPaint(painter: _RectPainter(rect: rect)),
        ),
        const SizedBox(height: 8),
        Text('L:${rect!.left.toInt()} T:${rect.top.toInt()} W:${rect.width.toInt()} H:${rect.height.toInt()}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      ],
    ),
  );
}

class _RectPainter extends CustomPainter {
  final Rect? rect;
  _RectPainter({required this.rect});
  @override
  void paint(Canvas canvas, Size size) {
    if (rect == null) return;
    // Draw begin rect outline
    canvas.drawRect(const Rect.fromLTWH(0, 0, 50, 50), Paint()..color = Colors.blue.withOpacity(0.3)..style = PaintingStyle.stroke..strokeWidth = 2);
    // Draw end rect outline
    canvas.drawRect(const Rect.fromLTWH(100, 50, 150, 100), Paint()..color = Colors.orange.withOpacity(0.3)..style = PaintingStyle.stroke..strokeWidth = 2);
    // Draw current rect
    canvas.drawRect(rect!, Paint()..color = Colors.purple);
  }
  @override
  bool shouldRepaint(covariant _RectPainter old) => rect != old.rect;
}
