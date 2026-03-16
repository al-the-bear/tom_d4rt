import 'package:flutter/material.dart';

/// Demonstrates ThreePointCubic - cubic curve through 3 points.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, t, _) {
      // Simple 3-point curve approximation
      final y = t < 0.5 ? 2 * t * t : 1 - 2 * (1 - t) * (1 - t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ThreePointCubic Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100, width: 200,
            child: CustomPaint(painter: _ThreePointPainter(progress: t, value: y)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PointChip('P1', '(0,0)', Colors.blue),
              const SizedBox(width: 8),
              _PointChip('Mid', '(0.5, y)', Colors.purple),
              const SizedBox(width: 8),
              _PointChip('P2', '(1,1)', Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Smooth curve through 3 control points', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}

class _PointChip extends StatelessWidget {
  final String label, coord; final Color color;
  const _PointChip(this.label, this.coord, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
    child: Column(
      children: [Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)), Text(coord, style: const TextStyle(fontSize: 8))],
    ),
  );
}

class _ThreePointPainter extends CustomPainter {
  final double progress, value;
  _ThreePointPainter({required this.progress, required this.value});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (int i = 0; i <= 50; i++) {
      final t = i / 50;
      final y = t < 0.5 ? 2 * t * t : 1 - 2 * (1 - t) * (1 - t);
      if (i == 0) path.moveTo(0, size.height - y * size.height);
      else path.lineTo(t * size.width, size.height - y * size.height);
    }
    canvas.drawPath(path, Paint()..color = Colors.purple..style = PaintingStyle.stroke..strokeWidth = 2);
    canvas.drawCircle(Offset(progress * size.width, size.height - value * size.height), 6, Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant _ThreePointPainter old) => progress != old.progress;
}
