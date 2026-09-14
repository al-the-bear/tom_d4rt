// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// FLUTTER CURVES — A VISUAL DEEP DEMO
// =====================================================================
//
// This file is a long-form, hand-written gallery of Flutter's built-in
// `Curves` catalog. It is intentionally verbose: every named curve in
// `package:flutter/material.dart`'s `Curves` class is plotted, named,
// described, and grouped into families. Sibling curve types (`Threshold`,
// `Interval`, `SawTooth`, `FlippedCurve`, `Split`) are also illustrated.
//
// Hard rules followed in this file:
//   * Single static `dynamic build(BuildContext)` entry point.
//   * MaterialApp wrapper.
//   * No setState, no controllers, no async, no Future, no Timer, no
//     streams.
//   * Classes and typedefs are PascalCase; top-level functions and
//     variables are lowerCamelCase.
//   * No `.withOpacity` — `withValues(alpha:)` is used instead.
//   * No inline `// ignore:` directives.
//   * `Curves.X.transform(double t)` is treated as a pure function and
//     called inside `CustomPainter.paint` for plotting.
//
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// SECTION 0 — DESIGN TOKENS
// ---------------------------------------------------------------------
// Pulled out as top-level lowerCamelCase constants so the rest of the
// file reads like a static document rather than an app.
// ---------------------------------------------------------------------

const Color paperColor = Color(0xFFF6F1E7);
const Color inkColor = Color(0xFF1F2933);
const Color mutedInkColor = Color(0xFF52606D);
const Color accentBlue = Color(0xFF2563EB);
const Color accentRed = Color(0xFFDC2626);
const Color accentGreen = Color(0xFF16A34A);
const Color accentAmber = Color(0xFFD97706);
const Color accentPurple = Color(0xFF7C3AED);
const Color accentTeal = Color(0xFF0D9488);
const Color accentPink = Color(0xFFDB2777);
const Color gridColor = Color(0xFFD9D2C2);
const Color cardColor = Color(0xFFFFFCF4);
const Color borderColor = Color(0xFFE3DCC8);

const double sectionSpacing = 36.0;
const double paragraphSpacing = 12.0;
const double tileSpacing = 12.0;

// ---------------------------------------------------------------------
// SECTION 1 — DATA MODELS FOR CURVE METADATA
// ---------------------------------------------------------------------
// We describe each named `Curve` in `Curves` with a small immutable
// record-like class. This keeps plotting code uniform: a plot just needs
// a `Curve` and a label string.
// ---------------------------------------------------------------------

class CurveEntry {
  final String name;
  final Curve curve;
  final String description;
  final Color color;
  const CurveEntry({
    required this.name,
    required this.curve,
    required this.description,
    required this.color,
  });
}

class CurveFamily {
  final String title;
  final String paragraph;
  final List<CurveEntry> entries;
  const CurveFamily({
    required this.title,
    required this.paragraph,
    required this.entries,
  });
}

// ---------------------------------------------------------------------
// SECTION 2 — THE FULL CURVE CATALOG
// ---------------------------------------------------------------------
// Every named constant in `Curves` (as of the supported Flutter SDK).
// Listed once, then referenced by name in family groupings.
// ---------------------------------------------------------------------

const CurveEntry curveLinear = CurveEntry(
  name: 'linear',
  curve: Curves.linear,
  description: 'identity y = t — constant velocity, no easing',
  color: inkColor,
);
const CurveEntry curveDecelerate = CurveEntry(
  name: 'decelerate',
  curve: Curves.decelerate,
  description: 'starts fast, slows down toward the end',
  color: accentBlue,
);
const CurveEntry curveFastLinearToSlowEaseIn = CurveEntry(
  name: 'fastLinearToSlowEaseIn',
  curve: Curves.fastLinearToSlowEaseIn,
  description: 'sharp start, gentle settle — Material standard',
  color: accentTeal,
);
const CurveEntry curveFastEaseInToSlowEaseOut = CurveEntry(
  name: 'fastEaseInToSlowEaseOut',
  curve: Curves.fastEaseInToSlowEaseOut,
  description: 'asymmetric fast-in / slow-out blend',
  color: accentTeal,
);
const CurveEntry curveEase = CurveEntry(
  name: 'ease',
  curve: Curves.ease,
  description: 'CSS classic — gentle accel + decel',
  color: accentBlue,
);
const CurveEntry curveEaseIn = CurveEntry(
  name: 'easeIn',
  curve: Curves.easeIn,
  description: 'slow start, accelerates into motion',
  color: accentBlue,
);
const CurveEntry curveEaseInToLinear = CurveEntry(
  name: 'easeInToLinear',
  curve: Curves.easeInToLinear,
  description: 'easeIn for the first half, linear for the rest',
  color: accentBlue,
);
const CurveEntry curveEaseOut = CurveEntry(
  name: 'easeOut',
  curve: Curves.easeOut,
  description: 'fast start, decelerates to a stop',
  color: accentGreen,
);
const CurveEntry curveEaseOutQuad = CurveEntry(
  name: 'easeOutQuad',
  curve: Curves.easeOutQuad,
  description: 'quadratic deceleration — gentle ramp-out',
  color: accentGreen,
);
const CurveEntry curveEaseOutCubic = CurveEntry(
  name: 'easeOutCubic',
  curve: Curves.easeOutCubic,
  description: 'cubic deceleration — very common in UI',
  color: accentGreen,
);
const CurveEntry curveEaseOutQuart = CurveEntry(
  name: 'easeOutQuart',
  curve: Curves.easeOutQuart,
  description: 'quartic — sharper initial burst',
  color: accentGreen,
);
const CurveEntry curveEaseOutQuint = CurveEntry(
  name: 'easeOutQuint',
  curve: Curves.easeOutQuint,
  description: 'quintic — nearly an instant snap-out',
  color: accentGreen,
);
const CurveEntry curveEaseOutExpo = CurveEntry(
  name: 'easeOutExpo',
  curve: Curves.easeOutExpo,
  description: 'exponential settle — used for entrances',
  color: accentGreen,
);
const CurveEntry curveEaseOutCirc = CurveEntry(
  name: 'easeOutCirc',
  curve: Curves.easeOutCirc,
  description: 'circular ease-out, smooth tangent at end',
  color: accentGreen,
);
const CurveEntry curveEaseOutBack = CurveEntry(
  name: 'easeOutBack',
  curve: Curves.easeOutBack,
  description: 'overshoots past 1.0 then settles back',
  color: accentAmber,
);
const CurveEntry curveEaseInOut = CurveEntry(
  name: 'easeInOut',
  curve: Curves.easeInOut,
  description: 'symmetric S-curve — accel then decel',
  color: accentPurple,
);
const CurveEntry curveEaseInOutSine = CurveEntry(
  name: 'easeInOutSine',
  curve: Curves.easeInOutSine,
  description: 'sinusoidal S-curve — extremely smooth',
  color: accentPurple,
);
const CurveEntry curveEaseInOutQuad = CurveEntry(
  name: 'easeInOutQuad',
  curve: Curves.easeInOutQuad,
  description: 'quadratic S-curve',
  color: accentPurple,
);
const CurveEntry curveEaseInOutCubic = CurveEntry(
  name: 'easeInOutCubic',
  curve: Curves.easeInOutCubic,
  description: 'cubic S-curve — Material default',
  color: accentPurple,
);
const CurveEntry curveEaseInOutCubicEmphasized = CurveEntry(
  name: 'easeInOutCubicEmphasized',
  curve: Curves.easeInOutCubicEmphasized,
  description: 'Material 3 emphasized motion S-curve',
  color: accentPurple,
);
const CurveEntry curveEaseInOutQuart = CurveEntry(
  name: 'easeInOutQuart',
  curve: Curves.easeInOutQuart,
  description: 'quartic S-curve, sharper transitions',
  color: accentPurple,
);
const CurveEntry curveEaseInOutQuint = CurveEntry(
  name: 'easeInOutQuint',
  curve: Curves.easeInOutQuint,
  description: 'quintic S-curve, near-instant midpoint',
  color: accentPurple,
);
const CurveEntry curveEaseInOutCirc = CurveEntry(
  name: 'easeInOutCirc',
  curve: Curves.easeInOutCirc,
  description: 'circular S-curve, very steep middle',
  color: accentPurple,
);
const CurveEntry curveEaseInOutBack = CurveEntry(
  name: 'easeInOutBack',
  curve: Curves.easeInOutBack,
  description: 'undershoots then overshoots — playful',
  color: accentAmber,
);
const CurveEntry curveBounceIn = CurveEntry(
  name: 'bounceIn',
  curve: Curves.bounceIn,
  description: 'bounces near 0 then settles to 1',
  color: accentRed,
);
const CurveEntry curveBounceOut = CurveEntry(
  name: 'bounceOut',
  curve: Curves.bounceOut,
  description: 'overshoots and bounces near 1',
  color: accentRed,
);
const CurveEntry curveBounceInOut = CurveEntry(
  name: 'bounceInOut',
  curve: Curves.bounceInOut,
  description: 'bounces at both ends',
  color: accentRed,
);
const CurveEntry curveElasticIn = CurveEntry(
  name: 'elasticIn',
  curve: Curves.elasticIn,
  description: 'oscillates near 0 before snapping to 1',
  color: accentPink,
);
const CurveEntry curveElasticOut = CurveEntry(
  name: 'elasticOut',
  curve: Curves.elasticOut,
  description: 'overshoots 1 then oscillates back',
  color: accentPink,
);
const CurveEntry curveElasticInOut = CurveEntry(
  name: 'elasticInOut',
  curve: Curves.elasticInOut,
  description: 'oscillates at both endpoints',
  color: accentPink,
);
const CurveEntry curveSlowMiddle = CurveEntry(
  name: 'slowMiddle',
  curve: Curves.slowMiddle,
  description: 'fast at edges, slow through the middle',
  color: accentTeal,
);
const CurveEntry curveFastOutSlowIn = CurveEntry(
  name: 'fastOutSlowIn',
  curve: Curves.fastOutSlowIn,
  description: 'Material standard easing',
  color: accentBlue,
);

// The flat catalog — used for the 6x6 grid and the numeric table.
const List<CurveEntry> allCurves = <CurveEntry>[
  curveLinear,
  curveDecelerate,
  curveFastLinearToSlowEaseIn,
  curveFastEaseInToSlowEaseOut,
  curveEase,
  curveEaseIn,
  curveEaseInToLinear,
  curveEaseOut,
  curveEaseOutQuad,
  curveEaseOutCubic,
  curveEaseOutQuart,
  curveEaseOutQuint,
  curveEaseOutExpo,
  curveEaseOutCirc,
  curveEaseOutBack,
  curveEaseInOut,
  curveEaseInOutSine,
  curveEaseInOutQuad,
  curveEaseInOutCubic,
  curveEaseInOutCubicEmphasized,
  curveEaseInOutQuart,
  curveEaseInOutQuint,
  curveEaseInOutCirc,
  curveEaseInOutBack,
  curveBounceIn,
  curveBounceOut,
  curveBounceInOut,
  curveElasticIn,
  curveElasticOut,
  curveElasticInOut,
  curveSlowMiddle,
  curveFastOutSlowIn,
];

// ---------------------------------------------------------------------
// SECTION 3 — FAMILY GROUPINGS
// ---------------------------------------------------------------------
// These reorganize the catalog by intent: linear+ease, in/out/inOut,
// decelerate, bounce, elastic, sine, special. Each family has a
// paragraph explaining the shape and where it's most useful.
// ---------------------------------------------------------------------

const CurveFamily linearAndEase = CurveFamily(
  title: 'Linear & gentle ease',
  paragraph:
      'These are the simplest curves. `linear` is the identity — it is '
      'the baseline against which every other curve communicates its '
      'character. `ease` is the CSS classic: a soft acceleration into '
      'motion and a soft deceleration out of it. Both feel mechanical '
      'compared to the more nuanced Material curves, but they remain '
      'the right default for tooltips, color crossfades, and any '
      'animation where the eye should not be drawn to the timing.',
  entries: <CurveEntry>[curveLinear, curveEase],
);

const CurveFamily easeInFamily = CurveFamily(
  title: 'easeIn — slow start, fast finish',
  paragraph:
      'Use ease-in curves when an element is leaving the screen or '
      'becoming less prominent. The motion starts gently — drawing the '
      'eye in — and accelerates out, as if the object has fallen off '
      'the edge of attention. `easeIn` is the canonical version; '
      '`easeInToLinear` keeps the gentle start and then locks into '
      'a constant velocity, useful for transitions that hand off to a '
      'scrolling motion or a continuous indicator.',
  entries: <CurveEntry>[curveEaseIn, curveEaseInToLinear],
);

const CurveFamily easeOutFamily = CurveFamily(
  title: 'easeOut — fast start, soft landing',
  paragraph:
      'Ease-out curves are the workhorse of inbound motion. The element '
      'arrives with momentum and settles into place — the brain reads '
      'this as "this thing was already moving toward me; now it has '
      'stopped." The variants differ only in how steep the initial '
      'burst is: `easeOutQuad` is gentle, `easeOutCubic` is the most '
      'commonly used UI default, and `easeOutQuart`/`Quint`/`Expo`/'
      '`Circ` progressively snap harder. `easeOutBack` is the playful '
      'sibling: it overshoots past 1.0 before settling.',
  entries: <CurveEntry>[
    curveEaseOut,
    curveEaseOutQuad,
    curveEaseOutCubic,
    curveEaseOutQuart,
    curveEaseOutQuint,
    curveEaseOutExpo,
    curveEaseOutCirc,
    curveEaseOutBack,
  ],
);

const CurveFamily easeInOutFamily = CurveFamily(
  title: 'easeInOut — symmetric S-curves',
  paragraph:
      'When an element travels from one resting state to another '
      'without leaving or entering the scene, the eye expects a '
      'symmetric S-curve: gentle acceleration, a sustained middle '
      'glide, and a gentle deceleration. `easeInOutCubic` is the '
      'Material default; `easeInOutCubicEmphasized` is the Material 3 '
      'expressive variant which lingers longer at the endpoints. The '
      'higher-order variants (`Quart`, `Quint`, `Circ`) make the middle '
      'pass faster and the endpoints stickier — useful for emphasis '
      'but easy to overuse.',
  entries: <CurveEntry>[
    curveEaseInOut,
    curveEaseInOutSine,
    curveEaseInOutQuad,
    curveEaseInOutCubic,
    curveEaseInOutCubicEmphasized,
    curveEaseInOutQuart,
    curveEaseInOutQuint,
    curveEaseInOutCirc,
    curveEaseInOutBack,
  ],
);

const CurveFamily decelerateFamily = CurveFamily(
  title: 'Decelerate & Material standards',
  paragraph:
      '`decelerate` is the one-line relative of ease-out used by '
      'Material 2 dialogs and bottom sheets. `fastOutSlowIn` is the '
      'famous "Material standard" easing — a tuned cubic-bezier that '
      'reads as both quick and considered. `fastLinearToSlowEaseIn` '
      'and `fastEaseInToSlowEaseOut` are tuned blends used for '
      'expressive transitions where the start needs to feel snappy '
      'but the end needs to land softly.',
  entries: <CurveEntry>[
    curveDecelerate,
    curveFastOutSlowIn,
    curveFastLinearToSlowEaseIn,
    curveFastEaseInToSlowEaseOut,
  ],
);

const CurveFamily bounceFamily = CurveFamily(
  title: 'Bounce — physical drop motion',
  paragraph:
      'Bounce curves model a ball dropping under gravity. `bounceOut` '
      'reads the most natural — an object falling into place and '
      'bouncing once or twice before settling. `bounceIn` plays the '
      'same motion in reverse; `bounceInOut` chains both. Use bounce '
      'sparingly: it is a strong character moment that loses meaning '
      'when applied to every transition.',
  entries: <CurveEntry>[
    curveBounceIn,
    curveBounceOut,
    curveBounceInOut,
  ],
);

const CurveFamily elasticFamily = CurveFamily(
  title: 'Elastic — oscillating motion',
  paragraph:
      'Elastic curves model a spring overshooting its rest position '
      'and oscillating before settling. `elasticOut` is the iconic '
      '"playful arrival" — but it produces values outside the '
      '[0, 1] range, so a tween that drives a position will overshoot '
      'visually. Always check that the property being animated tolerates '
      'the overshoot.',
  entries: <CurveEntry>[
    curveElasticIn,
    curveElasticOut,
    curveElasticInOut,
  ],
);

const CurveFamily specialFamily = CurveFamily(
  title: 'Specials',
  paragraph:
      '`slowMiddle` inverts the usual S-curve: it is fast at the '
      'endpoints and slow through the middle. It is the natural choice '
      'for a "pause and reveal" moment — for example, a card flipping '
      'where the back-face needs to be readable for a beat.',
  entries: <CurveEntry>[curveSlowMiddle],
);

const List<CurveFamily> allFamilies = <CurveFamily>[
  linearAndEase,
  easeInFamily,
  easeOutFamily,
  easeInOutFamily,
  decelerateFamily,
  bounceFamily,
  elasticFamily,
  specialFamily,
];

// ---------------------------------------------------------------------
// SECTION 4 — THE CORE CURVE PAINTERS
// ---------------------------------------------------------------------
// All plotting goes through `CurvePlotPainter` (single curve) and
// `OverlayPlotPainter` (multiple curves on a shared axis). Both sample
// `Curve.transform(double)` at evenly spaced t values inside `paint`,
// which is allowed since `transform` is a pure function.
// ---------------------------------------------------------------------

class CurvePlotPainter extends CustomPainter {
  final Curve curve;
  final Color color;
  final int sampleCount;
  final bool showGrid;
  final bool showAxes;
  final double overshootPad;
  CurvePlotPainter({
    required this.curve,
    required this.color,
    this.sampleCount = 64,
    this.showGrid = true,
    this.showAxes = true,
    this.overshootPad = 0.25,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()..color = cardColor;
    canvas.drawRect(Offset.zero & size, background);

    // y in plot space includes overshoot range so elastic/back read.
    final double yMin = -overshootPad;
    final double yMax = 1.0 + overshootPad;
    final double ySpan = yMax - yMin;

    if (showGrid) {
      final Paint gridPaint = Paint()
        ..color = gridColor
        ..strokeWidth = 1.0;
      const int divs = 4;
      for (int i = 0; i <= divs; i++) {
        final double fx = i / divs;
        final double x = fx * size.width;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
      for (int i = 0; i <= divs; i++) {
        final double fy = i / divs;
        final double y = fy * size.height;
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }
    }

    if (showAxes) {
      final Paint axisPaint = Paint()
        ..color = mutedInkColor.withValues(alpha: 0.6)
        ..strokeWidth = 1.2;
      // y = 0 line
      final double y0 = ((1.0 - ((0.0 - yMin) / ySpan)) * size.height);
      canvas.drawLine(Offset(0, y0), Offset(size.width, y0), axisPaint);
      // y = 1 line
      final double y1 = ((1.0 - ((1.0 - yMin) / ySpan)) * size.height);
      canvas.drawLine(Offset(0, y1), Offset(size.width, y1), axisPaint);
    }

    final Path path = Path();
    for (int i = 0; i <= sampleCount; i++) {
      final double t = i / sampleCount;
      final double v = curve.transform(t);
      final double px = t * size.width;
      final double py = (1.0 - ((v - yMin) / ySpan)) * size.height;
      if (i == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }

    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    // start and end dots
    final Paint dot = Paint()..color = color;
    canvas.drawCircle(
      Offset(0,
          (1.0 - ((curve.transform(0.0) - yMin) / ySpan)) * size.height),
      2.5,
      dot,
    );
    canvas.drawCircle(
      Offset(
          size.width,
          (1.0 - ((curve.transform(1.0) - yMin) / ySpan)) *
              size.height),
      2.5,
      dot,
    );
  }

  @override
  bool shouldRepaint(covariant CurvePlotPainter old) =>
      old.curve != curve ||
      old.color != color ||
      old.sampleCount != sampleCount ||
      old.overshootPad != overshootPad;
}

class OverlayPlotPainter extends CustomPainter {
  final List<CurveEntry> entries;
  final int sampleCount;
  final double overshootPad;
  OverlayPlotPainter({
    required this.entries,
    this.sampleCount = 96,
    this.overshootPad = 0.3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()..color = cardColor;
    canvas.drawRect(Offset.zero & size, background);

    final double yMin = -overshootPad;
    final double yMax = 1.0 + overshootPad;
    final double ySpan = yMax - yMin;

    final Paint gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;
    const int divs = 8;
    for (int i = 0; i <= divs; i++) {
      final double f = i / divs;
      canvas.drawLine(
        Offset(f * size.width, 0),
        Offset(f * size.width, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, f * size.height),
        Offset(size.width, f * size.height),
        gridPaint,
      );
    }

    final Paint axisPaint = Paint()
      ..color = mutedInkColor
      ..strokeWidth = 1.2;
    final double y0 = (1.0 - ((0.0 - yMin) / ySpan)) * size.height;
    final double y1 = (1.0 - ((1.0 - yMin) / ySpan)) * size.height;
    canvas.drawLine(Offset(0, y0), Offset(size.width, y0), axisPaint);
    canvas.drawLine(Offset(0, y1), Offset(size.width, y1), axisPaint);

    for (final CurveEntry e in entries) {
      final Path path = Path();
      for (int i = 0; i <= sampleCount; i++) {
        final double t = i / sampleCount;
        final double v = e.curve.transform(t);
        final double px = t * size.width;
        final double py = (1.0 - ((v - yMin) / ySpan)) * size.height;
        if (i == 0) {
          path.moveTo(px, py);
        } else {
          path.lineTo(px, py);
        }
      }
      final Paint p = Paint()
        ..color = e.color
        ..strokeWidth = 2.4
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant OverlayPlotPainter old) =>
      old.entries != entries ||
      old.sampleCount != sampleCount ||
      old.overshootPad != overshootPad;
}

// ---------------------------------------------------------------------
// SECTION 5 — REUSABLE WIDGET PIECES
// ---------------------------------------------------------------------

class SectionHeader extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  const SectionHeader({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: accentBlue,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: inkColor,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: mutedInkColor,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(left: 48),
            height: 2,
            width: 80,
            color: accentBlue.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}

class CurveTile extends StatelessWidget {
  final CurveEntry entry;
  final double plotWidth;
  final double plotHeight;
  const CurveTile({
    super.key,
    required this.entry,
    this.plotWidth = 100,
    this.plotHeight = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: plotWidth,
              height: plotHeight,
              child: CustomPaint(
                painter: CurvePlotPainter(
                  curve: entry.curve,
                  color: entry.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            entry.name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: inkColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            entry.description,
            style: const TextStyle(
              fontSize: 10.5,
              color: mutedInkColor,
              height: 1.25,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class FamilyTile extends StatelessWidget {
  final CurveEntry entry;
  const FamilyTile({super.key, required this.entry});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 90,
            child: CustomPaint(
              painter: CurvePlotPainter(
                curve: entry.curve,
                color: entry.color,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry.name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: inkColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            entry.description,
            style: const TextStyle(
              fontSize: 11,
              color: mutedInkColor,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class FamilySection extends StatelessWidget {
  final CurveFamily family;
  const FamilySection({super.key, required this.family});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: paperColor,
        border: Border(
          left: BorderSide(color: accentBlue.withValues(alpha: 0.5), width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            family.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: inkColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            family.paragraph,
            style: const TextStyle(
              fontSize: 13.5,
              color: mutedInkColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final CurveEntry e in family.entries) FamilyTile(entry: e),
            ],
          ),
        ],
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String text;
  const Paragraph(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paragraphSpacing / 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: inkColor,
          height: 1.55,
        ),
      ),
    );
  }
}

class CodeBlock extends StatelessWidget {
  final String code;
  const CodeBlock({super.key, required this.code});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B16),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
          color: Color(0xFFEDE7D9),
          height: 1.45,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 6 — HERO PLOT
// ---------------------------------------------------------------------
// Giant easeInOut plot. Sampled at 64 t values per the spec.
// ---------------------------------------------------------------------

class HeroPlot extends StatelessWidget {
  const HeroPlot({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accentBlue.withValues(alpha: 0.08),
            accentPurple.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Curves',
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: inkColor,
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'A visual deep tour of Flutter\'s built-in easing catalog',
            style: TextStyle(
              fontSize: 16,
              color: mutedInkColor,
            ),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 16 / 7,
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              padding: const EdgeInsets.all(12),
              child: CustomPaint(
                painter: CurvePlotPainter(
                  curve: Curves.easeInOut,
                  color: accentPurple,
                  sampleCount: 64,
                  showGrid: true,
                  showAxes: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Curves.easeInOut sampled at 64 t values, plotted with grid '
            'and y=0/y=1 reference axes.',
            style: TextStyle(
              fontSize: 13,
              color: mutedInkColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 7 — 6x6 CATALOG GRID
// ---------------------------------------------------------------------
// 32 curves arranged in a responsive grid (6 columns where width
// allows). Each tile renders a 100x80 plot plus the name and
// description.
// ---------------------------------------------------------------------

class CatalogGrid extends StatelessWidget {
  const CatalogGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints c) {
        final int columns = c.maxWidth >= 1100
            ? 6
            : c.maxWidth >= 900
                ? 5
                : c.maxWidth >= 700
                    ? 4
                    : c.maxWidth >= 500
                        ? 3
                        : 2;
        final double tileWidth =
            (c.maxWidth - (tileSpacing * (columns - 1))) / columns;
        return Wrap(
          spacing: tileSpacing,
          runSpacing: tileSpacing,
          children: <Widget>[
            for (final CurveEntry e in allCurves)
              SizedBox(
                width: tileWidth,
                child: CurveTile(entry: e),
              ),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 8 — NUMERIC TABLE
// ---------------------------------------------------------------------
// transform(t) at t=0, 0.25, 0.5, 0.75, 1 for 6 representative curves.
// ---------------------------------------------------------------------

const List<CurveEntry> tableCurves = <CurveEntry>[
  curveLinear,
  curveEaseIn,
  curveEaseOut,
  curveEaseInOut,
  curveBounceOut,
  curveElasticOut,
];

const List<double> tableSamples = <double>[0.0, 0.25, 0.5, 0.75, 1.0];

class NumericTable extends StatelessWidget {
  const NumericTable({super.key});

  String fmt(double v) {
    return v.toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Container(
            color: inkColor,
            padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 200,
                  child: Text(
                    'curve',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                ),
                for (final double t in tableSamples)
                  Expanded(
                    child: Text(
                      't = ${t.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
              ],
            ),
          ),
          for (int row = 0; row < tableCurves.length; row++)
            Container(
              color: row.isEven
                  ? cardColor
                  : paperColor.withValues(alpha: 0.6),
              padding:
                  const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: Text(
                      tableCurves[row].name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        color: tableCurves[row].color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  for (final double t in tableSamples)
                    Expanded(
                      child: Text(
                        fmt(tableCurves[row].curve.transform(t)),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.5,
                          color: inkColor,
                        ),
                        textAlign: TextAlign.right,
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

// ---------------------------------------------------------------------
// SECTION 9 — COMPARISON OVERLAY
// ---------------------------------------------------------------------
// linear, easeIn, easeOut, bounceOut on shared axes with a legend.
// ---------------------------------------------------------------------

const List<CurveEntry> overlayCurves = <CurveEntry>[
  CurveEntry(
    name: 'linear',
    curve: Curves.linear,
    description: 'identity',
    color: inkColor,
  ),
  CurveEntry(
    name: 'easeIn',
    curve: Curves.easeIn,
    description: 'slow start',
    color: accentBlue,
  ),
  CurveEntry(
    name: 'easeOut',
    curve: Curves.easeOut,
    description: 'soft landing',
    color: accentGreen,
  ),
  CurveEntry(
    name: 'bounceOut',
    curve: Curves.bounceOut,
    description: 'bouncing arrival',
    color: accentRed,
  ),
];

class ComparisonOverlay extends StatelessWidget {
  const ComparisonOverlay({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor),
            ),
            padding: const EdgeInsets.all(10),
            child: CustomPaint(
              painter: OverlayPlotPainter(entries: overlayCurves),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 18,
          runSpacing: 6,
          children: <Widget>[
            for (final CurveEntry e in overlayCurves)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 18,
                    height: 4,
                    decoration: BoxDecoration(
                      color: e.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    e.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      color: e.color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '— ${e.description}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: mutedInkColor,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 10 — SIBLING CURVE TYPES
// ---------------------------------------------------------------------
// Threshold, Interval, SawTooth, FlippedCurve, Split — one mini-plot
// each, with a label and explanation.
// ---------------------------------------------------------------------

class SiblingTile extends StatelessWidget {
  final String name;
  final String description;
  final Curve curve;
  final Color color;
  const SiblingTile({
    super.key,
    required this.name,
    required this.description,
    required this.curve,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: CustomPaint(
              painter: CurvePlotPainter(
                curve: curve,
                color: color,
                overshootPad: 0.15,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: inkColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 11.5,
              color: mutedInkColor,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class SiblingsRow extends StatelessWidget {
  const SiblingsRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: const <Widget>[
        SiblingTile(
          name: 'Threshold(0.5)',
          description:
              'returns 0 until t crosses the threshold, then jumps to 1 — '
              'useful for binary visibility toggles within an animation.',
          curve: Threshold(0.5),
          color: accentRed,
        ),
        SiblingTile(
          name: 'Interval(0.25, 0.75, easeInOut)',
          description:
              'clamps t to a sub-range, runs the inner curve there, and '
              'pads the rest. Use to compose multi-stage animations.',
          curve: Interval(0.25, 0.75, curve: Curves.easeInOut),
          color: accentBlue,
        ),
        SiblingTile(
          name: 'SawTooth(3)',
          description:
              'three identical ramps — a stuttered repeat. Great for '
              'pulse, blink, and metronome patterns inside a single '
              'tween.',
          curve: SawTooth(3),
          color: accentAmber,
        ),
        SiblingTile(
          name: 'FlippedCurve(easeOut)',
          description:
              'mirrors a curve across t=0.5 — turns easeOut into easeIn '
              'shape, but applied symmetrically. Useful for reversing '
              'the *feel* without negating the value.',
          curve: FlippedCurve(Curves.easeOut),
          color: accentGreen,
        ),
        SiblingTile(
          name: 'Split(0.5, easeIn → bounceOut)',
          description:
              'concatenates two curves at a t-split point. Perfect for '
              '"slide in, then bounce" two-phase entrances.',
          curve: Split(
            0.5,
            beginCurve: Curves.easeIn,
            endCurve: Curves.bounceOut,
          ),
          color: accentPurple,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 11 — CUBIC RECIPE PANEL
// ---------------------------------------------------------------------
// CSS cubic-bezier(a, b, c, d) maps to Cubic(a, b, c, d). Three example
// recipes are plotted alongside the syntax callout.
// ---------------------------------------------------------------------

const List<CurveEntry> cubicRecipes = <CurveEntry>[
  CurveEntry(
    name: 'Cubic(0.25, 0.1, 0.25, 1.0)',
    curve: Cubic(0.25, 0.1, 0.25, 1.0),
    description: 'CSS "ease" — gentle classic',
    color: accentBlue,
  ),
  CurveEntry(
    name: 'Cubic(0.42, 0.0, 1.0, 1.0)',
    curve: Cubic(0.42, 0.0, 1.0, 1.0),
    description: 'CSS "ease-in" — slow start',
    color: accentGreen,
  ),
  CurveEntry(
    name: 'Cubic(0.0, 0.0, 0.58, 1.0)',
    curve: Cubic(0.0, 0.0, 0.58, 1.0),
    description: 'CSS "ease-out" — soft landing',
    color: accentRed,
  ),
];

class CubicRecipePanel extends StatelessWidget {
  const CubicRecipePanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'cubic-bezier(a, b, c, d) → Cubic(a, b, c, d)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: inkColor,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Any CSS cubic-bezier easing translates 1:1 to Flutter\'s '
            '`Cubic` curve. The four control parameters are the x and y '
            'coordinates of the two interior control points of a cubic '
            'Bezier from (0, 0) to (1, 1).',
            style: TextStyle(
              fontSize: 13,
              color: mutedInkColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final CurveEntry e in cubicRecipes)
                SizedBox(width: 220, child: FamilyTile(entry: e)),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 12 — USAGE LISTING
// ---------------------------------------------------------------------

const String tweenAnimateExample = '''
// Driving a Tween with a chosen Curve.
//
// AnimationController is illustrative only — this file does not
// instantiate one; the listing exists as a reference card.
//
// final controller = AnimationController(
//   duration: const Duration(milliseconds: 350),
//   vsync: this,
// );
//
// final animation = Tween<double>(begin: 0, end: 1).animate(
//   CurvedAnimation(
//     parent: controller,
//     curve: Curves.easeInOutCubicEmphasized,
//     reverseCurve: Curves.easeInCubic,
//   ),
// );
//
// AnimatedBuilder(
//   animation: animation,
//   builder: (context, child) => Opacity(
//     opacity: animation.value,
//     child: child,
//   ),
//   child: const Text('Hello, easing.'),
// )
''';

class UsagePanel extends StatelessWidget {
  const UsagePanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Paragraph(
          'A `Curve` is consumed almost exclusively through '
          '`CurvedAnimation`, which wraps a base `Animation<double>` '
          'and remaps its t value via `Curve.transform`. The pattern '
          'below is the canonical recipe.',
        ),
        SizedBox(height: 8),
        CodeBlock(code: tweenAnimateExample),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 13 — PITFALLS PANEL
// ---------------------------------------------------------------------

class Pitfall extends StatelessWidget {
  final String title;
  final String body;
  final Color tone;
  const Pitfall({
    super.key,
    required this.title,
    required this.body,
    required this.tone,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        border: Border(left: BorderSide(color: tone, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tone,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: inkColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class PitfallsPanel extends StatelessWidget {
  const PitfallsPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Pitfall(
          tone: accentBlue,
          title: 'Curves are stateless and shareable',
          body:
              'Every named `Curves.X` constant is a `const` `Curve` '
              'instance. They are pure functions of t and can be reused '
              'across any number of animations without coordination. '
              'This is why we can call `transform` directly inside a '
              'CustomPainter — no controller, no listener, no rebuild.',
        ),
        Pitfall(
          tone: accentAmber,
          title: 'Out-of-[0, 1] t can produce NaN',
          body:
              'Flutter only guarantees curve behavior on the closed '
              'interval [0, 1]. Some curves (notably the bounce and '
              'circular families) involve square roots or piecewise '
              'logic that returns NaN for t outside that range. Always '
              'clamp t before passing it to a curve outside an '
              'AnimationController-driven flow.',
        ),
        Pitfall(
          tone: accentRed,
          title: 'Bounce and elastic overshoot in y',
          body:
              'Even on valid t in [0, 1], `bounceOut`, `elasticOut`, '
              '`easeOutBack`, and friends produce values outside the '
              '[0, 1] range. A driven Tween of opacity will clamp '
              'silently, but a Tween of position or scale will visibly '
              'overshoot. Pick the curve to match the property — and '
              'check what happens at the extremes.',
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 14 — FOOTER
// ---------------------------------------------------------------------

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: inkColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'End of curves catalog',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${allCurves.length} named curves plotted; sibling types '
            'demonstrated; cubic recipe shown; pitfalls noted. All plots '
            'are drawn from `Curve.transform(double)` directly — no '
            'controllers, no setState, no asynchronous code.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.78),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 15 — PAGE BODY
// ---------------------------------------------------------------------

class CurvesPage extends StatelessWidget {
  const CurvesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paperColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              // 1. Hero
              HeroPlot(),
              SizedBox(height: sectionSpacing),

              // 2. Catalog grid
              SectionHeader(
                number: '1',
                title: 'The full catalog',
                subtitle:
                    'Every named constant in `Curves`, plotted at 100x80. '
                    'Names are monospace; descriptions are one line.',
              ),
              SizedBox(height: 12),
              CatalogGrid(),
              SizedBox(height: sectionSpacing),

              // 3. Family groupings
              SectionHeader(
                number: '2',
                title: 'Family groupings',
                subtitle:
                    'Reorganized by intent — linear/ease, in, out, inOut, '
                    'decelerate, bounce, elastic, and special.',
              ),
              SizedBox(height: 8),
              FamilySection(family: linearAndEase),
              FamilySection(family: easeInFamily),
              FamilySection(family: easeOutFamily),
              FamilySection(family: easeInOutFamily),
              FamilySection(family: decelerateFamily),
              FamilySection(family: bounceFamily),
              FamilySection(family: elasticFamily),
              FamilySection(family: specialFamily),
              SizedBox(height: sectionSpacing),

              // 4. Numeric table
              SectionHeader(
                number: '3',
                title: 'transform(t) numeric table',
                subtitle:
                    'Six representative curves evaluated at five t '
                    'sample points. Computed directly from '
                    '`Curve.transform`.',
              ),
              SizedBox(height: 12),
              NumericTable(),
              SizedBox(height: sectionSpacing),

              // 5. Comparison overlay
              SectionHeader(
                number: '4',
                title: 'Comparison overlay',
                subtitle:
                    'Linear, easeIn, easeOut, and bounceOut on shared '
                    'axes. Shows how the same Tween end-points produce '
                    'wildly different visual character depending on '
                    'easing.',
              ),
              SizedBox(height: 12),
              ComparisonOverlay(),
              SizedBox(height: sectionSpacing),

              // 6. Sibling curves
              SectionHeader(
                number: '5',
                title: 'Sibling curve types',
                subtitle:
                    'Threshold, Interval, SawTooth, FlippedCurve, Split '
                    '— building blocks for composing custom curves '
                    'without writing a new Curve class.',
              ),
              SizedBox(height: 12),
              SiblingsRow(),
              SizedBox(height: sectionSpacing),

              // 7. Cubic recipe
              SectionHeader(
                number: '6',
                title: 'cubic-bezier → Cubic',
                subtitle:
                    'Translating CSS easing recipes into Flutter\'s '
                    '`Cubic` curve.',
              ),
              SizedBox(height: 12),
              CubicRecipePanel(),
              SizedBox(height: sectionSpacing),

              // 8. Usage listing
              SectionHeader(
                number: '7',
                title: 'Usage with Tween.animate',
                subtitle:
                    'The canonical CurvedAnimation pattern. Listing '
                    'is illustrative only — this file does not run '
                    'animations.',
              ),
              SizedBox(height: 12),
              UsagePanel(),
              SizedBox(height: sectionSpacing),

              // 9. Pitfalls
              SectionHeader(
                number: '8',
                title: 'Pitfalls',
                subtitle: 'Three things that bite people about curves.',
              ),
              SizedBox(height: 12),
              PitfallsPanel(),

              // Footer
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 16 — APP ROOT
// ---------------------------------------------------------------------

class CurvesApp extends StatelessWidget {
  const CurvesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curves — visual deep demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: accentBlue,
        scaffoldBackgroundColor: paperColor,
        textTheme: const TextTheme(),
      ),
      home: const CurvesPage(),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 17 — SINGLE STATIC ENTRY POINT
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const CurvesApp();
}
