// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =============================================================================
// PolynomialFit — visual deep dive
// -----------------------------------------------------------------------------
// `PolynomialFit` is the result of fitting an `n`-degree polynomial to a set
// of `(x, y, w)` samples using `LeastSquaresSolver.solve(n)`. Internally, the
// Flutter framework leans on this machinery whenever a finger is sliding on
// the screen: every `PointerMoveEvent` is forwarded to a `VelocityTracker`
// which, when the gesture finishes, asks a least-squares solver to fit a
// degree-2 polynomial (a parabola) through the most recent ~100 ms of
// samples. The slope of that parabola at `t = now` is the velocity that gets
// reported to drag/fling recognizers.
//
// This demo renders the full chain end-to-end: raw scatter samples, the
// fitted polynomial, the coefficients vector, the `confidence` (r²) metric,
// and how all of that ladders up to `Velocity` and `VelocityEstimate`.
// =============================================================================

// ---------------------------------------------------------------------------
// Palette + spacing constants. Single source of truth so painters and
// section cards stay visually aligned.
// ---------------------------------------------------------------------------
const Color _privateInk = Color(0xFF1A1B23);
const Color _privateInkSoft = Color(0xFF555770);
const Color _privatePaper = Color(0xFFFAFAF7);
const Color _privatePaperWarm = Color(0xFFFFF7EC);
const Color _privatePaperCold = Color(0xFFEAF1F6);
const Color _privateAccent = Color(0xFF6A4CFF);
const Color _privateAccentSoft = Color(0xFFE6DEFF);
const Color _privateScatter = Color(0xFFD83B5C);
const Color _privateFit = Color(0xFF1F8F66);
const Color _privateGrid = Color(0xFFD8D6CC);
const Color _privateConsoleBg = Color(0xFF11131B);
const Color _privateConsoleFg = Color(0xFFCFEAFF);

const double _privateGap = 16;
const double _privateGapBig = 28;

// ---------------------------------------------------------------------------
// Tiny value-types used by the painters.
// ---------------------------------------------------------------------------
class _PrivateSample {
  const _PrivateSample(this.x, this.y, [this.w = 1.0]);
  final double x;
  final double y;
  final double w;
}

class _PrivateAxisRange {
  const _PrivateAxisRange(this.minX, this.maxX, this.minY, this.maxY);
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  Offset toCanvas(double x, double y, Size s, EdgeInsets pad) {
    final double cw = s.width - pad.left - pad.right;
    final double ch = s.height - pad.top - pad.bottom;
    final double nx = (x - minX) / (maxX - minX);
    final double ny = (y - minY) / (maxY - minY);
    return Offset(pad.left + nx * cw, pad.top + (1.0 - ny) * ch);
  }
}

// ---------------------------------------------------------------------------
// Worked-example payload: a list of samples + a fitted curve + metadata.
// Everything required to render a worked-example card is bundled into one
// of these so the section list stays readable.
// ---------------------------------------------------------------------------
class _PrivateWorkedExample {
  const _PrivateWorkedExample({
    required this.title,
    required this.story,
    required this.samples,
    required this.degree,
    required this.range,
    required this.tint,
  });
  final String title;
  final String story;
  final List<_PrivateSample> samples;
  final int degree;
  final _PrivateAxisRange range;
  final Color tint;
}

// ---------------------------------------------------------------------------
// Confidence scenario: same axis range, same shape of "story", but different
// noise levels so the reader can see r² collapse from ~1.0 to ~0.0.
// ---------------------------------------------------------------------------
class _PrivateConfidenceCase {
  const _PrivateConfidenceCase({
    required this.label,
    required this.subtitle,
    required this.samples,
    required this.tint,
  });
  final String label;
  final String subtitle;
  final List<_PrivateSample> samples;
  final Color tint;
}

// ---------------------------------------------------------------------------
// Section descriptor used by the page composer.
// ---------------------------------------------------------------------------
class _PrivateSection {
  const _PrivateSection({
    required this.heading,
    required this.lead,
    required this.builder,
  });
  final String heading;
  final String lead;
  final Widget Function(BuildContext) builder;
}

// =============================================================================
// Numerical helpers. We re-implement a thin solver wrapper so the page can
// always render *some* fit, even when `LeastSquaresSolver.solve` returns null
// (e.g. when there are not enough samples for the requested degree).
// =============================================================================

double _privateEvalPoly(List<double> coeffs, double x) {
  // Horner's scheme: numerically more stable than naive sum of x^i terms.
  double acc = 0.0;
  for (int i = coeffs.length - 1; i >= 0; i -= 1) {
    acc = acc * x + coeffs[i];
  }
  return acc;
}

double _privatePolyDerivative(List<double> coeffs, double x) {
  // Derivative of a 0..n polynomial evaluated at x.
  double acc = 0.0;
  for (int i = coeffs.length - 1; i >= 1; i -= 1) {
    acc = acc * x + coeffs[i] * i;
  }
  return acc;
}

PolynomialFit? _privateSolveOrNull(
  List<_PrivateSample> samples,
  int degree,
) {
  if (samples.length < degree + 1) return null;
  final List<double> xs = <double>[];
  final List<double> ys = <double>[];
  final List<double> ws = <double>[];
  for (final _PrivateSample s in samples) {
    xs.add(s.x);
    ys.add(s.y);
    ws.add(s.w);
  }
  final LeastSquaresSolver solver = LeastSquaresSolver(xs, ys, ws);
  return solver.solve(degree);
}

PolynomialFit _privateSolveOrFallback(
  List<_PrivateSample> samples,
  int degree,
) {
  final PolynomialFit? real = _privateSolveOrNull(samples, degree);
  if (real != null) return real;
  // Fallback: a hand-rolled fit instance so we still have something to draw.
  // We mutate `coefficients` and `confidence` for illustration; this is the
  // *only* place we do so — every other plot uses a real solver result.
  final PolynomialFit hand = PolynomialFit(degree);
  for (int i = 0; i < hand.coefficients.length; i += 1) {
    hand.coefficients[i] = 0.0;
  }
  hand.confidence = 0.0;
  return hand;
}

// =============================================================================
// CustomPainter — draws axes, grid, scatter samples, and a fitted polynomial.
// Reused by every plot in this file so visual style stays consistent.
// =============================================================================
class _PrivateScatterFitPainter extends CustomPainter {
  _PrivateScatterFitPainter({
    required this.samples,
    required this.fit,
    required this.range,
    required this.fitColor,
    this.showWeights = false,
    this.showResiduals = false,
    this.label,
  });

  final List<_PrivateSample> samples;
  final PolynomialFit fit;
  final _PrivateAxisRange range;
  final Color fitColor;
  final bool showWeights;
  final bool showResiduals;
  final String? label;

  static const EdgeInsets _pad = EdgeInsets.fromLTRB(40, 16, 16, 32);

  @override
  void paint(Canvas canvas, Size size) {
    _paintBackground(canvas, size);
    _paintGrid(canvas, size);
    _paintAxes(canvas, size);
    if (showResiduals) _paintResiduals(canvas, size);
    _paintFit(canvas, size);
    _paintSamples(canvas, size);
    _paintLabel(canvas, size);
  }

  void _paintBackground(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _privatePaper;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)),
      bg,
    );
  }

  void _paintGrid(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = _privateGrid
      ..strokeWidth = 1;
    const int divisions = 5;
    for (int i = 0; i <= divisions; i += 1) {
      final double t = i / divisions;
      final double x = range.minX + (range.maxX - range.minX) * t;
      final double y = range.minY + (range.maxY - range.minY) * t;
      final Offset top = range.toCanvas(x, range.maxY, size, _pad);
      final Offset bot = range.toCanvas(x, range.minY, size, _pad);
      canvas.drawLine(top, bot, grid);
      final Offset left = range.toCanvas(range.minX, y, size, _pad);
      final Offset right = range.toCanvas(range.maxX, y, size, _pad);
      canvas.drawLine(left, right, grid);
    }
  }

  void _paintAxes(Canvas canvas, Size size) {
    final Paint axis = Paint()
      ..color = _privateInkSoft
      ..strokeWidth = 1.2;
    final Offset origin = Offset(_pad.left, size.height - _pad.bottom);
    final Offset xEnd = Offset(size.width - _pad.right, size.height - _pad.bottom);
    final Offset yEnd = Offset(_pad.left, _pad.top);
    canvas.drawLine(origin, xEnd, axis);
    canvas.drawLine(origin, yEnd, axis);

    // Axis tick labels (min and max only, to keep things calm).
    _drawText(canvas, range.minX.toStringAsFixed(1), origin + const Offset(-6, 4));
    _drawText(canvas, range.maxX.toStringAsFixed(1), xEnd + const Offset(-22, 4));
    _drawText(canvas, range.minY.toStringAsFixed(0), origin + const Offset(-32, -6));
    _drawText(canvas, range.maxY.toStringAsFixed(0), yEnd + const Offset(-32, -4));
  }

  void _paintResiduals(Canvas canvas, Size size) {
    final Paint resPaint = Paint()
      ..color = _privateScatter.withValues(alpha: 0.35)
      ..strokeWidth = 1;
    for (final _PrivateSample s in samples) {
      final double yHat = _privateEvalPoly(fit.coefficients, s.x);
      final Offset a = range.toCanvas(s.x, s.y, size, _pad);
      final Offset b = range.toCanvas(s.x, yHat, size, _pad);
      canvas.drawLine(a, b, resPaint);
    }
  }

  void _paintFit(Canvas canvas, Size size) {
    if (fit.coefficients.isEmpty) return;
    final Paint line = Paint()
      ..color = fitColor
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const int steps = 240;
    final Path path = Path();
    bool started = false;
    for (int i = 0; i <= steps; i += 1) {
      final double t = i / steps;
      final double x = range.minX + (range.maxX - range.minX) * t;
      final double y = _privateEvalPoly(fit.coefficients, x);
      if (y.isNaN || y.isInfinite) continue;
      final Offset p = range.toCanvas(x, y, size, _pad);
      if (!started) {
        path.moveTo(p.dx, p.dy);
        started = true;
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path, line);
  }

  void _paintSamples(Canvas canvas, Size size) {
    final Paint dotFill = Paint()..color = _privateScatter;
    final Paint dotEdge = Paint()
      ..color = _privatePaper
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    for (final _PrivateSample s in samples) {
      final Offset p = range.toCanvas(s.x, s.y, size, _pad);
      final double r = showWeights ? (3.0 + s.w * 3.5) : 4.0;
      canvas.drawCircle(p, r, dotFill);
      canvas.drawCircle(p, r, dotEdge);
    }
  }

  void _paintLabel(Canvas canvas, Size size) {
    if (label == null) return;
    _drawText(canvas, label!, Offset(size.width - _pad.right - 90, _pad.top));
  }

  void _drawText(Canvas canvas, String text, Offset origin) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: _privateInkSoft, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, origin);
  }

  @override
  bool shouldRepaint(covariant _PrivateScatterFitPainter oldDelegate) {
    return oldDelegate.samples != samples ||
        oldDelegate.fit != fit ||
        oldDelegate.range != range ||
        oldDelegate.fitColor != fitColor ||
        oldDelegate.showWeights != showWeights ||
        oldDelegate.showResiduals != showResiduals;
  }
}

// =============================================================================
// CustomPainter — draws THREE polynomial fits (degree 1, 2, 3) over the
// same scatter, so the reader can compare the bias/variance tradeoff at a
// glance.
// =============================================================================
class _PrivateMultiDegreePainter extends CustomPainter {
  _PrivateMultiDegreePainter({
    required this.samples,
    required this.fits,
    required this.colors,
    required this.range,
  });

  final List<_PrivateSample> samples;
  final List<PolynomialFit> fits;
  final List<Color> colors;
  final _PrivateAxisRange range;

  static const EdgeInsets _pad = EdgeInsets.fromLTRB(40, 16, 16, 32);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _privatePaper;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)),
      bg,
    );
    _paintGrid(canvas, size);
    for (int i = 0; i < fits.length; i += 1) {
      _paintFit(canvas, size, fits[i], colors[i % colors.length]);
    }
    _paintSamples(canvas, size);
  }

  void _paintGrid(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = _privateGrid
      ..strokeWidth = 1;
    const int divisions = 5;
    for (int i = 0; i <= divisions; i += 1) {
      final double t = i / divisions;
      final double x = range.minX + (range.maxX - range.minX) * t;
      final double y = range.minY + (range.maxY - range.minY) * t;
      canvas.drawLine(
        range.toCanvas(x, range.maxY, size, _pad),
        range.toCanvas(x, range.minY, size, _pad),
        grid,
      );
      canvas.drawLine(
        range.toCanvas(range.minX, y, size, _pad),
        range.toCanvas(range.maxX, y, size, _pad),
        grid,
      );
    }
  }

  void _paintFit(Canvas canvas, Size size, PolynomialFit fit, Color c) {
    if (fit.coefficients.isEmpty) return;
    final Paint line = Paint()
      ..color = c
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const int steps = 240;
    final Path path = Path();
    bool started = false;
    for (int i = 0; i <= steps; i += 1) {
      final double t = i / steps;
      final double x = range.minX + (range.maxX - range.minX) * t;
      final double y = _privateEvalPoly(fit.coefficients, x);
      if (y.isNaN || y.isInfinite) continue;
      final Offset p = range.toCanvas(x, y, size, _pad);
      if (!started) {
        path.moveTo(p.dx, p.dy);
        started = true;
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path, line);
  }

  void _paintSamples(Canvas canvas, Size size) {
    final Paint dot = Paint()..color = _privateScatter;
    for (final _PrivateSample s in samples) {
      canvas.drawCircle(range.toCanvas(s.x, s.y, size, _pad), 4, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _PrivateMultiDegreePainter oldDelegate) {
    return oldDelegate.samples != samples || oldDelegate.fits != fits;
  }
}

// =============================================================================
// CustomPainter — pipeline diagram showing how a `PointerMoveEvent` walks
// through `VelocityTracker` → `LeastSquaresSolver.solve(2)` → `PolynomialFit`
// → `Velocity`. This is purely informational — no math is run here.
// =============================================================================
class _PrivatePipelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _privatePaperCold;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)),
      bg,
    );

    final List<String> nodes = <String>[
      'PointerMoveEvent',
      'VelocityTracker.addPosition',
      '_DragGestureRecognizer.acceptGesture',
      'tracker.getVelocity()',
      'LeastSquaresSolver.solve(2)',
      'PolynomialFit\ncoefficients[0..2]',
      'Velocity(pixelsPerSecond)',
    ];

    final double slot = size.width / nodes.length;
    final Paint box = Paint()..color = _privatePaper;
    final Paint border = Paint()
      ..color = _privateAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Paint arrow = Paint()
      ..color = _privateInkSoft
      ..strokeWidth = 1.6;

    for (int i = 0; i < nodes.length; i += 1) {
      final double cx = slot * i + slot / 2;
      final Rect r = Rect.fromCenter(
        center: Offset(cx, size.height / 2),
        width: slot - 12,
        height: size.height - 24,
      );
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(6));
      canvas.drawRRect(rr, box);
      canvas.drawRRect(rr, border);
      _drawCenteredText(canvas, nodes[i], r);
      if (i < nodes.length - 1) {
        final Offset a = Offset(r.right, size.height / 2);
        final Offset b = Offset(r.right + 12, size.height / 2);
        canvas.drawLine(a, b, arrow);
        final Path tri = Path()
          ..moveTo(b.dx, b.dy)
          ..lineTo(b.dx - 5, b.dy - 4)
          ..lineTo(b.dx - 5, b.dy + 4)
          ..close();
        canvas.drawPath(tri, Paint()..color = _privateInkSoft);
      }
    }
  }

  void _drawCenteredText(Canvas canvas, String text, Rect r) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: _privateInk,
          fontSize: 9.5,
          height: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    tp.layout(maxWidth: r.width - 6);
    tp.paint(
      canvas,
      Offset(
        r.center.dx - tp.width / 2,
        r.center.dy - tp.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// CustomPainter — a bar/gauge for a single `confidence` value (0..1). Used by
// the confidence cluster cards.
// =============================================================================
class _PrivateConfidenceBarPainter extends CustomPainter {
  _PrivateConfidenceBarPainter(this.confidence, this.tint);
  final double confidence;
  final Color tint;

  @override
  void paint(Canvas canvas, Size size) {
    final RRect track = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, size.height / 2 - 4, size.width, 8),
      const Radius.circular(4),
    );
    canvas.drawRRect(track, Paint()..color = _privateGrid);
    final double clamped = confidence.clamp(0.0, 1.0);
    final RRect bar = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, size.height / 2 - 4, size.width * clamped, 8),
      const Radius.circular(4),
    );
    canvas.drawRRect(bar, Paint()..color = tint);
  }

  @override
  bool shouldRepaint(covariant _PrivateConfidenceBarPainter oldDelegate) {
    return oldDelegate.confidence != confidence || oldDelegate.tint != tint;
  }
}

// =============================================================================
// Worked-example sample data. Each list mimics a finger-drag or scroll
// trajectory in (time-ms, position-px) form.
// =============================================================================

List<_PrivateSample> _privateLinearDrag() {
  // Constant velocity — slope ~ 1.5 px/ms = 1500 px/s.
  return const <_PrivateSample>[
    _PrivateSample(0, 100),
    _PrivateSample(16, 124),
    _PrivateSample(32, 148),
    _PrivateSample(48, 172),
    _PrivateSample(64, 196),
    _PrivateSample(80, 220),
    _PrivateSample(96, 244),
  ];
}

List<_PrivateSample> _privateAcceleratingFling() {
  // Parabolic — finger accelerates as it lifts off. Classic fling profile.
  return const <_PrivateSample>[
    _PrivateSample(0, 50),
    _PrivateSample(16, 58),
    _PrivateSample(32, 76),
    _PrivateSample(48, 110),
    _PrivateSample(64, 158),
    _PrivateSample(80, 218),
    _PrivateSample(96, 290),
  ];
}

List<_PrivateSample> _privateDeceleratingDrag() {
  // Inverse parabola — finger slows down before lifting (a "soft release").
  return const <_PrivateSample>[
    _PrivateSample(0, 0),
    _PrivateSample(16, 80),
    _PrivateSample(32, 148),
    _PrivateSample(48, 200),
    _PrivateSample(64, 236),
    _PrivateSample(80, 256),
    _PrivateSample(96, 264),
  ];
}

List<_PrivateSample> _privateNoisyDrag() {
  // Mostly linear but with sensor jitter — confidence will drop noticeably.
  return const <_PrivateSample>[
    _PrivateSample(0, 100),
    _PrivateSample(16, 130),
    _PrivateSample(32, 142),
    _PrivateSample(48, 178),
    _PrivateSample(64, 188),
    _PrivateSample(80, 232),
    _PrivateSample(96, 240),
  ];
}

List<_PrivateSample> _privateWeightedRecent() {
  // Same as linear, but the most recent samples carry more weight: this
  // mimics `VelocityTracker`'s behaviour of preferring fresh data.
  return const <_PrivateSample>[
    _PrivateSample(0, 100, 0.2),
    _PrivateSample(16, 124, 0.3),
    _PrivateSample(32, 148, 0.5),
    _PrivateSample(48, 172, 0.7),
    _PrivateSample(64, 196, 0.85),
    _PrivateSample(80, 220, 0.95),
    _PrivateSample(96, 244, 1.0),
  ];
}

List<_PrivateSample> _privateMicroPause() {
  // Finger paused mid-drag — interesting because a degree-2 fit will still
  // happily produce a smooth parabola through the inflection.
  return const <_PrivateSample>[
    _PrivateSample(0, 0),
    _PrivateSample(16, 40),
    _PrivateSample(32, 60),
    _PrivateSample(48, 62),
    _PrivateSample(64, 80),
    _PrivateSample(80, 130),
    _PrivateSample(96, 200),
  ];
}

// ---------------------------------------------------------------------------
// Confidence-cluster scenarios.
// ---------------------------------------------------------------------------
List<_PrivateConfidenceCase> _privateConfidenceCases() {
  return <_PrivateConfidenceCase>[
    _PrivateConfidenceCase(
      label: 'tight cluster',
      subtitle: 'low jitter',
      tint: const Color(0xFF1F8F66),
      samples: const <_PrivateSample>[
        _PrivateSample(0, 100),
        _PrivateSample(16, 124),
        _PrivateSample(32, 148),
        _PrivateSample(48, 172),
        _PrivateSample(64, 196),
        _PrivateSample(80, 220),
        _PrivateSample(96, 244),
      ],
    ),
    _PrivateConfidenceCase(
      label: 'mild noise',
      subtitle: '±2 px wobble',
      tint: const Color(0xFF73B33B),
      samples: const <_PrivateSample>[
        _PrivateSample(0, 100),
        _PrivateSample(16, 126),
        _PrivateSample(32, 146),
        _PrivateSample(48, 173),
        _PrivateSample(64, 195),
        _PrivateSample(80, 222),
        _PrivateSample(96, 243),
      ],
    ),
    _PrivateConfidenceCase(
      label: 'medium noise',
      subtitle: '±8 px wobble',
      tint: const Color(0xFFD8A23B),
      samples: const <_PrivateSample>[
        _PrivateSample(0, 100),
        _PrivateSample(16, 132),
        _PrivateSample(32, 140),
        _PrivateSample(48, 180),
        _PrivateSample(64, 188),
        _PrivateSample(80, 230),
        _PrivateSample(96, 238),
      ],
    ),
    _PrivateConfidenceCase(
      label: 'heavy noise',
      subtitle: '±25 px wobble',
      tint: const Color(0xFFE07A2C),
      samples: const <_PrivateSample>[
        _PrivateSample(0, 100),
        _PrivateSample(16, 145),
        _PrivateSample(32, 130),
        _PrivateSample(48, 200),
        _PrivateSample(64, 175),
        _PrivateSample(80, 250),
        _PrivateSample(96, 220),
      ],
    ),
    _PrivateConfidenceCase(
      label: 'random scatter',
      subtitle: 'no clear trend',
      tint: const Color(0xFFD83B5C),
      samples: const <_PrivateSample>[
        _PrivateSample(0, 180),
        _PrivateSample(16, 90),
        _PrivateSample(32, 220),
        _PrivateSample(48, 110),
        _PrivateSample(64, 200),
        _PrivateSample(80, 95),
        _PrivateSample(96, 230),
      ],
    ),
  ];
}

// ---------------------------------------------------------------------------
// All worked examples.
// ---------------------------------------------------------------------------
List<_PrivateWorkedExample> _privateWorkedExamples() {
  const _PrivateAxisRange dragRange = _PrivateAxisRange(0, 96, 0, 320);
  return <_PrivateWorkedExample>[
    _PrivateWorkedExample(
      title: '1. Linear drag (constant velocity)',
      story:
          'Finger slides at 1500 px/s. A degree-1 fit recovers the slope '
          'cleanly; degree-2 also works, with the squared coefficient near 0.',
      samples: _privateLinearDrag(),
      degree: 2,
      range: dragRange,
      tint: _privateFit,
    ),
    _PrivateWorkedExample(
      title: '2. Accelerating fling',
      story:
          'Finger speeds up before lift-off. The squared coefficient becomes '
          'large and positive; the slope at t=now is the lift-off velocity.',
      samples: _privateAcceleratingFling(),
      degree: 2,
      range: dragRange,
      tint: _privateAccent,
    ),
    _PrivateWorkedExample(
      title: '3. Decelerating drag (soft release)',
      story:
          'The most common UI pattern: slow down before letting go. '
          'Squared coefficient is negative; slope at t=now is small.',
      samples: _privateDeceleratingDrag(),
      degree: 2,
      range: dragRange,
      tint: const Color(0xFFD8A23B),
    ),
    _PrivateWorkedExample(
      title: '4. Noisy drag (sensor jitter)',
      story:
          'Same trajectory as #1 with ±10 px sensor noise. The fit absorbs '
          'the noise but `confidence` drops well below 1.0.',
      samples: _privateNoisyDrag(),
      degree: 2,
      range: dragRange,
      tint: const Color(0xFFE07A2C),
    ),
    _PrivateWorkedExample(
      title: '5. Weighted recent samples',
      story:
          'Identical positions to #1 but with VelocityTracker-style weights '
          '(recent > old). The fit privileges fresh data near t=now.',
      samples: _privateWeightedRecent(),
      degree: 2,
      range: dragRange,
      tint: const Color(0xFF6A4CFF),
    ),
    _PrivateWorkedExample(
      title: '6. Micro-pause then accelerate',
      story:
          'Inflection mid-drag. A degree-2 fit smears the pause into the '
          'parabola — a higher degree would track it more faithfully.',
      samples: _privateMicroPause(),
      degree: 2,
      range: dragRange,
      tint: const Color(0xFFD83B5C),
    ),
  ];
}

// =============================================================================
// Console-style code listing widget.
// =============================================================================
Widget _privateConsole(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _privateConsoleBg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _privateConsoleFg,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.45,
      ),
    ),
  );
}

// =============================================================================
// Section heading + lead paragraph helper.
// =============================================================================
Widget _privateSectionHeader(String heading, String lead) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        heading,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: _privateInk,
          letterSpacing: -0.4,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        lead,
        style: const TextStyle(
          fontSize: 14,
          color: _privateInkSoft,
          height: 1.45,
        ),
      ),
      const SizedBox(height: 14),
    ],
  );
}

// =============================================================================
// Hero card.
// =============================================================================
Widget _privateHeroCard() {
  final List<_PrivateSample> samples = _privateAcceleratingFling();
  final PolynomialFit fit = _privateSolveOrFallback(samples, 2);
  const _PrivateAxisRange range = _PrivateAxisRange(0, 96, 0, 320);

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_privateAccent, Color(0xFF8E78FF)],
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'PolynomialFit',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'package:flutter/gestures.dart  ·  result of LeastSquaresSolver.solve(n)',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 18),
        Container(
          height: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomPaint(
            painter: _PrivateScatterFitPainter(
              samples: samples,
              fit: fit,
              range: range,
              fitColor: _privateAccent,
              showResiduals: true,
              label: 'degree 2',
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: <Widget>[
            _privateChip('coefficients', _formatCoeffs(fit.coefficients)),
            _privateChip('confidence', fit.confidence.toStringAsFixed(4)),
            _privateChip('samples', '${samples.length}'),
            _privateChip('degree', '2'),
          ],
        ),
      ],
    ),
  );
}

Widget _privateChip(String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
    ),
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
}

String _formatCoeffs(List<double> c) {
  if (c.isEmpty) return '[]';
  return '[${c.map((double v) => v.toStringAsPrecision(3)).join(', ')}]';
}

// =============================================================================
// Section: anatomy of PolynomialFit.
// =============================================================================
Widget _privateAnatomyCard() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _privatePaperWarm,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _privateGrid),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy of PolynomialFit',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        _privateConsole(
          'class PolynomialFit {\n'
          '  PolynomialFit(int degree)\n'
          '    : coefficients = Float64List(degree + 1);\n\n'
          '  /// c[i] is the coefficient of x^i.\n'
          '  final List<double> coefficients;\n\n'
          '  /// r-squared. 1.0 = perfect fit, 0.0 = no relationship.\n'
          '  late double confidence;\n'
          '}',
        ),
        const SizedBox(height: 14),
        const Text(
          'Three things to remember:',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        _privateBullet(
          'A degree-n fit has exactly n+1 coefficients (the constant term '
          'lives at index 0).',
        ),
        _privateBullet(
          '`coefficients` is mutable (a Float64List) — solvers write into '
          'it directly. You generally do not write to it yourself.',
        ),
        _privateBullet(
          '`confidence` is initialised lazily; it is set to a real r² value '
          'by the end of `LeastSquaresSolver.solve`.',
        ),
      ],
    ),
  );
}

Widget _privateBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 8),
          child: Icon(Icons.circle, size: 6, color: _privateInkSoft),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: _privateInk,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: worked examples grid.
// =============================================================================
Widget _privateWorkedExamplesGrid() {
  final List<_PrivateWorkedExample> examples = _privateWorkedExamples();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      for (final _PrivateWorkedExample ex in examples) ...<Widget>[
        _privateWorkedCard(ex),
        const SizedBox(height: _privateGap),
      ],
    ],
  );
}

Widget _privateWorkedCard(_PrivateWorkedExample ex) {
  final PolynomialFit fit = _privateSolveOrFallback(ex.samples, ex.degree);
  final double slopeAtEnd = _privatePolyDerivative(
    fit.coefficients,
    ex.samples.last.x,
  );
  // Convert px/ms → px/s for the human readout.
  final double pxPerSecond = slopeAtEnd * 1000;

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _privatePaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _privateGrid),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ex.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: ex.tint,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          ex.story,
          style: const TextStyle(
            fontSize: 13,
            color: _privateInkSoft,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _PrivateScatterFitPainter(
              samples: ex.samples,
              fit: fit,
              range: ex.range,
              fitColor: ex.tint,
              showResiduals: true,
              showWeights: ex.title.contains('Weighted'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _privateConsole(
          '> samples = ${ex.samples.length}\n'
          '> solver  = LeastSquaresSolver(xs, ys, ws)\n'
          '> fit     = solver.solve(${ex.degree})\n'
          '\n'
          '  fit.coefficients = ${_formatCoeffs(fit.coefficients)}\n'
          '  fit.confidence   = ${fit.confidence.toStringAsFixed(5)}\n'
          '  slope @ t_end    = ${slopeAtEnd.toStringAsFixed(3)} px/ms '
          '(${pxPerSecond.toStringAsFixed(0)} px/s)',
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: degree comparison.
// =============================================================================
Widget _privateDegreeComparison() {
  final List<_PrivateSample> samples = _privateAcceleratingFling();
  final PolynomialFit deg1 = _privateSolveOrFallback(samples, 1);
  final PolynomialFit deg2 = _privateSolveOrFallback(samples, 2);
  final PolynomialFit deg3 = _privateSolveOrFallback(samples, 3);
  const _PrivateAxisRange range = _PrivateAxisRange(0, 96, 0, 320);

  final List<Color> colors = <Color>[
    const Color(0xFFD8A23B),
    _privateAccent,
    _privateFit,
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _privatePaper,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _privateGrid),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Same data, three degrees',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 240,
              child: CustomPaint(
                painter: _PrivateMultiDegreePainter(
                  samples: samples,
                  fits: <PolynomialFit>[deg1, deg2, deg3],
                  colors: colors,
                  range: range,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: <Widget>[
                _privateLegendDot('degree 1 (line)', colors[0]),
                _privateLegendDot('degree 2 (parabola)', colors[1]),
                _privateLegendDot('degree 3 (cubic)', colors[2]),
              ],
            ),
            const SizedBox(height: 14),
            _privateConsole(
              'degree 1: coeffs=${_formatCoeffs(deg1.coefficients)}  '
              'r²=${deg1.confidence.toStringAsFixed(4)}\n'
              'degree 2: coeffs=${_formatCoeffs(deg2.coefficients)}  '
              'r²=${deg2.confidence.toStringAsFixed(4)}\n'
              'degree 3: coeffs=${_formatCoeffs(deg3.coefficients)}  '
              'r²=${deg3.confidence.toStringAsFixed(4)}',
            ),
            const SizedBox(height: 10),
            const Text(
              'Higher degree never reduces r² on the training data, but risks '
              'overfitting noise. Flutter uses degree 2 for VelocityTracker as '
              'a good bias/variance tradeoff for short pointer histories.',
              style: TextStyle(
                fontSize: 12,
                color: _privateInkSoft,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _privateLegendDot(String label, Color tint) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}

// =============================================================================
// Section: VelocityTracker pipeline.
// =============================================================================
Widget _privateVelocityTrackerPipeline() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _privatePaperCold,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _privateGrid),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'How VelocityTracker uses PolynomialFit',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 90,
              child: CustomPaint(painter: _PrivatePipelinePainter()),
            ),
            const SizedBox(height: 14),
            _privateConsole(
              '// Inside VelocityTracker.getVelocity():\n'
              '\n'
              'final solver = LeastSquaresSolver(xs, ys, ws);\n'
              'final fit    = solver.solve(2);          // degree-2 fit\n'
              'if (fit == null) return Velocity.zero;\n'
              '\n'
              '// At t = now, position = c0 + c1*t + c2*t²\n'
              '// d/dt position = c1 + 2*c2*t\n'
              'final pixelsPerMs = fit.coefficients[1] + 2 * fit.coefficients[2] * t;\n'
              'return Velocity(pixelsPerSecond: Offset(vx, vy) * 1000);',
            ),
            const SizedBox(height: 10),
            const Text(
              'In practice both axes (x and y) are tracked independently and '
              'recombined into a single Offset. The slope is taken at the '
              'newest sample, which is why the same `coefficients[1]` does '
              'NOT directly give you the velocity for a degree-2 fit.',
              style: TextStyle(
                fontSize: 12,
                color: _privateInkSoft,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// Section: confidence cluster.
// =============================================================================
Widget _privateConfidenceCluster() {
  final List<_PrivateConfidenceCase> cases = _privateConfidenceCases();
  const _PrivateAxisRange range = _PrivateAxisRange(0, 96, 0, 280);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Confidence — from r²≈1 to r²≈0',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 10),
      for (final _PrivateConfidenceCase c in cases) ...<Widget>[
        _privateConfidenceTile(c, range),
        const SizedBox(height: _privateGap),
      ],
    ],
  );
}

Widget _privateConfidenceTile(_PrivateConfidenceCase c, _PrivateAxisRange range) {
  final PolynomialFit fit = _privateSolveOrFallback(c.samples, 2);
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _privatePaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _privateGrid),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: c.tint,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              c.label,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: 8),
            Text(
              c.subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: _privateInkSoft,
              ),
            ),
            const Spacer(),
            Text(
              'r² = ${fit.confidence.toStringAsFixed(4)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 32,
          child: CustomPaint(
            painter: _PrivateConfidenceBarPainter(fit.confidence, c.tint),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 160,
          child: CustomPaint(
            painter: _PrivateScatterFitPainter(
              samples: c.samples,
              fit: fit,
              range: range,
              fitColor: c.tint,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: recipe code listing.
// =============================================================================
Widget _privateRecipeListing() {
  return _privateConsole(
    '// Recipe: estimate fling velocity from a list of (t, x) samples.\n'
    'import \'package:flutter/gestures.dart\';\n'
    '\n'
    'Velocity estimateVelocity(List<Offset> positions, List<int> times) {\n'
    '  final xs = times.map((t) => t.toDouble()).toList();\n'
    '  final yx = positions.map((p) => p.dx).toList();\n'
    '  final yy = positions.map((p) => p.dy).toList();\n'
    '  final ws = List<double>.filled(times.length, 1.0);\n'
    '\n'
    '  final fitX = LeastSquaresSolver(xs, yx, ws).solve(2);\n'
    '  final fitY = LeastSquaresSolver(xs, yy, ws).solve(2);\n'
    '  if (fitX == null || fitY == null) return Velocity.zero;\n'
    '\n'
    '  // slope at t = times.last\n'
    '  final t = xs.last;\n'
    '  final vx = fitX.coefficients[1] + 2 * fitX.coefficients[2] * t;\n'
    '  final vy = fitY.coefficients[1] + 2 * fitY.coefficients[2] * t;\n'
    '\n'
    '  // xs were in ms → multiply by 1000 for px/s.\n'
    '  return Velocity(pixelsPerSecond: Offset(vx, vy) * 1000);\n'
    '}',
  );
}

// =============================================================================
// Section: relationship with VelocityEstimate.
// =============================================================================
Widget _privateVelocityEstimateCard() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _privateAccentSoft,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'PolynomialFit ↔ VelocityEstimate ↔ Velocity',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'PolynomialFit is the raw mathematical result. VelocityTracker '
          'wraps it in a richer object so callers also get a confidence '
          'score and the time/distance window the fit covers.',
          style: TextStyle(fontSize: 13, color: _privateInk, height: 1.45),
        ),
        const SizedBox(height: 12),
        _privateConsole(
          'class VelocityEstimate {\n'
          '  final Offset pixelsPerSecond; // = derivative of fit @ t_now\n'
          '  final double confidence;      // = fit.confidence\n'
          '  final Duration duration;      // window covered by the samples\n'
          '  final Offset offset;          // total pointer displacement\n'
          '}\n'
          '\n'
          'class Velocity {\n'
          '  final Offset pixelsPerSecond;\n'
          '  Velocity clampMagnitude(double min, double max) { /* ... */ }\n'
          '}',
        ),
        const SizedBox(height: 10),
        const Text(
          'Both are derived from the same PolynomialFit; VelocityEstimate '
          'preserves the diagnostic info, Velocity is the lean version that '
          'reaches gesture callbacks.',
          style: TextStyle(
            fontSize: 12,
            color: _privateInkSoft,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: pitfalls.
// =============================================================================
Widget _privatePitfallsCard() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF1F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE8B4B4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Pitfalls and gotchas',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        _privatePitfallRow(
          'Need at least degree+1 samples',
          '`solve(n)` returns null if `x.length < n + 1`. For a degree-2 fit '
              'you need 3 samples; VelocityTracker keeps a small ring buffer.',
        ),
        _privatePitfallRow(
          'Weights matter',
          'A uniform weight vector treats every sample equally; '
              'VelocityTracker weights by recency, which dramatically biases '
              'the slope at t=now toward the freshest data.',
        ),
        _privatePitfallRow(
          'confidence is r², not a likelihood',
          'It is the fraction of variance explained by the fit. It is '
              'meaningful relative to other fits on similar data, not as an '
              'absolute "this gesture is real" score.',
        ),
        _privatePitfallRow(
          'Coefficients are written into a Float64List',
          '`PolynomialFit(degree).coefficients.length == degree + 1`. You can '
              'write to it for testing/illustration but solvers will overwrite '
              'on every call.',
        ),
        _privatePitfallRow(
          'Numerical conditioning',
          'If x values are huge (epoch ms instead of relative ms), the '
              'least-squares matrix becomes ill-conditioned and `solve()` may '
              'return null due to precisionErrorTolerance.',
        ),
      ],
    ),
  );
}

Widget _privatePitfallRow(String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 3, right: 10),
          child: Icon(
            Icons.warning_amber_rounded,
            size: 18,
            color: Color(0xFFB94A4A),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: _privateInkSoft,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: footer.
// =============================================================================
Widget _privateFooter() {
  final List<_PrivateSample> samples = _privateLinearDrag();
  final PolynomialFit fit = _privateSolveOrFallback(samples, 1);
  final double slope = fit.coefficients.length >= 2 ? fit.coefficients[1] : 0;
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _privateInk,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'PolynomialFit — TL;DR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A degree-n polynomial fit, returned by LeastSquaresSolver.solve. '
          'Two fields: coefficients[0..n] and confidence (r²). Used by '
          'VelocityTracker with degree 2 to estimate fling velocity from '
          'the last ~100 ms of pointer samples.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 14),
        Text(
          'Sanity check: a constant-velocity drag at ${slope.toStringAsFixed(2)} '
          'px/ms rounds to ${(slope * 1000).toStringAsFixed(0)} px/s — exactly '
          'what VelocityTracker would report for the same samples.',
          style: const TextStyle(
            color: _privateConsoleFg,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'rendered with ${math.pi.toStringAsFixed(4)}-precision  ·  '
          'Flutter gestures library',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Page composition.
// =============================================================================

List<_PrivateSection> _privateSections() {
  return <_PrivateSection>[
    _PrivateSection(
      heading: 'Anatomy',
      lead:
          'PolynomialFit is intentionally minimal: a list of coefficients '
          'and a single r²-style confidence number. Below is its full source '
          'shape and the contract you can rely on.',
      builder: (BuildContext _) => _privateAnatomyCard(),
    ),
    _PrivateSection(
      heading: 'Worked examples',
      lead:
          'Six real-shaped pointer trajectories. For each: the raw samples, '
          'a degree-2 fit drawn over them, the residuals, and a console '
          'block printing the resulting PolynomialFit.',
      builder: (BuildContext _) => _privateWorkedExamplesGrid(),
    ),
    _PrivateSection(
      heading: 'Degree comparison',
      lead:
          'Same samples, three different polynomial degrees. Watch how '
          'higher degrees track the data more closely — and notice that '
          'beyond degree 2 the gain on `confidence` is already small.',
      builder: (BuildContext _) => _privateDegreeComparison(),
    ),
    _PrivateSection(
      heading: 'VelocityTracker pipeline',
      lead:
          'How a single PointerMoveEvent ends up as a Velocity in your '
          'onDragEnd callback, with PolynomialFit sitting at the centre of '
          'the chain.',
      builder: (BuildContext _) => _privateVelocityTrackerPipeline(),
    ),
    _PrivateSection(
      heading: 'Confidence cluster',
      lead:
          'Five scenarios sharing the same underlying linear trend, with '
          'increasing amounts of noise. r² collapses cleanly from ≈1 to ≈0.',
      builder: (BuildContext _) => _privateConfidenceCluster(),
    ),
    _PrivateSection(
      heading: 'Recipe',
      lead:
          'A minimal helper that turns a list of pointer positions into a '
          'Velocity using a degree-2 PolynomialFit on each axis.',
      builder: (BuildContext _) => _privateRecipeListing(),
    ),
    _PrivateSection(
      heading: 'Related types',
      lead:
          'PolynomialFit is the lowest layer; VelocityEstimate and Velocity '
          'sit on top.',
      builder: (BuildContext _) => _privateVelocityEstimateCard(),
    ),
    _PrivateSection(
      heading: 'Pitfalls',
      lead:
          'Things to keep in mind when using PolynomialFit (or reasoning '
          'about VelocityTracker output) in your own gesture pipelines.',
      builder: (BuildContext _) => _privatePitfallsCard(),
    ),
  ];
}

// =============================================================================
// Single static entry point.
// =============================================================================
dynamic build(BuildContext context) {
  final List<_PrivateSection> sections = _privateSections();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _privatePaper,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _privateInk),
      ),
    ),
    home: Scaffold(
      backgroundColor: _privatePaper,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _privateHeroCard(),
            const SizedBox(height: _privateGapBig),
            for (final _PrivateSection s in sections) ...<Widget>[
              _privateSectionHeader(s.heading, s.lead),
              s.builder(context),
              const SizedBox(height: _privateGapBig),
            ],
            _privateFooter(),
          ],
        ),
      ),
    ),
  );
}
