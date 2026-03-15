import 'package:flutter/material.dart';

/// Demonstrates Cubic - cubic Bezier curve defined by 4 control points.
dynamic build(BuildContext context) {
  const cubic = Cubic(0.25, 0.1, 0.25, 1.0); // ease-out like

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, t, _) {
      final y = cubic.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Cubic Bezier Curve', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100, width: 200,
            child: CustomPaint(painter: _CubicPainter(cubic: cubic, progress: t)),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Cubic(0.25, 0.1, 0.25, 1.0)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: Offset((t - 0.5) * 150, 0),
            child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.purple, shape: BoxShape.circle)),
          ),
        ],
      );
    },
  );
}

class _CubicPainter extends CustomPainter {
  final Cubic cubic; final double progress;
  _CubicPainter({required this.cubic, required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (int i = 0; i <= 50; i++) {
      final t = i / 50;
      final y = cubic.transform(t);
      if (i == 0) path.moveTo(0, size.height - y * size.height);
      else path.lineTo(t * size.width, size.height - y * size.height);
    }
    canvas.drawPath(path, Paint()..color = Colors.purple..style = PaintingStyle.stroke..strokeWidth = 2);
    canvas.drawCircle(Offset(progress * size.width, size.height - cubic.transform(progress) * size.height), 5, Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant _CubicPainter old) => progress != old.progress;
}
