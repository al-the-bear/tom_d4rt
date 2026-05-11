// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// D4rt test script: Deep visual dossier for SpringDescription from
// package:flutter/physics.dart.  A hand-authored, scrolling, build-time-only
// laboratory that pre-computes SpringSimulation trajectories and renders the
// resulting curves through CustomPaint.  No timers, no controllers, no
// stateful widgets --- every pixel is determined by static math evaluated in
// the build() pass.
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// ---------------------------------------------------------------------------
// Data model: a single time/value/velocity sample produced by simulating a
// SpringSimulation at a fixed step.  We use this everywhere a CustomPainter
// needs to draw a curve --- it keeps all the physics work in build() instead
// of inside paint() which must stay cheap and deterministic.
// ---------------------------------------------------------------------------
class _SpringSample {
  const _SpringSample(this.t, this.x, this.v);
  final double t;
  final double x;
  final double v;
}

class _Trace {
  const _Trace({
    required this.label,
    required this.color,
    required this.samples,
    this.dashed = false,
  });
  final String label;
  final Color color;
  final List<_SpringSample> samples;
  final bool dashed;
}

// ---------------------------------------------------------------------------
// Helper: pull <count> equally spaced samples from a SpringSimulation across
// the time window [0, duration].  This is the canonical way to ask a
// Flutter Simulation what it would do without actually running an Animation.
// ---------------------------------------------------------------------------
List<_SpringSample> _sampleSpring(
  SpringSimulation sim,
  double duration,
  int count,
) {
  final List<_SpringSample> out = <_SpringSample>[];
  for (int i = 0; i < count; i++) {
    final double t = duration * (i / (count - 1));
    out.add(_SpringSample(t, sim.x(t), sim.dx(t)));
  }
  return out;
}

// Same idea for FrictionSimulation / GravitySimulation --- accept any
// Simulation and probe it.
List<_SpringSample> _sampleAny(
  Simulation sim,
  double duration,
  int count,
) {
  final List<_SpringSample> out = <_SpringSample>[];
  for (int i = 0; i < count; i++) {
    final double t = duration * (i / (count - 1));
    out.add(_SpringSample(t, sim.x(t), sim.dx(t)));
  }
  return out;
}

// ---------------------------------------------------------------------------
// Painter: draws a stack of traces against shared x/y axes.  The bounds are
// computed automatically from the data; an optional <target> line marks the
// rest position of the spring (where x(t) -> end).
// ---------------------------------------------------------------------------
class _CurvePainter extends CustomPainter {
  _CurvePainter({
    required this.traces,
    required this.tMin,
    required this.tMax,
    required this.yMin,
    required this.yMax,
    this.target,
    this.gridColor = const Color(0xFFE2E8F0),
    this.axisColor = const Color(0xFF475569),
    this.targetColor = const Color(0xFFEF4444),
    this.background,
    this.showGrid = true,
    this.showAxes = true,
  });

  final List<_Trace> traces;
  final double tMin;
  final double tMax;
  final double yMin;
  final double yMax;
  final double? target;
  final Color gridColor;
  final Color axisColor;
  final Color targetColor;
  final Color? background;
  final bool showGrid;
  final bool showAxes;

  Offset _mapPoint(double t, double y, Size size, EdgeInsets pad) {
    final double w = size.width - pad.left - pad.right;
    final double h = size.height - pad.top - pad.bottom;
    final double nx = (t - tMin) / (tMax - tMin);
    final double ny = (y - yMin) / (yMax - yMin);
    final double px = pad.left + nx * w;
    final double py = pad.top + (1.0 - ny) * h;
    return Offset(px, py);
  }

  @override
  void paint(Canvas canvas, Size size) {
    const EdgeInsets pad = EdgeInsets.fromLTRB(28.0, 12.0, 12.0, 22.0);
    final Rect plotRect = Rect.fromLTWH(
      pad.left,
      pad.top,
      size.width - pad.left - pad.right,
      size.height - pad.top - pad.bottom,
    );

    if (background != null) {
      final Paint bg = Paint()..color = background!;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          const Radius.circular(8.0),
        ),
        bg,
      );
    }

    if (showGrid) {
      final Paint gridPaint = Paint()
        ..color = gridColor
        ..strokeWidth = 1.0;
      for (int i = 0; i <= 5; i++) {
        final double y = plotRect.top + plotRect.height * (i / 5.0);
        canvas.drawLine(
          Offset(plotRect.left, y),
          Offset(plotRect.right, y),
          gridPaint,
        );
      }
      for (int i = 0; i <= 6; i++) {
        final double x = plotRect.left + plotRect.width * (i / 6.0);
        canvas.drawLine(
          Offset(x, plotRect.top),
          Offset(x, plotRect.bottom),
          gridPaint,
        );
      }
    }

    if (target != null && target! >= yMin && target! <= yMax) {
      final Paint targetPaint = Paint()
        ..color = targetColor.withValues(alpha: 0.6)
        ..strokeWidth = 1.4;
      final Offset a = _mapPoint(tMin, target!, size, pad);
      final Offset b = _mapPoint(tMax, target!, size, pad);
      const double dashWidth = 5.0;
      const double dashGap = 4.0;
      double dx = b.dx - a.dx;
      double dy = b.dy - a.dy;
      double dist = math.sqrt(dx * dx + dy * dy);
      double steps = dist / (dashWidth + dashGap);
      for (double s = 0.0; s < steps; s += 1.0) {
        final double t0 = s / steps;
        final double t1 = math.min(1.0, (s + dashWidth / (dashWidth + dashGap)) / steps);
        canvas.drawLine(
          Offset(a.dx + dx * t0, a.dy + dy * t0),
          Offset(a.dx + dx * t1, a.dy + dy * t1),
          targetPaint,
        );
      }
    }

    if (showAxes) {
      final Paint axisPaint = Paint()
        ..color = axisColor
        ..strokeWidth = 1.2;
      canvas.drawLine(
        Offset(plotRect.left, plotRect.top),
        Offset(plotRect.left, plotRect.bottom),
        axisPaint,
      );
      canvas.drawLine(
        Offset(plotRect.left, plotRect.bottom),
        Offset(plotRect.right, plotRect.bottom),
        axisPaint,
      );
      // zero baseline if it falls inside the y range
      if (yMin < 0.0 && yMax > 0.0) {
        final Offset z0 = _mapPoint(tMin, 0.0, size, pad);
        final Offset z1 = _mapPoint(tMax, 0.0, size, pad);
        final Paint zeroPaint = Paint()
          ..color = axisColor.withValues(alpha: 0.4)
          ..strokeWidth = 1.0;
        canvas.drawLine(z0, z1, zeroPaint);
      }
    }

    for (final _Trace trace in traces) {
      final Paint linePaint = Paint()
        ..color = trace.color
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      if (trace.samples.length < 2) {
        continue;
      }
      if (!trace.dashed) {
        final Path p = Path();
        final Offset first = _mapPoint(
          trace.samples.first.t,
          trace.samples.first.x,
          size,
          pad,
        );
        p.moveTo(first.dx, first.dy);
        for (int i = 1; i < trace.samples.length; i++) {
          final Offset pt = _mapPoint(
            trace.samples[i].t,
            trace.samples[i].x,
            size,
            pad,
          );
          p.lineTo(pt.dx, pt.dy);
        }
        canvas.drawPath(p, linePaint);
      } else {
        for (int i = 1; i < trace.samples.length; i++) {
          if (i.isEven) {
            continue;
          }
          final Offset a = _mapPoint(
            trace.samples[i - 1].t,
            trace.samples[i - 1].x,
            size,
            pad,
          );
          final Offset b = _mapPoint(
            trace.samples[i].t,
            trace.samples[i].x,
            size,
            pad,
          );
          canvas.drawLine(a, b, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CurvePainter old) {
    return old.traces != traces ||
        old.tMin != tMin ||
        old.tMax != tMax ||
        old.yMin != yMin ||
        old.yMax != yMax ||
        old.target != target;
  }
}

// ---------------------------------------------------------------------------
// A tiny painter for a single mini-curve --- used in matrix cells where we
// want a thumbnail of a spring's behavior without axes or grid clutter.
// ---------------------------------------------------------------------------
class _ThumbnailPainter extends CustomPainter {
  _ThumbnailPainter({
    required this.samples,
    required this.yMin,
    required this.yMax,
    required this.color,
    this.background = const Color(0xFFF8FAFC),
    this.target = 1.0,
  });

  final List<_SpringSample> samples;
  final double yMin;
  final double yMax;
  final Color color;
  final Color background;
  final double target;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bg = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bg, const Radius.circular(6.0)),
      Paint()..color = background,
    );
    if (samples.length < 2) {
      return;
    }
    final double tMin = samples.first.t;
    final double tMax = samples.last.t;
    Offset map(double t, double y) {
      final double nx = (t - tMin) / (tMax - tMin);
      final double ny = (y - yMin) / (yMax - yMin);
      return Offset(4.0 + nx * (size.width - 8.0),
          size.height - 4.0 - ny * (size.height - 8.0));
    }

    // Target dashed line
    final Paint targetPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.0;
    final Offset ta = map(tMin, target);
    final Offset tb = map(tMax, target);
    for (double x = ta.dx; x < tb.dx; x += 6.0) {
      canvas.drawLine(
        Offset(x, ta.dy),
        Offset(math.min(x + 3.0, tb.dx), tb.dy),
        targetPaint,
      );
    }

    final Path p = Path();
    final Offset first = map(samples.first.t, samples.first.x);
    p.moveTo(first.dx, first.dy);
    for (int i = 1; i < samples.length; i++) {
      final Offset pt = map(samples[i].t, samples[i].x);
      p.lineTo(pt.dx, pt.dy);
    }
    canvas.drawPath(
      p,
      Paint()
        ..color = color
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ThumbnailPainter old) {
    return old.samples != samples ||
        old.color != color ||
        old.yMin != yMin ||
        old.yMax != yMax;
  }
}

// ---------------------------------------------------------------------------
// A painter for the spring anatomy diagram: a stylised coil between two
// fixed mounts, drawn with sinusoidal zig-zag.  Static --- the geometry
// depends only on the rest length and the number of coils we pick.
// ---------------------------------------------------------------------------
class _SpringCoilPainter extends CustomPainter {
  _SpringCoilPainter({
    this.coils = 8,
    this.amplitude = 12.0,
    this.color = const Color(0xFF1E40AF),
    this.mountColor = const Color(0xFF334155),
    this.stretch = 1.0,
  });

  final int coils;
  final double amplitude;
  final Color color;
  final Color mountColor;
  final double stretch;

  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height / 2.0;
    final double leftX = 8.0;
    final double rightX = size.width - 8.0;
    final double span = (rightX - leftX) * stretch;
    final double actualRight = leftX + span;

    // Left mount
    final Paint mountPaint = Paint()..color = mountColor;
    canvas.drawRect(
      Rect.fromLTWH(0.0, midY - 22.0, 6.0, 44.0),
      mountPaint,
    );

    // Right mount
    canvas.drawRect(
      Rect.fromLTWH(size.width - 6.0, midY - 22.0, 6.0, 44.0),
      mountPaint,
    );

    // Spring coil: zig-zag using sin
    final Paint coilPaint = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Path coilPath = Path();
    const int segments = 120;
    for (int i = 0; i <= segments; i++) {
      final double f = i / segments;
      final double x = leftX + f * (actualRight - leftX);
      final double phase = f * coils * 2.0 * math.pi;
      final double y = midY + math.sin(phase) * amplitude;
      if (i == 0) {
        coilPath.moveTo(x, y);
      } else {
        coilPath.lineTo(x, y);
      }
    }
    canvas.drawPath(coilPath, coilPaint);

    // Mass block riding on the right end of the coil
    final Paint massPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.fill;
    final Paint massBorder = Paint()
      ..color = const Color(0xFFB45309)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Rect massRect = Rect.fromCenter(
      center: Offset(actualRight, midY),
      width: 28.0,
      height: 28.0,
    );
    final RRect massRRect =
        RRect.fromRectAndRadius(massRect, const Radius.circular(5.0));
    canvas.drawRRect(massRRect, massPaint);
    canvas.drawRRect(massRRect, massBorder);
  }

  @override
  bool shouldRepaint(covariant _SpringCoilPainter old) {
    return old.coils != coils ||
        old.amplitude != amplitude ||
        old.color != color ||
        old.stretch != stretch;
  }
}

// ---------------------------------------------------------------------------
// Helper widgets: little reusable cards that keep build() readable below.
// ---------------------------------------------------------------------------
Widget _paramChip(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: color,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    ),
  );
}

Widget _equationBox(String text, Color color) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        color: color,
        height: 1.5,
      ),
    ),
  );
}

Widget _sectionTitle(
  String number,
  String title,
  String subtitle,
  Color color,
  IconData icon,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[color, color.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.35),
                blurRadius: 8.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 24.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    number,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    height: 1.0,
                    width: 30.0,
                    color: color.withValues(alpha: 0.5),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13.0,
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

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 4.0,
            ),
          ],
        ),
      ),
      const SizedBox(width: 6.0),
      Text(
        label,
        style: const TextStyle(fontSize: 11.5, color: Color(0xFF334155)),
      ),
    ],
  );
}

Widget _glossaryEntry(String term, String def, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 4.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                term,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: accent.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                def,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF475569),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallTile(IconData icon, String title, String body, Color color) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      border: Border.all(color: color.withValues(alpha: 0.4)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF334155),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _statTile(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            color: color.withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 3.0),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// build(): the entire dossier.  All physics is computed here; no callbacks,
// no timers --- everything is laid out flat.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('SpringDescription Deep Demo executing');
  print('=' * 64);
  // Sanity log via foundation.debugPrint so the import earns its keep.
  debugPrint('[springdescription] kReleaseMode=$kReleaseMode');

  // --------------------------------------------------------------
  // PRELUDE: build the canonical reference springs and sample them.
  // --------------------------------------------------------------
  print('=== Prelude: hero spring and sampling ===');

  // Hero spring: mass = 1 kg, stiffness = 100 N/m, damping = 10 Nsm.
  // omega_n = sqrt(100/1) = 10 rad/s.  Critical damping coefficient =
  // 2*sqrt(mass*stiffness) = 2*sqrt(100) = 20.  So damping = 10 means
  // ratio = 10/20 = 0.5 --- under-damped, bouncy.
  final SpringDescription heroSpring = SpringDescription(
    mass: 1.0,
    stiffness: 100.0,
    damping: 10.0,
  );
  print('Hero spring: mass=${heroSpring.mass}, '
      'stiffness=${heroSpring.stiffness}, damping=${heroSpring.damping}');

  final SpringDescription critical = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.0,
  );
  final SpringDescription under = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 0.4,
  );
  final SpringDescription over = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.8,
  );

  print('Critical damping coefficient (ratio=1.0): ${critical.damping}');
  print('Under-damped (ratio=0.4): ${under.damping}');
  print('Over-damped (ratio=1.8): ${over.damping}');

  // Spring simulations: from x=0 to x=1, no initial velocity.
  final SpringSimulation heroSim =
      SpringSimulation(heroSpring, 0.0, 1.0, 0.0);
  final SpringSimulation criticalSim =
      SpringSimulation(critical, 0.0, 1.0, 0.0);
  final SpringSimulation underSim =
      SpringSimulation(under, 0.0, 1.0, 0.0);
  final SpringSimulation overSim = SpringSimulation(over, 0.0, 1.0, 0.0);

  final List<_SpringSample> heroSamples = _sampleSpring(heroSim, 3.0, 220);
  final List<_SpringSample> criticalSamples =
      _sampleSpring(criticalSim, 3.0, 220);
  final List<_SpringSample> underSamples = _sampleSpring(underSim, 3.0, 220);
  final List<_SpringSample> overSamples = _sampleSpring(overSim, 3.0, 220);

  for (int i = 0; i < 6; i++) {
    final double t = i * 0.5;
    print('hero t=${t.toStringAsFixed(2)} -> '
        'x=${heroSim.x(t).toStringAsFixed(4)} '
        'dx=${heroSim.dx(t).toStringAsFixed(4)}');
  }

  // --------------------------------------------------------------
  // SECTION 1: hero header
  // --------------------------------------------------------------
  print('=== Section 1: Hero header ===');
  final Widget hero = Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E3A8A),
          Color(0xFF6D28D9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.5),
          blurRadius: 24.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: <Color>[Color(0xFFFBBF24), Color(0xFFB45309)],
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.55),
                    blurRadius: 26.0,
                    spreadRadius: 4.0,
                  ),
                ],
              ),
              child: const Icon(Icons.waves, color: Colors.white, size: 38.0),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'SpringDescription',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Hooke\u2019s Atelier --- a static laboratory of mass, '
                    'stiffness and damping',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.amber.shade200,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: const Text(
            'A SpringDescription bundles the three numbers that fully define '
            'a one-dimensional simple harmonic oscillator under viscous '
            'damping: the mass riding on the spring, the spring\u2019s '
            'stiffness, and the damping coefficient that opposes velocity. '
            'Feed one into a SpringSimulation (or its scroll-aware sibling '
            'ScrollSpringSimulation) and Flutter\u2019s physics package will '
            'play back the resulting motion at any time t.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _paramChip('mass', '1.0 kg', Colors.amberAccent),
            _paramChip('stiffness', '100 N/m', Colors.lightBlueAccent),
            _paramChip('damping', '10 N\u00B7s/m', Colors.pinkAccent),
            _paramChip('\u03C9\u2099', '10 rad/s', Colors.greenAccent),
            _paramChip('\u03B6', '0.5 (under)', Colors.deepOrangeAccent),
          ],
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 2: anatomy --- the three params and the withDampingRatio
  // derived formula.
  // --------------------------------------------------------------
  print('=== Section 2: Anatomy ===');
  final Widget anatomyDiagram = Container(
    height: 130.0,
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFCBD5E1)),
    ),
    child: CustomPaint(
      painter: _SpringCoilPainter(
        coils: 10,
        amplitude: 14.0,
        color: const Color(0xFF1D4ED8),
        stretch: 1.0,
      ),
      child: const SizedBox.expand(),
    ),
  );

  final Widget anatomy = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'SpringDescription(mass:, stiffness:, damping:)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Three positive doubles fully describe a damped 1-D oscillator. '
          'No animation lives inside the description itself --- it is a '
          'pure data carrier that is consumed by a Simulation.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
        anatomyDiagram,
        Wrap(
          spacing: 12.0,
          runSpacing: 10.0,
          children: <Widget>[
            _statTile('mass (kg)', '${heroSpring.mass}', Colors.amber.shade700),
            _statTile(
              'stiffness (N/m)',
              '${heroSpring.stiffness}',
              Colors.blue.shade700,
            ),
            _statTile(
              'damping (N\u00B7s/m)',
              '${heroSpring.damping}',
              Colors.pink.shade700,
            ),
            _statTile(
              '\u03C9\u2099 = \u221A(k/m)',
              math.sqrt(heroSpring.stiffness / heroSpring.mass)
                  .toStringAsFixed(3),
              Colors.green.shade700,
            ),
            _statTile(
              'c_crit = 2\u221A(km)',
              (2.0 *
                      math.sqrt(heroSpring.mass * heroSpring.stiffness))
                  .toStringAsFixed(3),
              Colors.deepPurple.shade700,
            ),
            _statTile(
              '\u03B6 = c / c_crit',
              (heroSpring.damping /
                      (2.0 *
                          math.sqrt(heroSpring.mass * heroSpring.stiffness)))
                  .toStringAsFixed(3),
              Colors.red.shade700,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _equationBox(
          'SpringDescription.withDampingRatio(\n'
          '    mass: m, stiffness: k, ratio: \u03B6,\n'
          ')\n'
          '  // derives damping = \u03B6 \u00B7 2 \u00B7 \u221A(m\u00B7k)',
          const Color(0xFF7C3AED),
        ),
        const SizedBox(height: 8.0),
        _equationBox(
          'Equation of motion (damped harmonic oscillator):\n'
          '  m\u00B7\u1E8D + c\u00B7\u1E8B + k\u00B7x = 0\n'
          '  \u03C9\u2099 = \u221A(k/m)         (natural frequency)\n'
          '  \u03B6   = c / (2\u00B7\u221A(m\u00B7k))   (damping ratio)\n'
          '  \u03C9_d = \u03C9\u2099\u00B7\u221A(1 - \u03B6\u00B2)   (damped frequency)',
          const Color(0xFF0F766E),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 3: critically/over/under damped gallery
  // --------------------------------------------------------------
  print('=== Section 3: Damping gallery ===');

  final List<_Trace> dampingGalleryTraces = <_Trace>[
    _Trace(
      label: 'under-damped (\u03B6 = 0.4)',
      color: const Color(0xFFEC4899),
      samples: underSamples,
    ),
    _Trace(
      label: 'critical (\u03B6 = 1.0)',
      color: const Color(0xFF22C55E),
      samples: criticalSamples,
    ),
    _Trace(
      label: 'over-damped (\u03B6 = 1.8)',
      color: const Color(0xFF3B82F6),
      samples: overSamples,
    ),
  ];

  double galleryYMin = -0.5;
  double galleryYMax = 1.6;
  for (final _Trace t in dampingGalleryTraces) {
    for (final _SpringSample s in t.samples) {
      if (s.x < galleryYMin) galleryYMin = s.x - 0.05;
      if (s.x > galleryYMax) galleryYMax = s.x + 0.05;
    }
  }

  final Widget dampingGallery = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Three regimes of damping',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'All three springs share mass = 1 kg and stiffness = 100 N/m. '
          'Only the damping ratio \u03B6 changes.  The dashed red line marks '
          'the rest position x = 1.0.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 260.0,
          child: CustomPaint(
            painter: _CurvePainter(
              traces: dampingGalleryTraces,
              tMin: 0.0,
              tMax: 3.0,
              yMin: galleryYMin,
              yMax: galleryYMax,
              target: 1.0,
              background: const Color(0xFFF8FAFC),
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 8.0,
          children: <Widget>[
            _legendDot(const Color(0xFFEC4899), 'under-damped (oscillates)'),
            _legendDot(const Color(0xFF22C55E), 'critical (fastest no-overshoot)'),
            _legendDot(const Color(0xFF3B82F6), 'over-damped (slow approach)'),
            _legendDot(const Color(0xFFEF4444), 'rest position'),
          ],
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 4: stiffness matrix --- five stiffness values, fixed mass
  // and damping ratio.  Each cell shows a thumbnail curve.
  // --------------------------------------------------------------
  print('=== Section 4: Stiffness matrix ===');
  final List<double> stiffnessValues = <double>[10.0, 50.0, 100.0, 200.0, 500.0];
  final List<Color> stiffnessColors = <Color>[
    const Color(0xFFFCA5A5),
    const Color(0xFFFB923C),
    const Color(0xFFFACC15),
    const Color(0xFF22C55E),
    const Color(0xFF3B82F6),
  ];
  final List<Widget> stiffnessTiles = <Widget>[];
  for (int i = 0; i < stiffnessValues.length; i++) {
    final double k = stiffnessValues[i];
    final SpringDescription desc = SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: k,
      ratio: 0.4,
    );
    final SpringSimulation sim = SpringSimulation(desc, 0.0, 1.0, 0.0);
    final List<_SpringSample> samples = _sampleSpring(sim, 4.0, 180);
    double yMin = 0.0;
    double yMax = 1.6;
    for (final _SpringSample s in samples) {
      if (s.x < yMin) yMin = s.x;
      if (s.x > yMax) yMax = s.x;
    }
    print('stiffness k=$k -> '
        '\u03C9\u2099=${math.sqrt(k).toStringAsFixed(3)} '
        'c=${desc.damping.toStringAsFixed(3)}');
    stiffnessTiles.add(
      Container(
        width: 175.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: stiffnessColors[i].withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: stiffnessColors[i],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Text(
                  'k = ${k.toStringAsFixed(0)} N/m',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            SizedBox(
              height: 70.0,
              child: CustomPaint(
                painter: _ThumbnailPainter(
                  samples: samples,
                  yMin: yMin - 0.05,
                  yMax: yMax + 0.05,
                  color: stiffnessColors[i],
                ),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              '\u03C9\u2099 = ${math.sqrt(k).toStringAsFixed(2)} rad/s\n'
              'c   = ${desc.damping.toStringAsFixed(2)} N\u00B7s/m',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget stiffnessMatrix = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFEF3C7).withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFDE68A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Stiffness matrix (mass = 1 kg, \u03B6 = 0.4)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF92400E),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Higher stiffness shrinks the period and pulls the oscillation '
          'into a tighter envelope.  Because we hold \u03B6 constant the '
          'shape stays self-similar --- only the time-axis stretches.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.brown.shade800,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: stiffnessTiles,
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 5: mass matrix --- vary mass, hold k = 100 and \u03B6 = 0.4
  // --------------------------------------------------------------
  print('=== Section 5: Mass matrix ===');
  final List<double> massValues = <double>[0.5, 1.0, 2.0, 5.0];
  final List<Color> massColors = <Color>[
    const Color(0xFF22D3EE),
    const Color(0xFF06B6D4),
    const Color(0xFF0EA5E9),
    const Color(0xFF1D4ED8),
  ];
  final List<Widget> massTiles = <Widget>[];
  for (int i = 0; i < massValues.length; i++) {
    final double m = massValues[i];
    final SpringDescription desc = SpringDescription.withDampingRatio(
      mass: m,
      stiffness: 100.0,
      ratio: 0.4,
    );
    final SpringSimulation sim = SpringSimulation(desc, 0.0, 1.0, 0.0);
    final List<_SpringSample> samples = _sampleSpring(sim, 4.5, 180);
    double yMin = 0.0;
    double yMax = 1.6;
    for (final _SpringSample s in samples) {
      if (s.x < yMin) yMin = s.x;
      if (s.x > yMax) yMax = s.x;
    }
    print('mass m=$m -> '
        '\u03C9\u2099=${math.sqrt(100.0 / m).toStringAsFixed(3)} '
        'c=${desc.damping.toStringAsFixed(3)}');
    massTiles.add(
      Container(
        width: 200.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.fitness_center, color: massColors[i], size: 16.0),
                const SizedBox(width: 6.0),
                Text(
                  'm = ${m.toStringAsFixed(1)} kg',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            SizedBox(
              height: 80.0,
              child: CustomPaint(
                painter: _ThumbnailPainter(
                  samples: samples,
                  yMin: yMin - 0.05,
                  yMax: yMax + 0.05,
                  color: massColors[i],
                ),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              '\u03C9\u2099 = ${math.sqrt(100.0 / m).toStringAsFixed(2)} rad/s\n'
              'c   = ${desc.damping.toStringAsFixed(2)} N\u00B7s/m',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget massMatrix = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFCFFAFE).withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFA5F3FC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Mass matrix (k = 100 N/m, \u03B6 = 0.4)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF155E75),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Heavier masses lower \u03C9\u2099 = \u221A(k/m); the oscillation '
          'becomes slower and lazier.  withDampingRatio scales c with '
          '\u221Am, so the visual decay envelope still matches \u03B6.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.cyan.shade900,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: massTiles,
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 6: damping ratio matrix --- vary \u03B6
  // --------------------------------------------------------------
  print('=== Section 6: Damping ratio matrix ===');
  final List<double> ratioValues = <double>[0.1, 0.5, 1.0, 1.5, 2.0];
  final List<Color> ratioColors = <Color>[
    const Color(0xFFF472B6),
    const Color(0xFFEC4899),
    const Color(0xFFA855F7),
    const Color(0xFF6366F1),
    const Color(0xFF1E40AF),
  ];
  final List<Widget> ratioTiles = <Widget>[];
  final List<_Trace> ratioTraces = <_Trace>[];
  for (int i = 0; i < ratioValues.length; i++) {
    final double r = ratioValues[i];
    final SpringDescription desc = SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 100.0,
      ratio: r,
    );
    final SpringSimulation sim = SpringSimulation(desc, 0.0, 1.0, 0.0);
    final List<_SpringSample> samples = _sampleSpring(sim, 3.0, 220);
    print('ratio \u03B6=$r -> c=${desc.damping.toStringAsFixed(3)}');

    double yMin = -0.5;
    double yMax = 1.5;
    for (final _SpringSample s in samples) {
      if (s.x < yMin) yMin = s.x - 0.05;
      if (s.x > yMax) yMax = s.x + 0.05;
    }

    ratioTraces.add(_Trace(
      label: '\u03B6 = ${r.toStringAsFixed(1)}',
      color: ratioColors[i],
      samples: samples,
    ));

    ratioTiles.add(
      Container(
        width: 165.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: ratioColors[i].withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: ratioColors[i],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Text(
                  '\u03B6 = ${r.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            SizedBox(
              height: 70.0,
              child: CustomPaint(
                painter: _ThumbnailPainter(
                  samples: samples,
                  yMin: yMin,
                  yMax: yMax,
                  color: ratioColors[i],
                ),
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              _describeRegime(r),
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            Text(
              'c = ${desc.damping.toStringAsFixed(2)}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double ratioYMin = -0.5;
  double ratioYMax = 1.5;
  for (final _Trace t in ratioTraces) {
    for (final _SpringSample s in t.samples) {
      if (s.x < ratioYMin) ratioYMin = s.x - 0.05;
      if (s.x > ratioYMax) ratioYMax = s.x + 0.05;
    }
  }

  final Widget ratioMatrix = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFCE7F3).withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFBCFE8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Damping ratio matrix (mass = 1 kg, k = 100 N/m)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF9D174D),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Sweep \u03B6 from very-bouncy (0.1) through critical (1.0) into '
          'molasses (2.0).  The overlay graph plots all five against the '
          'same axes; the matrix below shows the same data as thumbnails.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.pink.shade900,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 240.0,
          child: CustomPaint(
            painter: _CurvePainter(
              traces: ratioTraces,
              tMin: 0.0,
              tMax: 3.0,
              yMin: ratioYMin,
              yMax: ratioYMax,
              target: 1.0,
              background: const Color(0xFFFFFFFF),
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: ratioTiles,
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 7: Recipes --- named springs you might actually use
  // --------------------------------------------------------------
  print('=== Section 7: Recipes ===');
  final SpringDescription bouncyRecipe = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 380.0,
    ratio: 0.35,
  );
  final SpringDescription gentleRecipe = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 120.0,
    ratio: 0.85,
  );
  final SpringDescription snappyRecipe = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 220.0,
    ratio: 1.0,
  );
  final SpringDescription slowRecipe = SpringDescription.withDampingRatio(
    mass: 4.0,
    stiffness: 30.0,
    ratio: 0.7,
  );
  final ScrollSpringSimulation scrollRecipe = ScrollSpringSimulation(
    const SpringDescription(mass: 1.0, stiffness: 100.0, damping: 14.0),
    100.0,
    300.0,
    -800.0,
  );

  final SpringSimulation bouncySim =
      SpringSimulation(bouncyRecipe, 0.0, 1.0, 0.0);
  final SpringSimulation gentleSim =
      SpringSimulation(gentleRecipe, 0.0, 1.0, 0.0);
  final SpringSimulation snappySim =
      SpringSimulation(snappyRecipe, 0.0, 1.0, 0.0);
  final SpringSimulation slowSim = SpringSimulation(slowRecipe, 0.0, 1.0, 0.0);

  final List<_SpringSample> bouncySamples =
      _sampleSpring(bouncySim, 2.5, 200);
  final List<_SpringSample> gentleSamples =
      _sampleSpring(gentleSim, 2.5, 200);
  final List<_SpringSample> snappySamples =
      _sampleSpring(snappySim, 2.5, 200);
  final List<_SpringSample> slowSamples = _sampleSpring(slowSim, 2.5, 200);
  final List<_SpringSample> scrollSamples =
      _sampleAny(scrollRecipe, 2.5, 200);

  print('bouncy: c=${bouncyRecipe.damping.toStringAsFixed(3)}');
  print('gentle: c=${gentleRecipe.damping.toStringAsFixed(3)}');
  print('snappy: c=${snappyRecipe.damping.toStringAsFixed(3)}');
  print('slow:   c=${slowRecipe.damping.toStringAsFixed(3)}');
  print('scroll overscroll first samples: '
      'x(0)=${scrollRecipe.x(0.0).toStringAsFixed(3)} '
      'x(0.1)=${scrollRecipe.x(0.1).toStringAsFixed(3)} '
      'x(0.5)=${scrollRecipe.x(0.5).toStringAsFixed(3)}');

  final List<_Trace> recipeTraces = <_Trace>[
    _Trace(
      label: 'bouncy',
      color: const Color(0xFFEF4444),
      samples: bouncySamples,
    ),
    _Trace(
      label: 'gentle',
      color: const Color(0xFF22C55E),
      samples: gentleSamples,
    ),
    _Trace(
      label: 'snappy',
      color: const Color(0xFFA855F7),
      samples: snappySamples,
    ),
    _Trace(
      label: 'slow',
      color: const Color(0xFF0EA5E9),
      samples: slowSamples,
    ),
  ];

  double recipeYMin = -0.2;
  double recipeYMax = 1.5;
  for (final _Trace t in recipeTraces) {
    for (final _SpringSample s in t.samples) {
      if (s.x < recipeYMin) recipeYMin = s.x - 0.05;
      if (s.x > recipeYMax) recipeYMax = s.x + 0.05;
    }
  }

  Widget recipeCard(
    String name,
    String desc,
    SpringDescription d,
    Color color,
    List<_SpringSample> samples,
  ) {
    double cardYMin = -0.2;
    double cardYMax = 1.5;
    for (final _SpringSample s in samples) {
      if (s.x < cardYMin) cardYMin = s.x - 0.05;
      if (s.x > cardYMax) cardYMax = s.x + 0.05;
    }
    return Container(
      width: 230.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 14.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: color.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            desc,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 70.0,
            child: CustomPaint(
              painter: _ThumbnailPainter(
                samples: samples,
                yMin: cardYMin,
                yMax: cardYMax,
                color: color,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'm=${d.mass.toStringAsFixed(2)}, '
            'k=${d.stiffness.toStringAsFixed(0)}, '
            'c=${d.damping.toStringAsFixed(2)}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  // Scroll recipe is a different breed --- its samples vary in absolute
  // position so we render it standalone.
  double scrollYMin = scrollSamples.first.x;
  double scrollYMax = scrollSamples.first.x;
  for (final _SpringSample s in scrollSamples) {
    if (s.x < scrollYMin) scrollYMin = s.x;
    if (s.x > scrollYMax) scrollYMax = s.x;
  }
  scrollYMin -= 5.0;
  scrollYMax += 5.0;

  final Widget recipes = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFCBD5E1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Named spring recipes',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Four ergonomic SpringDescription presets plus a ScrollSpringSimulation '
          'that drives the overscroll bounce you see at the edge of a '
          'BouncingScrollPhysics list view.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            recipeCard(
              'bounce',
              'A playful overshoot for chip dialogs and confetti.',
              bouncyRecipe,
              const Color(0xFFEF4444),
              bouncySamples,
            ),
            recipeCard(
              'gentle',
              'Soft settle; ideal for inline form rearrangements.',
              gentleRecipe,
              const Color(0xFF22C55E),
              gentleSamples,
            ),
            recipeCard(
              'snappy',
              'Critically damped --- fast, no overshoot, very Material.',
              snappyRecipe,
              const Color(0xFFA855F7),
              snappySamples,
            ),
            recipeCard(
              'slow',
              'Heavy mass + low stiffness; languid, ASMR motion.',
              slowRecipe,
              const Color(0xFF0EA5E9),
              slowSamples,
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'ScrollSpringSimulation --- overscroll snap-back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Starts at position 100 with velocity -800 (a fast pull '
                'away from rest at 300), then snaps back toward 300 under '
                'the same SpringDescription.  Same physics as the iOS-style '
                'list bounce.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 150.0,
                child: CustomPaint(
                  painter: _CurvePainter(
                    traces: <_Trace>[
                      _Trace(
                        label: 'ScrollSpringSimulation',
                        color: const Color(0xFFDB2777),
                        samples: scrollSamples,
                      ),
                    ],
                    tMin: 0.0,
                    tMax: 2.5,
                    yMin: scrollYMin,
                    yMax: scrollYMax,
                    target: 300.0,
                    background: const Color(0xFFFDF2F8),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 8: Comparison vs FrictionSimulation and GravitySimulation
  // --------------------------------------------------------------
  print('=== Section 8: Comparison with FrictionSimulation / GravitySimulation ===');
  final FrictionSimulation frictionSim =
      FrictionSimulation(0.135, 0.0, 4.0);
  final GravitySimulation gravitySim =
      GravitySimulation(2.0, 0.0, 5.0, 0.0);
  final SpringSimulation compareSpring = SpringSimulation(
    SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: 18.0,
      ratio: 0.55,
    ),
    0.0,
    1.0,
    0.0,
  );

  final List<_SpringSample> frictionSamples =
      _sampleAny(frictionSim, 4.0, 200);
  final List<_SpringSample> gravitySamples =
      _sampleAny(gravitySim, 2.0, 200);
  final List<_SpringSample> compareSpringSamples =
      _sampleSpring(compareSpring, 4.0, 200);

  print('friction: x(0)=${frictionSim.x(0.0).toStringAsFixed(3)} '
      'x(2)=${frictionSim.x(2.0).toStringAsFixed(3)} '
      'x(4)=${frictionSim.x(4.0).toStringAsFixed(3)}');
  print('gravity:  x(0)=${gravitySim.x(0.0).toStringAsFixed(3)} '
      'x(1)=${gravitySim.x(1.0).toStringAsFixed(3)} '
      'x(2)=${gravitySim.x(2.0).toStringAsFixed(3)}');

  // Re-scale gravity samples to fit the same plot
  final List<_SpringSample> gravityScaled = <_SpringSample>[];
  for (final _SpringSample s in gravitySamples) {
    gravityScaled.add(_SpringSample(s.t * 2.0, s.x / 4.0, s.v));
  }
  final List<_SpringSample> frictionScaled = <_SpringSample>[];
  for (final _SpringSample s in frictionSamples) {
    frictionScaled.add(_SpringSample(s.t, s.x, s.v));
  }

  final List<_Trace> compareTraces = <_Trace>[
    _Trace(
      label: 'SpringSimulation (\u03B6=0.55)',
      color: const Color(0xFFEC4899),
      samples: compareSpringSamples,
    ),
    _Trace(
      label: 'FrictionSimulation (scroll fling)',
      color: const Color(0xFF22C55E),
      samples: frictionScaled,
    ),
    _Trace(
      label: 'GravitySimulation (re-scaled)',
      color: const Color(0xFF3B82F6),
      samples: gravityScaled,
      dashed: true,
    ),
  ];

  double compYMin = -0.2;
  double compYMax = 1.5;
  for (final _Trace t in compareTraces) {
    for (final _SpringSample s in t.samples) {
      if (s.x < compYMin) compYMin = s.x - 0.05;
      if (s.x > compYMax) compYMax = s.x + 0.05;
    }
  }

  final Widget comparison = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'SpringSimulation vs FrictionSimulation vs GravitySimulation',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Three Simulation subclasses share the same x(t)/dx(t)/isDone(t) API '
          'but encode wildly different physics.  The spring oscillates, '
          'friction decays exponentially toward a final value, gravity '
          'accelerates without bound until it reaches its end position.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 240.0,
          child: CustomPaint(
            painter: _CurvePainter(
              traces: compareTraces,
              tMin: 0.0,
              tMax: 4.0,
              yMin: compYMin,
              yMax: compYMax,
              target: 1.0,
              background: const Color(0xFFF8FAFC),
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 8.0,
          children: <Widget>[
            _legendDot(const Color(0xFFEC4899), 'Spring: oscillation'),
            _legendDot(const Color(0xFF22C55E), 'Friction: exponential settle'),
            _legendDot(const Color(0xFF3B82F6), 'Gravity: open-ended accel'),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Text(
            'Tip --- if you need physics-y motion that tracks a target value '
            '(snapping a sheet, dismissing a card), choose SpringSimulation. '
            'For fling-style decay where the user threw the content, choose '
            'FrictionSimulation.  GravitySimulation is for honest '
            'constant-acceleration motion --- think of a hero element '
            '"dropping" into place.',
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.brown.shade900,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 9: Math sidebar
  // --------------------------------------------------------------
  print('=== Section 9: Math sidebar ===');
  final Widget mathSidebar = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.calculate, color: Color(0xFFFBBF24), size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Math sidebar',
              style: TextStyle(
                color: Color(0xFFFBBF24),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'The classical damped harmonic oscillator behind SpringSimulation.',
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        _equationBox(
          'm\u00B7\u1E8D(t) + c\u00B7\u1E8B(t) + k\u00B7x(t) = 0\n'
          '  m = mass, c = damping, k = stiffness',
          const Color(0xFFFBBF24),
        ),
        const SizedBox(height: 8.0),
        _equationBox(
          '\u03C9\u2099 = \u221A(k / m)      // natural frequency (rad/s)\n'
          'T   = 2\u03C0 / \u03C9\u2099       // natural period (s)\n'
          'f\u2099  = 1 / T          // natural frequency (Hz)',
          const Color(0xFF34D399),
        ),
        const SizedBox(height: 8.0),
        _equationBox(
          'c_crit = 2 \u00B7 \u221A(m \u00B7 k)  // critical damping coefficient\n'
          '\u03B6 = c / c_crit         // damping ratio (dimensionless)',
          const Color(0xFF60A5FA),
        ),
        const SizedBox(height: 8.0),
        _equationBox(
          'Regimes:\n'
          '  \u03B6 < 1  -> under-damped (oscillates, envelope e^{-\u03B6\u03C9\u2099t})\n'
          '  \u03B6 = 1  -> critically damped (fastest settle, no overshoot)\n'
          '  \u03B6 > 1  -> over-damped (two real exponentials, slow approach)',
          const Color(0xFFF472B6),
        ),
        const SizedBox(height: 8.0),
        _equationBox(
          'Damped frequency (under-damped only):\n'
          '  \u03C9_d = \u03C9\u2099 \u00B7 \u221A(1 - \u03B6\u00B2)\n'
          'Closed-form for x(t) with x(0)=x\u2080, dx(0)=v\u2080:\n'
          '  x(t) = e^{-\u03B6\u03C9\u2099t} (A\u00B7cos(\u03C9_d t) + B\u00B7sin(\u03C9_d t))\n'
          '  A = x\u2080, B = (v\u2080 + \u03B6\u00B7\u03C9\u2099\u00B7x\u2080) / \u03C9_d',
          const Color(0xFFFACC15),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 10: Pitfalls
  // --------------------------------------------------------------
  print('=== Section 10: Pitfalls ===');
  final Widget pitfalls = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBEB),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFCD34D)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.warning_amber, color: Color(0xFFD97706), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF92400E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _pitfallTile(
          Icons.bolt,
          'Zero stiffness',
          'k = 0 means no restoring force --- the spring has no rest position '
              'and the resulting simulation diverges linearly with velocity. '
              'SpringDescription does not reject k = 0, but x(t) will not '
              'converge.  Use FrictionSimulation instead for pure decay.',
          const Color(0xFFD97706),
        ),
        _pitfallTile(
          Icons.do_not_disturb,
          'Negative damping',
          'A negative damping coefficient amplifies oscillation --- energy '
              'is injected on every cycle.  Animation controllers that drive '
              'this will run forever and the on-screen value will grow without '
              'bound.  Always pass a non-negative damping or use withDampingRatio '
              'with a non-negative ratio.',
          const Color(0xFFB91C1C),
        ),
        _pitfallTile(
          Icons.scale,
          'Zero mass',
          'Dividing by zero in \u221A(k/m).  Avoid mass = 0; if you want an '
              '"instant" spring just use a very low mass paired with high '
              'stiffness (but keep \u03B6 \u2248 1 to avoid jitter).',
          const Color(0xFFDC2626),
        ),
        _pitfallTile(
          Icons.tune,
          'Mismatch between description and target distance',
          'SpringSimulation uses the description to compute c implicitly, '
              'but x(0) - end determines how big the swing is.  A large '
              'distance with low stiffness produces a slow, distant arc. '
              'Combine target distance with the natural frequency \u03C9\u2099 '
              'when tuning.',
          const Color(0xFF7C3AED),
        ),
        _pitfallTile(
          Icons.timer_off,
          'isDone semantics',
          'SpringSimulation.isDone(t) returns true once the oscillation '
              'falls inside tolerance.  Using sim.x() past that point still '
              'works but the value approaches the rest position asymptotically; '
              'do not assume a hard stop time.',
          const Color(0xFF0EA5E9),
        ),
        _pitfallTile(
          Icons.swap_horiz,
          'Using SpringDescription as a Simulation',
          'SpringDescription is a parameter bag, not a Simulation.  You '
              'cannot call x() / dx() / isDone() on it directly --- always '
              'wrap it in SpringSimulation (or ScrollSpringSimulation).',
          const Color(0xFF059669),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 11: Glossary
  // --------------------------------------------------------------
  print('=== Section 11: Glossary ===');
  final Widget glossary = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.menu_book, color: Color(0xFF6366F1), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Glossary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF312E81),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _glossaryEntry(
          'SpringDescription',
          'Immutable record of (mass, stiffness, damping).  Pure data --- '
              'feeds a Simulation to actually evolve the motion.',
          const Color(0xFF1D4ED8),
        ),
        _glossaryEntry(
          'SpringSimulation',
          'A Simulation that integrates a damped harmonic oscillator from '
              'startPosition to endPosition with initial velocity.  Exposes '
              'x(t), dx(t), isDone(t).',
          const Color(0xFF7C3AED),
        ),
        _glossaryEntry(
          'ScrollSpringSimulation',
          'SpringSimulation tuned for scroll overscroll bounce.  Tolerates '
              'the high velocities typical of fling gestures.',
          const Color(0xFFEC4899),
        ),
        _glossaryEntry(
          'mass (m)',
          'Inertia of the object on the spring (kg).  Heavier mass slows '
              '\u03C9\u2099 since \u03C9\u2099 = \u221A(k/m).',
          const Color(0xFF059669),
        ),
        _glossaryEntry(
          'stiffness (k)',
          'How strongly the spring pulls toward its rest position (N/m). '
              'Higher k yields faster oscillation.',
          const Color(0xFFEA580C),
        ),
        _glossaryEntry(
          'damping (c)',
          'Viscous resistance opposing velocity (N\u00B7s/m).  Removes energy '
              'from the system; controls overshoot.',
          const Color(0xFFDC2626),
        ),
        _glossaryEntry(
          'damping ratio (\u03B6)',
          'Dimensionless ratio c / (2\u00B7\u221A(m\u00B7k)).  Universal way '
              'to talk about a spring\u2019s shape independent of m and k.',
          const Color(0xFF0EA5E9),
        ),
        _glossaryEntry(
          'natural frequency (\u03C9\u2099)',
          'Angular oscillation frequency the spring would have with zero '
              'damping: \u03C9\u2099 = \u221A(k/m).  Units of rad/s.',
          const Color(0xFFA855F7),
        ),
        _glossaryEntry(
          'damped frequency (\u03C9_d)',
          'Actual oscillation frequency under damping: '
              '\u03C9_d = \u03C9\u2099\u00B7\u221A(1 - \u03B6\u00B2).  Only '
              'real when \u03B6 < 1.',
          const Color(0xFF14B8A6),
        ),
        _glossaryEntry(
          'critical damping coefficient (c_crit)',
          'The exact damping that brings the spring to rest as fast as '
              'possible without overshoot.  c_crit = 2\u00B7\u221A(m\u00B7k).',
          const Color(0xFF6366F1),
        ),
        _glossaryEntry(
          'under-damped',
          '\u03B6 < 1.  Oscillates with an exponentially decaying envelope.',
          const Color(0xFFF59E0B)),
        _glossaryEntry(
          'critically damped',
          '\u03B6 = 1.  Fastest possible non-oscillatory return to rest.',
          const Color(0xFF10B981),
        ),
        _glossaryEntry(
          'over-damped',
          '\u03B6 > 1.  Two real exponential modes; slow, sluggish approach.',
          const Color(0xFF6B7280),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // SECTION 12: Recap card
  // --------------------------------------------------------------
  print('=== Section 12: Recap ===');
  final Widget recap = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0F766E), Color(0xFF065F46)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.check_circle, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _recapLine(
          '1.',
          'SpringDescription is a tiny immutable record of (mass, stiffness, '
              'damping).  Build it once, reuse it everywhere.',
        ),
        _recapLine(
          '2.',
          'SpringDescription.withDampingRatio derives damping = '
              '\u03B6 \u00B7 2 \u00B7 \u221A(mass \u00B7 stiffness).  Reach '
              'for it whenever you think in terms of "bouncy" vs "snappy".',
        ),
        _recapLine(
          '3.',
          'Wrap the description in a SpringSimulation (or '
              'ScrollSpringSimulation) and call x(t) / dx(t) / isDone(t) at '
              'build time to draw curves, like this entire demo does.',
        ),
        _recapLine(
          '4.',
          'Under-damped (\u03B6 < 1) springs oscillate; critical springs '
              '(\u03B6 = 1) are the fastest non-overshooting; over-damped '
              'springs (\u03B6 > 1) drift slowly.',
        ),
        _recapLine(
          '5.',
          'Mass scales \u03C9\u2099 by 1/\u221Am; stiffness scales it by '
              '\u221Ak.  withDampingRatio preserves \u03B6 across mass/stiffness '
              'changes, keeping the visual character consistent.',
        ),
        _recapLine(
          '6.',
          'Compare with FrictionSimulation (pure decay) and '
              'GravitySimulation (constant acceleration) to pick the right '
              'physics for the gesture you are honoring.',
        ),
      ],
    ),
  );

  // --------------------------------------------------------------
  // Final assembly
  // --------------------------------------------------------------
  print('=== Final assembly ===');
  final Widget body = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        hero,
        _sectionTitle(
          'PART 01',
          'Anatomy',
          'mass, stiffness, damping --- and the withDampingRatio shortcut',
          const Color(0xFF1D4ED8),
          Icons.architecture,
        ),
        anatomy,
        _sectionTitle(
          'PART 02',
          'Damping gallery',
          'critically, over, and under-damped curves side by side',
          const Color(0xFFEC4899),
          Icons.show_chart,
        ),
        dampingGallery,
        _sectionTitle(
          'PART 03',
          'Stiffness matrix',
          'k = 10 / 50 / 100 / 200 / 500 N/m',
          const Color(0xFFEA580C),
          Icons.expand,
        ),
        stiffnessMatrix,
        _sectionTitle(
          'PART 04',
          'Mass matrix',
          'm = 0.5 / 1 / 2 / 5 kg',
          const Color(0xFF0891B2),
          Icons.fitness_center,
        ),
        massMatrix,
        _sectionTitle(
          'PART 05',
          'Damping ratio matrix',
          '\u03B6 = 0.1 / 0.5 / 1.0 / 1.5 / 2.0',
          const Color(0xFFA855F7),
          Icons.tune,
        ),
        ratioMatrix,
        _sectionTitle(
          'PART 06',
          'Recipes',
          'bouncy, gentle, snappy, slow, and a ScrollSpringSimulation',
          const Color(0xFF22C55E),
          Icons.restaurant_menu,
        ),
        recipes,
        _sectionTitle(
          'PART 07',
          'Comparison',
          'Spring vs Friction vs Gravity --- three flavors of motion',
          const Color(0xFF6366F1),
          Icons.compare_arrows,
        ),
        comparison,
        _sectionTitle(
          'PART 08',
          'Math sidebar',
          'the equations that drive SpringSimulation',
          const Color(0xFFFBBF24),
          Icons.calculate,
        ),
        mathSidebar,
        _sectionTitle(
          'PART 09',
          'Pitfalls',
          'sharp edges to avoid when authoring SpringDescriptions',
          const Color(0xFFD97706),
          Icons.warning_amber,
        ),
        pitfalls,
        _sectionTitle(
          'PART 10',
          'Glossary',
          'terms used throughout this dossier',
          const Color(0xFF6366F1),
          Icons.menu_book,
        ),
        glossary,
        const SizedBox(height: 12.0),
        recap,
        const SizedBox(height: 24.0),
      ],
    ),
  );

  print('SpringDescription Deep Demo complete');
  print('=' * 64);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        title: const Text('SpringDescription Deep Demo'),
      ),
      body: body,
    ),
  );
}

// ---------------------------------------------------------------------------
// Tiny helper used by the recap section.
// ---------------------------------------------------------------------------
Widget _recapLine(String marker, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28.0,
          padding: const EdgeInsets.only(top: 1.0),
          child: Text(
            marker,
            style: const TextStyle(
              color: Color(0xFFA7F3D0),
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// Map a damping ratio to a short human description used by the matrix cells.
String _describeRegime(double ratio) {
  if (ratio < 0.3) {
    return 'highly under-damped';
  } else if (ratio < 0.9) {
    return 'under-damped';
  } else if (ratio < 1.1) {
    return 'critical';
  } else if (ratio < 1.6) {
    return 'over-damped';
  }
  return 'heavily over-damped';
}
