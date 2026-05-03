// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// CustomPainter / CustomPaint — Deep Demo
// -----------------------------------------------------------------------------
// This file is a hand-authored, comprehensive walkthrough of Flutter's
// imperative drawing surface: the `CustomPainter` class and the `CustomPaint`
// widget that hosts it.  While the file lives under `proxies/` (because the
// d4rt proxy harness consumes it), the *subject* is the underlying Flutter
// rendering primitives, not the proxy itself.
//
// Topics covered (one section per Card):
//   * Intro — the `paint(Canvas, Size)` contract and `shouldRepaint`
//   * Per-painter showcases — grid, radar, sine wave, starburst, bar chart,
//     gauge, polygon, confetti, dotted background, signature pad
//   * Animated painter via a `ValueNotifier<double>` and `TweenAnimationBuilder`
//   * Interactive painter — slider drives painter parameter
//   * `shouldRepaint` discussion — wasteful vs frugal painters with counters
//   * Hit testing — `hitTest(Offset)` with a circular hit region
//   * `foregroundPainter` vs `painter` on the same `CustomPaint`
//   * Layered painters — Stack of `CustomPaint`s
//   * Recipe: data visualisation (bar chart from `List<double>`)
//   * Recipe: dashed/dotted background
//   * Recipe: signature pad (drag-to-draw with `ValueNotifier<List<List<Offset>>>`)
//   * Decision card — `CustomPainter` vs `Container`/`DecoratedBox`/`Stack`
//   * Reference card — painter table, Canvas API tour, performance tips
//
// Harness contract (recap):
//   * first non-comment line is the analyzer ignore directive,
//   * imports limited to `package:flutter/material.dart`,
//   * `dynamic build(BuildContext context)` returns a `MaterialApp`,
//   * Scaffold → SafeArea → SingleChildScrollView → Column of section cards,
//   * no `main()`, no `runApp()`, no `testWidgets()`.
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Section palettes.  Each section gets a distinct background/accent/ink trio
// so the vertical rhythm of the page is obvious while scrolling.
// -----------------------------------------------------------------------------
const Color _introBg = Color(0xFFEDE7F6);
const Color _introAccent = Color(0xFF4527A0);
const Color _introInk = Color(0xFF1A0E4D);

const Color _gridBg = Color(0xFFE3F2FD);
const Color _gridAccent = Color(0xFF1565C0);
const Color _gridInk = Color(0xFF0D2E58);

const Color _radarBg = Color(0xFFE8F5E9);
const Color _radarAccent = Color(0xFF2E7D32);
const Color _radarInk = Color(0xFF1B3D1F);

const Color _sineBg = Color(0xFFFFF3E0);
const Color _sineAccent = Color(0xFFE65100);
const Color _sineInk = Color(0xFF6A2C00);

const Color _starBg = Color(0xFFFCE4EC);
const Color _starAccent = Color(0xFFAD1457);
const Color _starInk = Color(0xFF560027);

const Color _barBg = Color(0xFFE0F7FA);
const Color _barAccent = Color(0xFF00838F);
const Color _barInk = Color(0xFF003844);

const Color _gaugeBg = Color(0xFFEDE7F6);
const Color _gaugeAccent = Color(0xFF512DA8);
const Color _gaugeInk = Color(0xFF1A0E4D);

const Color _polyBg = Color(0xFFFFF8E1);
const Color _polyAccent = Color(0xFFF57F17);
const Color _polyInk = Color(0xFF5C3A00);

const Color _confettiBg = Color(0xFFE8EAF6);
const Color _confettiInk = Color(0xFF101542);

const Color _dottedBg = Color(0xFFF3E5F5);
const Color _dottedAccent = Color(0xFF6A1B9A);
const Color _dottedInk = Color(0xFF4A148C);

const Color _signatureBg = Color(0xFFFFEBEE);
const Color _signatureAccent = Color(0xFFC62828);
const Color _signatureInk = Color(0xFF6A0F12);

const Color _animBg = Color(0xFFE0F2F1);
const Color _animAccent = Color(0xFF00695C);
const Color _animInk = Color(0xFF002F2A);

const Color _interactBg = Color(0xFFFFF9C4);
const Color _interactAccent = Color(0xFFF9A825);
const Color _interactInk = Color(0xFF624A00);

const Color _repaintBg = Color(0xFFD7CCC8);
const Color _repaintAccent = Color(0xFF4E342E);
const Color _repaintInk = Color(0xFF1B0000);

const Color _hitBg = Color(0xFFB2DFDB);
const Color _hitInk = Color(0xFF003D33);

const Color _foreBg = Color(0xFFCFD8DC);
const Color _foreAccent = Color(0xFF37474F);
const Color _foreInk = Color(0xFF102027);

const Color _layerBg = Color(0xFFC5CAE9);
const Color _layerAccent = Color(0xFF1A237E);
const Color _layerInk = Color(0xFF0A0E40);

const Color _decisionBg = Color(0xFFF1F8E9);
const Color _decisionInk = Color(0xFF1B3300);

const Color _refBg = Color(0xFFECEFF1);
const Color _refInk = Color(0xFF263238);

// =============================================================================
// CustomPainter subclasses (file scope).
// Every painter overrides paint(Canvas, Size) and shouldRepaint(...).  Where
// applicable they also implement hitTest(Offset) (see _CircleHitPainter).
// =============================================================================

// -----------------------------------------------------------------------------
// _GridPainter — paints a square grid with optional axis emphasis.
//
// Demonstrates `Canvas.drawLine` and the use of `Paint.style = PaintingStyle.stroke`.
// The grid honours antialiasing and an opaque background fill.
// -----------------------------------------------------------------------------
class _GridPainter extends CustomPainter {
  const _GridPainter({
    required this.cellSize,
    required this.lineColor,
    required this.axisColor,
    this.background = const Color(0xFFFAFAFA),
  });

  final double cellSize;
  final Color lineColor;
  final Color axisColor;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Background fill — drawRect with a filled paint.
    final Paint bg = Paint()..color = background;
    canvas.drawRect(Offset.zero & size, bg);

    // 2. Minor grid lines — strokes at every `cellSize` step.
    final Paint minor = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
    for (double x = 0; x <= size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), minor);
    }
    for (double y = 0; y <= size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), minor);
    }

    // 3. Axis emphasis — bolder lines through the centre.
    final Paint axis = Paint()
      ..color = axisColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      axis,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      axis,
    );
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.cellSize != cellSize ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.axisColor != axisColor ||
        oldDelegate.background != background;
  }
}

// -----------------------------------------------------------------------------
// _RadarSweepPainter — concentric rings, cardinal spokes, and a sweeping arc.
//
// Demonstrates `Canvas.drawCircle`, `Canvas.drawArc`, and how a single
// `sweepAngle` parameter can drive a radar-style animation.
// -----------------------------------------------------------------------------
class _RadarSweepPainter extends CustomPainter {
  const _RadarSweepPainter({
    required this.sweepAngle,
    required this.ringColor,
    required this.sweepColor,
    this.rings = 4,
  });

  final double sweepAngle;
  final Color ringColor;
  final Color sweepColor;
  final int rings;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset centre = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 6;

    // Background disc.
    final Paint disc = Paint()..color = const Color(0xFFE8F5E9);
    canvas.drawCircle(centre, radius, disc);

    // Concentric rings.
    final Paint ring = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (int i = 1; i <= rings; i++) {
      canvas.drawCircle(centre, radius * (i / rings), ring);
    }

    // Cardinal spokes (N, E, S, W) with thin strokes.
    final Paint spoke = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawLine(centre, centre + Offset(0, -radius), spoke);
    canvas.drawLine(centre, centre + Offset(0, radius), spoke);
    canvas.drawLine(centre, centre + Offset(-radius, 0), spoke);
    canvas.drawLine(centre, centre + Offset(radius, 0), spoke);

    // Sweep wedge — thin bright arc rotating around the centre.
    final Rect rect = Rect.fromCircle(center: centre, radius: radius);
    final Paint sweep = Paint()
      ..shader = SweepGradient(
        colors: <Color>[sweepColor.withOpacity(0), sweepColor],
        startAngle: sweepAngle - 0.6,
        endAngle: sweepAngle,
        transform: GradientRotation(sweepAngle - 0.6),
      ).createShader(rect)
      ..style = PaintingStyle.fill;
    canvas.drawArc(rect, sweepAngle - 0.6, 0.6, true, sweep);

    // Pivot dot.
    final Paint pivot = Paint()..color = sweepColor;
    canvas.drawCircle(centre, 3.0, pivot);
  }

  @override
  bool shouldRepaint(covariant _RadarSweepPainter oldDelegate) {
    return oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.ringColor != ringColor ||
        oldDelegate.sweepColor != sweepColor ||
        oldDelegate.rings != rings;
  }
}

// -----------------------------------------------------------------------------
// _SineWavePainter — plots a sine wave across the canvas using `drawPath`.
//
// Demonstrates building a `Path` with `moveTo`/`lineTo` and stroking it with
// rounded line caps.  The amplitude/frequency are configurable.
// -----------------------------------------------------------------------------
class _SineWavePainter extends CustomPainter {
  const _SineWavePainter({
    required this.amplitude,
    required this.frequency,
    required this.phase,
    required this.lineColor,
  });

  final double amplitude;
  final double frequency;
  final double phase;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Background.
    final Paint bg = Paint()..color = const Color(0xFFFFFDE7);
    canvas.drawRect(Offset.zero & size, bg);

    // Mid-line guide.
    final Paint mid = Paint()
      ..color = const Color(0xFFFFCC80)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      mid,
    );

    // Sine path.
    final Path path = Path();
    final double midY = size.height / 2;
    for (double x = 0; x <= size.width; x += 1.0) {
      final double t = x / size.width;
      final double y = midY +
          amplitude * math.sin((2 * math.pi * frequency * t) + phase);
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final Paint stroke = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant _SineWavePainter oldDelegate) {
    return oldDelegate.amplitude != amplitude ||
        oldDelegate.frequency != frequency ||
        oldDelegate.phase != phase ||
        oldDelegate.lineColor != lineColor;
  }
}

// -----------------------------------------------------------------------------
// _StarBurstPainter — radial spokes emanating from a centre with a star shape.
//
// Demonstrates `Path` with relative coordinates and `drawPath` for a
// non-trivial closed shape.  A 5-point star is drawn analytically.
// -----------------------------------------------------------------------------
class _StarBurstPainter extends CustomPainter {
  const _StarBurstPainter({
    required this.points,
    required this.fillColor,
    required this.strokeColor,
  });

  final int points;
  final Color fillColor;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFF8FB);
    canvas.drawRect(Offset.zero & size, bg);

    final Offset centre = Offset(size.width / 2, size.height / 2);
    final double outerR = math.min(size.width, size.height) / 2 - 8;
    final double innerR = outerR * 0.45;

    final Path star = Path();
    for (int i = 0; i < points * 2; i++) {
      final double r = i.isEven ? outerR : innerR;
      final double angle = (i * math.pi) / points - math.pi / 2;
      final Offset p = centre + Offset(math.cos(angle) * r, math.sin(angle) * r);
      if (i == 0) {
        star.moveTo(p.dx, p.dy);
      } else {
        star.lineTo(p.dx, p.dy);
      }
    }
    star.close();

    final Paint fill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas.drawPath(star, fill);

    final Paint stroke = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    canvas.drawPath(star, stroke);
  }

  @override
  bool shouldRepaint(covariant _StarBurstPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.strokeColor != strokeColor;
  }
}

// -----------------------------------------------------------------------------
// _BarChartPainter — vertical bar chart from a `List<double>` of values.
//
// Demonstrates `drawRRect`, label rendering with `TextPainter`, and how to
// scale data into pixel coordinates.
// -----------------------------------------------------------------------------
class _BarChartPainter extends CustomPainter {
  const _BarChartPainter({
    required this.values,
    required this.barColor,
    required this.axisColor,
    required this.labelColor,
  });

  final List<double> values;
  final Color barColor;
  final Color axisColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE0F7FA);
    canvas.drawRect(Offset.zero & size, bg);

    if (values.isEmpty) {
      return;
    }

    final double maxV = values.reduce(math.max);
    if (maxV <= 0) {
      return;
    }

    const double leftPad = 22;
    const double bottomPad = 22;
    const double topPad = 8;
    const double rightPad = 8;
    final double chartW = size.width - leftPad - rightPad;
    final double chartH = size.height - topPad - bottomPad;
    final double slot = chartW / values.length;
    final double barW = slot * 0.65;

    // Axis lines.
    final Paint axis = Paint()
      ..color = axisColor
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(leftPad, topPad),
      Offset(leftPad, size.height - bottomPad),
      axis,
    );
    canvas.drawLine(
      Offset(leftPad, size.height - bottomPad),
      Offset(size.width - rightPad, size.height - bottomPad),
      axis,
    );

    // Bars.
    final Paint barPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    for (int i = 0; i < values.length; i++) {
      final double h = (values[i] / maxV) * chartH;
      final double left = leftPad + slot * i + (slot - barW) / 2;
      final double top = size.height - bottomPad - h;
      final RRect rr = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barW, h),
        const Radius.circular(3),
      );
      canvas.drawRRect(rr, barPaint);

      // Label below each bar.
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(color: labelColor, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(left + (barW - tp.width) / 2, size.height - bottomPad + 4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    if (oldDelegate.barColor != barColor ||
        oldDelegate.axisColor != axisColor ||
        oldDelegate.labelColor != labelColor) {
      return true;
    }
    if (oldDelegate.values.length != values.length) {
      return true;
    }
    for (int i = 0; i < values.length; i++) {
      if (oldDelegate.values[i] != values[i]) {
        return true;
      }
    }
    return false;
  }
}

// -----------------------------------------------------------------------------
// _GaugePainter — semicircular gauge with a needle and tick labels.
//
// Demonstrates `drawArc` for the dial face, manual rotation of the needle by
// computing trig endpoints, and per-tick `TextPainter` labels.
// -----------------------------------------------------------------------------
class _GaugePainter extends CustomPainter {
  const _GaugePainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.dialColor,
    required this.needleColor,
    required this.tickColor,
  });

  final double value;
  final double minValue;
  final double maxValue;
  final Color dialColor;
  final Color needleColor;
  final Color tickColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFEDE7F6);
    canvas.drawRect(Offset.zero & size, bg);

    final Offset centre = Offset(size.width / 2, size.height * 0.85);
    final double radius = math.min(size.width / 2, size.height) - 12;

    // Dial arc — half circle from 180° to 360°.
    final Rect rect = Rect.fromCircle(center: centre, radius: radius);
    final Paint dial = Paint()
      ..color = dialColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, math.pi, math.pi, false, dial);

    // Tick marks at 0%, 25%, 50%, 75%, 100%.
    final Paint tick = Paint()
      ..color = tickColor
      ..strokeWidth = 1.6;
    for (int i = 0; i <= 4; i++) {
      final double t = i / 4.0;
      final double angle = math.pi + (math.pi * t);
      final Offset p1 = centre +
          Offset(math.cos(angle) * (radius - 4), math.sin(angle) * (radius - 4));
      final Offset p2 = centre +
          Offset(math.cos(angle) * (radius - 14), math.sin(angle) * (radius - 14));
      canvas.drawLine(p1, p2, tick);

      // Label.
      final double labelValue = minValue + (maxValue - minValue) * t;
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labelValue.toStringAsFixed(0),
          style: TextStyle(color: tickColor, fontSize: 9),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final Offset labelP = centre +
          Offset(
            math.cos(angle) * (radius - 26) - tp.width / 2,
            math.sin(angle) * (radius - 26) - tp.height / 2,
          );
      tp.paint(canvas, labelP);
    }

    // Needle.
    final double clamped = value.clamp(minValue, maxValue);
    final double t = (clamped - minValue) / (maxValue - minValue);
    final double angle = math.pi + (math.pi * t);
    final Offset tip = centre +
        Offset(math.cos(angle) * (radius - 18), math.sin(angle) * (radius - 18));
    final Paint needle = Paint()
      ..color = needleColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(centre, tip, needle);
    canvas.drawCircle(centre, 5, Paint()..color = needleColor);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.dialColor != dialColor ||
        oldDelegate.needleColor != needleColor ||
        oldDelegate.tickColor != tickColor;
  }
}

// -----------------------------------------------------------------------------
// _PolygonPainter — regular n-gon centred in the canvas.
//
// Demonstrates a closed `Path` built from polar coordinates and the difference
// between fill and stroke when both are applied to the same path.
// -----------------------------------------------------------------------------
class _PolygonPainter extends CustomPainter {
  const _PolygonPainter({
    required this.sides,
    required this.rotation,
    required this.fillColor,
    required this.strokeColor,
  });

  final int sides;
  final double rotation;
  final Color fillColor;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFFDE7);
    canvas.drawRect(Offset.zero & size, bg);

    if (sides < 3) {
      return;
    }
    final Offset centre = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 8;

    final Path path = Path();
    for (int i = 0; i < sides; i++) {
      final double angle = rotation + (i * 2 * math.pi / sides) - math.pi / 2;
      final Offset p =
          centre + Offset(math.cos(angle) * radius, math.sin(angle) * radius);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();

    final Paint fill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas.drawPath(path, fill);

    final Paint stroke = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant _PolygonPainter oldDelegate) {
    return oldDelegate.sides != sides ||
        oldDelegate.rotation != rotation ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.strokeColor != strokeColor;
  }
}

// -----------------------------------------------------------------------------
// _ConfettiPainter — many small coloured rectangles scattered deterministically.
//
// Demonstrates `Canvas.save`/`restore` plus rotations and translations to draw
// rotated rectangles without manually rotating the rectangle's corners.  A
// fixed `math.Random(seed)` keeps the layout reproducible.
// -----------------------------------------------------------------------------
class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter({
    required this.count,
    required this.seed,
    required this.palette,
  });

  final int count;
  final int seed;
  final List<Color> palette;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE8EAF6);
    canvas.drawRect(Offset.zero & size, bg);

    final math.Random rng = math.Random(seed);
    for (int i = 0; i < count; i++) {
      final double cx = rng.nextDouble() * size.width;
      final double cy = rng.nextDouble() * size.height;
      final double angle = rng.nextDouble() * 2 * math.pi;
      final double w = 4 + rng.nextDouble() * 6;
      final double h = 8 + rng.nextDouble() * 10;
      final Color c = palette[rng.nextInt(palette.length)];

      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(angle);
      final Paint p = Paint()..color = c;
      canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: w, height: h), p);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.count != count ||
        oldDelegate.seed != seed ||
        oldDelegate.palette != palette;
  }
}

// -----------------------------------------------------------------------------
// _DottedBackgroundPainter — a regularly-spaced grid of dots used as wallpaper.
// -----------------------------------------------------------------------------
class _DottedBackgroundPainter extends CustomPainter {
  const _DottedBackgroundPainter({
    required this.spacing,
    required this.dotRadius,
    required this.dotColor,
    required this.background,
  });

  final double spacing;
  final double dotRadius;
  final Color dotColor;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = background;
    canvas.drawRect(Offset.zero & size, bg);

    final Paint dot = Paint()
      ..color = dotColor
      ..isAntiAlias = true;
    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedBackgroundPainter oldDelegate) {
    return oldDelegate.spacing != spacing ||
        oldDelegate.dotRadius != dotRadius ||
        oldDelegate.dotColor != dotColor ||
        oldDelegate.background != background;
  }
}

// -----------------------------------------------------------------------------
// _SignaturePainter — paints the strokes captured by a signature pad.
//
// The painter listens to a `ValueNotifier<List<List<Offset>>>` so it repaints
// whenever a new point is appended.  Each inner `List<Offset>` is one stroke.
// -----------------------------------------------------------------------------
class _SignaturePainter extends CustomPainter {
  _SignaturePainter({
    required this.strokes,
    required this.inkColor,
    required this.background,
  }) : super(repaint: strokes);

  final ValueNotifier<List<List<Offset>>> strokes;
  final Color inkColor;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = background;
    canvas.drawRect(Offset.zero & size, bg);

    final Paint ink = Paint()
      ..color = inkColor
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    for (final List<Offset> stroke in strokes.value) {
      if (stroke.length < 2) {
        if (stroke.length == 1) {
          canvas.drawCircle(stroke.first, 1.4, Paint()..color = inkColor);
        }
        continue;
      }
      final Path path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, ink);
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    // The Listenable supplied to super already drives repaints on stroke
    // mutation.  Identity comparisons here cover palette changes.
    return oldDelegate.inkColor != inkColor ||
        oldDelegate.background != background ||
        oldDelegate.strokes != strokes;
  }
}

// -----------------------------------------------------------------------------
// _AnimatedPulsePainter — a pulsing concentric ring, driven by a 0..1 value.
// -----------------------------------------------------------------------------
class _AnimatedPulsePainter extends CustomPainter {
  const _AnimatedPulsePainter({
    required this.t,
    required this.color,
  });

  final double t; // 0..1
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE0F2F1);
    canvas.drawRect(Offset.zero & size, bg);

    final Offset c = Offset(size.width / 2, size.height / 2);
    final double maxR = math.min(size.width, size.height) / 2 - 4;

    // 3 staggered rings.
    for (int i = 0; i < 3; i++) {
      final double phase = (t + i / 3.0) % 1.0;
      final double r = maxR * phase;
      final double alpha = (1.0 - phase).clamp(0.0, 1.0);
      final Paint p = Paint()
        ..color = color.withOpacity(alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawCircle(c, r, p);
    }

    // Solid centre dot pulses size with t.
    final double dotR = 4 + 6 * (0.5 + 0.5 * math.sin(t * 2 * math.pi));
    final Paint dot = Paint()..color = color;
    canvas.drawCircle(c, dotR, dot);
  }

  @override
  bool shouldRepaint(covariant _AnimatedPulsePainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.color != color;
  }
}

// -----------------------------------------------------------------------------
// _WastefulPainter — always returns `true` from `shouldRepaint`, which forces
// a repaint every frame even when nothing has changed.  Used in the demo to
// contrast with a frugal painter.
// -----------------------------------------------------------------------------
class _WastefulPainter extends CustomPainter {
  _WastefulPainter({required this.color, required this.counter});

  final Color color;
  final ValueNotifier<int> counter;

  @override
  void paint(Canvas canvas, Size size) {
    // Defer the counter bump out of the paint phase. Mutating a `ValueNotifier`
    // here would notify any `ValueListenableBuilder` listener synchronously and
    // schedule a `setState` while the framework is still painting, raising
    // "Build scheduled during frame." See `_FrugalPainter` for the same idiom.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      counter.value = counter.value + 1;
    });
    final Paint bg = Paint()..color = const Color(0xFFD7CCC8);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint dot = Paint()..color = color;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 16, dot);
  }

  @override
  bool shouldRepaint(covariant _WastefulPainter oldDelegate) => true;
}

// -----------------------------------------------------------------------------
// _FrugalPainter — only repaints when its parameters actually change.
// -----------------------------------------------------------------------------
class _FrugalPainter extends CustomPainter {
  _FrugalPainter({required this.color, required this.counter});

  final Color color;
  final ValueNotifier<int> counter;

  @override
  void paint(Canvas canvas, Size size) {
    // Same deferral as `_WastefulPainter`: bump the counter after the frame
    // completes so the `ValueListenableBuilder<int>` rebuild does not fire
    // synchronously inside paint.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      counter.value = counter.value + 1;
    });
    final Paint bg = Paint()..color = const Color(0xFFD7CCC8);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint sq = Paint()..color = color;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 32,
        height: 32,
      ),
      sq,
    );
  }

  @override
  bool shouldRepaint(covariant _FrugalPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

// -----------------------------------------------------------------------------
// _CircleHitPainter — draws a filled circle and reports hit-tests inside it.
//
// Overrides `hitTest(Offset)` so the surrounding `CustomPaint` can be made
// hit-testable in a non-rectangular way.
// -----------------------------------------------------------------------------
class _CircleHitPainter extends CustomPainter {
  const _CircleHitPainter({
    required this.radius,
    required this.fillColor,
  });

  final double radius;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFB2DFDB);
    canvas.drawRect(Offset.zero & size, bg);

    final Offset centre = Offset(size.width / 2, size.height / 2);
    final Paint p = Paint()
      ..color = fillColor
      ..isAntiAlias = true;
    canvas.drawCircle(centre, radius, p);

    final Paint ring = Paint()
      ..color = const Color(0xFF003D33)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(centre, radius, ring);
  }

  @override
  bool shouldRepaint(covariant _CircleHitPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.fillColor != fillColor;
  }

  @override
  bool? hitTest(Offset position) {
    // Hit testing in painter-local coordinates.  We don't know the host size
    // here, but the host size is fixed (200) for this section so the centre is
    // well-defined.  In production, push the centre via the constructor.
    const double host = 200.0;
    final Offset centre = const Offset(host / 2, host / 2);
    final double d = (position - centre).distance;
    return d <= radius;
  }
}

// -----------------------------------------------------------------------------
// _ForegroundCrossPainter — paints a translucent diagonal cross.  Used as the
// `foregroundPainter` to overlay markings on whatever the main painter draws.
// -----------------------------------------------------------------------------
class _ForegroundCrossPainter extends CustomPainter {
  const _ForegroundCrossPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), p);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), p);
  }

  @override
  bool shouldRepaint(covariant _ForegroundCrossPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

// -----------------------------------------------------------------------------
// _CheckerPainter — plain background painter showing a checkerboard, used as
// the "back" layer in the layered-painters demo.
// -----------------------------------------------------------------------------
class _CheckerPainter extends CustomPainter {
  const _CheckerPainter({
    required this.cell,
    required this.colorA,
    required this.colorB,
  });

  final double cell;
  final Color colorA;
  final Color colorB;

  @override
  void paint(Canvas canvas, Size size) {
    for (double y = 0; y < size.height; y += cell) {
      for (double x = 0; x < size.width; x += cell) {
        final bool even = (((x ~/ cell) + (y ~/ cell)) % 2) == 0;
        final Paint p = Paint()..color = even ? colorA : colorB;
        canvas.drawRect(Rect.fromLTWH(x, y, cell, cell), p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CheckerPainter oldDelegate) {
    return oldDelegate.cell != cell ||
        oldDelegate.colorA != colorA ||
        oldDelegate.colorB != colorB;
  }
}

// =============================================================================
// Section helpers — tiny widget builders to keep section code uniform.
// =============================================================================

Widget _sectionHeader(String number, String title, Color bg, Color ink) {
  return Container(
    width: double.infinity,
    color: bg,
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
    child: Row(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: ink,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _card({required Color bg, required List<Widget> children}) {
  return Container(
    width: double.infinity,
    color: bg,
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _bodyText(String text, {required Color color, double fontSize = 13}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(text, style: TextStyle(color: color, fontSize: fontSize)),
  );
}

Widget _label(String text, {required Color color}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 4),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    ),
  );
}

Widget _canvasFrame({
  required double width,
  required double height,
  required Widget child,
  Color border = const Color(0xFF607D8B),
}) {
  return Center(
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: border, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    ),
  );
}

// =============================================================================
// Top-level build.
// =============================================================================
dynamic build(BuildContext context) {
  // Long-lived notifiers used across sections.  These are intentionally kept at
  // build-scope so the sections that read them all share identity; in a real
  // app they would live on a State object, but the harness contract forbids
  // top-level state outside the build function.
  final ValueNotifier<double> animTick = ValueNotifier<double>(0.0);
  final ValueNotifier<int> wastefulCount = ValueNotifier<int>(0);
  final ValueNotifier<int> frugalCount = ValueNotifier<int>(0);
  final ValueNotifier<List<List<Offset>>> strokes =
      ValueNotifier<List<List<Offset>>>(<List<Offset>>[]);

  // ---------------------------------------------------------------------------
  // 1 — Intro card.
  // ---------------------------------------------------------------------------
  final Widget introSection = _card(
    bg: _introBg,
    children: <Widget>[
      _label('What is CustomPainter?', color: _introInk),
      _bodyText(
        'CustomPainter is the lowest-level Flutter drawing primitive that you '
        'are likely to touch from widget code.  You subclass it, override '
        'paint(Canvas, Size) to issue drawing commands, and override '
        'shouldRepaint(oldDelegate) to tell Flutter when the painter must '
        're-run.',
        color: _introInk,
      ),
      _bodyText(
        'A CustomPainter is hosted by the CustomPaint widget.  CustomPaint '
        'sizes itself to its child (or to its size: argument when no child is '
        'given) and forwards that size to paint().',
        color: _introInk,
      ),
      _bodyText(
        'Two slots exist on every CustomPaint: painter (drawn behind the '
        'child) and foregroundPainter (drawn in front of the child).  The '
        'child itself can be a normal widget — backgrounds and overlays are '
        'a common use of these two slots.',
        color: _introInk,
      ),
      _label('paint() contract', color: _introInk),
      _bodyText(
        '  void paint(Canvas canvas, Size size)',
        color: _introInk,
      ),
      _bodyText(
        '  - canvas: the imperative drawing surface',
        color: _introInk,
      ),
      _bodyText(
        '  - size: the area Flutter has reserved for you',
        color: _introInk,
      ),
      _bodyText(
        'Coordinates start at (0, 0) in the top-left.  Flutter automatically '
        'clips your drawing to the size, but for performance you should still '
        'avoid drawing far outside it.',
        color: _introInk,
      ),
      _label('shouldRepaint() contract', color: _introInk),
      _bodyText(
        '  bool shouldRepaint(covariant CustomPainter oldDelegate)',
        color: _introInk,
      ),
      _bodyText(
        'Return true only if your paint output would actually differ from '
        'oldDelegate.  Returning true unconditionally is a common, costly '
        'bug — see the shouldRepaint section below.',
        color: _introInk,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 2 — _GridPainter showcase.
  // ---------------------------------------------------------------------------
  final Widget gridSection = _card(
    bg: _gridBg,
    children: <Widget>[
      _label('_GridPainter', color: _gridInk),
      _bodyText(
        'Demonstrates Canvas.drawLine plus a stroke-style Paint.  The grid '
        'highlights the centre axes with a heavier line.',
        color: _gridInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 280,
        height: 200,
        child: CustomPaint(
          size: const Size(280, 200),
          painter: const _GridPainter(
            cellSize: 20,
            lineColor: Color(0xFFBBDEFB),
            axisColor: _gridAccent,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 3 — _RadarSweepPainter showcase (static — animation lives in section 11).
  // ---------------------------------------------------------------------------
  final Widget radarSection = _card(
    bg: _radarBg,
    children: <Widget>[
      _label('_RadarSweepPainter', color: _radarInk),
      _bodyText(
        'Concentric rings + cardinal spokes + a single sweep wedge drawn with '
        'drawArc and a SweepGradient shader.',
        color: _radarInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 240,
        height: 240,
        child: CustomPaint(
          size: const Size(240, 240),
          painter: const _RadarSweepPainter(
            sweepAngle: 1.2,
            ringColor: Color(0xFFA5D6A7),
            sweepColor: _radarAccent,
            rings: 4,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 4 — _SineWavePainter showcase.
  // ---------------------------------------------------------------------------
  final Widget sineSection = _card(
    bg: _sineBg,
    children: <Widget>[
      _label('_SineWavePainter', color: _sineInk),
      _bodyText(
        'Builds a Path with moveTo/lineTo and strokes it with rounded caps. '
        'Frequency and amplitude are constructor parameters.',
        color: _sineInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 320,
        height: 160,
        child: CustomPaint(
          size: const Size(320, 160),
          painter: const _SineWavePainter(
            amplitude: 40,
            frequency: 2.5,
            phase: 0.4,
            lineColor: _sineAccent,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 5 — _StarBurstPainter showcase.
  // ---------------------------------------------------------------------------
  final Widget starSection = _card(
    bg: _starBg,
    children: <Widget>[
      _label('_StarBurstPainter', color: _starInk),
      _bodyText(
        'Closed Path built from polar coordinates.  Filled and stroked with '
        'two passes for a clean rim.',
        color: _starInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 200,
        height: 200,
        child: CustomPaint(
          size: const Size(200, 200),
          painter: const _StarBurstPainter(
            points: 5,
            fillColor: Color(0xFFF8BBD0),
            strokeColor: _starAccent,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 6 — _BarChartPainter showcase.
  // ---------------------------------------------------------------------------
  final Widget barSection = _card(
    bg: _barBg,
    children: <Widget>[
      _label('_BarChartPainter', color: _barInk),
      _bodyText(
        'Recipe: data visualisation.  Takes a List<double>, draws axis lines, '
        'rounded-rect bars and per-bar labels via TextPainter.',
        color: _barInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 320,
        height: 200,
        child: CustomPaint(
          size: const Size(320, 200),
          painter: const _BarChartPainter(
            values: <double>[3, 7, 4, 9, 6, 2, 8, 5, 7, 3],
            barColor: _barAccent,
            axisColor: _barInk,
            labelColor: _barInk,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 7 — _GaugePainter showcase.
  // ---------------------------------------------------------------------------
  final Widget gaugeSection = _card(
    bg: _gaugeBg,
    children: <Widget>[
      _label('_GaugePainter', color: _gaugeInk),
      _bodyText(
        'Half-circle gauge with tick labels and a needle.  Demonstrates '
        'drawArc and per-tick TextPainter labels positioned with trig.',
        color: _gaugeInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 280,
        height: 180,
        child: CustomPaint(
          size: const Size(280, 180),
          painter: const _GaugePainter(
            value: 64,
            minValue: 0,
            maxValue: 100,
            dialColor: Color(0xFFB39DDB),
            needleColor: _gaugeAccent,
            tickColor: _gaugeInk,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 8 — _PolygonPainter showcase.
  // ---------------------------------------------------------------------------
  final Widget polySection = _card(
    bg: _polyBg,
    children: <Widget>[
      _label('_PolygonPainter', color: _polyInk),
      _bodyText(
        'Regular n-gon centred in the canvas.  Both fill and stroke are '
        'applied to the same path; note the roundness is controlled by '
        'StrokeJoin.round on the stroke pass.',
        color: _polyInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 220,
        height: 220,
        child: CustomPaint(
          size: const Size(220, 220),
          painter: const _PolygonPainter(
            sides: 6,
            rotation: 0.2,
            fillColor: Color(0xFFFFE082),
            strokeColor: _polyAccent,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 9 — _ConfettiPainter showcase.
  // ---------------------------------------------------------------------------
  final Widget confettiSection = _card(
    bg: _confettiBg,
    children: <Widget>[
      _label('_ConfettiPainter', color: _confettiInk),
      _bodyText(
        'Many rotated rectangles scattered over the canvas using save/'
        'translate/rotate/restore.  A seeded math.Random keeps the layout '
        'reproducible across rebuilds.',
        color: _confettiInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 320,
        height: 180,
        child: CustomPaint(
          size: const Size(320, 180),
          painter: const _ConfettiPainter(
            count: 80,
            seed: 7,
            palette: <Color>[
              Color(0xFFEF5350),
              Color(0xFF42A5F5),
              Color(0xFFFFCA28),
              Color(0xFF66BB6A),
              Color(0xFFAB47BC),
            ],
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 10 — _DottedBackgroundPainter (used as a wallpaper layer in section 14).
  // ---------------------------------------------------------------------------
  final Widget dottedSection = _card(
    bg: _dottedBg,
    children: <Widget>[
      _label('_DottedBackgroundPainter', color: _dottedInk),
      _bodyText(
        'Recipe: dashed/dotted background.  A tight grid of small filled '
        'circles drawn behind a child widget.  Use this as a low-contrast '
        'wallpaper for canvases that host other content.',
        color: _dottedInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 320,
        height: 140,
        child: CustomPaint(
          size: const Size(320, 140),
          painter: const _DottedBackgroundPainter(
            spacing: 14,
            dotRadius: 1.6,
            dotColor: _dottedAccent,
            background: Color(0xFFF8F0FB),
          ),
          child: const Center(
            child: Text(
              'Child rides on top of the dotted painter',
              style: TextStyle(color: _dottedInk, fontSize: 13),
            ),
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 11 — Animated painter via TweenAnimationBuilder + ValueNotifier.
  // ---------------------------------------------------------------------------
  final Widget animSection = _card(
    bg: _animBg,
    children: <Widget>[
      _label('Animated painter', color: _animInk),
      _bodyText(
        'A CustomPaint can animate by accepting a Listenable into its painter '
        'constructor (CustomPainter has a `super(repaint: listenable)` slot) '
        'or by being rebuilt from above with a fresh painter instance every '
        'frame.  Here we drive _AnimatedPulsePainter with a 4-second '
        'TweenAnimationBuilder that loops 0..1.',
        color: _animInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 220,
        height: 220,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 4),
          onEnd: () {
            // Reset the controller value so the build below sees it loop.
            animTick.value = animTick.value + 1;
          },
          builder: (BuildContext context, double t, Widget? child) {
            return CustomPaint(
              size: const Size(220, 220),
              painter: _AnimatedPulsePainter(t: t, color: _animAccent),
            );
          },
        ),
      ),
      const SizedBox(height: 8),
      _bodyText(
        'For interactive animations driven by user input, prefer passing a '
        'ValueNotifier into super(repaint: ...) — the painter rebuilds only '
        'when the notifier changes, not when the parent does.',
        color: _animInk,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 12 — Interactive painter — slider drives polygon sides.
  // ---------------------------------------------------------------------------
  final Widget interactSection = _card(
    bg: _interactBg,
    children: <Widget>[
      _label('Interactive painter', color: _interactInk),
      _bodyText(
        'A Slider drives the side count of _PolygonPainter via setState in a '
        'StatefulBuilder.  shouldRepaint compares the new sides to the old, '
        'so dragging the slider produces exactly one repaint per discrete '
        'value change.',
        color: _interactInk,
      ),
      const SizedBox(height: 8),
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          int sides = 5;
          double rotation = 0.0;
          return StatefulBuilder(
            builder: (BuildContext context2, StateSetter setState2) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _canvasFrame(
                    width: 220,
                    height: 220,
                    child: CustomPaint(
                      size: const Size(220, 220),
                      painter: _PolygonPainter(
                        sides: sides,
                        rotation: rotation,
                        fillColor: const Color(0xFFFFF59D),
                        strokeColor: _interactAccent,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 4),
                      Text('sides: $sides', style: TextStyle(color: _interactInk)),
                      Expanded(
                        child: Slider(
                          value: sides.toDouble(),
                          min: 3,
                          max: 12,
                          divisions: 9,
                          activeColor: _interactAccent,
                          onChanged: (double v) {
                            setState2(() => sides = v.round());
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 4),
                      Text(
                        'rotation: ${rotation.toStringAsFixed(2)}',
                        style: TextStyle(color: _interactInk),
                      ),
                      Expanded(
                        child: Slider(
                          value: rotation,
                          min: 0,
                          max: math.pi,
                          activeColor: _interactAccent,
                          onChanged: (double v) {
                            setState2(() => rotation = v);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 13 — shouldRepaint discussion: wasteful vs frugal.
  // ---------------------------------------------------------------------------
  final Widget repaintSection = _card(
    bg: _repaintBg,
    children: <Widget>[
      _label('shouldRepaint discussion', color: _repaintInk),
      _bodyText(
        'shouldRepaint(oldDelegate) is called when the host CustomPaint is '
        'rebuilt with a NEW painter delegate.  Returning true forces a '
        'repaint; returning false means Flutter reuses the previously '
        'rasterised layer.',
        color: _repaintInk,
      ),
      _bodyText(
        'Below: two painters side-by-side, both rebuilt by the same '
        'StatefulBuilder.  Press the button to trigger a rebuild.',
        color: _repaintInk,
      ),
      const SizedBox(height: 8),
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Wasteful (always repaints)',
                          style: TextStyle(
                            color: _repaintInk,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _canvasFrame(
                          width: 120,
                          height: 120,
                          child: CustomPaint(
                            size: const Size(120, 120),
                            painter: _WastefulPainter(
                              color: _repaintAccent,
                              counter: wastefulCount,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        ValueListenableBuilder<int>(
                          valueListenable: wastefulCount,
                          builder: (BuildContext c, int v, Widget? _) =>
                              Text(
                            'paint() called: $v',
                            style: TextStyle(color: _repaintInk),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Frugal (compares params)',
                          style: TextStyle(
                            color: _repaintInk,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _canvasFrame(
                          width: 120,
                          height: 120,
                          child: CustomPaint(
                            size: const Size(120, 120),
                            painter: _FrugalPainter(
                              color: _repaintAccent,
                              counter: frugalCount,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        ValueListenableBuilder<int>(
                          valueListenable: frugalCount,
                          builder: (BuildContext c, int v, Widget? _) =>
                              Text(
                            'paint() called: $v',
                            style: TextStyle(color: _repaintInk),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                  onPressed: () => setState(() {}),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _repaintAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Force rebuild'),
                ),
              ),
              const SizedBox(height: 6),
              _bodyText(
                'Each rebuild instantiates fresh painter delegates with the '
                'same parameters.  The wasteful painter still calls paint(); '
                'the frugal one does not, because shouldRepaint returns '
                'false when the colour is unchanged.',
                color: _repaintInk,
              ),
            ],
          );
        },
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 14 — Hit testing via hitTest(Offset).
  // ---------------------------------------------------------------------------
  final Widget hitSection = _card(
    bg: _hitBg,
    children: <Widget>[
      _label('Custom hit testing', color: _hitInk),
      _bodyText(
        'CustomPainter.hitTest(Offset) lets you constrain hit detection to a '
        'non-rectangular region.  _CircleHitPainter only reports hits inside '
        'its filled circle.',
        color: _hitInk,
      ),
      const SizedBox(height: 8),
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          String message = 'Tap inside or outside the circle';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTapDown: (TapDownDetails d) {
                    final Offset local = d.localPosition;
                    const Offset c = Offset(100, 100);
                    final double dist = (local - c).distance;
                    setState(() {
                      message = dist <= 60
                          ? 'HIT inside circle (d=${dist.toStringAsFixed(1)})'
                          : 'MISS outside circle (d=${dist.toStringAsFixed(1)})';
                    });
                  },
                  child: _canvasFrame(
                    width: 200,
                    height: 200,
                    child: const CustomPaint(
                      size: Size(200, 200),
                      painter: _CircleHitPainter(
                        radius: 60,
                        fillColor: Color(0xFF80CBC4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: _hitInk,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              _bodyText(
                'Note: hitTest is only consulted when CustomPaint has no child '
                'or when the child does not absorb the gesture.  In '
                'production, prefer pushing the geometry into the painter '
                'constructor rather than hard-coding it like the demo does.',
                color: _hitInk,
              ),
            ],
          );
        },
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 15 — foregroundPainter vs painter.
  // ---------------------------------------------------------------------------
  final Widget foreSection = _card(
    bg: _foreBg,
    children: <Widget>[
      _label('foregroundPainter vs painter', color: _foreInk),
      _bodyText(
        'CustomPaint.painter draws BEHIND the child; '
        'CustomPaint.foregroundPainter draws IN FRONT.  The child is rendered '
        'in between, like a sandwich.',
        color: _foreInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 280,
        height: 200,
        child: CustomPaint(
          size: const Size(280, 200),
          painter: const _GridPainter(
            cellSize: 20,
            lineColor: Color(0xFFB0BEC5),
            axisColor: _foreAccent,
            background: Color(0xFFECEFF1),
          ),
          foregroundPainter:
              const _ForegroundCrossPainter(color: Color(0x80B71C1C)),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Child sits between painter (grid) and foregroundPainter (X)',
                textAlign: TextAlign.center,
                style: TextStyle(color: _foreInk, fontSize: 12),
              ),
            ),
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 16 — Layered painters via Stack.
  // ---------------------------------------------------------------------------
  final Widget layerSection = _card(
    bg: _layerBg,
    children: <Widget>[
      _label('Layered painters via Stack', color: _layerInk),
      _bodyText(
        'When two effects are independent and you do not want to merge them '
        'into a single CustomPainter, stack two CustomPaint widgets.  Each '
        'one paints to its own layer and shouldRepaint independently.',
        color: _layerInk,
      ),
      const SizedBox(height: 8),
      _canvasFrame(
        width: 280,
        height: 200,
        child: Stack(
          children: <Widget>[
            CustomPaint(
              size: const Size(280, 200),
              painter: const _CheckerPainter(
                cell: 16,
                colorA: Color(0xFFE8EAF6),
                colorB: Color(0xFFC5CAE9),
              ),
            ),
            CustomPaint(
              size: const Size(280, 200),
              painter: const _SineWavePainter(
                amplitude: 36,
                frequency: 2,
                phase: 0,
                lineColor: _layerAccent,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 17 — Signature pad recipe.
  // ---------------------------------------------------------------------------
  final Widget signatureSection = _card(
    bg: _signatureBg,
    children: <Widget>[
      _label('Signature pad recipe', color: _signatureInk),
      _bodyText(
        'A GestureDetector captures pan events; each pan-start opens a new '
        'inner stroke list, each pan-update appends an Offset, and the '
        'CustomPainter listens to a ValueNotifier<List<List<Offset>>> for '
        'efficient incremental redraws.',
        color: _signatureInk,
      ),
      const SizedBox(height: 8),
      Center(
        child: GestureDetector(
          onPanStart: (DragStartDetails d) {
            final List<List<Offset>> current =
                List<List<Offset>>.from(strokes.value);
            current.add(<Offset>[d.localPosition]);
            strokes.value = current;
          },
          onPanUpdate: (DragUpdateDetails d) {
            final List<List<Offset>> current =
                List<List<Offset>>.from(strokes.value);
            if (current.isEmpty) {
              current.add(<Offset>[]);
            }
            final List<Offset> last = List<Offset>.from(current.last)
              ..add(d.localPosition);
            current[current.length - 1] = last;
            strokes.value = current;
          },
          child: Container(
            width: 320,
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: _signatureAccent, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            clipBehavior: Clip.hardEdge,
            child: CustomPaint(
              size: const Size(320, 160),
              painter: _SignaturePainter(
                strokes: strokes,
                inkColor: _signatureAccent,
                background: const Color(0xFFFFF8F8),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Center(
        child: TextButton(
          onPressed: () => strokes.value = <List<Offset>>[],
          style: TextButton.styleFrom(foregroundColor: _signatureAccent),
          child: const Text('Clear'),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 18 — Decision card.
  // ---------------------------------------------------------------------------
  final Widget decisionSection = _card(
    bg: _decisionBg,
    children: <Widget>[
      _label('CustomPainter vs Container/DecoratedBox/Stack', color: _decisionInk),
      _bodyText(
        'When to reach for CustomPainter:',
        color: _decisionInk,
      ),
      _bodyText(
        '  - shapes that no built-in widget can render (stars, gauges, ',
        color: _decisionInk,
      ),
      _bodyText(
        '    polygons, signature paths, charts)',
        color: _decisionInk,
      ),
      _bodyText(
        '  - fine-grained pixel-accurate control of strokes, joins, caps',
        color: _decisionInk,
      ),
      _bodyText(
        '  - performance-critical visuals where a single layer is cheaper '
        'than a tree of widgets',
        color: _decisionInk,
      ),
      _bodyText(
        '  - data-driven graphics that change parameters but not structure',
        color: _decisionInk,
      ),
      const SizedBox(height: 6),
      _bodyText(
        'When to prefer Container / DecoratedBox / Stack:',
        color: _decisionInk,
      ),
      _bodyText(
        '  - simple gradients, borders, rounded rectangles → DecoratedBox',
        color: _decisionInk,
      ),
      _bodyText(
        '  - layered widgets with their own state and gesture handling → '
        'Stack',
        color: _decisionInk,
      ),
      _bodyText(
        '  - one-off shadows, paddings, alignments → Container',
        color: _decisionInk,
      ),
      _bodyText(
        '  - any shape Flutter already paints natively (RRect, ovals, '
        'arrows, dividers) — re-using a widget is cheaper than rolling a '
        'painter.',
        color: _decisionInk,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // 19 — Reference card.
  // ---------------------------------------------------------------------------
  final Widget refSection = _card(
    bg: _refBg,
    children: <Widget>[
      _label('Painter reference table', color: _refInk),
      _bodyText('Painter                       Size        Repaint behaviour',
          color: _refInk),
      _bodyText('_GridPainter                  any         params equality',
          color: _refInk),
      _bodyText('_RadarSweepPainter            square      sweepAngle changes',
          color: _refInk),
      _bodyText('_SineWavePainter              any         params equality',
          color: _refInk),
      _bodyText('_StarBurstPainter             square      params equality',
          color: _refInk),
      _bodyText('_BarChartPainter              any         deep value compare',
          color: _refInk),
      _bodyText('_GaugePainter                 wide        value changes',
          color: _refInk),
      _bodyText('_PolygonPainter               square      sides + rotation',
          color: _refInk),
      _bodyText('_ConfettiPainter              any         seed/count change',
          color: _refInk),
      _bodyText('_DottedBackgroundPainter      any         spacing/colour',
          color: _refInk),
      _bodyText('_SignaturePainter             any         super(repaint:)',
          color: _refInk),
      _bodyText('_AnimatedPulsePainter         square      tween-driven',
          color: _refInk),
      _bodyText('_WastefulPainter              any         always true (bad)',
          color: _refInk),
      _bodyText('_FrugalPainter                any         params equality',
          color: _refInk),
      _bodyText('_CircleHitPainter             square      params equality',
          color: _refInk),
      _bodyText('_ForegroundCrossPainter       any         colour change',
          color: _refInk),
      _bodyText('_CheckerPainter               any         cell/colour change',
          color: _refInk),
      const SizedBox(height: 12),
      _label('Canvas API quick tour', color: _refInk),
      _bodyText('  drawLine(p1, p2, paint)            stroke a single segment',
          color: _refInk),
      _bodyText('  drawRect(rect, paint)              fill or stroke a rect',
          color: _refInk),
      _bodyText('  drawRRect(rrect, paint)            same but rounded',
          color: _refInk),
      _bodyText('  drawCircle(centre, r, paint)       fast disc/ring',
          color: _refInk),
      _bodyText('  drawArc(rect, start, sweep, ...)   slice of circle',
          color: _refInk),
      _bodyText('  drawPath(path, paint)              arbitrary closed/open path',
          color: _refInk),
      _bodyText('  drawOval(rect, paint)              ellipse fitted in rect',
          color: _refInk),
      _bodyText('  save() / restore()                 stack canvas transform',
          color: _refInk),
      _bodyText('  translate / rotate / scale         transform helpers',
          color: _refInk),
      _bodyText('  TextPainter(...).layout(); paint() draw text via TextPainter',
          color: _refInk),
      const SizedBox(height: 12),
      _label('Paint configuration', color: _refInk),
      _bodyText('  Paint.style       fill (default) or stroke',
          color: _refInk),
      _bodyText('  Paint.strokeWidth pixels',
          color: _refInk),
      _bodyText('  Paint.strokeCap   butt / round / square',
          color: _refInk),
      _bodyText('  Paint.strokeJoin  miter / round / bevel',
          color: _refInk),
      _bodyText('  Paint.color       opaque colour',
          color: _refInk),
      _bodyText('  Paint.shader      gradient or image shader',
          color: _refInk),
      _bodyText('  Paint.isAntiAlias true (default) for smooth edges',
          color: _refInk),
      _bodyText('  Paint.blendMode   how this paint composites onto target',
          color: _refInk),
      const SizedBox(height: 12),
      _label('Performance tips', color: _refInk),
      _bodyText(
        '  - Compare actual fields in shouldRepaint, never return true blindly.',
        color: _refInk,
      ),
      _bodyText(
        '  - Pass a Listenable into super(repaint:) so paint() runs without '
        'a parent rebuild.',
        color: _refInk,
      ),
      _bodyText(
        '  - Build Path objects once and reuse them when only colour changes.',
        color: _refInk,
      ),
      _bodyText(
        '  - Prefer drawCircle/drawRect over drawPath for primitives — '
        'Skia has fast paths for them.',
        color: _refInk,
      ),
      _bodyText(
        '  - Wrap heavy painters in a RepaintBoundary so they do not invalidate '
        'their neighbours.',
        color: _refInk,
      ),
      _bodyText(
        '  - For very large scenes, consider RenderObject + Layer instead of '
        'CustomPainter.',
        color: _refInk,
      ),
      const SizedBox(height: 12),
      _label('Animation tracker', color: _refInk),
      ValueListenableBuilder<double>(
        valueListenable: animTick,
        builder: (BuildContext c, double v, Widget? _) =>
            _bodyText('animTick = ${v.toStringAsFixed(2)}', color: _refInk),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Top-level assembly.
  // ---------------------------------------------------------------------------
  return MaterialApp(
    title: 'CustomPainter Deep Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: _introAccent),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: _introAccent,
        foregroundColor: Colors.white,
        title: const Text('CustomPainter — Deep Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _sectionHeader('1', 'Intro — paint() and shouldRepaint contract',
                  _introBg, _introInk),
              introSection,
              _sectionHeader('2', '_GridPainter', _gridBg, _gridInk),
              gridSection,
              _sectionHeader('3', '_RadarSweepPainter', _radarBg, _radarInk),
              radarSection,
              _sectionHeader('4', '_SineWavePainter', _sineBg, _sineInk),
              sineSection,
              _sectionHeader('5', '_StarBurstPainter', _starBg, _starInk),
              starSection,
              _sectionHeader(
                  '6', '_BarChartPainter (data-viz recipe)', _barBg, _barInk),
              barSection,
              _sectionHeader('7', '_GaugePainter', _gaugeBg, _gaugeInk),
              gaugeSection,
              _sectionHeader('8', '_PolygonPainter', _polyBg, _polyInk),
              polySection,
              _sectionHeader('9', '_ConfettiPainter', _confettiBg, _confettiInk),
              confettiSection,
              _sectionHeader('10', '_DottedBackgroundPainter (background recipe)',
                  _dottedBg, _dottedInk),
              dottedSection,
              _sectionHeader(
                  '11', 'Animated painter (TweenAnimationBuilder)', _animBg, _animInk),
              animSection,
              _sectionHeader('12', 'Interactive painter (slider-driven)',
                  _interactBg, _interactInk),
              interactSection,
              _sectionHeader('13', 'shouldRepaint — wasteful vs frugal',
                  _repaintBg, _repaintInk),
              repaintSection,
              _sectionHeader('14', 'Hit testing via hitTest(Offset)', _hitBg,
                  _hitInk),
              hitSection,
              _sectionHeader('15', 'foregroundPainter vs painter', _foreBg,
                  _foreInk),
              foreSection,
              _sectionHeader('16', 'Layered painters via Stack', _layerBg,
                  _layerInk),
              layerSection,
              _sectionHeader(
                  '17', 'Signature pad (gesture recipe)', _signatureBg, _signatureInk),
              signatureSection,
              _sectionHeader('18', 'Decision — CustomPainter vs alternatives',
                  _decisionBg, _decisionInk),
              decisionSection,
              _sectionHeader('19', 'Painter reference + Canvas API tour',
                  _refBg, _refInk),
              refSection,
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
