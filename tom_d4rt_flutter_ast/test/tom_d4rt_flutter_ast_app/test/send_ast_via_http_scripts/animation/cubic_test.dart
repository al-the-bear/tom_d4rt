// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
//   Cubic — Visual Deep Demo
// =====================================================================
//
// This file is a hand-authored, analyzer-free visual demo for the D4rt
// interpreter test corpus.  The subject is Flutter's `Cubic` curve from
// `package:flutter/animation.dart` (re-exported through Material).  A
// `Cubic(a, b, c, d)` curve is a cubic Bezier easing curve where the
// start point is fixed at (0, 0), the end point at (1, 1), and the two
// control points are P1 = (a, b) and P2 = (c, d).  By convention the x
// components a, c are constrained to [0, 1] (so the curve is a function
// of t) but b, d are free reals — leading to overshoot effects (e.g.
// `easeOutBack`, `elasticOut`).
//
// This demo deliberately avoids any controllers, tickers, async, or
// state.  It samples curves directly via the pure `Curve.transform(t)`
// method (which IS allowed) inside `CustomPainter.paint`.  No animation
// is actually animated — every frame is identical.  The demo is a
// rendering-only walkthrough of cubic-Bezier easing geometry.
//
// Structure
// ---------
//   Section 1 — Hero card (giant easeInOut plot)
//   Section 2 — Anatomy of a Cubic
//   Section 3 — 4×4 curve gallery
//   Section 4 — Cubic constructor cards
//   Section 5 — transform(t) numeric table
//   Section 6 — Sibling-curve gallery (Threshold, Interval, ...)
//   Section 7 — Code-listing card
//   Section 8 — Pitfalls
//   Section 9 — Footer
//
// Strict rules: single static `dynamic build(BuildContext)` entry point;
// `_Private`-prefixed helpers; no `.withOpacity()` (use `withValues`); no
// inline `// ignore:` comments.
//

import 'dart:math' as math;

import 'package:flutter/material.dart';

// =====================================================================
//   Palette and tokens
// =====================================================================

const Color _kBg = Color(0xFFF6F4EE);
const Color _kSurface = Color(0xFFFFFFFF);
const Color _kInk = Color(0xFF1B1F2A);
const Color _kInkSoft = Color(0xFF4A5161);
const Color _kInkMuted = Color(0xFF7E8594);
const Color _kAccent = Color(0xFF2B5BD7);
const Color _kAccentSoft = Color(0xFFCFE0FF);
const Color _kHi = Color(0xFFE94F37);
const Color _kHi2 = Color(0xFFF6BD60);
const Color _kHi3 = Color(0xFF38B000);
const Color _kHi4 = Color(0xFF6A4C93);
const Color _kGrid = Color(0xFFE2E0DA);
const Color _kAxis = Color(0xFF8B92A1);
const Color _kCardEdge = Color(0xFFE6E2D6);
const Color _kCode = Color(0xFF11161F);
const Color _kCodeInk = Color(0xFFE9F0F8);
const Color _kCodeKey = Color(0xFF7BD3F7);
const Color _kCodeStr = Color(0xFFC8E58F);
const Color _kCodeNum = Color(0xFFFFB86C);
const Color _kCodeCom = Color(0xFF6F7B89);

const TextStyle _kH1 = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w800,
  color: _kInk,
  height: 1.1,
  letterSpacing: -0.6,
);

const TextStyle _kH2 = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  height: 1.15,
  letterSpacing: -0.3,
);

const TextStyle _kH3 = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  height: 1.2,
);

const TextStyle _kBody = TextStyle(
  fontSize: 14.0,
  color: _kInkSoft,
  height: 1.45,
);

const TextStyle _kSmall = TextStyle(
  fontSize: 12.0,
  color: _kInkMuted,
  height: 1.35,
);

const TextStyle _kMono = TextStyle(
  fontSize: 13.0,
  color: _kInk,
  fontFamily: 'monospace',
  height: 1.35,
);

const TextStyle _kMonoSmall = TextStyle(
  fontSize: 11.0,
  color: _kInkSoft,
  fontFamily: 'monospace',
  height: 1.3,
);

const TextStyle _kEyebrow = TextStyle(
  fontSize: 11.0,
  color: _kAccent,
  fontWeight: FontWeight.w800,
  letterSpacing: 1.6,
);

// =====================================================================
//   Curve metadata used by the gallery sections
// =====================================================================

class _PrivateCurveSpec {
  const _PrivateCurveSpec({
    required this.name,
    required this.curve,
    required this.blurb,
    required this.tint,
  });

  final String name;
  final Curve curve;
  final String blurb;
  final Color tint;
}

List<_PrivateCurveSpec> _privateGalleryCurves() {
  return <_PrivateCurveSpec>[
    _PrivateCurveSpec(
      name: 'linear',
      curve: Curves.linear,
      blurb: 'Identity curve. f(t) = t. Baseline reference.',
      tint: _kInkMuted,
    ),
    _PrivateCurveSpec(
      name: 'decelerate',
      curve: Curves.decelerate,
      blurb: 'Quadratic out. Hard start, soft stop.',
      tint: _kAccent,
    ),
    _PrivateCurveSpec(
      name: 'easeIn',
      curve: Curves.easeIn,
      blurb: 'Cubic(0.42, 0, 1, 1). Soft start, hard stop.',
      tint: _kHi4,
    ),
    _PrivateCurveSpec(
      name: 'easeOut',
      curve: Curves.easeOut,
      blurb: 'Cubic(0, 0, 0.58, 1). Hard start, soft stop.',
      tint: _kHi3,
    ),
    _PrivateCurveSpec(
      name: 'easeInOut',
      curve: Curves.easeInOut,
      blurb: 'Cubic(0.42, 0, 0.58, 1). The classic CSS ease-in-out.',
      tint: _kAccent,
    ),
    _PrivateCurveSpec(
      name: 'easeInToLinear',
      curve: Curves.easeInToLinear,
      blurb: 'Soft start, then linear. Useful for chaining.',
      tint: _kHi,
    ),
    _PrivateCurveSpec(
      name: 'easeOutBack',
      curve: Curves.easeOutBack,
      blurb: 'Overshoot then settle. Cubic with d > 1.',
      tint: _kHi,
    ),
    _PrivateCurveSpec(
      name: 'bounceIn',
      curve: Curves.bounceIn,
      blurb: 'Not a Cubic — piecewise. Bounces at the start.',
      tint: _kHi2,
    ),
    _PrivateCurveSpec(
      name: 'bounceOut',
      curve: Curves.bounceOut,
      blurb: 'Piecewise. Bounces at the end. Drop-style.',
      tint: _kHi2,
    ),
    _PrivateCurveSpec(
      name: 'elasticIn',
      curve: Curves.elasticIn,
      blurb: 'Sinusoidal pull-back at the start.',
      tint: _kHi4,
    ),
    _PrivateCurveSpec(
      name: 'elasticOut',
      curve: Curves.elasticOut,
      blurb: 'Sinusoidal overshoot at the end.',
      tint: _kHi4,
    ),
    _PrivateCurveSpec(
      name: 'fastOutSlowIn',
      curve: Curves.fastOutSlowIn,
      blurb: 'Material standard easing. Cubic(0.4, 0, 0.2, 1).',
      tint: _kAccent,
    ),
    _PrivateCurveSpec(
      name: 'slowMiddle',
      curve: Curves.slowMiddle,
      blurb: 'Cubic(0.15, 0.85, 0.85, 0.15). S-shape.',
      tint: _kHi3,
    ),
    _PrivateCurveSpec(
      name: 'easeOutCubic',
      curve: Curves.easeOutCubic,
      blurb: 'Cubic(0.215, 0.61, 0.355, 1). Strong out.',
      tint: _kHi3,
    ),
    _PrivateCurveSpec(
      name: 'easeInQuart',
      curve: Curves.easeInQuart,
      blurb: 'Cubic(0.895, 0.03, 0.685, 0.22). Aggressive in.',
      tint: _kHi4,
    ),
    _PrivateCurveSpec(
      name: 'easeInOutCirc',
      curve: Curves.easeInOutCirc,
      blurb: 'Cubic(0.785, 0.135, 0.15, 0.86). Circular S.',
      tint: _kAccent,
    ),
  ];
}

// =====================================================================
//   The single allowed entry point
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cubic — Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kBg,
      primaryColor: _kAccent,
    ),
    home: Scaffold(
      backgroundColor: _kBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1080.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _PrivateTitleBlock(),
                SizedBox(height: 28.0),
                _PrivateHeroCard(),
                SizedBox(height: 28.0),
                _PrivateAnatomyCard(),
                SizedBox(height: 28.0),
                _PrivateGalleryCard(),
                SizedBox(height: 28.0),
                _PrivateConstructorCards(),
                SizedBox(height: 28.0),
                _PrivateTransformTableCard(),
                SizedBox(height: 28.0),
                _PrivateSiblingCurveCard(),
                SizedBox(height: 28.0),
                _PrivateCodeListingCard(),
                SizedBox(height: 28.0),
                _PrivatePitfallsCard(),
                SizedBox(height: 28.0),
                _PrivateFooter(),
                SizedBox(height: 36.0),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
//   Title block
// =====================================================================

class _PrivateTitleBlock extends StatelessWidget {
  const _PrivateTitleBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('FLUTTER · ANIMATION · CURVES', style: _kEyebrow),
        SizedBox(height: 10.0),
        Text(
          'Cubic — the four numbers that shape every animation',
          style: _kH1,
        ),
        SizedBox(height: 12.0),
        Text(
          'A walkthrough of the Cubic Bezier easing curve and its '
          'siblings: Curves.easeIn / easeOut / easeInOut, Material\'s '
          'fastOutSlowIn, the Threshold/Interval/SawTooth family, and '
          'how the four control numbers (a, b, c, d) determine the '
          'shape of every curve in package:flutter/animation.dart.',
          style: _kBody,
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _PrivateChip(label: 'package:flutter/animation.dart'),
            SizedBox(width: 8.0),
            _PrivateChip(label: 'Curve.transform(double t)'),
            SizedBox(width: 8.0),
            _PrivateChip(label: 'Cubic(a, b, c, d)'),
          ],
        ),
      ],
    );
  }
}

class _PrivateChip extends StatelessWidget {
  const _PrivateChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: _kAccentSoft.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: _kAccent.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: _kAccent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// =====================================================================
//   Generic card chrome
// =====================================================================

class _PrivateCard extends StatelessWidget {
  const _PrivateCard({
    required this.eyebrow,
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: _kCardEdge),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18.0,
            offset: Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(eyebrow, style: _kEyebrow),
          SizedBox(height: 6.0),
          Text(title, style: _kH2),
          if (subtitle != null) ...<Widget>[
            SizedBox(height: 6.0),
            Text(subtitle!, style: _kBody),
          ],
          SizedBox(height: 16.0),
          child,
        ],
      ),
    );
  }
}

// =====================================================================
//   Section 1 — Hero card with giant easeInOut plot
// =====================================================================

class _PrivateHeroCard extends StatelessWidget {
  const _PrivateHeroCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      eyebrow: 'SECTION 1 · HERO PLOT',
      title: 'Curves.easeInOut, sampled at 64 t-values',
      subtitle:
          'easeInOut is a static Cubic(0.42, 0, 0.58, 1.0) — the canonical '
          'CSS ease-in-out. The painter below samples Curve.transform(t) at '
          '64 evenly-spaced t values and draws the result with control-point '
          'markers, axis labels, and a (t, f(t)) readout strip.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: CustomPaint(
                painter: _PrivateHeroCurvePainter(
                  curve: Curves.easeInOut,
                  // P1 = (0.42, 0), P2 = (0.58, 1) in (a,b,c,d) order.
                  controlPoints: <Offset>[
                    Offset(0.42, 0.0),
                    Offset(0.58, 1.0),
                  ],
                  label: 'easeInOut',
                  formula: 'Cubic(0.42, 0, 0.58, 1.0)',
                ),
              ),
            ),
          ),
          SizedBox(height: 14.0),
          _PrivateLegendRow(items: <_PrivateLegendItem>[
            _PrivateLegendItem(color: _kAccent, label: 'curve'),
            _PrivateLegendItem(color: _kHi, label: 'control points'),
            _PrivateLegendItem(color: _kAxis, label: 'axes'),
            _PrivateLegendItem(color: _kGrid, label: 'grid'),
          ]),
        ],
      ),
    );
  }
}

class _PrivateLegendItem {
  const _PrivateLegendItem({required this.color, required this.label});
  final Color color;
  final String label;
}

class _PrivateLegendRow extends StatelessWidget {
  const _PrivateLegendRow({required this.items});
  final List<_PrivateLegendItem> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: items
          .map<Widget>((_PrivateLegendItem item) => Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 14.0,
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(item.label, style: _kSmall),
                ],
              ))
          .toList(),
    );
  }
}

class _PrivateHeroCurvePainter extends CustomPainter {
  _PrivateHeroCurvePainter({
    required this.curve,
    required this.controlPoints,
    required this.label,
    required this.formula,
  });

  final Curve curve;
  final List<Offset> controlPoints; // in (x,y) curve-space, [0..1] x R
  final String label;
  final String formula;

  static const int _kSamples = 64;
  static const double _kPad = 56.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Background.
    final Paint bg = Paint()..color = Color(0xFFFBFAF5);
    canvas.drawRect(Offset.zero & size, bg);

    final Rect plotRect = Rect.fromLTRB(
      _kPad,
      _kPad * 0.55,
      size.width - _kPad * 0.4,
      size.height - _kPad * 0.95,
    );

    _drawGrid(canvas, plotRect);
    _drawAxes(canvas, plotRect);
    _drawCurve(canvas, plotRect);
    _drawControlGeometry(canvas, plotRect);
    _drawLabels(canvas, size, plotRect);
  }

  void _drawGrid(Canvas canvas, Rect rect) {
    final Paint grid = Paint()
      ..color = _kGrid
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Paint gridSoft = Paint()
      ..color = _kGrid.withValues(alpha: 0.45)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const int major = 10;
    for (int i = 0; i <= major; i++) {
      final double fx = rect.left + rect.width * (i / major);
      final double fy = rect.top + rect.height * (i / major);
      final Paint p = (i == 0 || i == major) ? grid : gridSoft;
      canvas.drawLine(Offset(fx, rect.top), Offset(fx, rect.bottom), p);
      canvas.drawLine(Offset(rect.left, fy), Offset(rect.right, fy), p);
    }
  }

  void _drawAxes(Canvas canvas, Rect rect) {
    final Paint axis = Paint()
      ..color = _kAxis
      ..strokeWidth = 1.4;
    canvas.drawLine(
        Offset(rect.left, rect.bottom), Offset(rect.right, rect.bottom), axis);
    canvas.drawLine(
        Offset(rect.left, rect.bottom), Offset(rect.left, rect.top), axis);

    // tick labels.
    for (int i = 0; i <= 10; i += 2) {
      final double tx = rect.left + rect.width * (i / 10.0);
      final double ty = rect.bottom + 4.0;
      _label(canvas, (i / 10.0).toStringAsFixed(1),
          Offset(tx - 10.0, ty), _kSmall);
    }
    for (int i = 0; i <= 10; i += 2) {
      final double v = i / 10.0;
      final double yy = rect.bottom - rect.height * v;
      _label(canvas, v.toStringAsFixed(1),
          Offset(rect.left - 30.0, yy - 7.0), _kSmall);
    }
  }

  void _drawCurve(Canvas canvas, Rect rect) {
    final Path path = Path();
    for (int i = 0; i <= _kSamples; i++) {
      final double t = i / _kSamples;
      // The pure transform call — allowed by the rules.
      final double v = curve.transform(t).clamp(-0.5, 1.5);
      final double x = rect.left + rect.width * t;
      final double y = rect.bottom - rect.height * v;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Glow.
    final Paint glow = Paint()
      ..color = _kAccent.withValues(alpha: 0.15)
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, glow);

    final Paint stroke = Paint()
      ..color = _kAccent
      ..strokeWidth = 3.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, stroke);

    // Sample dots.
    final Paint dot = Paint()..color = _kAccent.withValues(alpha: 0.85);
    final Paint dotRing = Paint()
      ..color = _kSurface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (int i = 0; i <= _kSamples; i += 4) {
      final double t = i / _kSamples;
      final double v = curve.transform(t).clamp(-0.5, 1.5);
      final double x = rect.left + rect.width * t;
      final double y = rect.bottom - rect.height * v;
      canvas.drawCircle(Offset(x, y), 2.6, dot);
      canvas.drawCircle(Offset(x, y), 2.6, dotRing);
    }
  }

  void _drawControlGeometry(Canvas canvas, Rect rect) {
    if (controlPoints.length != 2) {
      return;
    }
    final Offset p0 = Offset(rect.left, rect.bottom);
    final Offset p3 = Offset(rect.right, rect.top);
    final Offset p1 = _project(controlPoints[0], rect);
    final Offset p2 = _project(controlPoints[1], rect);

    final Paint guide = Paint()
      ..color = _kHi.withValues(alpha: 0.55)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final Paint dashed = Paint()
      ..color = _kHi.withValues(alpha: 0.7)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    _drawDashedLine(canvas, p0, p1, dashed, dash: 5.0, gap: 4.0);
    _drawDashedLine(canvas, p3, p2, dashed, dash: 5.0, gap: 4.0);

    final Paint cp = Paint()..color = _kHi;
    final Paint cpRing = Paint()
      ..color = _kSurface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    canvas.drawCircle(p1, 6.0, cp);
    canvas.drawCircle(p1, 6.0, cpRing);
    canvas.drawCircle(p2, 6.0, cp);
    canvas.drawCircle(p2, 6.0, cpRing);

    _label(canvas,
        'P1 (${controlPoints[0].dx.toStringAsFixed(2)}, ${controlPoints[0].dy.toStringAsFixed(2)})',
        p1.translate(10.0, -16.0), _kMonoSmall);
    _label(canvas,
        'P2 (${controlPoints[1].dx.toStringAsFixed(2)}, ${controlPoints[1].dy.toStringAsFixed(2)})',
        p2.translate(-92.0, 6.0), _kMonoSmall);
  }

  void _drawLabels(Canvas canvas, Size size, Rect rect) {
    _label(canvas, label,
        Offset(rect.left, rect.top - 32.0),
        TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: _kInk));
    _label(canvas, formula,
        Offset(rect.left, rect.top - 12.0),
        TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            color: _kAccent,
            fontWeight: FontWeight.w700));
    _label(canvas, 't (input)',
        Offset(rect.right - 70.0, rect.bottom + 18.0), _kSmall);
    _label(canvas, 'f(t)',
        Offset(rect.left - 38.0, rect.top - 6.0), _kSmall);
  }

  Offset _project(Offset curveSpace, Rect rect) {
    return Offset(
      rect.left + rect.width * curveSpace.dx,
      rect.bottom - rect.height * curveSpace.dy,
    );
  }

  void _label(Canvas canvas, String text, Offset at, TextStyle style) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, at);
  }

  void _drawDashedLine(Canvas canvas, Offset a, Offset b, Paint paint,
      {double dash = 5.0, double gap = 4.0}) {
    final double dx = b.dx - a.dx;
    final double dy = b.dy - a.dy;
    final double dist = math.sqrt(dx * dx + dy * dy);
    if (dist < 0.0001) return;
    final double ux = dx / dist;
    final double uy = dy / dist;
    double traveled = 0.0;
    bool drawing = true;
    Offset cursor = a;
    while (traveled < dist) {
      final double step = drawing ? dash : gap;
      final double next = math.min(traveled + step, dist);
      final Offset n = Offset(a.dx + ux * next, a.dy + uy * next);
      if (drawing) {
        canvas.drawLine(cursor, n, paint);
      }
      cursor = n;
      traveled = next;
      drawing = !drawing;
    }
  }

  @override
  bool shouldRepaint(covariant _PrivateHeroCurvePainter oldDelegate) {
    return oldDelegate.curve != curve;
  }
}

// =====================================================================
//   Section 2 — Anatomy of a Cubic
// =====================================================================

class _PrivateAnatomyCard extends StatelessWidget {
  const _PrivateAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      eyebrow: 'SECTION 2 · ANATOMY',
      title: 'Cubic(a, b, c, d) — what each number does',
      subtitle:
          'A Cubic is a parametric Bezier with fixed endpoints (0,0) and '
          '(1,1), and two adjustable control points P1 = (a, b) and '
          'P2 = (c, d). The x-coordinates a, c MUST live in [0, 1]. The '
          'y-coordinates b, d are free reals — values outside [0, 1] cause '
          'overshoot (e.g. easeOutBack with d > 1).',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 320.0,
            decoration: BoxDecoration(
              color: Color(0xFFFBFAF5),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: _kCardEdge),
            ),
            child: CustomPaint(
              painter: _PrivateAnatomyPainter(),
            ),
          ),
          SizedBox(height: 16.0),
          _PrivateAnatomyLegend(),
        ],
      ),
    );
  }
}

class _PrivateAnatomyLegend extends StatelessWidget {
  const _PrivateAnatomyLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        _PrivateAnatomyChip(
          mark: 'P0',
          color: _kInkMuted,
          desc: 'Start (0, 0). Always fixed.',
        ),
        _PrivateAnatomyChip(
          mark: 'P1',
          color: _kHi,
          desc: 'First control. (a, b). a ∈ [0,1].',
        ),
        _PrivateAnatomyChip(
          mark: 'P2',
          color: _kHi3,
          desc: 'Second control. (c, d). c ∈ [0,1].',
        ),
        _PrivateAnatomyChip(
          mark: 'P3',
          color: _kInkMuted,
          desc: 'End (1, 1). Always fixed.',
        ),
      ],
    );
  }
}

class _PrivateAnatomyChip extends StatelessWidget {
  const _PrivateAnatomyChip({
    required this.mark,
    required this.color,
    required this.desc,
  });

  final String mark;
  final Color color;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kCardEdge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 24.0,
            height: 24.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(mark,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                )),
          ),
          SizedBox(width: 8.0),
          Text(desc, style: _kSmall),
        ],
      ),
    );
  }
}

class _PrivateAnatomyPainter extends CustomPainter {
  _PrivateAnatomyPainter();

  // Chosen control points emphasising both axes.
  final Offset _p1 = Offset(0.30, 0.05);
  final Offset _p2 = Offset(0.70, 0.95);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(60.0, 30.0, size.width - 30.0, size.height - 38.0);

    _grid(canvas, rect);

    // Axes.
    final Paint axisPaint = Paint()..color = _kAxis..strokeWidth = 1.4;
    canvas.drawLine(
        Offset(rect.left, rect.bottom), Offset(rect.right, rect.bottom), axisPaint);
    canvas.drawLine(
        Offset(rect.left, rect.bottom), Offset(rect.left, rect.top), axisPaint);

    // The Cubic curve to illustrate.
    final Cubic c = Cubic(_p1.dx, _p1.dy, _p2.dx, _p2.dy);

    // Bezier hull — light dashed lines from P0->P1, P1->P2, P2->P3.
    final Offset p0 = _project(Offset(0.0, 0.0), rect);
    final Offset p3 = _project(Offset(1.0, 1.0), rect);
    final Offset p1 = _project(_p1, rect);
    final Offset p2 = _project(_p2, rect);

    final Paint hull = Paint()
      ..color = _kInkMuted.withValues(alpha: 0.6)
      ..strokeWidth = 1.0;
    _dashed(canvas, p0, p1, hull);
    _dashed(canvas, p1, p2, hull);
    _dashed(canvas, p2, p3, hull);

    // Curve.
    final Path path = Path();
    for (int i = 0; i <= 96; i++) {
      final double t = i / 96.0;
      final double v = c.transform(t).clamp(-0.3, 1.3);
      final double x = rect.left + rect.width * t;
      final double y = rect.bottom - rect.height * v;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final Paint curvePaint = Paint()
      ..color = _kAccent
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, curvePaint);

    // Endpoints.
    _marker(canvas, p0, _kInkMuted, 'P0 (0, 0)');
    _marker(canvas, p3, _kInkMuted, 'P3 (1, 1)');
    _marker(canvas, p1, _kHi,
        'P1 (${_p1.dx.toStringAsFixed(2)}, ${_p1.dy.toStringAsFixed(2)})');
    _marker(canvas, p2, _kHi3,
        'P2 (${_p2.dx.toStringAsFixed(2)}, ${_p2.dy.toStringAsFixed(2)})');

    // Title.
    _text(canvas, 'Cubic(a, b, c, d)',
        Offset(rect.left, rect.top - 24.0),
        TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
          color: _kInk,
        ));
  }

  void _grid(Canvas canvas, Rect rect) {
    final Paint p = Paint()
      ..color = _kGrid
      ..strokeWidth = 1.0;
    for (int i = 1; i < 10; i++) {
      final double f = i / 10.0;
      canvas.drawLine(Offset(rect.left + rect.width * f, rect.top),
          Offset(rect.left + rect.width * f, rect.bottom), p);
      canvas.drawLine(Offset(rect.left, rect.bottom - rect.height * f),
          Offset(rect.right, rect.bottom - rect.height * f), p);
    }
  }

  Offset _project(Offset c, Rect rect) {
    return Offset(rect.left + rect.width * c.dx,
        rect.bottom - rect.height * c.dy);
  }

  void _marker(Canvas canvas, Offset at, Color color, String label) {
    final Paint fill = Paint()..color = color;
    final Paint ring = Paint()
      ..color = _kSurface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawCircle(at, 6.5, fill);
    canvas.drawCircle(at, 6.5, ring);
    _text(canvas, label, at.translate(10.0, -18.0),
        TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: _kInkSoft,
            fontWeight: FontWeight.w600));
  }

  void _dashed(Canvas canvas, Offset a, Offset b, Paint paint) {
    final double dx = b.dx - a.dx;
    final double dy = b.dy - a.dy;
    final double dist = math.sqrt(dx * dx + dy * dy);
    if (dist < 0.5) return;
    final double ux = dx / dist;
    final double uy = dy / dist;
    double t = 0.0;
    bool draw = true;
    Offset cur = a;
    const double dash = 5.0;
    const double gap = 3.5;
    while (t < dist) {
      final double step = draw ? dash : gap;
      final double n = math.min(t + step, dist);
      final Offset p = Offset(a.dx + ux * n, a.dy + uy * n);
      if (draw) canvas.drawLine(cur, p, paint);
      cur = p;
      t = n;
      draw = !draw;
    }
  }

  void _text(Canvas canvas, String s, Offset at, TextStyle style) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: s, style: style),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _PrivateAnatomyPainter oldDelegate) => false;
}

// =====================================================================
//   Section 3 — 4×4 curve gallery
// =====================================================================

class _PrivateGalleryCard extends StatelessWidget {
  const _PrivateGalleryCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateCurveSpec> specs = _privateGalleryCurves();
    return _PrivateCard(
      eyebrow: 'SECTION 3 · GALLERY',
      title: '16 curves at a glance',
      subtitle:
          'Each tile is an ~140×100 plot of Curve.transform(t) for 48 sample '
          't-values. Most of these are static Cubic instances; a few '
          '(bounceIn, bounceOut, elastic*) are piecewise.',
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.05,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: specs
            .map<Widget>((_PrivateCurveSpec spec) =>
                _PrivateGalleryTile(spec: spec))
            .toList(),
      ),
    );
  }
}

class _PrivateGalleryTile extends StatelessWidget {
  const _PrivateGalleryTile({required this.spec});
  final _PrivateCurveSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFBFAF5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kCardEdge),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(spec.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  color: spec.tint,
                )),
            SizedBox(height: 4.0),
            Expanded(
              child: CustomPaint(
                painter: _PrivateMiniCurvePainter(
                  curve: spec.curve,
                  tint: spec.tint,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              spec.blurb,
              style: TextStyle(
                fontSize: 9.5,
                color: _kInkMuted,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateMiniCurvePainter extends CustomPainter {
  _PrivateMiniCurvePainter({required this.curve, required this.tint});
  final Curve curve;
  final Color tint;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect r = Rect.fromLTRB(4.0, 4.0, size.width - 4.0, size.height - 4.0);

    // Frame.
    final Paint frame = Paint()
      ..color = _kGrid
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(
        RRect.fromRectAndRadius(r, Radius.circular(6.0)), frame);

    // Mid-line.
    final Paint mid = Paint()
      ..color = _kGrid.withValues(alpha: 0.6)
      ..strokeWidth = 1.0;
    canvas.drawLine(
        Offset(r.left, r.top + r.height / 2),
        Offset(r.right, r.top + r.height / 2),
        mid);

    // Curve.
    final Path path = Path();
    const int n = 48;
    for (int i = 0; i <= n; i++) {
      final double t = i / n;
      final double v = curve.transform(t).clamp(-0.4, 1.4);
      final double x = r.left + r.width * t;
      final double y = r.bottom - r.height * v;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final Paint stroke = Paint()
      ..color = tint
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, stroke);

    // Endpoint dots.
    final Paint dot = Paint()..color = tint.withValues(alpha: 0.85);
    canvas.drawCircle(Offset(r.left, r.bottom), 2.5, dot);
    canvas.drawCircle(Offset(r.right, r.top), 2.5, dot);
  }

  @override
  bool shouldRepaint(covariant _PrivateMiniCurvePainter oldDelegate) {
    return oldDelegate.curve != curve || oldDelegate.tint != tint;
  }
}

// =====================================================================
//   Section 4 — Cubic constructor cards
// =====================================================================

class _PrivateConstructorCards extends StatelessWidget {
  const _PrivateConstructorCards();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateConstructorSpec> specs = <_PrivateConstructorSpec>[
      _PrivateConstructorSpec(
        title: 'CSS ease-in-out',
        cubic: Cubic(0.42, 0.0, 0.58, 1.0),
        css: 'cubic-bezier(0.42, 0, 0.58, 1)',
        note:
            'The standard double-symmetric ease. Smooth start and stop; '
            'maximum velocity at t = 0.5.',
        tint: _kAccent,
      ),
      _PrivateConstructorSpec(
        title: 'Material standard',
        cubic: Cubic(0.4, 0.0, 0.2, 1.0),
        css: 'cubic-bezier(0.4, 0, 0.2, 1)',
        note:
            'Curves.fastOutSlowIn. Material Design\'s recommended easing '
            'for entering / exiting elements on a single screen.',
        tint: _kHi3,
      ),
      _PrivateConstructorSpec(
        title: 'easeOutBack',
        cubic: Cubic(0.175, 0.885, 0.32, 1.275),
        css: 'cubic-bezier(0.175, 0.885, 0.32, 1.275)',
        note:
            'Overshoot at the end (d = 1.275 > 1). Useful for playful '
            '"settle-back" effects on dialogs and chips.',
        tint: _kHi,
      ),
      _PrivateConstructorSpec(
        title: 'slowMiddle',
        cubic: Cubic(0.15, 0.85, 0.85, 0.15),
        css: 'cubic-bezier(0.15, 0.85, 0.85, 0.15)',
        note:
            'S-curve that slows in the middle. Rare but useful for '
            '"hesitation" feel when crossing a threshold.',
        tint: _kHi4,
      ),
    ];

    return _PrivateCard(
      eyebrow: 'SECTION 4 · CONSTRUCTORS',
      title: 'Four hand-picked Cubic instances',
      subtitle:
          'Each card pairs a Cubic constructor call with its CSS '
          'cubic-bezier() equivalent. The numbers a, b, c, d match '
          'one-to-one between the two notations.',
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _PrivateConstructorCard(spec: specs[0])),
              SizedBox(width: 12.0),
              Expanded(child: _PrivateConstructorCard(spec: specs[1])),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _PrivateConstructorCard(spec: specs[2])),
              SizedBox(width: 12.0),
              Expanded(child: _PrivateConstructorCard(spec: specs[3])),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateConstructorSpec {
  const _PrivateConstructorSpec({
    required this.title,
    required this.cubic,
    required this.css,
    required this.note,
    required this.tint,
  });

  final String title;
  final Cubic cubic;
  final String css;
  final String note;
  final Color tint;
}

class _PrivateConstructorCard extends StatelessWidget {
  const _PrivateConstructorCard({required this.spec});
  final _PrivateConstructorSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFBFAF5),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _kCardEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: spec.tint,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(spec.title, style: _kH3),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            height: 130.0,
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _kCardEdge),
            ),
            child: CustomPaint(
              painter: _PrivateConstructorPlotPainter(
                cubic: spec.cubic,
                tint: spec.tint,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Cubic(${spec.cubic.a}, ${spec.cubic.b}, ${spec.cubic.c}, ${spec.cubic.d})',
            style: _kMono,
          ),
          SizedBox(height: 4.0),
          Text(spec.css,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: _kAccent,
              )),
          SizedBox(height: 8.0),
          Text(spec.note, style: _kSmall),
        ],
      ),
    );
  }
}

class _PrivateConstructorPlotPainter extends CustomPainter {
  _PrivateConstructorPlotPainter({required this.cubic, required this.tint});
  final Cubic cubic;
  final Color tint;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect r =
        Rect.fromLTRB(12.0, 10.0, size.width - 12.0, size.height - 10.0);

    // Grid.
    final Paint grid = Paint()
      ..color = _kGrid
      ..strokeWidth = 1.0;
    for (int i = 1; i < 5; i++) {
      final double f = i / 5.0;
      canvas.drawLine(Offset(r.left + r.width * f, r.top),
          Offset(r.left + r.width * f, r.bottom), grid);
      canvas.drawLine(Offset(r.left, r.bottom - r.height * f),
          Offset(r.right, r.bottom - r.height * f), grid);
    }

    // Frame.
    final Paint frame = Paint()
      ..color = _kAxis
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(
        RRect.fromRectAndRadius(r, Radius.circular(6.0)), frame);

    // Hull.
    final Offset p0 = Offset(r.left, r.bottom);
    final Offset p3 = Offset(r.right, r.top);
    final Offset p1 = Offset(
        r.left + r.width * cubic.a,
        r.bottom - r.height * cubic.b);
    final Offset p2 = Offset(
        r.left + r.width * cubic.c,
        r.bottom - r.height * cubic.d);

    final Paint hull = Paint()
      ..color = tint.withValues(alpha: 0.4)
      ..strokeWidth = 1.0;
    canvas.drawLine(p0, p1, hull);
    canvas.drawLine(p3, p2, hull);

    // Curve.
    final Path path = Path();
    for (int i = 0; i <= 64; i++) {
      final double t = i / 64.0;
      final double v = cubic.transform(t).clamp(-0.4, 1.4);
      final double x = r.left + r.width * t;
      final double y = r.bottom - r.height * v;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final Paint stroke = Paint()
      ..color = tint
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, stroke);

    // CP markers.
    final Paint cpFill = Paint()..color = tint;
    canvas.drawCircle(p1, 4.0, cpFill);
    canvas.drawCircle(p2, 4.0, cpFill);
  }

  @override
  bool shouldRepaint(covariant _PrivateConstructorPlotPainter oldDelegate) {
    return oldDelegate.cubic != cubic || oldDelegate.tint != tint;
  }
}

// =====================================================================
//   Section 5 — transform(t) numeric table
// =====================================================================

class _PrivateTransformTableCard extends StatelessWidget {
  const _PrivateTransformTableCard();

  @override
  Widget build(BuildContext context) {
    final List<double> ts = <double>[0.0, 0.1, 0.25, 0.5, 0.75, 0.9, 1.0];
    final List<_PrivateNamedCurve> cols = <_PrivateNamedCurve>[
      _PrivateNamedCurve('linear', Curves.linear),
      _PrivateNamedCurve('easeIn', Curves.easeIn),
      _PrivateNamedCurve('easeOut', Curves.easeOut),
      _PrivateNamedCurve('easeInOut', Curves.easeInOut),
      _PrivateNamedCurve('bounceOut', Curves.bounceOut),
    ];

    return _PrivateCard(
      eyebrow: 'SECTION 5 · transform(t)',
      title: 'Numeric table — five curves at seven sample t-values',
      subtitle:
          'Curve.transform(t) is a pure function from double to double. '
          'It must satisfy transform(0) == 0 and transform(1) == 1; values '
          'in between depend entirely on the shape.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _PrivateTableRow(
            cells: <_PrivateCell>[
              _PrivateCell(text: 't', isHeader: true, flex: 2),
              ...cols.map<_PrivateCell>(
                  (_PrivateNamedCurve c) => _PrivateCell(
                        text: c.name,
                        isHeader: true,
                        flex: 3,
                      )),
            ],
            zebra: false,
            isHeader: true,
          ),
          for (int i = 0; i < ts.length; i++)
            _PrivateTableRow(
              cells: <_PrivateCell>[
                _PrivateCell(
                  text: ts[i].toStringAsFixed(2),
                  isHeader: false,
                  flex: 2,
                  mono: true,
                  bold: true,
                ),
                ...cols.map<_PrivateCell>(
                    (_PrivateNamedCurve c) => _PrivateCell(
                          text: c.curve.transform(ts[i]).toStringAsFixed(4),
                          isHeader: false,
                          flex: 3,
                          mono: true,
                          tint: _curveTint(c.name),
                        )),
              ],
              zebra: i.isOdd,
              isHeader: false,
            ),
        ],
      ),
    );
  }

  Color _curveTint(String name) {
    switch (name) {
      case 'linear':
        return _kInkMuted;
      case 'easeIn':
        return _kHi4;
      case 'easeOut':
        return _kHi3;
      case 'easeInOut':
        return _kAccent;
      case 'bounceOut':
        return _kHi2;
    }
    return _kInk;
  }
}

class _PrivateNamedCurve {
  const _PrivateNamedCurve(this.name, this.curve);
  final String name;
  final Curve curve;
}

class _PrivateCell {
  const _PrivateCell({
    required this.text,
    required this.isHeader,
    required this.flex,
    this.mono = false,
    this.bold = false,
    this.tint,
  });
  final String text;
  final bool isHeader;
  final int flex;
  final bool mono;
  final bool bold;
  final Color? tint;
}

class _PrivateTableRow extends StatelessWidget {
  const _PrivateTableRow({
    required this.cells,
    required this.zebra,
    required this.isHeader,
  });
  final List<_PrivateCell> cells;
  final bool zebra;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHeader
            ? _kAccentSoft.withValues(alpha: 0.4)
            : (zebra ? Color(0xFFFBFAF5) : _kSurface),
        border: Border(
          bottom: BorderSide(color: _kCardEdge),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 9.0),
      child: Row(
        children: cells
            .map<Widget>((_PrivateCell c) => Expanded(
                  flex: c.flex,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      c.text,
                      style: TextStyle(
                        fontFamily: c.mono ? 'monospace' : null,
                        fontSize: c.isHeader ? 12.5 : 13.0,
                        fontWeight: c.isHeader || c.bold
                            ? FontWeight.w800
                            : FontWeight.w500,
                        color: c.tint ??
                            (c.isHeader ? _kAccent : _kInk),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

// =====================================================================
//   Section 6 — Sibling-curve gallery
// =====================================================================

class _PrivateSiblingCurveCard extends StatelessWidget {
  const _PrivateSiblingCurveCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateSiblingSpec> siblings = <_PrivateSiblingSpec>[
      _PrivateSiblingSpec(
        name: 'Threshold(0.5)',
        curve: Threshold(0.5),
        blurb: 'Step from 0 to 1 at threshold; useful for binary states.',
        tint: _kInk,
      ),
      _PrivateSiblingSpec(
        name: 'Interval(0.25, 0.75, easeInOut)',
        curve: Interval(0.25, 0.75, curve: Curves.easeInOut),
        blurb: 'Pads start/end with 0/1 plateaus; runs child curve in between.',
        tint: _kAccent,
      ),
      _PrivateSiblingSpec(
        name: 'SawTooth(3)',
        curve: SawTooth(3),
        blurb: 'Three rising ramps from 0 to 1; for repeated motion.',
        tint: _kHi,
      ),
      _PrivateSiblingSpec(
        name: 'FlippedCurve(easeIn)',
        curve: FlippedCurve(Curves.easeIn),
        blurb: 'Reverses input AND output: f\'(t) = 1 - f(1 - t).',
        tint: _kHi3,
      ),
      _PrivateSiblingSpec(
        name: 'Split(0.5, easeIn, easeOut)',
        curve: Split(0.5, beginCurve: Curves.easeIn, endCurve: Curves.easeOut),
        blurb: 'Two curves stitched at the split point.',
        tint: _kHi4,
      ),
      _PrivateSiblingSpec(
        name: 'easeInOut.flipped',
        curve: Curves.easeInOut.flipped,
        blurb: 'Built-in .flipped getter — symmetric to original.',
        tint: _kHi2,
      ),
    ];

    return _PrivateCard(
      eyebrow: 'SECTION 6 · SIBLINGS',
      title: 'Curves that wrap or compose other curves',
      subtitle:
          'Cubic is just one Curve subclass. The animation library ships '
          'several composers and shape-curves. They all implement the same '
          'transform(t) contract.',
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.25,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: siblings
            .map<Widget>((_PrivateSiblingSpec s) =>
                _PrivateSiblingTile(spec: s))
            .toList(),
      ),
    );
  }
}

class _PrivateSiblingSpec {
  const _PrivateSiblingSpec({
    required this.name,
    required this.curve,
    required this.blurb,
    required this.tint,
  });
  final String name;
  final Curve curve;
  final String blurb;
  final Color tint;
}

class _PrivateSiblingTile extends StatelessWidget {
  const _PrivateSiblingTile({required this.spec});
  final _PrivateSiblingSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFFBFAF5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kCardEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(spec.name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: spec.tint,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: 6.0),
          Expanded(
            child: CustomPaint(
              painter: _PrivateMiniCurvePainter(
                curve: spec.curve,
                tint: spec.tint,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(spec.blurb, style: _kSmall, maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

// =====================================================================
//   Section 7 — Code-listing card
// =====================================================================

class _PrivateCodeListingCard extends StatelessWidget {
  const _PrivateCodeListingCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateCodeLine> code = <_PrivateCodeLine>[
      _PrivateCodeLine(
          [_PrivateCodeTok('// Construct a Tween animated by a Cubic curve.', _kCodeCom)]),
      _PrivateCodeLine([
        _PrivateCodeTok('final ', _kCodeKey),
        _PrivateCodeTok('controller ', _kCodeInk),
        _PrivateCodeTok('= ', _kCodeInk),
        _PrivateCodeTok('AnimationController', _kCodeKey),
        _PrivateCodeTok('(', _kCodeInk),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('  duration: ', _kCodeInk),
        _PrivateCodeTok('Duration', _kCodeKey),
        _PrivateCodeTok('(milliseconds: ', _kCodeInk),
        _PrivateCodeTok('400', _kCodeNum),
        _PrivateCodeTok('),', _kCodeInk),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('  vsync: ', _kCodeInk),
        _PrivateCodeTok('this', _kCodeKey),
        _PrivateCodeTok(',', _kCodeInk),
      ]),
      _PrivateCodeLine([_PrivateCodeTok(');', _kCodeInk)]),
      _PrivateCodeLine([_PrivateCodeTok('', _kCodeInk)]),
      _PrivateCodeLine([
        _PrivateCodeTok('// Apply Cubic ease-in-out via CurvedAnimation.', _kCodeCom),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('final ', _kCodeKey),
        _PrivateCodeTok('eased ', _kCodeInk),
        _PrivateCodeTok('= ', _kCodeInk),
        _PrivateCodeTok('CurvedAnimation', _kCodeKey),
        _PrivateCodeTok('(', _kCodeInk),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('  parent: ', _kCodeInk),
        _PrivateCodeTok('controller', _kCodeInk),
        _PrivateCodeTok(',', _kCodeInk),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('  curve: ', _kCodeInk),
        _PrivateCodeTok('const ', _kCodeKey),
        _PrivateCodeTok('Cubic', _kCodeKey),
        _PrivateCodeTok('(', _kCodeInk),
        _PrivateCodeTok('0.42', _kCodeNum),
        _PrivateCodeTok(', ', _kCodeInk),
        _PrivateCodeTok('0', _kCodeNum),
        _PrivateCodeTok(', ', _kCodeInk),
        _PrivateCodeTok('0.58', _kCodeNum),
        _PrivateCodeTok(', ', _kCodeInk),
        _PrivateCodeTok('1.0', _kCodeNum),
        _PrivateCodeTok('),', _kCodeInk),
      ]),
      _PrivateCodeLine([_PrivateCodeTok(');', _kCodeInk)]),
      _PrivateCodeLine([_PrivateCodeTok('', _kCodeInk)]),
      _PrivateCodeLine([
        _PrivateCodeTok('// Or use the canonical preset.', _kCodeCom),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('final ', _kCodeKey),
        _PrivateCodeTok('preset ', _kCodeInk),
        _PrivateCodeTok('= ', _kCodeInk),
        _PrivateCodeTok('CurvedAnimation', _kCodeKey),
        _PrivateCodeTok('(', _kCodeInk),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('  parent: ', _kCodeInk),
        _PrivateCodeTok('controller', _kCodeInk),
        _PrivateCodeTok(',', _kCodeInk),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('  curve: ', _kCodeInk),
        _PrivateCodeTok('Curves', _kCodeKey),
        _PrivateCodeTok('.fastOutSlowIn,', _kCodeInk),
      ]),
      _PrivateCodeLine([_PrivateCodeTok(');', _kCodeInk)]),
      _PrivateCodeLine([_PrivateCodeTok('', _kCodeInk)]),
      _PrivateCodeLine([
        _PrivateCodeTok('// Drive a Tween from a CurvedAnimation.', _kCodeCom),
      ]),
      _PrivateCodeLine([
        _PrivateCodeTok('final ', _kCodeKey),
        _PrivateCodeTok('size ', _kCodeInk),
        _PrivateCodeTok('= ', _kCodeInk),
        _PrivateCodeTok('Tween<double>', _kCodeKey),
        _PrivateCodeTok('(begin: ', _kCodeInk),
        _PrivateCodeTok('0.0', _kCodeNum),
        _PrivateCodeTok(', end: ', _kCodeInk),
        _PrivateCodeTok('120.0', _kCodeNum),
        _PrivateCodeTok(').animate(eased);', _kCodeInk),
      ]),
    ];

    return _PrivateCard(
      eyebrow: 'SECTION 7 · USAGE',
      title: 'Cubic in real Flutter code',
      subtitle:
          'Illustrative only — this snippet is not run by the demo (no '
          'controllers / vsync are created at build time). It shows the '
          'two idiomatic ways to apply Cubic easing: literal `Cubic(...)` '
          'and `Curves.fastOutSlowIn`.',
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _kCode,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: code
              .asMap()
              .entries
              .map<Widget>((MapEntry<int, _PrivateCodeLine> e) =>
                  _PrivateCodeLineWidget(
                      lineNumber: e.key + 1, line: e.value))
              .toList(),
        ),
      ),
    );
  }
}

class _PrivateCodeTok {
  const _PrivateCodeTok(this.text, this.color);
  final String text;
  final Color color;
}

class _PrivateCodeLine {
  const _PrivateCodeLine(this.tokens);
  final List<_PrivateCodeTok> tokens;
}

class _PrivateCodeLineWidget extends StatelessWidget {
  const _PrivateCodeLineWidget(
      {required this.lineNumber, required this.line});
  final int lineNumber;
  final _PrivateCodeLine line;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: 32.0,
          child: Text(
            lineNumber.toString().padLeft(2),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kCodeCom,
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: line.tokens
                  .map<InlineSpan>((_PrivateCodeTok t) => TextSpan(
                        text: t.text,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13.0,
                          color: t.color,
                          height: 1.45,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
//   Section 8 — Pitfalls
// =====================================================================

class _PrivatePitfallsCard extends StatelessWidget {
  const _PrivatePitfallsCard();

  @override
  Widget build(BuildContext context) {
    final List<_PrivatePitfall> pitfalls = <_PrivatePitfall>[
      _PrivatePitfall(
        title: 'Control x-coordinates must be in [0, 1].',
        body: 'a (P1.x) and c (P2.x) outside [0, 1] make the curve no longer '
            'a function — the same t could map to multiple y values. Flutter '
            'asserts on this in debug builds.',
        tone: _kHi,
      ),
      _PrivatePitfall(
        title: 'Curves.linear is the identity, not a Cubic.',
        body: 'Curves.linear is a small dedicated subclass with '
            'transform(t) => t. You will not find Bezier control points; '
            'do not pattern-match on (a, b, c, d) for it.',
        tone: _kAccent,
      ),
      _PrivatePitfall(
        title: 'Non-monotone Cubics cause overshoot — by design.',
        body: 'A Cubic with d > 1 (e.g. easeOutBack) intentionally exceeds '
            '1.0 mid-curve. If you Tween a length or opacity, clamp the '
            'output OR pick a non-overshoot curve.',
        tone: _kHi3,
      ),
      _PrivatePitfall(
        title: 'transform(0) and transform(1) must hit 0 and 1.',
        body: 'This is part of the Curve contract. Cubic enforces it via '
            'fixed endpoints; custom Curve subclasses must respect it.',
        tone: _kHi4,
      ),
    ];

    return _PrivateCard(
      eyebrow: 'SECTION 8 · PITFALLS',
      title: 'Things that bite when you build curves by hand',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: pitfalls
            .map<Widget>((_PrivatePitfall p) => Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: _PrivatePitfallRow(pitfall: p),
                ))
            .toList(),
      ),
    );
  }
}

class _PrivatePitfall {
  const _PrivatePitfall({
    required this.title,
    required this.body,
    required this.tone,
  });
  final String title;
  final String body;
  final Color tone;
}

class _PrivatePitfallRow extends StatelessWidget {
  const _PrivatePitfallRow({required this.pitfall});
  final _PrivatePitfall pitfall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: pitfall.tone.withValues(alpha: 0.07),
        border: Border(
          left: BorderSide(color: pitfall.tone, width: 4.0),
          top: BorderSide(color: _kCardEdge),
          right: BorderSide(color: _kCardEdge),
          bottom: BorderSide(color: _kCardEdge),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(pitfall.title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
                color: pitfall.tone,
              )),
          SizedBox(height: 6.0),
          Text(pitfall.body, style: _kBody),
        ],
      ),
    );
  }
}

// =====================================================================
//   Section 9 — Footer
// =====================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text('C',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                )),
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Cubic — visual deep demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(height: 4.0),
                Text(
                  'package:flutter/animation.dart · Cubic, Curves, '
                  'CurvedAnimation, Threshold, Interval, SawTooth, '
                  'FlippedCurve, Split, ThreePointCubic',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11.5,
                    fontFamily: 'monospace',
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
