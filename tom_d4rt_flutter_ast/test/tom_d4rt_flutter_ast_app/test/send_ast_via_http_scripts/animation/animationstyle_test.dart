// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_import, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of Flutter's AnimationStyle, Curves,
// Curve subclasses and Duration helpers.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)` -
// which is invoked a single time, and which returns a Widget tree.
//
// The rendered output is a static gallery that walks through the building
// blocks that Flutter uses for declarative animation parameters:
//
//   * AnimationStyle   - the immutable "config bag" used by many Material
//                        widgets (DefaultTabController, AnimatedSwitcher,
//                        ExpansionTile, etc.) to express how to animate
//                        without requiring a full AnimationController.
//   * Curves           - the static namespace of pre-built Curve instances
//                        (Curves.linear, Curves.easeInOut, Curves.bounceIn).
//   * Curve / Cubic    - the base class and most common implementation; this
//                        demo plots 24 curves on a small CustomPainter grid.
//   * SawTooth, Interval, Threshold, FlippedCurve, ElasticInCurve - special
//                        curve constructors used in custom-tween scenarios.
//   * Duration         - the immutable amount of time alongside arithmetic
//                        and inMilliseconds / compareTo helpers.
//
// Each section is followed by literal code blocks, comparison tables and a
// pitfalls panel.  The script runs in a static, no-interaction environment;
// there is no `setState`, no `Timer`, no `Future`, no `AnimationController`
// anywhere in this file - we render motion *configuration*, not motion
// itself.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// AnimationStyle is part of the Material library, so the demo leans on
// Material's M3 palette rather than the iOS one. Colours are written as
// literal ARGB values so they survive even without a live MaterialTheme.
const Color _kCanvas = Color(0xFFF5F4F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1F1B2C);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1A1B2E);
const Color _kInkSecondary = Color(0xFF42425A);
const Color _kInkTertiary = Color(0xFF7A7A92);
const Color _kInkOnDark = Color(0xFFEFEDF7);
const Color _kInkOnDarkSecondary = Color(0xFFAEA9C8);
const Color _kAccent = Color(0xFF6750A4); // M3 primary
const Color _kAccentSecondary = Color(0xFF625B71);
const Color _kAccentTertiary = Color(0xFF7D5260);
const Color _kAccentTeal = Color(0xFF006A6A);
const Color _kAccentOrange = Color(0xFFE0541E);
const Color _kAccentGreen = Color(0xFF386A20);
const Color _kAccentBlue = Color(0xFF1B5A8E);
const Color _kAccentRed = Color(0xFFB3261E);
const Color _kCurveLine = Color(0xFF6750A4);
const Color _kCurveGuide = Color(0x336750A4);
const Color _kCurveAxis = Color(0xFFBDB7CC);
const Color _kCurveFill = Color(0x1A6750A4);
const Color _kCodeBg = Color(0xFF1E1B2A);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFFB39DDB);
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
  fontSize: 13.5,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.0,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoBody = TextStyle(
  fontSize: 12.0,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.4,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPER WIDGETS
// ---------------------------------------------------------------------------
// All helpers below are top-level `_camelCase` functions. They render small,
// reusable chunks of UI: section headers, cards, code blocks, tables, tiles
// and so on. They are kept as plain functions (not StatelessWidget classes)
// to keep the file approachable to anyone reading top-to-bottom.
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
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
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
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

Widget _cardTitle(String title, {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary}) {
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
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
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
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color keyColour = _kInkSecondary, Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: keyColour,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: valueColour,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, {bool header = false, List<int>? flexes}) {
  final List<int> f = flexes ?? List<int>.filled(cells.length, 1);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: header ? const Color(0xFFF1EEF7) : const Color(0xFFFFFFFF),
      border: const Border(
        bottom: BorderSide(color: _kHairline),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: f[i],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                cells[i],
                style: TextStyle(
                  fontSize: header ? 11.5 : 12.0,
                  fontWeight: header ? FontWeight.w700 : FontWeight.w400,
                  color: header ? _kAccent : _kInk,
                  height: 1.35,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _bullet(String text, {IconData icon = Icons.check_circle, Color colour = _kAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 16.0, color: colour),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12.5, color: _kInk, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallRow(String headline, String body, {IconData icon = Icons.warning_amber_rounded, Color colour = _kAccentOrange}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: colour, size: 18.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headline,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: colour,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.0,
                  height: 1.4,
                  color: _kInk,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CURVE GRAPH PAINTER
// ---------------------------------------------------------------------------
// `_CurveGraphPainter` plots a Curve onto a small box. The painter is
// purely visual - it samples the curve at `samples` evenly-spaced t values
// in [0, 1] and connects them with line segments. A faint diagonal guide
// and a filled area under the curve make the shape easy to read at a glance.
class _CurveGraphPainter extends CustomPainter {
  const _CurveGraphPainter({
    required this.curve,
    this.samples = 64,
    this.lineColour = _kCurveLine,
    this.guideColour = _kCurveGuide,
    this.axisColour = _kCurveAxis,
    this.fillColour = _kCurveFill,
  });

  final Curve curve;
  final int samples;
  final Color lineColour;
  final Color guideColour;
  final Color axisColour;
  final Color fillColour;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint axisPaint = Paint()
      ..color = axisColour
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Paint guidePaint = Paint()
      ..color = guideColour
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Paint linePaint = Paint()
      ..color = lineColour
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Paint fillPaint = Paint()
      ..color = fillColour
      ..style = PaintingStyle.fill;

    // Frame.
    final Rect frame = Rect.fromLTWH(0.0, 0.0, w, h);
    canvas.drawRect(frame, axisPaint);

    // Diagonal "linear" guide from (0, h) to (w, 0).
    canvas.drawLine(Offset(0.0, h), Offset(w, 0.0), guidePaint);

    // Mid-line cross-hairs.
    canvas.drawLine(Offset(w / 2, 0.0), Offset(w / 2, h), guidePaint);
    canvas.drawLine(Offset(0.0, h / 2), Offset(w, h / 2), guidePaint);

    // Sample the curve - we let it overshoot beyond [0,1] for elastic /
    // bounce curves but clamp visually with a generous padding ratio.
    final double padTop = h * 0.08;
    final double padBot = h * 0.08;
    final double drawH = h - padTop - padBot;
    final Path linePath = Path();
    final Path fillPath = Path()..moveTo(0.0, h - padBot);
    for (int i = 0; i <= samples; i++) {
      final double t = i / samples;
      final double v = curve.transform(t).clamp(-0.2, 1.2);
      final double x = t * w;
      final double y = padTop + (1.0 - v) * drawH;
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }
      fillPath.lineTo(x, y);
    }
    fillPath.lineTo(w, h - padBot);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _CurveGraphPainter old) =>
      old.curve != curve ||
      old.samples != samples ||
      old.lineColour != lineColour ||
      old.guideColour != guideColour ||
      old.axisColour != axisColour ||
      old.fillColour != fillColour;
}

Widget _curveTile(String name, Curve curve, {double height = 84.0}) {
  return Container(
    margin: const EdgeInsets.all(4.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: _kInkSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          height: height,
          child: CustomPaint(
            painter: _CurveGraphPainter(curve: curve),
            size: Size.infinite,
          ),
        ),
      ],
    ),
  );
}

Widget _curveTileWithSource(String name, Curve curve, String source, {Color accent = _kAccent}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          width: 130.0,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
              SizedBox(
                height: 80.0,
                child: CustomPaint(
                  painter: _CurveGraphPainter(curve: curve, lineColour: accent, fillColour: accent.withOpacity(0.12)),
                  size: Size.infinite,
                ),
              ),
            ],
          ),
        ),
        Container(width: 1.0, color: _kHairline),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: _kCodeBg,
            child: Text(source, style: _kCodeStyle),
          ),
        ),
      ],
    ),
  );
}

Widget _barBar(double value, {Color colour = _kAccent}) {
  final double v = value.clamp(-0.2, 1.2);
  return Container(
    width: 18.0,
    margin: const EdgeInsets.symmetric(horizontal: 2.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: (v * 100.0).clamp(0.0, 100.0),
                decoration: BoxDecoration(
                  color: colour,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(3.0)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          v.toStringAsFixed(2),
          style: const TextStyle(
            fontSize: 8.5,
            color: _kInkTertiary,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _barChart(String label, Curve curve, List<double> ts, {Color colour = _kAccent}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      border: Border.all(color: _kHairline),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: _kInk,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              for (final double t in ts) _barBar(curve.transform(t), colour: colour),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (final double t in ts)
                Container(
                  width: 22.0,
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  alignment: Alignment.center,
                  child: Text(
                    t.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 9.0,
                      color: _kInkTertiary,
                      fontFamily: 'monospace',
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

Widget _styleSummaryRow(String label, AnimationStyle? style) {
  String fmt(Duration? d) {
    if (d == null) return '<null>';
    return '${d.inMilliseconds} ms';
  }
  String fmtCurve(Curve? c) => c == null ? '<null>' : c.toString();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F6FC),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: _kAccent)),
        const SizedBox(height: 4.0),
        _kvRow('duration:',        fmt(style?.duration)),
        _kvRow('reverseDuration:', fmt(style?.reverseDuration)),
        _kvRow('curve:',           fmtCurve(style?.curve)),
        _kvRow('reverseCurve:',    fmtCurve(style?.reverseCurve)),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All state must live in
// local variables. The function returns a Widget tree wrapped in a
// MaterialApp.
// ===========================================================================
dynamic build(BuildContext context) {
  print('AnimationStyle deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int warm = rng.nextInt(100);
  print('  rng warm-up: $warm');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains what AnimationStyle is and why it differs from
  // the Curves library.  AnimationStyle is a *configuration bag* - it has
  // four nullable fields (duration, reverseDuration, curve, reverseCurve)
  // and no `animate()` method of its own. Material widgets read those
  // fields and apply them to the AnimationController they already own.
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF6750A4),
          Color(0xFF7D5260),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x336750A4),
          offset: Offset(0.0, 4.0),
          blurRadius: 14.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.animation, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'AnimationStyle & Curves',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Declarative motion configuration for Material widgets',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'AnimationStyle is a tiny immutable value object: four nullable fields '
          '- duration, reverseDuration, curve, reverseCurve. It is consumed by Material '
          'widgets such as DefaultTabController, AnimatedSwitcher, ExpansionTile, '
          'NavigationDrawer and MaterialApp.theme.animationStyle. The widget owns the '
          'AnimationController; AnimationStyle just describes the parameters to feed it.',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.5,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Curves is something different - a namespace of static, pre-built Curve '
          'instances (Curves.linear, Curves.easeInOut, Curves.bounceIn, etc.). Curves '
          'plug into AnimationStyle.curve, into CurvedAnimation, into Tween.chain() and '
          'into anywhere a Curve is expected.',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.5,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: const <Widget>[
            _IntroPill(label: 'Immutable'),
            _IntroPill(label: 'Nullable fields'),
            _IntroPill(label: 'Material-only'),
            _IntroPill(label: 'No setState'),
            _IntroPill(label: 'No controllers'),
            _IntroPill(label: 'Declarative'),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - ANIMATIONSTYLE CONSTRUCTOR SHOWCASE
  // -------------------------------------------------------------------------
  // Six literal AnimationStyle configurations covering the four-field
  // surface. Each card pairs the constructor expression with a key/value
  // table summarising the resulting properties, plus a "use-site" hint
  // explaining the Material widget it would feed.
  // -------------------------------------------------------------------------
  final AnimationStyle styleA = const AnimationStyle(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
  );
  final AnimationStyle styleB = const AnimationStyle(
    curve: Curves.easeIn,
    reverseCurve: Curves.easeOut,
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 250),
  );
  final AnimationStyle styleC = const AnimationStyle(
    curve: Curves.bounceOut,
    duration: Duration(milliseconds: 700),
  );
  final AnimationStyle styleD = const AnimationStyle(
    curve: Curves.linear,
    duration: Duration(milliseconds: 100),
  );
  final AnimationStyle styleE = const AnimationStyle(
    curve: Curves.fastOutSlowIn,
    duration: Duration(seconds: 2),
  );
  final AnimationStyle styleF = const AnimationStyle(
    duration: Duration(milliseconds: 400),
  );

  Widget styleCard(String tag, String constructor, String useHint, AnimationStyle s, IconData icon, Color tint) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18.0, color: tint),
              const SizedBox(width: 6.0),
              _cardTitle(tag, subtitle: useHint),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(constructor, style: _kCodeStyle),
          ),
          const SizedBox(height: 8.0),
          _styleSummaryRow(tag, s),
        ],
      ),
    );
  }

  final Widget constructorShowcase = Column(
    children: <Widget>[
      styleCard(
        'styleA — 300ms easeInOut',
        "const AnimationStyle(\n  curve: Curves.easeInOut,\n  duration: Duration(milliseconds: 300),\n)",
        'Classic AnimatedSwitcher swap; default Material expansion tile feel.',
        styleA,
        Icons.swap_horiz,
        _kAccent,
      ),
      styleCard(
        'styleB — 500ms forward / 250ms reverse',
        "const AnimationStyle(\n  curve: Curves.easeIn,\n  reverseCurve: Curves.easeOut,\n  duration: Duration(milliseconds: 500),\n  reverseDuration: Duration(milliseconds: 250),\n)",
        'DefaultTabController with asymmetric timing - slow in, fast out.',
        styleB,
        Icons.tab,
        _kAccentSecondary,
      ),
      styleCard(
        'styleC — bounceOut 700ms',
        "const AnimationStyle(\n  curve: Curves.bounceOut,\n  duration: Duration(milliseconds: 700),\n)",
        'SnackBar entrance feel; playful in-app celebration.',
        styleC,
        Icons.sports_basketball,
        _kAccentTertiary,
      ),
      styleCard(
        'styleD — 100ms linear',
        "const AnimationStyle(\n  curve: Curves.linear,\n  duration: Duration(milliseconds: 100),\n)",
        'Hover overlay fade-in inside a NavigationRail.',
        styleD,
        Icons.timer_outlined,
        _kAccentBlue,
      ),
      styleCard(
        'styleE — 2s fastOutSlowIn',
        "const AnimationStyle(\n  curve: Curves.fastOutSlowIn,\n  duration: Duration(seconds: 2),\n)",
        'NavigationDrawer slide; AnimatedTheme.theme().',
        styleE,
        Icons.menu_open,
        _kAccentTeal,
      ),
      styleCard(
        'styleF — duration only (curve == null)',
        "const AnimationStyle(\n  duration: Duration(milliseconds: 400),\n)",
        'Lets the consumer widget supply its own default curve.',
        styleF,
        Icons.tune,
        _kAccentOrange,
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - NOANIMATION + LERP
  // -------------------------------------------------------------------------
  // `AnimationStyle.noAnimation` is a singleton that disables animation
  // entirely (zero duration). `AnimationStyle.lerp(a, b, t)` blends two
  // styles linearly. The card below shows both.
  // -------------------------------------------------------------------------
  final AnimationStyle noAnim = AnimationStyle.noAnimation;
  final AnimationStyle? lerpHalf = AnimationStyle.lerp(styleA, styleC, 0.5);
  final AnimationStyle? lerpStart = AnimationStyle.lerp(styleA, styleC, 0.0);
  final AnimationStyle? lerpEnd = AnimationStyle.lerp(styleA, styleC, 1.0);

  final Widget noAnimCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.flash_on, size: 18.0, color: _kAccentOrange),
            SizedBox(width: 6.0),
            Text(
              'AnimationStyle.noAnimation',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: _kInk),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Singleton equivalent to `AnimationStyle(duration: Duration.zero, '
          'reverseDuration: Duration.zero)`. Use it to opt a Material widget '
          'out of motion entirely - useful for tests, accessibility flags '
          '(MediaQuery.disableAnimations) and ultra-fast UI.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'const AnimationStyle noAnim = AnimationStyle.noAnimation;',
            style: _kCodeStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        _styleSummaryRow('noAnimation', noAnim),
      ],
    ),
  );

  final Widget lerpCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.timeline, size: 18.0, color: _kAccent),
            SizedBox(width: 6.0),
            Text(
              'AnimationStyle.lerp(a, b, t)',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: _kInk),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Linearly interpolates each numeric field of two styles. Curve '
          'fields are *not* blended - the result snaps to `b.curve` once '
          't crosses 0.5. The duration / reverseDuration values, however, '
          'lerp as expected.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            "AnimationStyle? a = styleA;        // 300ms easeInOut\n"
            "AnimationStyle? b = styleC;        // 700ms bounceOut\n"
            "AnimationStyle? half = AnimationStyle.lerp(a, b, 0.5);\n"
            "AnimationStyle? start = AnimationStyle.lerp(a, b, 0.0);\n"
            "AnimationStyle? end   = AnimationStyle.lerp(a, b, 1.0);",
            style: _kCodeStyle,
          ),
        ),
        const SizedBox(height: 10.0),
        _styleSummaryRow('lerp(a, b, 0.0)', lerpStart),
        _styleSummaryRow('lerp(a, b, 0.5)', lerpHalf),
        _styleSummaryRow('lerp(a, b, 1.0)', lerpEnd),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - CURVE GALLERY
  // -------------------------------------------------------------------------
  // 24 curves drawn on a 3-column grid. Each curve is plotted by
  // `_CurveGraphPainter` using 64 samples and a faint linear-guide
  // diagonal.
  // -------------------------------------------------------------------------
  final List<List<Object>> curveCatalog = <List<Object>>[
    <Object>['linear',          Curves.linear],
    <Object>['decelerate',      Curves.decelerate],
    <Object>['ease',            Curves.ease],
    <Object>['easeIn',          Curves.easeIn],
    <Object>['easeOut',         Curves.easeOut],
    <Object>['easeInOut',       Curves.easeInOut],
    <Object>['easeInQuad',      Curves.easeInQuad],
    <Object>['easeInCubic',     Curves.easeInCubic],
    <Object>['easeInQuart',     Curves.easeInQuart],
    <Object>['easeOutQuint',    Curves.easeOutQuint],
    <Object>['easeInExpo',      Curves.easeInExpo],
    <Object>['easeOutExpo',     Curves.easeOutExpo],
    <Object>['easeInOutQuart',  Curves.easeInOutQuart],
    <Object>['easeInOutCubic',  Curves.easeInOutCubic],
    <Object>['fastOutSlowIn',   Curves.fastOutSlowIn],
    <Object>['slowMiddle',      Curves.slowMiddle],
    <Object>['bounceIn',        Curves.bounceIn],
    <Object>['bounceOut',       Curves.bounceOut],
    <Object>['bounceInOut',     Curves.bounceInOut],
    <Object>['elasticIn',       Curves.elasticIn],
    <Object>['elasticOut',      Curves.elasticOut],
    <Object>['elasticInOut',    Curves.elasticInOut],
    <Object>['fastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn],
    <Object>['easeInToLinear',  Curves.easeInToLinear],
  ];

  Widget buildCurveGrid() {
    const int columns = 3;
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < curveCatalog.length; i += columns) {
      final List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < columns; j++) {
        final int idx = i + j;
        if (idx >= curveCatalog.length) {
          rowChildren.add(const Expanded(child: SizedBox.shrink()));
          continue;
        }
        final String name = curveCatalog[idx][0] as String;
        final Curve curve = curveCatalog[idx][1] as Curve;
        rowChildren.add(Expanded(child: _curveTile(name, curve)));
      }
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowChildren));
    }
    return Column(children: rows);
  }

  final Widget curveGalleryCard = _card(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Icon(Icons.show_chart, size: 20.0, color: _kAccent),
              const SizedBox(width: 6.0),
              _cardTitle(
                '24 Curves on a Grid',
                subtitle: 'Each tile plots curve.transform(t) for t in [0, 1].',
              ),
            ],
          ),
        ),
        buildCurveGrid(),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - CUSTOM CURVE CONSTRUCTORS
  // -------------------------------------------------------------------------
  // Six curve subclasses constructed inline. Each row pairs a graph with
  // the source-code constructor that produced it.
  // -------------------------------------------------------------------------
  final Curve customCubic = const Cubic(0.42, 0.0, 0.58, 1.0);
  final Curve customSawTooth = const SawTooth(3);
  final Curve customElastic = const ElasticInCurve(0.4);
  final Curve customFlipped = const FlippedCurve(Curves.easeIn);
  final Curve customInterval = const Interval(0.2, 0.8, curve: Curves.easeOut);
  final Curve customThreshold = const Threshold(0.5);

  final Widget customCurvesCard = _card(
    padding: const EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            children: <Widget>[
              const Icon(Icons.build, size: 20.0, color: _kAccentTeal),
              const SizedBox(width: 6.0),
              _cardTitle(
                'Custom curve constructors',
                subtitle: 'Cubic, SawTooth, ElasticInCurve, FlippedCurve, Interval, Threshold',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        _curveTileWithSource(
          'Cubic',
          customCubic,
          "const Cubic(0.42, 0.0, 0.58, 1.0)\n\n// Two-control-point Bezier in [0,1].\n// This particular Cubic is identical to\n// Curves.ease (a.k.a. CSS 'ease').",
        ),
        _curveTileWithSource(
          'SawTooth',
          customSawTooth,
          "const SawTooth(3)\n\n// Repeats t in [0,1] 'count' times then\n// jumps back to 0. Good for ticking\n// indicators or looped tweens.",
          accent: _kAccentSecondary,
        ),
        _curveTileWithSource(
          'ElasticInCurve',
          customElastic,
          "const ElasticInCurve(0.4)\n\n// An elastic in-curve where the\n// argument controls the period of the\n// elastic oscillation. Smaller =\n// snappier wobble.",
          accent: _kAccentTertiary,
        ),
        _curveTileWithSource(
          'FlippedCurve',
          customFlipped,
          "const FlippedCurve(Curves.easeIn)\n\n// Wraps another curve and inverts\n// its direction along t. Equivalent to\n// Curves.easeIn.flipped at compile-time.",
          accent: _kAccentOrange,
        ),
        _curveTileWithSource(
          'Interval',
          customInterval,
          "const Interval(0.2, 0.8, curve: Curves.easeOut)\n\n// Maps [begin..end] of t onto [0..1] of\n// the inner curve. Useful for staggering\n// multiple animations on one controller.",
          accent: _kAccentBlue,
        ),
        _curveTileWithSource(
          'Threshold',
          customThreshold,
          "const Threshold(0.5)\n\n// A step function: 0 below the threshold,\n// 1 at and above. Handy for binary\n// 'visible/invisible' transitions.",
          accent: _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - DURATION ARITHMETIC
  // -------------------------------------------------------------------------
  // Six sample cards demonstrating how Duration combines, scales and
  // compares. AnimationStyle stores Durations in both forward and reverse
  // slots, so understanding these operations is a prerequisite.
  // -------------------------------------------------------------------------
  const Duration durA = Duration(milliseconds: 300);
  const Duration durB = Duration(milliseconds: 250);
  const Duration durC = Duration(seconds: 1);
  const Duration durZero = Duration.zero;
  final Duration durSum = durA + durB;
  final Duration durDiff = durC - durA;
  final Duration durDouble = durA * 2;
  final Duration durHalf = durA ~/ 2;
  final int cmpAB = durA.compareTo(durB);
  final int cmpAC = durA.compareTo(durC);
  final int durAMs = durA.inMilliseconds;
  final int durCSec = durC.inSeconds;

  Widget durCard(String title, String code, String result, IconData icon, Color tint) {
    return _card(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: tint, size: 16.0),
              const SizedBox(width: 6.0),
              Text(title, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: _kInk)),
            ],
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(code, style: _kCodeStyle),
          ),
          const SizedBox(height: 4.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F8E9),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: _kHairline),
            ),
            child: Row(
              children: <Widget>[
                const Text('=>', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: _kAccentGreen, fontWeight: FontWeight.w700)),
                const SizedBox(width: 6.0),
                Expanded(child: Text(result, style: _kMonoBody)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget durationCards = Column(
    children: <Widget>[
      durCard(
        '1. Sum two durations',
        "const Duration a = Duration(milliseconds: 300);\n"
        "const Duration b = Duration(milliseconds: 250);\n"
        "final Duration sum = a + b;",
        'sum.inMilliseconds == ${durSum.inMilliseconds}  // ${durSum.toString()}',
        Icons.add_circle_outline,
        _kAccent,
      ),
      durCard(
        '2. Difference of two durations',
        "const Duration c = Duration(seconds: 1);\n"
        "final Duration diff = c - a;",
        'diff.inMilliseconds == ${durDiff.inMilliseconds}  // ${durDiff.toString()}',
        Icons.remove_circle_outline,
        _kAccentTertiary,
      ),
      durCard(
        '3. Scale a duration by an integer',
        "final Duration twice = a * 2;",
        'twice.inMilliseconds == ${durDouble.inMilliseconds}  // ${durDouble.toString()}',
        Icons.close,
        _kAccentSecondary,
      ),
      durCard(
        '4. Integer-divide a duration',
        "final Duration half = a ~/ 2;",
        'half.inMilliseconds == ${durHalf.inMilliseconds}  // ${durHalf.toString()}',
        Icons.percent,
        _kAccentBlue,
      ),
      durCard(
        '5. Compare two durations',
        "final int cmpAB = a.compareTo(b);\n"
        "final int cmpAC = a.compareTo(c);",
        'cmpAB == $cmpAB  // a > b => 1\n'
        'cmpAC == $cmpAC  // a < c => -1',
        Icons.compare_arrows,
        _kAccentOrange,
      ),
      durCard(
        '6. Extract numeric components',
        "final int aMs = a.inMilliseconds;\n"
        "final int cSec = c.inSeconds;\n"
        "const Duration zero = Duration.zero;",
        'aMs == $durAMs\n'
        'cSec == $durCSec\n'
        'zero == ${durZero.toString()}',
        Icons.calculate,
        _kAccentGreen,
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - CURVE.TRANSFORM SAMPLES AS BAR CHARTS
  // -------------------------------------------------------------------------
  // For a fixed grid of t values {0.0, 0.1, 0.2, ..., 1.0}, render
  // curve.transform(t) as bars. Four curves are chosen to highlight
  // contrasting shapes.
  // -------------------------------------------------------------------------
  final List<double> tGrid = <double>[
    0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
  ];
  final Widget transformBars = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.bar_chart, size: 20.0, color: _kAccent),
            const SizedBox(width: 6.0),
            _cardTitle(
              'curve.transform(t) bar charts',
              subtitle: 't sweeps {0.0, 0.1, …, 1.0}; height = curve(t)',
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _barChart('Curves.linear',       Curves.linear,       tGrid, colour: _kAccentBlue),
        _barChart('Curves.easeInOut',    Curves.easeInOut,    tGrid, colour: _kAccent),
        _barChart('Curves.bounceOut',    Curves.bounceOut,    tGrid, colour: _kAccentOrange),
        _barChart('Curves.elasticOut',   Curves.elasticOut,   tGrid, colour: _kAccentTertiary),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // AnimationStyle is sometimes confused with Tween, CurvedAnimation and
  // Animation<double>. The comparison table makes their roles distinct.
  // -------------------------------------------------------------------------
  final Widget comparisonTable = _card(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Row(
            children: <Widget>[
              const Icon(Icons.compare, size: 20.0, color: _kAccent),
              const SizedBox(width: 6.0),
              _cardTitle(
                'Who does what?',
                subtitle: 'AnimationStyle vs Tween vs CurvedAnimation vs Animation<double>',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            children: <Widget>[
              _tableRow(
                <String>['Type', 'Owns time?', 'Owns shape?', 'Owns value?', 'Used with'],
                header: true,
                flexes: <int>[2, 2, 2, 2, 3],
              ),
              _tableRow(
                <String>[
                  'AnimationStyle',
                  'No (config only)',
                  'No (config only)',
                  'No',
                  'Material widgets',
                ],
                flexes: <int>[2, 2, 2, 2, 3],
              ),
              _tableRow(
                <String>[
                  'Tween<T>',
                  'No',
                  'No',
                  'Yes - maps t in [0,1] -> T',
                  'Animation.drive()',
                ],
                flexes: <int>[2, 2, 2, 2, 3],
              ),
              _tableRow(
                <String>[
                  'CurvedAnimation',
                  'No (wraps parent)',
                  'Yes',
                  'No (yields t in [0,1])',
                  'Anywhere a curve is needed',
                ],
                flexes: <int>[2, 2, 2, 2, 3],
              ),
              _tableRow(
                <String>[
                  'Animation<double>',
                  'Yes (driven by controller)',
                  'No (pass-through)',
                  'Yes - current value',
                  'AnimatedBuilder, Listenable',
                ],
                flexes: <int>[2, 2, 2, 2, 3],
              ),
              _tableRow(
                <String>[
                  'AnimationController',
                  'Yes (owns vsync, ticks)',
                  'No (linear by default)',
                  'Yes',
                  'StatefulWidget + vsync',
                ],
                flexes: <int>[2, 2, 2, 2, 3],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Rule of thumb: AnimationStyle is a *bag* (configuration). Tween '
          'is a *function* (value mapping). CurvedAnimation is a *filter* '
          '(curve-shaping). AnimationController is a *clock* (time + tick).',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - SIX CODE-BLOCK USAGE CARDS
  // -------------------------------------------------------------------------
  // The most common consumption sites for AnimationStyle: themes, switchers,
  // implicit widgets and hero.
  // -------------------------------------------------------------------------
  final Widget usageCards = Column(
    children: <Widget>[
      _codeBlock(
        "// 1. ThemeData.bottomSheetTheme et al accept an AnimationStyle.\n"
        "MaterialApp(\n"
        "  theme: ThemeData(\n"
        "    bottomSheetTheme: BottomSheetThemeData(\n"
        "      // AnimationStyle wired through the widget\n"
        "    ),\n"
        "  ),\n"
        ");",
        title: 'animationstyle_in_theme.dart',
      ),
      _codeBlock(
        "// 2. AnimatedSwitcher swap with a custom curve.\n"
        "AnimatedSwitcher(\n"
        "  duration: const Duration(milliseconds: 300),\n"
        "  switchInCurve: Curves.easeIn,\n"
        "  switchOutCurve: Curves.easeOut,\n"
        "  transitionBuilder: (Widget child, Animation<double> anim) {\n"
        "    return FadeTransition(opacity: anim, child: child);\n"
        "  },\n"
        "  child: KeyedSubtree(key: ValueKey<int>(page), child: body),\n"
        ");",
        title: 'animated_switcher.dart',
      ),
      _codeBlock(
        "// 3. ExpansionTile takes an animationStyle directly.\n"
        "ExpansionTile(\n"
        "  title: const Text('Advanced settings'),\n"
        "  expansionAnimationStyle: AnimationStyle(\n"
        "    curve: Curves.easeOut,\n"
        "    duration: const Duration(milliseconds: 250),\n"
        "  ),\n"
        "  children: const <Widget>[/* ... */],\n"
        ");",
        title: 'expansion_tile.dart',
      ),
      _codeBlock(
        "// 4. AnimatedTheme - implicit theme cross-fade.\n"
        "AnimatedTheme(\n"
        "  duration: const Duration(milliseconds: 400),\n"
        "  curve: Curves.fastOutSlowIn,\n"
        "  data: isDark ? darkTheme : lightTheme,\n"
        "  child: const _MyApp(),\n"
        ");",
        title: 'animated_theme.dart',
      ),
      _codeBlock(
        "// 5. ImplicitlyAnimatedWidget subclass with custom curve.\n"
        "class _BlinkBox extends ImplicitlyAnimatedWidget {\n"
        "  const _BlinkBox({required this.size})\n"
        "    : super(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);\n"
        "  final double size;\n"
        "\n"
        "  @override\n"
        "  ImplicitlyAnimatedWidgetState<_BlinkBox> createState() => _BlinkBoxState();\n"
        "}",
        title: 'implicitly_animated.dart',
      ),
      _codeBlock(
        "// 6. Hero transition: tune timing via PageRoute.\n"
        "Navigator.of(context).push<void>(MaterialPageRoute<void>(\n"
        "  builder: (BuildContext _) => const _DetailPage(),\n"
        "));\n"
        "// Within _DetailPage:\n"
        "Hero(tag: 'avatar', child: CircleAvatar(radius: 48.0));",
        title: 'hero_routing.dart',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - PITFALLS
  // -------------------------------------------------------------------------
  // Five common pitfalls grouped into a single visual panel.
  // -------------------------------------------------------------------------
  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.warning_amber_rounded, color: _kAccentOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Five Pitfalls',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Things that look reasonable but bite the next maintainer.',
          style: _kCaptionStyle,
        ),
        const SizedBox(height: 10.0),
        _pitfallRow(
          '1. reverseCurve == null silently reuses curve',
          'When AnimationStyle.reverseCurve is null the consumer widget '
          'falls back to AnimationStyle.curve. That is often fine, but it '
          'means a symmetrical-looking style may behave very differently '
          'on reverse than the developer expected.',
        ),
        _pitfallRow(
          '2. AnimationStyle.lerp does not blend curve fields',
          'The lerp helper only interpolates durations. Curves snap from '
          '`a.curve` to `b.curve` at t = 0.5, with no smooth transition. '
          'If you need a smooth curve transition, you must compose curves '
          'yourself.',
          icon: Icons.swap_calls,
        ),
        _pitfallRow(
          '3. Curves.linear is not the identity tween',
          'Curves.linear is a Curve - it returns t for t in [0,1]. The '
          'identity *tween* is `Tween<double>(begin: 0.0, end: 1.0)`. '
          'Mixing the two concepts leads to "why is nothing animating?" '
          'questions.',
          icon: Icons.straighten,
          colour: _kAccentBlue,
        ),
        _pitfallRow(
          '4. Bouncing / elastic curves overshoot [0, 1]',
          'bounceOut, elasticIn, elasticOut produce values < 0 or > 1 at '
          'intermediate t. If you wire them into a Tween that expects '
          'values inside the begin..end range (eg. a Color), apply '
          'CurvedAnimation first and clamp where needed.',
          icon: Icons.sports_basketball,
          colour: _kAccentTertiary,
        ),
        _pitfallRow(
          '5. reverseDuration without duration is undefined',
          'AnimationStyle(reverseDuration: Duration(ms: 200)) with no '
          'forward duration leaves the forward animation to whatever the '
          'consumer widget defaults to. Always set both, or rely on '
          'AnimationStyle.noAnimation when you mean "instant".',
          icon: Icons.timer_off,
          colour: _kAccentRed,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - CHEAT SHEET FOOTER
  // -------------------------------------------------------------------------
  // A compact dark card with three columns: the Curves namespace, the
  // AnimationStyle constructor variants and Duration helpers.
  // -------------------------------------------------------------------------
  Widget _cheatRow(String left, String right, {Color leftColour = _kCodeAccent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180.0,
            child: Text(
              left,
              style: TextStyle(
                color: leftColour,
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              right,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: _kInkOnDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cheatColumn(String title, List<Widget> rows, {Color tint = _kAccent}) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2740),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kHairlineDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          ...rows,
        ],
      ),
    );
  }

  final Widget cheatSheet = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 24.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.bookmark, color: Color(0xFFFFD60A), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Cheat Sheet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'AnimationStyle, the Curves namespace and Duration helpers at a glance.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 14.0),
        _cheatColumn(
          'AnimationStyle constructor variants',
          <Widget>[
            _cheatRow('AnimationStyle()',         'all four fields nullable; consumer fills defaults'),
            _cheatRow('curve:',                   'Curve - shape of forward animation'),
            _cheatRow('reverseCurve:',            'Curve? - shape of reverse animation; falls back to curve'),
            _cheatRow('duration:',                'Duration? - length of forward animation'),
            _cheatRow('reverseDuration:',         'Duration? - length of reverse; falls back to duration'),
            _cheatRow('AnimationStyle.noAnimation', 'singleton with zero forward & reverse durations'),
            _cheatRow('AnimationStyle.lerp(a,b,t)', 'lerps durations, snaps curves at t == 0.5'),
          ],
          tint: _kAccent,
        ),
        const SizedBox(height: 10.0),
        _cheatColumn(
          'Curves namespace (selected)',
          <Widget>[
            _cheatRow('Curves.linear',           'identity in [0,1]'),
            _cheatRow('Curves.ease',             'CSS-style ease (Cubic(.25,.1,.25,1))'),
            _cheatRow('Curves.easeIn / easeOut', 'asymmetric ease-only-on-one-end variants'),
            _cheatRow('Curves.easeInOut',       'symmetric ease-in and ease-out'),
            _cheatRow('Curves.fastOutSlowIn',   'Material standard easing'),
            _cheatRow('Curves.decelerate',      'rapid start, slow end'),
            _cheatRow('Curves.bounceIn/Out/InOut','overshooting bounce curves'),
            _cheatRow('Curves.elasticIn/Out/InOut','oscillating spring curves'),
            _cheatRow('Cubic(a,b,c,d)',          'arbitrary Bezier with two control points'),
            _cheatRow('SawTooth(count)',         'count repeats of t in [0,1)'),
            _cheatRow('Interval(start,end,curve:)','sub-range of t mapped onto curve'),
            _cheatRow('Threshold(t)',            'step at threshold t'),
            _cheatRow('FlippedCurve(inner)',     'inner curve with t reversed'),
            _cheatRow('ElasticInCurve(period)',  'elastic-in with custom period'),
          ],
          tint: _kAccentSecondary,
        ),
        const SizedBox(height: 10.0),
        _cheatColumn(
          'Duration helpers',
          <Widget>[
            _cheatRow('Duration.zero',           'sentinel for "no time"'),
            _cheatRow('Duration(milliseconds:)', 'most common unit for UI motion'),
            _cheatRow('Duration(seconds:)',      'use for slow transitions only'),
            _cheatRow('Duration(microseconds:)', 'rare; ticker-precision arithmetic'),
            _cheatRow('a + b / a - b',           'add or subtract two durations'),
            _cheatRow('a * factor',              'scale by integer or double'),
            _cheatRow('a ~/ divisor',            'integer-divide by an int'),
            _cheatRow('a.compareTo(b)',          '-1 / 0 / 1 ordering'),
            _cheatRow('a.inMilliseconds',        'numeric component for logs'),
            _cheatRow('a.inSeconds',             'numeric component for human display'),
          ],
          tint: _kAccentTeal,
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2940),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.info_outline, color: Color(0xFFFFD60A), size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'AnimationStyle is a value type - the same instance can be reused across '
                  'widgets, shared between themes, and held as a top-level `const` field. '
                  'Treat it as configuration, not as a controller.',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: _kInkOnDark,
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

  // -------------------------------------------------------------------------
  // ASSEMBLE THE FULL SCROLLABLE GALLERY
  // -------------------------------------------------------------------------
  // The eleven sections are stitched together in a single ListView body
  // wrapped by a MaterialApp / Scaffold. Section headers numbered 1..11
  // match the documentation table at the top of this file.
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'Constructor showcase',  'Six literal AnimationStyle(...) cards'),
    constructorShowcase,
    _sectionHeader(3, 'noAnimation & lerp',    'Instant transition + style blending'),
    noAnimCard,
    lerpCard,
    _sectionHeader(4, 'Curve gallery',         '24 curves plotted in a 3-column grid'),
    curveGalleryCard,
    _sectionHeader(5, 'Custom curves',         'Cubic, SawTooth, Interval, Threshold, Flipped, ElasticIn'),
    customCurvesCard,
    _sectionHeader(6, 'Duration arithmetic',   'sum, diff, scale, compareTo, inMilliseconds'),
    durationCards,
    _sectionHeader(7, 'curve.transform(t)',    'Bar charts for four selected curves'),
    transformBars,
    _sectionHeader(8, 'Comparison',            'AnimationStyle vs Tween vs CurvedAnimation vs Animation<double>'),
    comparisonTable,
    _sectionHeader(9, 'Usage code blocks',     'Theme, AnimatedSwitcher, ExpansionTile, AnimatedTheme, ImplicitlyAnimatedWidget, Hero'),
    usageCards,
    _sectionDivider(),
    _sectionHeader(10, 'Pitfalls',             'Five common mistakes when using AnimationStyle'),
    pitfalls,
    _sectionHeader(11, 'Cheat sheet',          'Surface area of AnimationStyle, Curves and Duration'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
      scaffoldBackgroundColor: _kCanvas,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: _kAccent,
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text('AnimationStyle & Curves'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('AnimationStyle deep visual demo built successfully');
  return app;
}

// ---------------------------------------------------------------------------
// PRIVATE INTRO PILL WIDGET
// ---------------------------------------------------------------------------
// Used in section 1 to render small token-style chips inside the hero card.
// Implemented as a StatelessWidget (rather than a function) purely so the
// hero card can use `const` constructors in its child list.
class _IntroPill extends StatelessWidget {
  const _IntroPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: const Color(0x55FFFFFF)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
