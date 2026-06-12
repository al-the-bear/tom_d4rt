// CustomPainter for the optimized particle field.
//
// Unlike the original sample's painter (which received plain values and was
// re-created by `setState` on every frame), this painter takes the live
// `ValueListenable<Field>` and registers it as its `repaint:` source. The
// `CustomPaint` widget is therefore built **once**; each tick / hover that
// updates the notifier triggers a repaint of just this painter — the
// interpreted `paint()` re-runs, but **no widget subtree is re-interpreted**.
import 'package:flutter/foundation.dart';
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
  final ValueListenable<Field> field;

  ParticlePainter({required this.field}) : super(repaint: field);

  @override
  void paint(Canvas canvas, Size size) {
    final f = field.value;

    // Background panel.
    final bg = Paint()..color = const Color(0xFF111418);
    canvas.drawRect(Offset.zero & size, bg);

    final sx = size.width / kWorldW;
    final sy = size.height / kWorldH;

    // Attractor cross.
    final attrPaint = Paint()
      ..color = _attractorColor(f.mode)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final ax = f.attractorX * sx;
    final ay = f.attractorY * sy;
    const arm = 8.0;
    canvas.drawLine(Offset(ax - arm, ay), Offset(ax + arm, ay), attrPaint);
    canvas.drawLine(Offset(ax, ay - arm), Offset(ax, ay + arm), attrPaint);

    // Particles.
    for (final p in f.particles) {
      final paint = Paint()..color = kParticlePalette[p.colorIndex];
      canvas.drawCircle(
        Offset(p.x * sx, p.y * sy),
        kParticleRadius * sx,
        paint,
      );
    }
  }

  Color _attractorColor(FieldMode mode) {
    switch (mode) {
      case FieldMode.attract:
        return const Color(0xFF80DEEA);
      case FieldMode.repel:
        return const Color(0xFFEF9A9A);
      case FieldMode.orbit:
        return const Color(0xFFFFE082);
    }
  }

  // Repaint is driven by the `repaint:` listenable, and the painter instance
  // is stable across the single build, so there is nothing to compare here.
  @override
  bool shouldRepaint(covariant ParticlePainter old) => false;
}
