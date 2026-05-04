// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SpringType from package:flutter/physics.dart
// Deep Demo: Visual demonstration of the three SpringType classifications
// (criticallyDamped, underDamped, overDamped) and how SpringDescription
// parameters (mass, stiffness, damping) drive the resulting type. Each
// section is fully static — no controllers, no timers, no setState — and
// uses pre-computed SpringSimulation samples drawn with CustomPaint.
import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// =============================================================================
// Top-level constants — used across multiple sections so they live here.
// =============================================================================

// Time grid used to sample every spring simulation in the file.
const double _kTotalSeconds = 2.5;
const int _kSampleCount = 120;

// Canonical palette per SpringType. Used by every section so the reader can
// build a strong visual association between colour and damping behaviour.
const Color _kUnderColor = Color(0xFFE91E63); // pink — bouncy, oscillates
const Color _kCriticalColor = Color(0xFF4CAF50); // green — perfect settle
const Color _kOverColor = Color(0xFF3F51B5); // indigo — slow, lazy

// Hero gradient — used by the header and footer for symmetry.
const List<Color> _kHeroGradient = [
  Color(0xFF1A237E),
  Color(0xFF311B92),
  Color(0xFF4A148C),
];

// =============================================================================
// Sample container — a tiny value type that records a position-vs-time trace
// produced by a SpringSimulation, plus the descriptive metadata needed to
// render it. We compute these once at the top of build().
// =============================================================================
class _SpringTrace {
  _SpringTrace({
    required this.label,
    required this.description,
    required this.type,
    required this.color,
    required this.points,
    required this.maxAbs,
  });

  final String label;
  final SpringDescription description;
  final SpringType type;
  final Color color;
  final List<Offset> points; // x: t in [0,1], y: position in [-1,1] normalised
  final double maxAbs; // raw max absolute displacement before normalisation
}

// Build a normalised trace by sampling a SpringSimulation at fixed time slices.
// We normalise so every curve fits the same painter rect regardless of energy.
_SpringTrace _buildTrace({
  required String label,
  required SpringDescription description,
  required Color color,
  double startPosition = 1.0,
  double endPosition = 0.0,
  double initialVelocity = 0.0,
}) {
  final SpringSimulation sim = SpringSimulation(
    description,
    startPosition,
    endPosition,
    initialVelocity,
  );
  final SpringType type = sim.type;

  final List<double> raw = <double>[];
  double maxAbs = 0.0;
  for (int i = 0; i < _kSampleCount; i++) {
    final double t = (_kTotalSeconds * i) / (_kSampleCount - 1);
    final double x = sim.x(t) - endPosition; // displacement from rest
    raw.add(x);
    if (x.abs() > maxAbs) maxAbs = x.abs();
  }
  if (maxAbs == 0.0) maxAbs = 1.0;

  final List<Offset> pts = <Offset>[];
  for (int i = 0; i < raw.length; i++) {
    final double tx = i / (raw.length - 1);
    final double ny = raw[i] / maxAbs; // y in [-1, 1]
    pts.add(Offset(tx, ny));
  }
  return _SpringTrace(
    label: label,
    description: description,
    type: type,
    color: color,
    points: pts,
    maxAbs: maxAbs,
  );
}

// =============================================================================
// CustomPainter — draws a single trace into a rect with axes and a guide line.
// =============================================================================
class _TracePainter extends CustomPainter {
  _TracePainter({
    required this.trace,
    this.showAxes = true,
    this.lineWidth = 2.5,
    this.dashed = false,
  });

  final _SpringTrace trace;
  final bool showAxes;
  final double lineWidth;
  final bool dashed;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    // Background grid.
    final Paint gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    for (int i = 0; i <= 4; i++) {
      final double y = rect.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(rect.width, y), gridPaint);
    }
    for (int i = 0; i <= 6; i++) {
      final double x = rect.width * i / 6;
      canvas.drawLine(Offset(x, 0), Offset(x, rect.height), gridPaint);
    }

    if (showAxes) {
      // Rest line at y == midline.
      final Paint axisPaint = Paint()
        ..color = Colors.black54
        ..strokeWidth = 1.0;
      canvas.drawLine(
        Offset(0, rect.height / 2),
        Offset(rect.width, rect.height / 2),
        axisPaint,
      );
    }

    // Plot curve.
    final Path path = Path();
    bool started = false;
    for (final Offset p in trace.points) {
      // p.dx in [0,1], p.dy in [-1,1]; remap to canvas coordinates.
      final double cx = p.dx * rect.width;
      final double cy = rect.height / 2 - p.dy * (rect.height / 2 - 4);
      if (!started) {
        path.moveTo(cx, cy);
        started = true;
      } else {
        path.lineTo(cx, cy);
      }
    }

    final Paint linePaint = Paint()
      ..color = trace.color
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    if (dashed) {
      _drawDashed(canvas, path, linePaint);
    } else {
      canvas.drawPath(path, linePaint);
    }

    // Highlight start dot.
    final Offset first = trace.points.first;
    canvas.drawCircle(
      Offset(
        first.dx * rect.width,
        rect.height / 2 - first.dy * (rect.height / 2 - 4),
      ),
      3.5,
      Paint()..color = trace.color,
    );
  }

  void _drawDashed(Canvas canvas, Path src, Paint paint) {
    const double dashLen = 6.0;
    const double gapLen = 4.0;
    for (final PathMetric metric in src.computeMetrics()) {
      double dist = 0.0;
      while (dist < metric.length) {
        final double end = (dist + dashLen).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(dist, end), paint);
        dist += dashLen + gapLen;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TracePainter old) =>
      old.trace != trace || old.dashed != dashed;
}

// =============================================================================
// CustomPainter — overlays multiple traces in one rect for comparison.
// =============================================================================
class _OverlayPainter extends CustomPainter {
  _OverlayPainter(this.traces);
  final List<_SpringTrace> traces;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    // Background.
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFAFAFA), Color(0xFFEEEEEE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, bg);

    // Grid.
    final Paint gridPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 0.5;
    for (int i = 0; i <= 8; i++) {
      final double y = rect.height * i / 8;
      canvas.drawLine(Offset(0, y), Offset(rect.width, y), gridPaint);
    }
    for (int i = 0; i <= 10; i++) {
      final double x = rect.width * i / 10;
      canvas.drawLine(Offset(x, 0), Offset(x, rect.height), gridPaint);
    }

    // Rest baseline.
    final Paint axisPaint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(0, rect.height / 2),
      Offset(rect.width, rect.height / 2),
      axisPaint,
    );

    // Each trace.
    for (final _SpringTrace tr in traces) {
      final Path p = Path();
      bool started = false;
      for (final Offset pt in tr.points) {
        final double cx = pt.dx * rect.width;
        final double cy = rect.height / 2 - pt.dy * (rect.height / 2 - 6);
        if (!started) {
          p.moveTo(cx, cy);
          started = true;
        } else {
          p.lineTo(cx, cy);
        }
      }
      final Paint linePaint = Paint()
        ..color = tr.color
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(p, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter old) => old.traces != traces;
}

// =============================================================================
// CustomPainter — anatomy of a spring (mass, stiffness, damping).
// =============================================================================
class _AnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    // Wall on the left.
    final Paint wall = Paint()..color = Colors.brown.shade300;
    final Rect wallRect = Rect.fromLTWH(0, rect.height * 0.1, 12, rect.height * 0.8);
    canvas.drawRect(wallRect, wall);
    // Wall hatching.
    final Paint hatch = Paint()
      ..color = Colors.brown.shade700
      ..strokeWidth = 1;
    for (double y = wallRect.top; y < wallRect.bottom; y += 8) {
      canvas.drawLine(Offset(0, y), Offset(-4, y + 6), hatch);
    }

    // Spring coil — drawn as a zigzag path.
    final double springStartX = wallRect.right;
    final double springEndX = rect.width * 0.65;
    final double midY = rect.height * 0.5;
    final Path coil = Path()..moveTo(springStartX, midY);
    const int coilCount = 10;
    final double step = (springEndX - springStartX) / coilCount;
    for (int i = 0; i < coilCount; i++) {
      final double x = springStartX + step * (i + 0.5);
      final double y = midY + (i.isEven ? -14 : 14);
      coil.lineTo(x, y);
    }
    coil.lineTo(springEndX, midY);
    final Paint coilPaint = Paint()
      ..color = _kCriticalColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(coil, coilPaint);

    // Mass block.
    final Rect massRect = Rect.fromLTWH(
      springEndX,
      midY - 24,
      48,
      48,
    );
    final Paint massPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(massRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(massRect, const Radius.circular(6)),
      massPaint,
    );

    // Damper — drawn as a parallel shock absorber below the spring.
    final double damperY = midY + 36;
    final Paint damperPaint = Paint()
      ..color = _kOverColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    // Cylinder.
    final Rect cyl = Rect.fromLTWH(
      springStartX + 8,
      damperY - 7,
      (springEndX - springStartX) * 0.6,
      14,
    );
    canvas.drawRect(cyl, damperPaint);
    // Piston rod going from cylinder to mass.
    canvas.drawLine(
      Offset(cyl.right, damperY),
      Offset(massRect.left, damperY),
      damperPaint,
    );
    // Piston head inside cylinder.
    final Paint piston = Paint()..color = _kOverColor.withValues(alpha: 0.5);
    canvas.drawRect(
      Rect.fromLTWH(cyl.right - 12, cyl.top + 1, 6, cyl.height - 2),
      piston,
    );

    // Labels.
    void drawLabel(String text, Offset pos, Color color) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, pos);
    }

    drawLabel('stiffness (k)', Offset(springStartX + 8, midY - 36), _kCriticalColor);
    drawLabel('damping (c)', Offset(springStartX + 8, damperY + 14), _kOverColor);
    drawLabel('mass (m)', Offset(massRect.left + 2, massRect.bottom + 4),
        const Color(0xFF0D47A1));

    // Equilibrium tick at right.
    final Paint tickPaint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(rect.width - 6, midY - 30),
      Offset(rect.width - 6, midY + 30),
      tickPaint,
    );
    drawLabel('rest', Offset(rect.width - 30, midY - 46), Colors.black54);
  }

  @override
  bool shouldRepaint(covariant _AnatomyPainter old) => false;
}

// =============================================================================
// Tiny painter — discriminant axis showing where the three SpringTypes live.
// =============================================================================
class _DiscriminantPainter extends CustomPainter {
  _DiscriminantPainter(this.markers);
  // markers: list of (zeta, label, color)
  final List<(double, String, Color)> markers;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final double midY = rect.height * 0.55;
    final Paint axis = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(8, midY), Offset(rect.width - 8, midY), axis);

    // ζ ranges shown: 0..2 (visual scale).
    double xFor(double zeta) =>
        8 + (rect.width - 16) * (zeta.clamp(0.0, 2.0) / 2.0);

    // Region shading.
    final Paint underBg = Paint()..color = _kUnderColor.withValues(alpha: 0.12);
    canvas.drawRect(
      Rect.fromLTRB(8, midY - 18, xFor(1.0), midY + 18),
      underBg,
    );
    final Paint critBg = Paint()..color = _kCriticalColor.withValues(alpha: 0.22);
    canvas.drawRect(
      Rect.fromLTRB(xFor(1.0) - 2, midY - 18, xFor(1.0) + 2, midY + 18),
      critBg,
    );
    final Paint overBg = Paint()..color = _kOverColor.withValues(alpha: 0.12);
    canvas.drawRect(
      Rect.fromLTRB(xFor(1.0) + 2, midY - 18, rect.width - 8, midY + 18),
      overBg,
    );

    // Tick at zeta=1.
    final Paint tick = Paint()
      ..color = _kCriticalColor
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(xFor(1.0), midY - 22),
      Offset(xFor(1.0), midY + 22),
      tick,
    );

    void drawText(String text, Offset pos, Color color, double size) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, pos);
    }

    drawText('ζ = 0', Offset(8, midY + 22), Colors.black54, 10);
    drawText('ζ = 1', Offset(xFor(1.0) - 14, midY + 22), _kCriticalColor, 11);
    drawText('ζ = 2', Offset(rect.width - 32, midY + 22), Colors.black54, 10);
    drawText('underDamped', Offset(xFor(0.5) - 36, midY - 36), _kUnderColor, 11);
    drawText('critical', Offset(xFor(1.0) - 18, midY - 36), _kCriticalColor, 11);
    drawText('overDamped', Offset(xFor(1.5) - 32, midY - 36), _kOverColor, 11);

    // Markers.
    for (final (double z, String name, Color c) in markers) {
      final double x = xFor(z);
      canvas.drawCircle(Offset(x, midY), 5, Paint()..color = c);
      canvas.drawCircle(
        Offset(x, midY),
        5,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      );
      drawText(name, Offset(x - 18, midY + 6), c, 9);
    }
  }

  @override
  bool shouldRepaint(covariant _DiscriminantPainter old) =>
      old.markers != markers;
}

// =============================================================================
// build() — single-pass construction of the visual demo.
// =============================================================================
dynamic build(BuildContext context) {
  print('SpringType Deep Demo executing');
  print('Library: package:flutter/physics.dart');
  print('Enum values: ${SpringType.values.map((SpringType v) => v.name).join(", ")}');

  // ---------------------------------------------------------------------------
  // 0. PRECOMPUTE — all simulations run once here so the build tree stays pure.
  // ---------------------------------------------------------------------------
  print('=== Precompute: spring simulations ===');

  // The classic three traces. Same mass and stiffness; only damping changes.
  final _SpringTrace under = _buildTrace(
    label: 'underDamped',
    description: const SpringDescription(mass: 1.0, stiffness: 120.0, damping: 4.0),
    color: _kUnderColor,
  );
  final _SpringTrace critical = _buildTrace(
    label: 'criticallyDamped',
    description: SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 120.0,
    ),
    color: _kCriticalColor,
  );
  final _SpringTrace over = _buildTrace(
    label: 'overDamped',
    description: const SpringDescription(mass: 1.0, stiffness: 120.0, damping: 60.0),
    color: _kOverColor,
  );

  for (final _SpringTrace tr in <_SpringTrace>[under, critical, over]) {
    print(
      '  ${tr.label}: type=${tr.type.name} '
      'mass=${tr.description.mass} '
      'stiffness=${tr.description.stiffness} '
      'damping=${tr.description.damping.toStringAsFixed(2)} '
      'maxAbs=${tr.maxAbs.toStringAsFixed(3)}',
    );
  }

  // Recipe traces (worked examples, used in section 6).
  final _SpringTrace snappy = _buildTrace(
    label: 'snappy menu',
    description: SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 320.0,
      ratio: 0.65,
    ),
    color: _kUnderColor,
  );
  final _SpringTrace soft = _buildTrace(
    label: 'soft reveal',
    description: SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 80.0,
    ),
    color: _kCriticalColor,
  );
  final _SpringTrace settle = _buildTrace(
    label: 'no-overshoot scrollEnd',
    description: SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 140.0,
      ratio: 1.4,
    ),
    color: _kOverColor,
  );

  print('Recipes: ${snappy.type.name}/${soft.type.name}/${settle.type.name}');

  // Edge case traces (section 7). We avoid actually negative damping (which
  // produces an unbounded simulation) — instead we surround the boundary.
  final _SpringTrace tinyDamping = _buildTrace(
    label: 'tiny damping',
    description: const SpringDescription(mass: 1.0, stiffness: 200.0, damping: 0.1),
    color: _kUnderColor,
  );
  final _SpringTrace heavyDamping = _buildTrace(
    label: 'heavy damping',
    description: const SpringDescription(mass: 1.0, stiffness: 200.0, damping: 200.0),
    color: _kOverColor,
  );
  final _SpringTrace heavyMass = _buildTrace(
    label: 'heavy mass',
    description: const SpringDescription(mass: 6.0, stiffness: 120.0, damping: 4.0),
    color: _kUnderColor,
  );

  // ---------------------------------------------------------------------------
  // 1. HERO HEADER
  // ---------------------------------------------------------------------------
  print('=== Section 1: Hero header ===');
  final Widget hero = Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: _kHeroGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: _kUnderColor.withValues(alpha: 0.18),
          blurRadius: 28,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: <Color>[Colors.white, Color(0xFFD1C4E9)],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.4),
                blurRadius: 16,
              ),
            ],
          ),
          child: const Icon(Icons.waves, size: 40, color: Color(0xFF311B92)),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'SpringType',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'package:flutter/physics.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFFB39DDB),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'How a SpringSimulation classifies itself: bounce, perfect '
                'settle, or molasses.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.92),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 2. ANATOMY DIAGRAM
  // ---------------------------------------------------------------------------
  print('=== Section 2: Anatomy ===');
  final Widget anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.amber.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.architecture, color: Colors.deepOrange.shade700),
            const SizedBox(width: 8),
            Text(
              'Anatomy of a SpringDescription',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'A spring is fully described by three numbers. The damping ratio '
          'ζ = c / (2·sqrt(m·k)) decides which SpringType you get.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.brown.shade800,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _AnatomyPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'ζ < 1 → underDamped (overshoots, oscillates)\n'
            'ζ = 1 → criticallyDamped (fastest settle, no overshoot)\n'
            'ζ > 1 → overDamped (slow approach, no overshoot)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 3. PER-VALUE CARDS — one card per SpringType value.
  // ---------------------------------------------------------------------------
  print('=== Section 3: Per-value cards ===');
  Widget buildValueCard(_SpringTrace tr, {
    required String mathIntuition,
    required String realWorld,
  }) {
    print('  card: ${tr.type.name} (label=${tr.label})');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tr.color.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: tr.color.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Card header band.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  tr.color,
                  tr.color.withValues(alpha: 0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    tr.type == SpringType.criticallyDamped
                        ? Icons.adjust
                        : tr.type == SpringType.underDamped
                            ? Icons.graphic_eq
                            : Icons.trending_flat,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'SpringType.${tr.type.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'index ${tr.type.index}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'c=${tr.description.damping.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Body.
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Curve trace.
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: tr.color.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: tr.color.withValues(alpha: 0.25),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomPaint(
                      size: const Size(double.infinity, 110),
                      painter: _TracePainter(trace: tr),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _LabelRow(
                  icon: Icons.functions,
                  title: 'Math intuition',
                  body: mathIntuition,
                  accent: tr.color,
                ),
                const SizedBox(height: 8),
                _LabelRow(
                  icon: Icons.public,
                  title: 'In the wild',
                  body: realWorld,
                  accent: tr.color,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'SpringDescription(\n'
                    '  mass: ${tr.description.mass},\n'
                    '  stiffness: ${tr.description.stiffness},\n'
                    '  damping: ${tr.description.damping.toStringAsFixed(2)},\n'
                    ')',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: tr.color.withValues(alpha: 0.95),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> valueCards = <Widget>[
    buildValueCard(
      under,
      mathIntuition: 'Damping ratio ζ < 1. The system has surplus energy and '
          'crosses the rest line, oscillating with exponentially decaying '
          'amplitude.',
      realWorld: 'Bouncy slide-in panels, playful confirmations, anything '
          'where overshoot is part of the personality.',
    ),
    buildValueCard(
      critical,
      mathIntuition: 'Damping ratio ζ = 1 exactly. The fastest decay possible '
          'without crossing the rest line — a single, smooth approach.',
      realWorld: 'Default Material motion, professional UI affordances, '
          'anything that should feel decisive but never bounce.',
    ),
    buildValueCard(
      over,
      mathIntuition: 'Damping ratio ζ > 1. Two real exponential decays sum '
          'together; motion is monotonic and lazy.',
      realWorld: 'Soft scroll-end clamps, deliberately heavy "magnet" pulls, '
          'modal dismissal where you do not want any rebound.',
    ),
  ];

  // ---------------------------------------------------------------------------
  // 4. SIDE-BY-SIDE COMPARISON OVERLAY
  // ---------------------------------------------------------------------------
  print('=== Section 4: Comparison overlay ===');
  final Widget overlayCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.indigo.shade100, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.compare_arrows, color: Colors.indigo.shade800),
            const SizedBox(width: 8),
            Text(
              'All three damping behaviours, overlaid',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Same mass (1.0) and stiffness (120.0); only damping (c) varies. '
          'Read across to see how SpringType is decided.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.indigo.shade900.withValues(alpha: 0.8),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo.shade200),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: _OverlayPainter(<_SpringTrace>[over, critical, under]),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          runSpacing: 8,
          children: <Widget>[
            _LegendDot(color: _kUnderColor, label: 'underDamped (c=4)'),
            _LegendDot(color: _kCriticalColor, label: 'criticallyDamped (auto)'),
            _LegendDot(color: _kOverColor, label: 'overDamped (c=60)'),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 5. DISCRIMINANT AXIS — where each example sits on the ζ axis.
  // ---------------------------------------------------------------------------
  print('=== Section 5: Discriminant axis ===');
  double zetaOf(SpringDescription d) =>
      d.damping / (2.0 * (d.mass * d.stiffness).abs().toDouble().sqrt());

  // Build the markers using a tiny extension on double declared below.
  final List<(double, String, Color)> markers = <(double, String, Color)>[
    (zetaOf(under.description), 'under', _kUnderColor),
    (zetaOf(critical.description), 'critical', _kCriticalColor),
    (zetaOf(over.description), 'over', _kOverColor),
  ];
  for (final (double z, String n, _) in markers) {
    print('  ζ($n) = ${z.toStringAsFixed(3)}');
  }

  final Widget discriminant = Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.teal.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.straighten, color: Colors.teal.shade800),
            const SizedBox(width: 8),
            Text(
              'Damping ratio ζ → SpringType',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'The whole classification collapses to a single number: '
          'ζ = c / (2·sqrt(m·k)). The boundary lives at exactly 1.0.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.teal.shade900.withValues(alpha: 0.85),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: CustomPaint(
            size: const Size(double.infinity, 110),
            painter: _DiscriminantPainter(markers),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 6. RECIPES — three worked examples, each with the SpringDescription numbers
  //    and the resulting SpringType after running the simulation.
  // ---------------------------------------------------------------------------
  print('=== Section 6: Recipes ===');
  Widget buildRecipe({
    required String title,
    required String useCase,
    required _SpringTrace trace,
    required IconData icon,
  }) {
    print('  recipe $title → ${trace.type.name}');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: trace.color.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: trace.color.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Icon block.
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  trace.color,
                  trace.color.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  useCase,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                // Mini trace.
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: trace.color.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomPaint(
                      size: const Size(double.infinity, 60),
                      painter: _TracePainter(
                        trace: trace,
                        showAxes: true,
                        lineWidth: 1.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: <Widget>[
                    _Chip(
                      label: 'mass ${trace.description.mass}',
                      color: Colors.blueGrey,
                    ),
                    _Chip(
                      label: 'k ${trace.description.stiffness}',
                      color: Colors.deepPurple,
                    ),
                    _Chip(
                      label: 'c ${trace.description.damping.toStringAsFixed(2)}',
                      color: Colors.deepOrange,
                    ),
                    _Chip(
                      label: trace.type.name,
                      color: trace.color,
                      filled: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> recipeCards = <Widget>[
    buildRecipe(
      title: 'Snappy menu drop',
      useCase: 'A dropdown menu that should feel responsive and a touch '
          'playful. Small overshoot communicates "arrived".',
      trace: snappy,
      icon: Icons.menu_open,
    ),
    buildRecipe(
      title: 'Soft reveal modal',
      useCase: 'A modal that slides into place with a single, decisive ease. '
          'No rebound, no second chance.',
      trace: soft,
      icon: Icons.layers,
    ),
    buildRecipe(
      title: 'No-overshoot scroll end',
      useCase: 'When a list snaps to its final offset; bouncing here would '
          'be perceived as an unintended drag.',
      trace: settle,
      icon: Icons.vertical_align_bottom,
    ),
  ];

  // ---------------------------------------------------------------------------
  // 7. EDGE CASES & PITFALLS
  // ---------------------------------------------------------------------------
  print('=== Section 7: Edge cases ===');
  Widget buildEdgeRow(_SpringTrace tr, String note) {
    print('  edge ${tr.label}: type=${tr.type.name}');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 90,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomPaint(
                size: const Size(90, 50),
                painter: _TracePainter(
                  trace: tr,
                  showAxes: true,
                  lineWidth: 1.6,
                  dashed: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tr.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  note,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: tr.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'type → SpringType.${tr.type.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      color: tr.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget edgeCases = Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.red.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber, color: Colors.red.shade700),
            const SizedBox(width: 8),
            Text(
              'Edge cases & pitfalls',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Some inputs to SpringDescription do not produce sensible motion. '
          'Even if the simulation runs, the SpringType may not be what you '
          'expected.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.red.shade900.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        buildEdgeRow(
          tinyDamping,
          'damping → 0 means ζ → 0: oscillation rings forever. '
          'Type still classifies as underDamped.',
        ),
        buildEdgeRow(
          heavyDamping,
          'damping ≫ 2·sqrt(m·k) drives ζ ≫ 1. The mass crawls toward rest; '
          'overDamped is a deliberate choice, not a default.',
        ),
        buildEdgeRow(
          heavyMass,
          'Increasing mass without raising damping shifts ζ down — even a '
          '"normally damped" spring becomes underDamped on a heavier object.',
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Negative damping or zero mass is ill-defined and should be '
            'guarded at the call site. Flutter does not validate these for '
            'you — the simulation may NaN, run forever, or invert.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 8. ENUM REFERENCE TABLE
  // ---------------------------------------------------------------------------
  print('=== Section 8: Enum reference ===');
  final Widget enumTable = Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.list_alt, color: Colors.cyan.shade300),
            const SizedBox(width: 8),
            Text(
              'SpringType.values',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final SpringType t in SpringType.values)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                left: BorderSide(
                  color: t == SpringType.criticallyDamped
                      ? _kCriticalColor
                      : t == SpringType.underDamped
                          ? _kUnderColor
                          : _kOverColor,
                  width: 4,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 32,
                  child: Text(
                    '${t.index}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.amber.shade300,
                      fontSize: 13,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    t.name,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  t == SpringType.underDamped
                      ? 'ζ < 1'
                      : t == SpringType.criticallyDamped
                          ? 'ζ = 1'
                          : 'ζ > 1',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.greenAccent.shade200,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '// Read the type after constructing the simulation:\n'
            'final sim = SpringSimulation(desc, 1.0, 0.0, 0.0);\n'
            'final SpringType t = sim.type;\n'
            'print(t.name); // e.g. "criticallyDamped"',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.lightGreenAccent.shade100,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 9. CODE & TAKE-AWAYS
  // ---------------------------------------------------------------------------
  print('=== Section 9: Code & take-aways ===');
  final Widget codeBlock = Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1B1B2F),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.3),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.purpleAccent.shade100),
            const SizedBox(width: 8),
            Text(
              'Wiring it up',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.purpleAccent.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _CodeSnippet(
          color: Colors.cyanAccent.shade100,
          code: '// Pick by intent, not by number\n'
              'final desc = SpringDescription.withDampingRatio(\n'
              '  mass: 1.0,\n'
              '  stiffness: 200.0,\n'
              '  ratio: 0.7, // playful overshoot → underDamped\n'
              ');',
        ),
        const SizedBox(height: 8),
        _CodeSnippet(
          color: Colors.greenAccent.shade100,
          code: '// Drive any AnimationController via SpringSimulation\n'
              'controller.animateWith(\n'
              '  SpringSimulation(desc, 0.0, 1.0, 0.0),\n'
              ');',
        ),
        const SizedBox(height: 8),
        _CodeSnippet(
          color: Colors.amberAccent.shade100,
          code: '// SpringType is computed eagerly in the constructor\n'
              'final sim = SpringSimulation(desc, 0.0, 1.0, 0.0);\n'
              'switch (sim.type) {\n'
              '  case SpringType.criticallyDamped: /* default UI motion */\n'
              '  case SpringType.underDamped:      /* allow overshoot */\n'
              '  case SpringType.overDamped:       /* lazy settle */\n'
              '}',
        ),
      ],
    ),
  );

  // Take-away strip — three coloured bullets summarising the lesson.
  final Widget takeaways = Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.green.shade50, Colors.lightGreen.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.shade200),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.lightbulb, color: Colors.green.shade700),
            const SizedBox(width: 8),
            Text(
              'Take-aways',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const _Bullet(
          color: _kUnderColor,
          text: 'Want personality? Pick ζ < 1 (underDamped). Expect overshoot.',
        ),
        const _Bullet(
          color: _kCriticalColor,
          text: 'Want decisive? Pick ζ = 1 (criticallyDamped). Default Material feel.',
        ),
        const _Bullet(
          color: _kOverColor,
          text: 'Want heavy/lazy? Pick ζ > 1 (overDamped). No bounce, no sparkle.',
        ),
        const SizedBox(height: 6),
        Text(
          'SpringType is the read-out of a decision you already made when '
          'you chose mass, stiffness, and damping. It is not a setting.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.green.shade900,
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 10. FOOTER
  // ---------------------------------------------------------------------------
  print('=== Section 10: Footer ===');
  const String filePath =
      'tom_d4rt_flutter_ast/test/.../physics/spring_type_test.dart';
  final Widget footer = Container(
    margin: const EdgeInsets.only(top: 16),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: _kHeroGradient,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '+----------------------------------------------+\n'
          '|  SpringType deep demo — flutter/physics      |\n'
          '|  3 values · 9 sections · static traces only  |\n'
          '+----------------------------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Colors.white,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          filePath,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      ],
    ),
  );

  print('SpringType Deep Demo build complete');

  // ---------------------------------------------------------------------------
  // FINAL TREE
  // ---------------------------------------------------------------------------
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        hero,
        const SizedBox(height: 18),
        const _SectionTitle(
          number: '1',
          title: 'Anatomy of a SpringDescription',
          subtitle: 'mass · stiffness · damping → SpringType',
        ),
        anatomy,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '2',
          title: 'The three values, one card each',
          subtitle: 'definition, math intuition, real-world example, trace',
        ),
        ...valueCards,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '3',
          title: 'Side-by-side comparison',
          subtitle: 'all three behaviours, same axes, overlaid',
        ),
        overlayCard,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '4',
          title: 'Where each lives on the ζ axis',
          subtitle: 'one number decides everything',
        ),
        discriminant,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '5',
          title: 'How to tune — three recipes',
          subtitle: 'numbers + the SpringType you will get',
        ),
        ...recipeCards,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '6',
          title: 'Edge cases & pitfalls',
          subtitle: 'when SpringType surprises you',
        ),
        edgeCases,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '7',
          title: 'SpringType.values reference',
          subtitle: 'index, name, ζ region',
        ),
        enumTable,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '8',
          title: 'Wiring it up in real code',
          subtitle: 'snippets you can paste into a controller',
        ),
        codeBlock,
        const SizedBox(height: 8),
        const _SectionTitle(
          number: '9',
          title: 'Take-aways',
          subtitle: 'pick by intent, read the type',
        ),
        takeaways,
        footer,
      ],
    ),
  );
}

// =============================================================================
// Helper widgets — small, reusable atoms.
// =============================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF311B92), Color(0xFF4A148C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  const _LabelRow({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 18, color: accent),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(fontSize: 12.5, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.color,
    this.filled = false,
  });
  final String label;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: filled ? color : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.5,
          color: filled ? Colors.white : color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet({required this.code, required this.color});
  final String code;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }
}

// =============================================================================
// Tiny extension — sqrt without importing dart:math at the top of the file.
// =============================================================================
extension _DoubleSqrt on double {
  double sqrt() {
    // Newton's method, plenty good for our display ζ values.
    if (this <= 0) return 0;
    double x = this;
    for (int i = 0; i < 20; i++) {
      x = 0.5 * (x + this / x);
    }
    return x;
  }
}
