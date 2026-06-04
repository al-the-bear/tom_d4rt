// CustomPainter drawing every ball as a filled circle on top of a
// faint world-boundary outline. The painter receives world-space
// coordinates and scales them into the canvas size, so the world
// stays a pure model regardless of the on-screen widget size.
import 'package:flutter/material.dart';

import 'world.dart';

/// Stable palette indexed by `Ball.colorIndex`.
const List<Color> kBallPalette = <Color>[
  Color(0xFFEF5350), // red
  Color(0xFF42A5F5), // blue
  Color(0xFF66BB6A), // green
  Color(0xFFFFCA28), // amber
  Color(0xFFAB47BC), // purple
  Color(0xFF26A69A), // teal
];

class BallPainter extends CustomPainter {
  final List<Ball> balls;

  const BallPainter({required this.balls});

  @override
  void paint(Canvas canvas, Size size) {
    // Background panel.
    final bg = Paint()..color = const Color(0xFFF5F5F5);
    canvas.drawRect(Offset.zero & size, bg);

    // World-boundary outline.
    final border = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(Offset.zero & size, border);

    final sx = size.width / kWorldW;
    final sy = size.height / kWorldH;
    for (final b in balls) {
      final p = Paint()..color = kBallPalette[b.colorIndex];
      canvas.drawCircle(
        Offset(b.x * sx, b.y * sy),
        b.radius * sx,
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BallPainter old) {
    // List identity is enough — `home.dart` always rebuilds a fresh
    // list on each step.
    if (!identical(old.balls, balls)) return true;
    if (old.balls.length != balls.length) return true;
    return false;
  }
}
