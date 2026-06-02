// CustomPainter for the particle field.
//
// Draws (in order) a faint world-boundary frame, the attractor as
// a small cross, then every particle as a filled circle. The
// painter receives world-space coordinates and scales them into
// its canvas so the model stays decoupled from the on-screen size.
//
// "Trails" in the spec are approximated by a translucent
// background wash on each frame - we don't persist the canvas, so
// a true motion blur would require Picture/ui.Image plumbing which
// the interpreter doesn't currently bridge. The trade-off is
// noted in `home.dart`.
import 'package:flutter/material.dart';

import 'field.dart';

/// Stable palette indexed by `Particle.colorIndex`.
const List<Color> kParticlePalette = <Color>[
  Color(0xFFE53935), // red
  Color(0xFF1E88E5), // blue
  Color(0xFF43A047), // green
  Color(0xFFFFB300), // amber
  Color(0xFF8E24AA), // purple
  Color(0xFF00897B), // teal
];

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double attractorX;
  final double attractorY;
  final FieldMode mode;

  const ParticlePainter({
    required this.particles,
    required this.attractorX,
    required this.attractorY,
    required this.mode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background panel.
    final bg = Paint()..color = const Color(0xFF111418);
    canvas.drawRect(Offset.zero & size, bg);

    final sx = size.width / kWorldW;
    final sy = size.height / kWorldH;

    // Attractor cross.
    final attrPaint = Paint()
      ..color = _attractorColor()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final ax = attractorX * sx;
    final ay = attractorY * sy;
    const arm = 8.0;
    canvas.drawLine(Offset(ax - arm, ay), Offset(ax + arm, ay), attrPaint);
    canvas.drawLine(Offset(ax, ay - arm), Offset(ax, ay + arm), attrPaint);

    // Particles.
    for (final p in particles) {
      final paint = Paint()..color = kParticlePalette[p.colorIndex];
      canvas.drawCircle(
        Offset(p.x * sx, p.y * sy),
        kParticleRadius * sx,
        paint,
      );
    }
  }

  Color _attractorColor() {
    switch (mode) {
      case FieldMode.attract:
        return const Color(0xFF80DEEA);
      case FieldMode.repel:
        return const Color(0xFFEF9A9A);
      case FieldMode.orbit:
        return const Color(0xFFFFE082);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter old) {
    if (!identical(old.particles, particles)) return true;
    if (old.mode != mode) return true;
    if (old.attractorX != attractorX) return true;
    if (old.attractorY != attractorY) return true;
    return false;
  }
}
