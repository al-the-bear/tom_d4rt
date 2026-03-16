import 'package:flutter/material.dart';

/// Demonstrates CatmullRomCurve - smooth curve through control points.
dynamic build(BuildContext context) {
  final curve = CatmullRomCurve([
    const Offset(0.0, 0.0),
    const Offset(0.25, 0.6),
    const Offset(0.5, 0.2),
    const Offset(0.75, 0.8),
    const Offset(1.0, 1.0),
  ]);

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      final y = curve.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('CatmullRomCurve Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 120, width: 200,
            child: CustomPaint(
              painter: _CurvePainter(curve: curve, progress: t),
            ),
          ),
          const SizedBox(height: 12),
          Text('t=${t.toStringAsFixed(2)} → y=${y.toStringAsFixed(2)}', style: const TextStyle(fontFamily: 'monospace')),
          const SizedBox(height: 8),
          const Text('Smooth spline through control points', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}

class _CurvePainter extends CustomPainter {
  final CatmullRomCurve curve; final double progress;
  _CurvePainter({required this.curve, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (int i = 0; i <= 50; i++) {
      final t = i / 50;
      final y = curve.transform(t);
      final x = t * size.width;
      final py = size.height - y * size.height;
      if (i == 0) path.moveTo(x, py); else path.lineTo(x, py);
    }
    canvas.drawPath(path, Paint()..color = Colors.blue..style = PaintingStyle.stroke..strokeWidth = 2);
    // Progress dot
    final px = progress * size.width;
    final py = size.height - curve.transform(progress) * size.height;
    canvas.drawCircle(Offset(px, py), 6, Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant _CurvePainter old) => progress != old.progress;
}
