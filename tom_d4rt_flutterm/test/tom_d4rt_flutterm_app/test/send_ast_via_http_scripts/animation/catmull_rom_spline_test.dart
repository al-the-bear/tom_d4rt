import 'package:flutter/material.dart';

/// Demonstrates CatmullRomSpline - 2D spline for path animation.
dynamic build(BuildContext context) {
  final spline = CatmullRomSpline([
    const Offset(0.1, 0.5),
    const Offset(0.3, 0.2),
    const Offset(0.5, 0.8),
    const Offset(0.7, 0.3),
    const Offset(0.9, 0.6),
  ]);

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 4),
    builder: (context, t, _) {
      final pos = spline.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('CatmullRomSpline Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 150, width: 200,
            child: CustomPaint(
              painter: _SplinePainter(spline: spline, progress: t, position: pos),
            ),
          ),
          const SizedBox(height: 8),
          Text('Position: (${pos.dx.toStringAsFixed(2)}, ${pos.dy.toStringAsFixed(2)})', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
        ],
      );
    },
  );
}

class _SplinePainter extends CustomPainter {
  final CatmullRomSpline spline; final double progress; final Offset position;
  _SplinePainter({required this.spline, required this.progress, required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw path
    final path = Path();
    for (int i = 0; i <= 50; i++) {
      final p = spline.transform(i / 50);
      final x = p.dx * size.width; final y = p.dy * size.height;
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    canvas.drawPath(path, Paint()..color = Colors.blue.withOpacity(0.5)..style = PaintingStyle.stroke..strokeWidth = 2);
    // Current position
    canvas.drawCircle(Offset(position.dx * size.width, position.dy * size.height), 8, Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant _SplinePainter old) => progress != old.progress;
}
