// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of ScrollPhysics deceleration variants.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight to
// the host app's renderer.
//
// The rendered output is a long, static technical poster that walks through
// the ScrollPhysics family from the framework's perspective. Ten thematic
// sections cover:
//
//   1. Hero intro - why scroll physics exists, what "deceleration rate" is,
//      and where it sits in Flutter's gesture pipeline.
//   2. Class hierarchy CustomPainter - ScrollPhysics base class and its six
//      idiomatic descendants (BouncingScrollPhysics, ClampingScrollPhysics,
//      AlwaysScrollableScrollPhysics, NeverScrollableScrollPhysics, PageScroll
//      Physics, RangeMaintainingScrollPhysics).
//   3. Velocity decay graph CustomPainter - two superimposed exponential
//      curves contrasting ScrollDecelerationRate.normal with .fast. Axes are
//      labelled, control points are highlighted.
//   4. ScrollPhysics anatomy table - minFlingVelocity, maxFlingVelocity,
//      dragStartDistanceMotionThreshold, carriedMomentum, toleranceFor,
//      decelerationRate.
//   5. Six physics variants - one card per physics type with a faux scroll
//      preview and a behaviour summary.
//   6. Worked example - a side-by-side numeric walk-through of how velocity
//      decays under the two deceleration rates with key timestamps.
//   7. Six code recipes - idiomatic snippets for composing physics, building
//      a custom subclass, page-snapping, disabling scroll, and clamping.
//   8. Comparison matrix - 6x6 grid scoring each physics type on overscroll,
//      bounce, clamp, snap, deceleration, and chainability.
//   9. Pitfalls callouts - gotchas like missing parent chains, fling velocity
//      clamps, deceleration on web, and Cupertino vs Material defaults.
//  10. Cheat-sheet footer - chip groups summarising the ScrollPhysics surface.
//
// Build-time discipline: no setState, no Timer, no Future, no live
// AnimationController. Physics objects are constructed inertly so we can
// read static fields like dragStartDistanceMotionThreshold and minFlingDist
// anceThreshold for the anatomy table.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
const Color _kCanvas = Color(0xFFF4F5F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF8F9FC);
const Color _kCardDark = Color(0xFF1B1D2A);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1A1C25);
const Color _kInkSecondary = Color(0xFF424657);
const Color _kInkTertiary = Color(0xFF8C90A1);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A6B8);
const Color _kAccent = Color(0xFF0F766E); // teal - "kinetic"
const Color _kAccentSoft = Color(0xFFCCFBF1);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentDeep = Color(0xFF134E4A);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kAccentOrange = Color(0xFFEA580C);
const Color _kCurveNormal = Color(0xFF2563EB);
const Color _kCurveFast = Color(0xFFE11D48);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kBodySoftStyle = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoInlineStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.3,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE BUILDER HELPERS
// ---------------------------------------------------------------------------
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 30.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(
  String title, {
  String? subtitle,
  Color titleColor = _kInk,
  Color subtitleColor = _kInkSecondary,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2D32)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 220.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: valueColour,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletList(List<String> items, {Color dotColour = _kAccent}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      for (final String item in items)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 7.0, right: 8.0),
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: dotColour,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Expanded(child: Text(item, style: _kBodyStyle)),
            ],
          ),
        ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------
Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF134E4A),
          Color(0xFF0F766E),
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33134E4A),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'package:flutter/widgets.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'scroll_physics.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Scroll Deceleration Physics',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'How ScrollPhysics turns finger velocity into motion that decays '
          'gracefully to zero. Six physics variants, two deceleration rates, '
          'one consistent simulation contract.',
          style: TextStyle(
            color: Color(0xFFD1FAF1),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('ScrollPhysics', colour: const Color(0xFFA7F3D0)),
            _pill('decel.normal', colour: const Color(0xFF93C5FD)),
            _pill('decel.fast', colour: const Color(0xFFFCA5A5)),
            _pill('Clamping', colour: const Color(0xFFFDE68A)),
            _pill('Bouncing', colour: const Color(0xFFFBCFE8)),
            _pill('PageScroll', colour: const Color(0xFFC4B5FD)),
          ],
        ),
      ],
    ),
  );
}

Widget _heroIntroCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'What ScrollPhysics actually does',
          subtitle:
              'ScrollPhysics is a Simulation factory. Given a finger fling, '
              'it produces a one-dimensional Simulation that the Scrollable '
              'integrates each frame until the velocity decays below tolerance.',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'The finger releases at velocity v0. ScrollPhysics.createBallistic'
            'Simulation builds a FrictionSimulation parameterised by '
            'decelerationRate. Each frame the Scrollable polls x(t) and v(t); '
            'when v(t) drops below toleranceFor(metrics).velocity, the '
            'simulation reports isDone(t)=true and the kinetic phase ends.',
            style: TextStyle(fontSize: 13.5, height: 1.5, color: _kInk),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _bulletList(const <String>[
                'Simulation: one-dimensional, time-parameterised motion.',
                'createBallisticSimulation: post-fling motion (the slide).',
                'applyBoundaryConditions: how to clamp at edges.',
                'applyPhysicsToUserOffset: how a drag turns into pixels.',
                'toleranceFor: when "close enough to stopped" is reached.',
              ]),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _kvRow('parent', 'ScrollPhysics? for chaining'),
                  _kvRow('minFlingVelocity', '50.0 logical px/sec'),
                  _kvRow('maxFlingVelocity', '8000.0 logical px/sec'),
                  _kvRow('minFlingDistance', '18.0 logical px'),
                  _kvRow('dragStartDistance', '3.5 logical px'),
                  _kvRow('carriedMomentum', 'sqrt(|v|/5000) * v'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - CLASS HIERARCHY CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _HierarchyPainter extends CustomPainter {
  const _HierarchyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint hairline = Paint()
      ..color = const Color(0x55134E4A)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final Paint hairlineLight = Paint()
      ..color = const Color(0x33134E4A)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    void drawNode(
      Offset center,
      String label,
      Color fill,
      Color textColour,
      double width,
    ) {
      final Rect r = Rect.fromCenter(center: center, width: width, height: 36.0);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(10.0));
      canvas.drawRRect(rr, Paint()..color = fill);
      canvas.drawRRect(rr, hairlineLight);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: textColour,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: width - 12.0);
      tp.paint(
        canvas,
        Offset(center.dx - tp.width / 2.0, center.dy - tp.height / 2.0),
      );
    }

    void drawEdge(Offset a, Offset b) {
      final Path p = Path()
        ..moveTo(a.dx, a.dy)
        ..lineTo(a.dx, (a.dy + b.dy) / 2.0)
        ..lineTo(b.dx, (a.dy + b.dy) / 2.0)
        ..lineTo(b.dx, b.dy);
      canvas.drawPath(p, hairline);
    }

    final double w = size.width;
    final Offset root = Offset(w / 2.0, 28.0);
    drawNode(root, 'ScrollPhysics', _kAccent, Colors.white, 170.0);

    final List<Offset> tier1 = <Offset>[
      Offset(w * 0.12, 110.0),
      Offset(w * 0.32, 110.0),
      Offset(w * 0.52, 110.0),
      Offset(w * 0.72, 110.0),
      Offset(w * 0.92, 110.0),
    ];
    final List<String> tier1Labels = <String>[
      'Bouncing',
      'Clamping',
      'AlwaysScrollable',
      'NeverScrollable',
      'PageScroll',
    ];
    final List<Color> tier1Colours = <Color>[
      _kAccentRose.withOpacity(0.15),
      _kCurveNormal.withOpacity(0.15),
      _kAccentGreen.withOpacity(0.15),
      _kAccentAmber.withOpacity(0.15),
      _kAccentViolet.withOpacity(0.15),
    ];
    for (int i = 0; i < tier1.length; i++) {
      drawNode(tier1[i], tier1Labels[i], tier1Colours[i], _kInk, 130.0);
      drawEdge(
        Offset(root.dx, root.dy + 18.0),
        Offset(tier1[i].dx, tier1[i].dy - 18.0),
      );
    }

    final Offset rangeNode = Offset(w * 0.50, 200.0);
    drawNode(
      rangeNode,
      'RangeMaintaining',
      _kAccentOrange.withOpacity(0.15),
      _kInk,
      170.0,
    );
    drawEdge(
      Offset(root.dx, root.dy + 18.0),
      Offset(rangeNode.dx, rangeNode.dy - 18.0),
    );

    // Caption strip across the bottom.
    final TextPainter cap = TextPainter(
      text: const TextSpan(
        text: 'ScrollPhysics is composable via the .applyTo(parent) chain.',
        style: TextStyle(
          fontSize: 11.0,
          color: _kInkTertiary,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    cap.layout(maxWidth: w);
    cap.paint(canvas, Offset((w - cap.width) / 2.0, size.height - 16.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _hierarchySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Inheritance tree',
          subtitle:
              'Every concrete physics is a ScrollPhysics subclass. They '
              'compose through .applyTo(parent) - a Decorator pattern.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 240.0,
          child: CustomPaint(
            painter: const _HierarchyPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('Listenable-free', colour: _kAccentGreen),
            _pill('Immutable', colour: _kAccentBlue),
            _pill('Composable', colour: _kAccent),
            _pill('Platform-aware', colour: _kAccentViolet),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - VELOCITY DECAY GRAPH CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _DecayPainter extends CustomPainter {
  const _DecayPainter();

  // Exponential decay model used purely for visual rendering. Real Flutter
  // uses a FrictionSimulation with d^t shape but the constants here are
  // chosen to match the qualitative feel of normal vs fast deceleration.
  double _normal(double t) => math.exp(-0.9 * t);
  double _fast(double t) => math.exp(-2.2 * t);

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    const double padL = 44.0;
    const double padR = 14.0;
    const double padT = 14.0;
    const double padB = 30.0;
    final Rect plot = Rect.fromLTRB(padL, padT, w - padR, h - padB);

    // Background plot panel.
    final Paint bg = Paint()..color = const Color(0xFFF8FBFA);
    canvas.drawRRect(
      RRect.fromRectAndRadius(plot, const Radius.circular(6.0)),
      bg,
    );

    // Grid lines.
    final Paint grid = Paint()
      ..color = const Color(0x14000000)
      ..strokeWidth = 1.0;
    for (int i = 1; i < 5; i++) {
      final double y = plot.top + plot.height * (i / 5.0);
      canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), grid);
    }
    for (int i = 1; i < 6; i++) {
      final double x = plot.left + plot.width * (i / 6.0);
      canvas.drawLine(Offset(x, plot.top), Offset(x, plot.bottom), grid);
    }

    // Axes.
    final Paint axis = Paint()
      ..color = _kInkSecondary
      ..strokeWidth = 1.4;
    canvas.drawLine(
      Offset(plot.left, plot.bottom),
      Offset(plot.right, plot.bottom),
      axis,
    );
    canvas.drawLine(
      Offset(plot.left, plot.top),
      Offset(plot.left, plot.bottom),
      axis,
    );

    Path buildPath(double Function(double) f) {
      final Path p = Path();
      for (int i = 0; i <= 120; i++) {
        final double t = i / 30.0; // 0..4 seconds
        final double v = f(t);
        final double x = plot.left + (i / 120.0) * plot.width;
        final double y = plot.bottom - v * plot.height;
        if (i == 0) {
          p.moveTo(x, y);
        } else {
          p.lineTo(x, y);
        }
      }
      return p;
    }

    final Paint curveNormal = Paint()
      ..color = _kCurveNormal
      ..strokeWidth = 2.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint curveFast = Paint()
      ..color = _kCurveFast
      ..strokeWidth = 2.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(buildPath(_normal), curveNormal);
    canvas.drawPath(buildPath(_fast), curveFast);

    // Tolerance threshold line at v=0.05.
    final Paint tolPaint = Paint()
      ..color = const Color(0xFF8C90A1)
      ..strokeWidth = 1.2;
    final double tolY = plot.bottom - 0.05 * plot.height;
    for (double x = plot.left; x < plot.right; x += 6.0) {
      canvas.drawLine(Offset(x, tolY), Offset(x + 3.0, tolY), tolPaint);
    }

    // Stop markers - where each curve crosses tolerance.
    final double tStopNormal = -math.log(0.05) / 0.9;
    final double tStopFast = -math.log(0.05) / 2.2;
    void markStop(double t, Color c) {
      final double x = plot.left + (t / 4.0) * plot.width;
      canvas.drawCircle(Offset(x, tolY), 4.5, Paint()..color = c);
      canvas.drawCircle(
        Offset(x, tolY),
        4.5,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }

    markStop(tStopNormal, _kCurveNormal);
    markStop(tStopFast, _kCurveFast);

    // Axis labels.
    void label(String s, Offset at, {bool right = false}) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: s,
          style: const TextStyle(
            fontSize: 10.5,
            color: _kInkTertiary,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, right ? Offset(at.dx - tp.width, at.dy) : at);
    }

    label('v0', Offset(plot.left - 30.0, plot.top - 2.0));
    label('0.5v0', Offset(plot.left - 36.0, plot.top + plot.height * 0.5 - 6.0));
    label('tol', Offset(plot.left - 30.0, tolY - 6.0));
    label('0s', Offset(plot.left - 4.0, plot.bottom + 4.0));
    label('1s', Offset(plot.left + plot.width / 4.0, plot.bottom + 4.0));
    label('2s', Offset(plot.left + plot.width * 2.0 / 4.0, plot.bottom + 4.0));
    label('3s', Offset(plot.left + plot.width * 3.0 / 4.0, plot.bottom + 4.0));
    label('4s', Offset(plot.right - 8.0, plot.bottom + 4.0));

    // Legend.
    void legend(double dx, double dy, Color c, String text) {
      canvas.drawLine(
        Offset(dx, dy),
        Offset(dx + 22.0, dy),
        Paint()
          ..color = c
          ..strokeWidth = 3.0
          ..strokeCap = StrokeCap.round,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 11.0,
            color: _kInk,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(dx + 28.0, dy - 7.0));
    }

    legend(plot.right - 240.0, plot.top + 14.0, _kCurveNormal,
        'decel.normal (~0.78)');
    legend(plot.right - 110.0, plot.top + 14.0, _kCurveFast,
        'decel.fast (~0.96)');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _decaySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Velocity decay over time',
          subtitle:
              'Normal vs fast deceleration. Higher rate value -> longer '
              'glide. Material defaults to normal; Cupertino lists use fast.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 230.0,
          child: CustomPaint(
            painter: const _DecayPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _kCurveNormal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _kCurveNormal.withOpacity(0.25)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ScrollDecelerationRate.normal',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: _kCurveNormal,
                        )),
                    SizedBox(height: 4.0),
                    Text(
                      'd = 0.135^(t). At t=1s velocity is ~13.5% of v0. The '
                      'glide is long and Material-y.',
                      style: TextStyle(fontSize: 12.0, color: _kInk),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _kCurveFast.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _kCurveFast.withOpacity(0.25)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ScrollDecelerationRate.fast',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: _kCurveFast,
                        )),
                    SizedBox(height: 4.0),
                    Text(
                      'd = 0.0006^(t). Velocity collapses quickly - the '
                      'feel is iOS-snappy, used for Cupertino lists.',
                      style: TextStyle(fontSize: 12.0, color: _kInk),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - ANATOMY TABLE
// ---------------------------------------------------------------------------
Widget _anatomySection() {
  const BouncingScrollPhysics bouncing = BouncingScrollPhysics();
  const ClampingScrollPhysics clamping = ClampingScrollPhysics();
  const PageScrollPhysics paging = PageScrollPhysics();
  const NeverScrollableScrollPhysics never = NeverScrollableScrollPhysics();

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Anatomy of a ScrollPhysics',
          subtitle:
              'Configuration getters every subclass may override. Defaults '
              'shown are from the base class unless noted.',
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('parent', 'ScrollPhysics? (Decorator chain)'),
              _kvRow('allowImplicitScrolling', 'true (false for never)'),
              _kvRow('minFlingVelocity', '50.0 logical px/s'),
              _kvRow('maxFlingVelocity', '8000.0 logical px/s'),
              _kvRow('minFlingDistance', '18.0 logical px'),
              _kvRow('dragStartDistanceMotionThreshold', '3.5 logical px'),
              _kvRow('carriedMomentum(v)', 'sqrt(v.abs()/5000)*v.sign*v'),
              _kvRow('toleranceFor(metrics)',
                  'Tolerance(velocity:1/devicePixelRatio*0.1)'),
              _kvRow('applyPhysicsToUserOffset(p,o)',
                  'returns offset (overscroll resists)'),
              _kvRow('applyBoundaryConditions(p,v)',
                  'returns clipped distance over boundary'),
              _kvRow('shouldAcceptUserOffset(p)',
                  'true unless never/scroll-locked'),
              _kvRow('createBallisticSimulation(p,v)',
                  'FrictionSimulation or null'),
              _kvRow('decelerationRate', 'ScrollDecelerationRate.normal'),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _cardTitle('Live instance probes', subtitle: 'Read at build() time.'),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('bouncing.minFlingVelocity',
                  bouncing.minFlingVelocity.toStringAsFixed(1)),
              _kvRow('bouncing.maxFlingVelocity',
                  bouncing.maxFlingVelocity.toStringAsFixed(1)),
              _kvRow('clamping.minFlingDistance',
                  clamping.minFlingDistance.toStringAsFixed(2)),
              _kvRow('paging.runtimeType', paging.runtimeType.toString()),
              _kvRow('never.runtimeType', never.runtimeType.toString()),
              _kvRow('never.allowImplicitScrolling',
                  never.allowImplicitScrolling.toString()),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - SIX PHYSICS VARIANTS
// ---------------------------------------------------------------------------
Widget _miniListPreview({
  required Color colour,
  required List<String> rows,
  required Color glow,
}) {
  return Container(
    height: 120.0,
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: glow.withOpacity(0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: <Widget>[
        for (int i = 0; i < rows.length; i++)
          Container(
            height: 28.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: i.isEven ? Colors.white : const Color(0xFFF1F4F8),
              border: Border(
                left: BorderSide(color: colour, width: 3.0),
              ),
            ),
            child: Text(
              rows[i],
              style: const TextStyle(
                fontSize: 11.5,
                fontFamily: 'monospace',
                color: _kInk,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _variantCard({
  required String name,
  required String description,
  required Color colour,
  required List<String> rows,
  required List<String> tags,
}) {
  return _card(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 32.0,
                    height: 32.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colour.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: colour.withOpacity(0.3)),
                    ),
                    child: Text(
                      name.substring(0, 1),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: colour,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(description, style: _kBodySoftStyle),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: <Widget>[
                  for (final String t in tags) _pill(t, colour: colour),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          flex: 4,
          child: _miniListPreview(colour: colour, rows: rows, glow: colour),
        ),
      ],
    ),
  );
}

Widget _variantsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _variantCard(
        name: 'BouncingScrollPhysics',
        description:
            'iOS-style overscroll. The list rubber-bands past its edge and '
            'settles back via a SpringSimulation. Used by Cupertino widgets '
            'and by Material on iOS by default.',
        colour: _kAccentRose,
        rows: const <String>['Photo 01', 'Photo 02', 'Photo 03', 'Photo 04'],
        tags: const <String>['overscroll', 'spring', 'cupertino'],
      ),
      _variantCard(
        name: 'ClampingScrollPhysics',
        description:
            'Android-style edge behaviour. Motion is clamped at the boundary; '
            'the platform glow effect (StretchingOverscrollIndicator on A12+) '
            'is layered separately.',
        colour: _kCurveNormal,
        rows: const <String>['Item A', 'Item B', 'Item C', 'Item D'],
        tags: const <String>['clamp', 'material', 'no-spring'],
      ),
      _variantCard(
        name: 'AlwaysScrollableScrollPhysics',
        description:
            'Forces shouldAcceptUserOffset to return true even when content '
            'fits the viewport. Pair with a pull-to-refresh on short lists.',
        colour: _kAccentGreen,
        rows: const <String>['Tile 1', 'Tile 2'],
        tags: const <String>['always-on', 'refresh-friendly'],
      ),
      _variantCard(
        name: 'NeverScrollableScrollPhysics',
        description:
            'Disables scrolling entirely. Pointer events are still hit-tested '
            'but createBallisticSimulation returns null. Useful for nested '
            'Scrollables driven by an outer controller.',
        colour: _kAccentAmber,
        rows: const <String>['Locked', 'Locked', 'Locked'],
        tags: const <String>['locked', 'no-fling', 'controller-driven'],
      ),
      _variantCard(
        name: 'PageScrollPhysics',
        description:
            'Snaps scroll offset to integer page boundaries when the fling '
            'settles. Pairs with PageView; ballistic simulation is replaced '
            'by a ScrollSpringSimulation aimed at the nearest page.',
        colour: _kAccentViolet,
        rows: const <String>['Page 1', 'Page 2', 'Page 3'],
        tags: const <String>['snap', 'pageview', 'spring-aimed'],
      ),
      _variantCard(
        name: 'RangeMaintainingScrollPhysics',
        description:
            'Tries to keep the visible range constant even if the underlying '
            'content extent changes (rows added or removed). Composed under '
            'top-level physics for stable position.',
        colour: _kAccentOrange,
        rows: const <String>['Row #04', 'Row #05', 'Row #06', 'Row #07'],
        tags: const <String>['stable', 'composable', 'compositional'],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - WORKED EXAMPLE (NUMERIC WALK-THROUGH)
// ---------------------------------------------------------------------------
class _DecayRow {
  const _DecayRow(this.t, this.vNormal, this.vFast, this.dNormal, this.dFast);
  final double t;
  final double vNormal;
  final double vFast;
  final double dNormal;
  final double dFast;
}

List<_DecayRow> _buildDecayTable() {
  // Toy model: v(t) = v0 * exp(-k*t); d(t) = (v0/k)*(1-exp(-k*t)).
  const double v0 = 2400.0; // logical px/s
  const double kNormal = 0.9;
  const double kFast = 2.2;
  final List<_DecayRow> out = <_DecayRow>[];
  for (final double t in const <double>[
    0.0,
    0.25,
    0.5,
    0.75,
    1.0,
    1.5,
    2.0,
    3.0,
    4.0,
  ]) {
    final double vN = v0 * math.exp(-kNormal * t);
    final double vF = v0 * math.exp(-kFast * t);
    final double dN = (v0 / kNormal) * (1.0 - math.exp(-kNormal * t));
    final double dF = (v0 / kFast) * (1.0 - math.exp(-kFast * t));
    out.add(_DecayRow(t, vN, vF, dN, dF));
  }
  return out;
}

Widget _decayTableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: const BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
    ),
    child: Row(
      children: const <Widget>[
        SizedBox(
          width: 60.0,
          child: Text(
            't (s)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'v_normal',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'v_fast',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'd_normal',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'd_fast',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _decayTableRow(_DecayRow r, bool stripe) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
    color: stripe ? _kCardSoft : _kCardBg,
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 60.0,
          child: Text(
            r.t.toStringAsFixed(2),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kInk,
            ),
          ),
        ),
        Expanded(
          child: Text(
            r.vNormal.toStringAsFixed(1),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kCurveNormal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            r.vFast.toStringAsFixed(1),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kCurveFast,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            r.dNormal.toStringAsFixed(0),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kInk,
            ),
          ),
        ),
        Expanded(
          child: Text(
            r.dFast.toStringAsFixed(0),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _workedExampleSection() {
  final List<_DecayRow> rows = _buildDecayTable();
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Worked example: v0 = 2400 px/s',
          subtitle:
              'Two columns of velocity (px/s) and cumulative distance (px) '
              'for each deceleration rate, sampled at nine timestamps.',
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kHairline),
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              _decayTableHeader(),
              for (int i = 0; i < rows.length; i++)
                _decayTableRow(rows[i], i.isOdd),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'Read it like this: at t=1.0s the normal rate retains ~976 px/s '
            'while the fast rate has already dropped to ~266 px/s. The '
            'distance numbers are the integrals - this is how far the list '
            'will scroll before settling. Normal travels ~2667 px asymptotic '
            'limit; fast caps near ~1091 px. That is why iOS lists "feel '
            'tight" and Material lists "feel coastable".',
            style: TextStyle(fontSize: 13.0, height: 1.5, color: _kInk),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - CODE RECIPES
// ---------------------------------------------------------------------------
Widget _recipesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(
        title: 'choose physics by platform',
        '// Pick deceleration rate based on platform target.\n'
            'ScrollPhysics pickPhysics(BuildContext context) {\n'
            '  switch (Theme.of(context).platform) {\n'
            '    case TargetPlatform.iOS:\n'
            '    case TargetPlatform.macOS:\n'
            '      return const BouncingScrollPhysics(\n'
            '        decelerationRate: ScrollDecelerationRate.fast,\n'
            '      );\n'
            '    default:\n'
            '      return const ClampingScrollPhysics();\n'
            '  }\n'
            '}',
      ),
      _codeBlock(
        title: 'compose with .applyTo(parent)',
        '// The Decorator pattern lets you stack physics. AlwaysScrollable\n'
            '// forces overscroll; the parent provides the deceleration shape.\n'
            'final ScrollPhysics composed = const AlwaysScrollableScrollPhysics()\n'
            '    .applyTo(const BouncingScrollPhysics());\n'
            '\n'
            '// Equivalent constructor form:\n'
            'final ScrollPhysics composedB = const AlwaysScrollableScrollPhysics(\n'
            '  parent: BouncingScrollPhysics(),\n'
            ');',
      ),
      _codeBlock(
        title: 'custom physics subclass',
        '// Cap fling velocity to slow the glide to a crawl.\n'
            'class SlowFlingPhysics extends BouncingScrollPhysics {\n'
            '  const SlowFlingPhysics({super.parent});\n'
            '\n'
            '  @override\n'
            '  SlowFlingPhysics applyTo(ScrollPhysics? ancestor) =>\n'
            '      SlowFlingPhysics(parent: buildParent(ancestor));\n'
            '\n'
            '  @override\n'
            '  double get maxFlingVelocity => 1500.0; // default 8000.0\n'
            '\n'
            '  @override\n'
            '  double get minFlingDistance => 24.0;   // deliberate flings\n'
            '}',
      ),
      _codeBlock(
        title: 'snap to page index',
        '// PageScrollPhysics replaces the ballistic glide with a spring\n'
            '// aimed at the nearest page boundary. The viewport drives the\n'
            '// "page" definition (PageController.viewportFraction).\n'
            'final PageController controller = PageController(viewportFraction: 0.86);\n'
            'final Widget pager = PageView.builder(\n'
            '  controller: controller,\n'
            '  physics: const PageScrollPhysics(\n'
            '    parent: BouncingScrollPhysics(),\n'
            '  ),\n'
            '  itemCount: pages.length,\n'
            '  itemBuilder: (BuildContext c, int i) => pages[i],\n'
            ');',
      ),
      _codeBlock(
        title: 'disable inner scrollable',
        '// In a NestedScrollView the inner Scrollable should not scroll\n'
            '// independently; only the outer body handles the gesture.\n'
            'return NestedScrollView(\n'
            '  headerSliverBuilder: (BuildContext c, bool inner) => <Widget>[],\n'
            '  body: ListView(\n'
            '    physics: const NeverScrollableScrollPhysics(),\n'
            '    children: rows,\n'
            '  ),\n'
            ');',
      ),
      _codeBlock(
        title: 'pull-to-refresh on short lists',
        '// Without AlwaysScrollable, short lists wont accept the overscroll\n'
            '// gesture that RefreshIndicator needs.\n'
            'return RefreshIndicator(\n'
            '  onRefresh: refresh,\n'
            '  child: ListView.builder(\n'
            '    physics: const AlwaysScrollableScrollPhysics(\n'
            '      parent: BouncingScrollPhysics(),\n'
            '    ),\n'
            '    itemCount: items.length,\n'
            '    itemBuilder: (BuildContext c, int i) => buildRow(items[i]),\n'
            '  ),\n'
            ');',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - COMPARISON MATRIX
// ---------------------------------------------------------------------------
class _MatrixCell {
  const _MatrixCell(this.glyph, this.colour);
  final String glyph;
  final Color colour;
}

Widget _matrixGlyph(_MatrixCell cell) {
  return Container(
    width: 26.0,
    height: 22.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: cell.colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: cell.colour.withOpacity(0.3)),
    ),
    child: Text(
      cell.glyph,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        color: cell.colour,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _comparisonSection() {
  const _MatrixCell yes = _MatrixCell('Y', _kAccentGreen);
  const _MatrixCell no = _MatrixCell('-', _kInkTertiary);
  const _MatrixCell partial = _MatrixCell('~', _kAccentAmber);

  final List<String> headers = <String>[
    'Overscroll',
    'Bounce',
    'Clamp edge',
    'Snap to grid',
    'Decel rate',
    'Chainable',
  ];

  final List<List<_MatrixCell>> data = <List<_MatrixCell>>[
    <_MatrixCell>[yes, yes, no, no, yes, yes],
    <_MatrixCell>[no, no, yes, no, yes, yes],
    <_MatrixCell>[yes, partial, partial, no, partial, yes],
    <_MatrixCell>[no, no, no, no, no, yes],
    <_MatrixCell>[partial, partial, no, yes, partial, yes],
    <_MatrixCell>[partial, partial, partial, no, partial, yes],
  ];

  final List<String> rowNames = <String>[
    'BouncingScrollPhysics',
    'ClampingScrollPhysics',
    'AlwaysScrollable',
    'NeverScrollable',
    'PageScrollPhysics',
    'RangeMaintaining',
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Comparison matrix',
          subtitle:
              'Y = supports out of the box. ~ = supports when chained. '
              '- = does not contribute that behaviour.',
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kHairline),
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              Container(
                color: _kCardDark,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 9.0,
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 180.0,
                      child: Text(
                        'Physics',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: _kInkOnDark,
                        ),
                      ),
                    ),
                    for (final String h in headers)
                      Expanded(
                        child: Text(
                          h,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            fontWeight: FontWeight.w700,
                            color: _kInkOnDark,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              for (int i = 0; i < rowNames.length; i++)
                Container(
                  color: i.isOdd ? _kCardSoft : _kCardBg,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 180.0,
                        child: Text(
                          rowNames[i],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: _kInk,
                          ),
                        ),
                      ),
                      for (int c = 0; c < headers.length; c++)
                        Expanded(
                          child: Center(child: _matrixGlyph(data[i][c])),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 6.0,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _matrixGlyph(yes),
                const SizedBox(width: 6.0),
                const Text('supports', style: _kCaptionStyle),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _matrixGlyph(partial),
                const SizedBox(width: 6.0),
                const Text('partial / chained', style: _kCaptionStyle),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _matrixGlyph(no),
                const SizedBox(width: 6.0),
                const Text('does not contribute', style: _kCaptionStyle),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - PITFALLS CALLOUTS
// ---------------------------------------------------------------------------
Widget _pitfallTile({
  required String title,
  required String body,
  required Color colour,
  required String tag,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: colour,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(body, style: _kBodyStyle),
      ],
    ),
  );
}

Widget _pitfallsSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Common pitfalls',
            subtitle: 'Six callouts to keep in mind.'),
        const SizedBox(height: 10.0),
        _pitfallTile(
          tag: '01',
          title: 'Forgetting .applyTo when wrapping',
          body:
              'AlwaysScrollableScrollPhysics() alone uses the default parent. '
              'On iOS that means clamping, not bouncing. Compose explicitly: '
              'AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()).',
          colour: _kAccentRose,
        ),
        _pitfallTile(
          tag: '02',
          title: 'Mixing decelerationRate on chained physics',
          body:
              'Each link in the .applyTo chain may override decelerationRate. '
              'The outermost wins, but only for the simulation - inner '
              'physics still control overscroll. Test on both fast and normal.',
          colour: _kAccentAmber,
        ),
        _pitfallTile(
          tag: '03',
          title: 'NeverScrollableScrollPhysics blocks RefreshIndicator',
          body:
              'createBallisticSimulation returns null, so the refresh '
              'indicator never receives an overscroll fling. Use '
              'AlwaysScrollable + a controller-driven outer scrollable instead.',
          colour: _kAccentOrange,
        ),
        _pitfallTile(
          tag: '04',
          title: 'Custom physics that forgets applyTo override',
          body:
              'Subclasses must override applyTo so the wrapping mechanism '
              'reconstructs the right runtime type. Forgetting this causes '
              'composition to silently fall back to the parent type.',
          colour: _kCurveNormal,
        ),
        _pitfallTile(
          tag: '05',
          title: 'Page-snap with the wrong viewportFraction',
          body:
              'PageScrollPhysics uses the viewport extent as page size. If '
              'PageController.viewportFraction != 1.0, expect the snap to '
              'land at fractional offsets. Compose with carriedMomentum '
              'tweaks for tight peek-pages.',
          colour: _kAccentViolet,
        ),
        _pitfallTile(
          tag: '06',
          title: 'Web wheel events bypass kinetic decay',
          body:
              'On the web pointer-wheel events deliver discrete deltas; the '
              'ballistic simulation runs only on fling gestures. Touch '
              'devices behave as expected, but desktop browsers do not '
              'animate to a stop - they jump per wheel tick.',
          colour: _kAccentBlue,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 - CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
Widget _chipGroup(String label, List<String> chips, Color colour) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            color: _kInkOnDarkSecondary,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (final String c in chips)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: colour.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(color: colour.withOpacity(0.4)),
                ),
                child: Text(
                  c,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: colour,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 6.0, 18.0, 22.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairlineDark),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ScrollPhysics cheat-sheet',
          style: TextStyle(
            fontSize: 16.0,
            color: _kInkOnDark,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Quick reference for the field of ScrollPhysics methods, getters, '
          'and the related Simulation/Tolerance helpers from physics.dart.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        _chipGroup(
          'CONFIG GETTERS',
          const <String>[
            'minFlingVelocity',
            'maxFlingVelocity',
            'minFlingDistance',
            'dragStartDistanceMotionThreshold',
            'decelerationRate',
            'allowImplicitScrolling',
          ],
          const Color(0xFFA7F3D0),
        ),
        _chipGroup(
          'PHYSICS HOOKS',
          const <String>[
            'applyPhysicsToUserOffset',
            'applyBoundaryConditions',
            'shouldAcceptUserOffset',
            'createBallisticSimulation',
            'toleranceFor',
            'carriedMomentum',
          ],
          const Color(0xFF93C5FD),
        ),
        _chipGroup(
          'COMPOSITION',
          const <String>['applyTo', 'parent', 'buildParent'],
          const Color(0xFFFBCFE8),
        ),
        _chipGroup(
          'SIMULATIONS (physics.dart)',
          const <String>[
            'FrictionSimulation',
            'BouncingScrollSimulation',
            'ClampingScrollSimulation',
            'ScrollSpringSimulation',
            'Tolerance',
          ],
          const Color(0xFFFDE68A),
        ),
        _chipGroup(
          'ENUMS',
          const <String>[
            'ScrollDecelerationRate.normal',
            'ScrollDecelerationRate.fast',
            'ScrollPositionAlignmentPolicy.explicit',
          ],
          const Color(0xFFC4B5FD),
        ),
        const SizedBox(height: 6.0),
        const Text(
          '"Velocity decays. Geometry constrains. Composition wins."',
          style: TextStyle(
            color: Color(0xFFD1FAF1),
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('ScrollPhysics deep visual demo: building widget tree');

  // Inert physics instances - construct so static getters can be probed
  // for the anatomy table. We never attach them to a live Scrollable, so
  // createBallisticSimulation is never called against a real metrics.
  const BouncingScrollPhysics bouncing = BouncingScrollPhysics();
  const ClampingScrollPhysics clamping = ClampingScrollPhysics();
  const AlwaysScrollableScrollPhysics always = AlwaysScrollableScrollPhysics();
  const NeverScrollableScrollPhysics never = NeverScrollableScrollPhysics();
  const PageScrollPhysics paging = PageScrollPhysics();
  const RangeMaintainingScrollPhysics ranging = RangeMaintainingScrollPhysics();

  print('bouncing.minFlingVelocity=${bouncing.minFlingVelocity}');
  print('clamping.minFlingDistance=${clamping.minFlingDistance}');
  print('always.runtimeType=${always.runtimeType}');
  print('never.allowImplicitScrolling=${never.allowImplicitScrolling}');
  print('paging.runtimeType=${paging.runtimeType}');
  print('ranging.runtimeType=${ranging.runtimeType}');
  print('kDebugMode=$kDebugMode');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroBanner(),
          _sectionHeader(
            1,
            'Why ScrollPhysics exists',
            'A factory for Simulations that turn fling velocity into motion.',
          ),
          _heroIntroCard(),
          _sectionDivider(),
          _sectionHeader(
            2,
            'Class hierarchy',
            'ScrollPhysics and the six concrete subclasses you will use.',
          ),
          _hierarchySection(),
          _sectionDivider(),
          _sectionHeader(
            3,
            'Velocity decay over time',
            'ScrollDecelerationRate.normal vs .fast plotted to scale.',
          ),
          _decaySection(),
          _sectionDivider(),
          _sectionHeader(
            4,
            'ScrollPhysics anatomy',
            'Configuration fields, hook methods, and live probes.',
          ),
          _anatomySection(),
          _sectionDivider(),
          _sectionHeader(
            5,
            'Six physics variants',
            'One card per concrete physics type with a faux scroll preview.',
          ),
          _variantsSection(),
          _sectionDivider(),
          _sectionHeader(
            6,
            'Worked example',
            'Numeric walk-through of v(t) and d(t) for both decel rates.',
          ),
          _workedExampleSection(),
          _sectionDivider(),
          _sectionHeader(
            7,
            'Code recipes',
            'Six idiomatic snippets for composing and customising physics.',
          ),
          _recipesSection(),
          _sectionDivider(),
          _sectionHeader(
            8,
            'Comparison matrix',
            'Six physics types scored across six behavioural axes.',
          ),
          _comparisonSection(),
          _sectionDivider(),
          _sectionHeader(
            9,
            'Pitfalls',
            'Six callouts that commonly bite engineers working on scroll.',
          ),
          _pitfallsSection(),
          _sectionDivider(),
          _sectionHeader(
            10,
            'Cheat-sheet',
            'A compact map of the ScrollPhysics surface area.',
          ),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
