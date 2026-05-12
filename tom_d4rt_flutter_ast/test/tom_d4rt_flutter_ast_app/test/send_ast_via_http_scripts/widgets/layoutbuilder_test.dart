// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of `flutter/widgets` LayoutBuilder.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)`
// - which is invoked a single time, and which returns a Widget tree.
//
// The rendered output is a long static gallery that walks through the
// LayoutBuilder family of widgets:
//
//   * LayoutBuilder              - takes a BoxConstraints, rebuilds on resize
//   * ConstrainedLayoutBuilder   - generic base, parametrised on constraints
//   * SliverLayoutBuilder        - takes SliverConstraints inside slivers
//   * BoxConstraints             - the value passed to LayoutBuilder.builder
//   * SliverConstraints          - the value passed to SliverLayoutBuilder
//
// Every section is purely declarative: no `setState`, `Timer`, `Future`,
// or `AnimationController` is used anywhere in this file. The live width
// and aspect-ratio galleries achieve their effect by rendering the same
// LayoutBuilder body inside three different `SizedBox`es of fixed extent.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
const Color _kCanvas = Color(0xFFF2F2F7);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1C1C1E);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1C1C1E);
const Color _kInkSecondary = Color(0xFF3C3C43);
const Color _kInkTertiary = Color(0xFF8E8E93);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kAccent = Color(0xFF007AFF);
const Color _kAccentGreen = Color(0xFF34C759);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentRed = Color(0xFFFF3B30);
const Color _kAccentIndigo = Color(0xFF5856D6);
const Color _kAccentPink = Color(0xFFFF2D55);
const Color _kAccentTeal = Color(0xFF30B0C7);
const Color _kAccentYellow = Color(0xFFFFCC00);
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
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
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

Widget _bullet(String text, {Color colour = _kAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 8.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: colour,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(child: Text(text, style: _kBodyStyle)),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, {Color valueColor = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: valueColor,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - BUILD-vs-LAYOUT PHASE CUSTOM PAINTER
// ---------------------------------------------------------------------------
// The two-phase diagram is drawn entirely from primitives. The painter paints
// a horizontal timeline with a "build" phase and a "layout" phase. The
// LayoutBuilder.builder callback fires during the layout phase, *after* the
// parent has imposed BoxConstraints.
class _PhasePainter extends CustomPainter {
  const _PhasePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.fill;
    final Paint buildPaint = Paint()
      ..color = _kAccentIndigo
      ..style = PaintingStyle.fill;
    final Paint layoutPaint = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.fill;
    final Paint paintPaint = Paint()
      ..color = _kAccentGreen
      ..style = PaintingStyle.fill;
    final Paint arrowPaint = Paint()
      ..color = _kInkSecondary
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    // Baseline track.
    final RRect track = RRect.fromRectAndRadius(
      Rect.fromLTWH(8.0, size.height * 0.55, size.width - 16.0, 18.0),
      const Radius.circular(9.0),
    );
    canvas.drawRRect(track, trackPaint);

    final double third = (size.width - 16.0) / 3.0;
    // Build phase (left).
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(8.0, size.height * 0.55, third, 18.0),
        const Radius.circular(9.0),
      ),
      buildPaint,
    );
    // Layout phase (middle).
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(8.0 + third, size.height * 0.55, third, 18.0),
        const Radius.circular(9.0),
      ),
      layoutPaint,
    );
    // Paint phase (right).
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(8.0 + 2.0 * third, size.height * 0.55, third, 18.0),
        const Radius.circular(9.0),
      ),
      paintPaint,
    );

    // Marker for LayoutBuilder.builder firing - in the layout phase.
    final double markerX = 8.0 + third + third * 0.5;
    final Path arrow = Path()
      ..moveTo(markerX, size.height * 0.55 - 6.0)
      ..lineTo(markerX - 6.0, size.height * 0.55 - 18.0)
      ..lineTo(markerX + 6.0, size.height * 0.55 - 18.0)
      ..close();
    canvas.drawPath(arrow, Paint()..color = _kAccentRed);

    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'builder() fires here',
        style: TextStyle(color: _kAccentRed, fontSize: 11.5, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(markerX - tp.width / 2.0, size.height * 0.55 - 36.0));

    // Phase labels.
    final TextPainter b = TextPainter(
      text: const TextSpan(
        text: 'build',
        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    b.paint(canvas, Offset(8.0 + third * 0.5 - b.width / 2.0, size.height * 0.55 + 2.0));

    final TextPainter l = TextPainter(
      text: const TextSpan(
        text: 'layout',
        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    l.paint(canvas, Offset(8.0 + third * 1.5 - l.width / 2.0, size.height * 0.55 + 2.0));

    final TextPainter p = TextPainter(
      text: const TextSpan(
        text: 'paint',
        style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    p.paint(canvas, Offset(8.0 + third * 2.5 - p.width / 2.0, size.height * 0.55 + 2.0));

    // Frame arrow on top.
    final double frameY = size.height * 0.20;
    canvas.drawLine(Offset(12.0, frameY), Offset(size.width - 12.0, frameY), arrowPaint);
    final Path tip = Path()
      ..moveTo(size.width - 12.0, frameY)
      ..lineTo(size.width - 20.0, frameY - 4.0)
      ..lineTo(size.width - 20.0, frameY + 4.0)
      ..close();
    canvas.drawPath(tip, Paint()..color = _kInkSecondary);
    final TextPainter f = TextPainter(
      text: const TextSpan(
        text: 'one frame',
        style: TextStyle(color: _kInkSecondary, fontSize: 11.0, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    f.paint(canvas, Offset(12.0, frameY - 16.0));
  }

  @override
  bool shouldRepaint(covariant _PhasePainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// SECTION 3 - BOXCONSTRAINTS ANATOMY PAINTER
// ---------------------------------------------------------------------------
// Draws a "box" with min/max width and min/max height bounds, callouts for
// the four constraint dimensions, and a legend.
class _ConstraintsPainter extends CustomPainter {
  const _ConstraintsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double pad = 30.0;
    final Rect outer = Rect.fromLTWH(pad, pad, size.width - pad * 2.0, size.height - pad * 2.0);
    final Paint outerBox = Paint()
      ..color = _kAccent.withOpacity(0.10)
      ..style = PaintingStyle.fill;
    final Paint outerStroke = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(outer, const Radius.circular(8.0)), outerBox);
    canvas.drawRRect(RRect.fromRectAndRadius(outer, const Radius.circular(8.0)), outerStroke);

    // Inner box - "min" envelope.
    final Rect inner = Rect.fromLTWH(
      outer.left + outer.width * 0.20,
      outer.top + outer.height * 0.25,
      outer.width * 0.45,
      outer.height * 0.50,
    );
    final Paint innerBox = Paint()
      ..color = _kAccentOrange.withOpacity(0.18)
      ..style = PaintingStyle.fill;
    final Paint innerStroke = Paint()
      ..color = _kAccentOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(inner, const Radius.circular(6.0)), innerBox);
    canvas.drawRRect(RRect.fromRectAndRadius(inner, const Radius.circular(6.0)), innerStroke);

    // Dimension lines.
    final Paint dim = Paint()
      ..color = _kInkSecondary
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // maxWidth - top of outer.
    canvas.drawLine(
      Offset(outer.left, outer.top - 10.0),
      Offset(outer.right, outer.top - 10.0),
      dim,
    );
    final TextPainter mw = TextPainter(
      text: const TextSpan(
        text: 'maxWidth',
        style: TextStyle(color: _kAccent, fontSize: 11.5, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    mw.paint(canvas, Offset(outer.left + outer.width / 2.0 - mw.width / 2.0, outer.top - 26.0));

    // minWidth - inner top.
    canvas.drawLine(
      Offset(inner.left, inner.top - 6.0),
      Offset(inner.right, inner.top - 6.0),
      dim,
    );
    final TextPainter mnw = TextPainter(
      text: const TextSpan(
        text: 'minWidth',
        style: TextStyle(color: _kAccentOrange, fontSize: 11.0, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    mnw.paint(canvas, Offset(inner.left + inner.width / 2.0 - mnw.width / 2.0, inner.top - 20.0));

    // maxHeight - right of outer.
    canvas.drawLine(
      Offset(outer.right + 10.0, outer.top),
      Offset(outer.right + 10.0, outer.bottom),
      dim,
    );
    final TextPainter mh = TextPainter(
      text: const TextSpan(
        text: 'maxHeight',
        style: TextStyle(color: _kAccent, fontSize: 11.5, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.save();
    canvas.translate(outer.right + 26.0, outer.top + outer.height / 2.0 + mh.width / 2.0);
    canvas.rotate(-math.pi / 2.0);
    mh.paint(canvas, Offset.zero);
    canvas.restore();

    // minHeight - left of inner.
    canvas.drawLine(
      Offset(inner.left - 6.0, inner.top),
      Offset(inner.left - 6.0, inner.bottom),
      dim,
    );
    final TextPainter mnh = TextPainter(
      text: const TextSpan(
        text: 'minHeight',
        style: TextStyle(color: _kAccentOrange, fontSize: 11.0, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.save();
    canvas.translate(inner.left - 22.0, inner.top + inner.height / 2.0 + mnh.width / 2.0);
    canvas.rotate(-math.pi / 2.0);
    mnh.paint(canvas, Offset.zero);
    canvas.restore();

    // Centre label.
    final TextPainter centre = TextPainter(
      text: const TextSpan(
        text: 'BoxConstraints',
        style: TextStyle(color: _kInk, fontSize: 13.0, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    centre.paint(
      canvas,
      Offset(
        inner.left + inner.width / 2.0 - centre.width / 2.0,
        inner.top + inner.height / 2.0 - centre.height / 2.0,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _ConstraintsPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// SECTION 4 / 5 - LAYOUTBUILDER PAYLOAD (responsive body)
// ---------------------------------------------------------------------------
// A reusable body that switches between three column counts based on the
// `maxWidth` it receives from its parent. It is used inside the width gallery
// to demonstrate how LayoutBuilder's `constraints.maxWidth` lets a widget
// adapt to its parent's available space - without consulting MediaQuery.
Widget _responsiveBody() {
  return LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final double w = constraints.maxWidth;
      String layoutName;
      int columns;
      Color tone;
      if (w < 500.0) {
        layoutName = 'compact (1 col)';
        columns = 1;
        tone = _kAccentOrange;
      } else if (w < 900.0) {
        layoutName = 'medium (2 col)';
        columns = 2;
        tone = _kAccent;
      } else {
        layoutName = 'expanded (3 col)';
        columns = 3;
        tone = _kAccentIndigo;
      }
      final List<Widget> tiles = <Widget>[];
      for (int i = 0; i < 6; i++) {
        tiles.add(
          Container(
            margin: const EdgeInsets.all(4.0),
            height: 38.0,
            decoration: BoxDecoration(
              color: tone.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: tone.withOpacity(0.35)),
            ),
            alignment: Alignment.center,
            child: Text(
              'tile ${i + 1}',
              style: TextStyle(
                fontSize: 12.0,
                color: tone,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
      final List<Widget> rows = <Widget>[];
      for (int i = 0; i < tiles.length; i += columns) {
        final List<Widget> rowChildren = <Widget>[];
        for (int c = 0; c < columns; c++) {
          if (i + c < tiles.length) {
            rowChildren.add(Expanded(child: tiles[i + c]));
          } else {
            rowChildren.add(const Expanded(child: SizedBox.shrink()));
          }
        }
        rows.add(Row(children: rowChildren));
      }
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: tone.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: tone.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'maxWidth = ${w.toStringAsFixed(0)}  ->  $layoutName',
                style: TextStyle(
                  color: tone,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            ...rows,
          ],
        ),
      );
    },
  );
}

// Aspect-ratio responsive body. Switches portrait vs landscape vs square.
Widget _aspectBody() {
  return LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final double w = constraints.maxWidth;
      final double h = constraints.maxHeight;
      final double ratio = (h <= 0.0) ? 1.0 : w / h;
      String label;
      Color tone;
      Axis dir;
      if (ratio < 0.9) {
        label = 'portrait (w/h=${ratio.toStringAsFixed(2)})';
        tone = _kAccentPink;
        dir = Axis.vertical;
      } else if (ratio > 1.4) {
        label = 'landscape (w/h=${ratio.toStringAsFixed(2)})';
        tone = _kAccentTeal;
        dir = Axis.horizontal;
      } else {
        label = 'square (w/h=${ratio.toStringAsFixed(2)})';
        tone = _kAccentIndigo;
        dir = Axis.horizontal;
      }
      final Widget hero = Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: tone.withOpacity(0.18),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: tone.withOpacity(0.45)),
        ),
        alignment: Alignment.center,
        child: Text('HERO',
            style: TextStyle(
              color: tone,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            )),
      );
      final Widget side = Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: tone.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: tone.withOpacity(0.30)),
        ),
        alignment: Alignment.center,
        child: Text('SIDE',
            style: TextStyle(
              color: tone,
              fontWeight: FontWeight.w600,
              fontSize: 11.5,
            )),
      );
      final Widget inner;
      if (dir == Axis.vertical) {
        inner = Column(
          children: <Widget>[
            Expanded(flex: 3, child: hero),
            Expanded(flex: 2, child: side),
          ],
        );
      } else {
        inner = Row(
          children: <Widget>[
            Expanded(flex: 3, child: hero),
            Expanded(flex: 2, child: side),
          ],
        );
      }
      return Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: tone.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: tone.withOpacity(0.25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                label,
                style: TextStyle(
                  color: tone,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(child: inner),
          ],
        ),
      );
    },
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ===========================================================================
dynamic build(BuildContext context) {
  print('LayoutBuilder deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int dummyEntropy = rng.nextInt(100);
  print('  rng warm-up: $dummyEntropy');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF007AFF),
          Color(0xFF5856D6),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33007AFF),
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
            Icon(Icons.aspect_ratio, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'LayoutBuilder',
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
          'Responsive UI driven by parent constraints, not screen size.',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'LayoutBuilder is a widget whose builder callback runs during the '
          'LAYOUT phase, after the parent has decided how much space to give it. '
          'The callback receives a BoxConstraints and returns a Widget tree '
          'tailored to that exact envelope. This is the canonical way to write '
          'responsive UI in Flutter: branching on maxWidth/maxHeight at the '
          'point of use, instead of asking MediaQuery for the device size.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.5,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('Responsive',         colour: const Color(0xFFFFFFFF)),
            _pill('Layout-phase',       colour: const Color(0xFFFFFFFF)),
            _pill('Parent constraints', colour: const Color(0xFFFFFFFF)),
            _pill('Slivers too',        colour: const Color(0xFFFFFFFF)),
            _pill('Breakpoint-friendly', colour: const Color(0xFFFFFFFF)),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: const <Widget>[
            Icon(Icons.check_circle, color: Color(0xFFFFFFFF), size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Use LayoutBuilder when the SAME widget must look different in '
                'a sidebar (300dp) vs a full pane (1100dp).',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xE6FFFFFF),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - BUILD vs LAYOUT PHASE
  // -------------------------------------------------------------------------
  final Widget phaseCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.timeline, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Build vs Layout phase',
              subtitle: 'LayoutBuilder.builder fires during LAYOUT, after constraints are known.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 160.0,
          child: CustomPaint(
            painter: const _PhasePainter(),
            size: const Size.fromHeight(160.0),
          ),
        ),
        const SizedBox(height: 8.0),
        _bullet(
          'A normal StatelessWidget.build() runs during the BUILD phase. '
          'At that point the widget has not yet been measured.',
        ),
        _bullet(
          'LayoutBuilder.builder runs during the LAYOUT phase. The parent '
          'has already passed it a BoxConstraints, so it can branch on '
          'maxWidth / maxHeight.',
          colour: _kAccentIndigo,
        ),
        _bullet(
          'Anything that uses LayoutBuilder is therefore slightly more '
          'expensive than a static widget: it is a second pass over the '
          'subtree once constraints settle.',
          colour: _kAccentOrange,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - BOXCONSTRAINTS ANATOMY
  // -------------------------------------------------------------------------
  final Widget constraintsCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.crop_din, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'BoxConstraints anatomy',
              subtitle: 'Four numbers: minWidth, maxWidth, minHeight, maxHeight.',
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 240.0,
          child: CustomPaint(
            painter: const _ConstraintsPainter(),
            size: const Size.fromHeight(240.0),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('tight', colour: _kAccent),
            _pill('loose', colour: _kAccentIndigo),
            _pill('bounded', colour: _kAccentGreen),
            _pill('unbounded', colour: _kAccentRed),
          ],
        ),
        const SizedBox(height: 10.0),
        _kvRow('tight', 'min == max  (no slack; widget must take exact size)'),
        _kvRow('loose', 'min == 0    (widget may shrink to its content)'),
        _kvRow('bounded', 'max is finite  (an upper limit exists)'),
        _kvRow('unbounded', 'max == infinity  (e.g. inside a ListView)'),
        const SizedBox(height: 8.0),
        _bullet(
          'A widget is laid out by being given a BoxConstraints and returning '
          'a Size that satisfies it. LayoutBuilder lets you inspect the '
          'constraints before deciding what to return.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - LIVE WIDTH-BASED GALLERY
  // -------------------------------------------------------------------------
  final Widget widthGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.view_column, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Live width breakpoints',
              subtitle: 'Same widget rendered at maxWidth = 350 / 700 / 1100.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('350dp', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                SizedBox(
                  width: 350.0,
                  child: _responsiveBody(),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('700dp', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                SizedBox(
                  width: 700.0,
                  child: _responsiveBody(),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('1100dp', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                SizedBox(
                  width: 1100.0,
                  child: _responsiveBody(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet(
          'The SAME _responsiveBody() function is invoked three times. The '
          'difference between the three renderings comes entirely from '
          'constraints.maxWidth - which is fed by the parent SizedBox.',
          colour: _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - LIVE ASPECT-RATIO GALLERY
  // -------------------------------------------------------------------------
  final Widget aspectGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.crop, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Live aspect-ratio branching',
              subtitle: 'Portrait / square / landscape envelopes at fixed pixel sizes.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.start,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('200 x 320 (portrait)', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                SizedBox(width: 200.0, height: 320.0, child: _aspectBody()),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('260 x 260 (square)', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                SizedBox(width: 260.0, height: 260.0, child: _aspectBody()),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('420 x 220 (landscape)', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                SizedBox(width: 420.0, height: 220.0, child: _aspectBody()),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet(
          'A LayoutBuilder can branch on ANY constraint dimension - not just '
          'width. Here we compute w/h from constraints and pick a column vs '
          'row arrangement.',
          colour: _kAccentTeal,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - SLIVERLAYOUTBUILDER DEMO
  // -------------------------------------------------------------------------
  // Two CustomScrollViews rendered side by side, each driven by a fixed
  // width SizedBox. The narrow viewport falls into the "list" branch; the
  // wide viewport falls into the "grid" branch.
  Widget _sliverDemo(double width) {
    return SizedBox(
      width: width,
      height: 260.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _kHairline),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverLayoutBuilder(
                builder: (BuildContext ctx, SliverConstraints constraints) {
                  final double cross = constraints.crossAxisExtent;
                  if (cross < 360.0) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext c, int i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _kAccent.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: _kAccent.withOpacity(0.30)),
                            ),
                            child: Text(
                              'list item #${i + 1}  -  cross=${cross.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: _kAccent,
                                fontFamily: 'monospace',
                              ),
                            ),
                          );
                        },
                        childCount: 8,
                      ),
                    );
                  } else {
                    return SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 6.0,
                        crossAxisSpacing: 6.0,
                        childAspectRatio: 2.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext c, int i) {
                          return Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: _kAccentIndigo.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: _kAccentIndigo.withOpacity(0.30)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'cell ${i + 1}',
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: _kAccentIndigo,
                                fontFamily: 'monospace',
                              ),
                            ),
                          );
                        },
                        childCount: 9,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget sliverGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.grid_view, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'SliverLayoutBuilder',
              subtitle: 'Inside a sliver, branch on SliverConstraints.crossAxisExtent.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('crossAxisExtent < 360 -> SliverList', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                _sliverDemo(300.0),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('crossAxisExtent >= 360 -> SliverGrid', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                _sliverDemo(520.0),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet(
          'Slivers do not receive BoxConstraints - they receive '
          'SliverConstraints with axisDirection, scrollOffset, '
          'remainingPaintExtent, crossAxisExtent and more.',
          colour: _kAccentIndigo,
        ),
        _bullet(
          'SliverLayoutBuilder is the only widget in the family that can '
          'switch sliver TYPES (list vs grid vs fixed) based on the actual '
          'viewport extent at layout time.',
          colour: _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - SIX CODE-BLOCK CARDS
  // -------------------------------------------------------------------------
  final Widget codeBasic = _codeBlock(
    title: '01_basic_layoutbuilder.dart',
    'LayoutBuilder(\n'
    '  builder: (BuildContext ctx, BoxConstraints constraints) {\n'
    '    if (constraints.maxWidth < 600) {\n'
    '      return const _CompactBody();\n'
    '    }\n'
    '    return const _ExpandedBody();\n'
    '  },\n'
    ')',
  );

  final Widget codeBreakpoints = _codeBlock(
    title: '02_breakpoint_table.dart',
    'class Breakpoints {\n'
    '  static const double compact  =  600.0;\n'
    '  static const double medium   =  900.0;\n'
    '  static const double expanded = 1240.0;\n'
    '}\n'
    '\n'
    'Widget responsive(BoxConstraints c) {\n'
    '  final double w = c.maxWidth;\n'
    '  if (w < Breakpoints.compact)  return const _Compact();\n'
    '  if (w < Breakpoints.medium)   return const _Medium();\n'
    '  if (w < Breakpoints.expanded) return const _Expanded();\n'
    '  return const _UltraWide();\n'
    '}',
  );

  final Widget codeIsolating = _codeBlock(
    title: '03_isolating_expensive_builders.dart',
    '// LayoutBuilder rebuilds whenever its constraints change. Keep the\n'
    '// expensive subtree OUTSIDE the builder so it is not re-instantiated\n'
    '// on every resize.\n'
    '\n'
    'class _Card extends StatelessWidget {\n'
    '  const _Card({required this.heavy});\n'
    '  final Widget heavy;\n'
    '\n'
    '  @override\n'
    '  Widget build(BuildContext context) {\n'
    '    return LayoutBuilder(\n'
    '      builder: (BuildContext ctx, BoxConstraints c) {\n'
    '        // cheap layout-time branching here\n'
    '        return c.maxWidth < 600 ? heavy : Center(child: heavy);\n'
    '      },\n'
    '    );\n'
    '  }\n'
    '}',
  );

  final Widget codeWithMq = _codeBlock(
    title: '04_layoutbuilder_with_mediaquery.dart',
    '// LayoutBuilder = parent constraints (local).\n'
    '// MediaQuery   = window / screen size (global).\n'
    '// Combine both when a widget cares about both.\n'
    '\n'
    'Widget build(BuildContext context) {\n'
    '  final EdgeInsets safe = MediaQuery.of(context).padding;\n'
    '  return Padding(\n'
    '    padding: safe,\n'
    '    child: LayoutBuilder(\n'
    '      builder: (BuildContext c, BoxConstraints cs) {\n'
    '        return cs.maxWidth > 800 ? _wide() : _narrow();\n'
    '      },\n'
    '    ),\n'
    '  );\n'
    '}',
  );

  final Widget codeSliverLb = _codeBlock(
    title: '05_sliver_layoutbuilder.dart',
    'CustomScrollView(\n'
    '  slivers: <Widget>[\n'
    '    SliverLayoutBuilder(\n'
    '      builder: (BuildContext ctx, SliverConstraints c) {\n'
    '        if (c.crossAxisExtent > 600) {\n'
    '          return SliverGrid(\n'
    '            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(\n'
    '              crossAxisCount: 3),\n'
    '            delegate: _delegate,\n'
    '          );\n'
    '        }\n'
    '        return SliverList(delegate: _delegate);\n'
    '      },\n'
    '    ),\n'
    '  ],\n'
    ')',
  );

  final Widget codeConstrainedLb = _codeBlock(
    title: '06_constrained_layoutbuilder_generic.dart',
    '// LayoutBuilder and SliverLayoutBuilder both extend the generic\n'
    '// ConstrainedLayoutBuilder<C extends Constraints>.\n'
    '//\n'
    '//   class LayoutBuilder        extends ConstrainedLayoutBuilder<BoxConstraints>\n'
    '//   class SliverLayoutBuilder  extends ConstrainedLayoutBuilder<SliverConstraints>\n'
    '//\n'
    '// You can roll your own by extending the base class - useful for\n'
    '// custom render objects that produce non-standard constraints.\n'
    'abstract class ConstrainedLayoutBuilder<C extends Constraints>\n'
    '    extends RenderObjectWidget { /* ... */ }',
  );

  final Widget codeSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      codeBasic,
      codeBreakpoints,
      codeIsolating,
      codeWithMq,
      codeSliverLb,
      codeConstrainedLb,
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  Widget _cellHeader(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF6F6F8),
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: _kInkSecondary,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _cell(String text, {Color colour = _kInk, bool mono = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.5,
          color: colour,
          fontWeight: FontWeight.w500,
          fontFamily: mono ? 'monospace' : null,
        ),
      ),
    );
  }

  final Widget comparisonTable = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.compare_arrows, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'LayoutBuilder vs MediaQuery vs OrientationBuilder',
              subtitle: 'Three different ways to react to size - pick the right one for the job.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kHairline),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(flex: 3, child: _cellHeader('Aspect')),
                  Expanded(flex: 4, child: _cellHeader('LayoutBuilder')),
                  Expanded(flex: 4, child: _cellHeader('MediaQuery')),
                  Expanded(flex: 4, child: _cellHeader('OrientationBuilder')),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(flex: 3, child: _cell('source')),
                  Expanded(flex: 4, child: _cell('parent constraints', colour: _kAccent, mono: true)),
                  Expanded(flex: 4, child: _cell('window / screen', colour: _kAccentIndigo, mono: true)),
                  Expanded(flex: 4, child: _cell('parent constraints', colour: _kAccentTeal, mono: true)),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(flex: 3, child: _cell('granularity')),
                  Expanded(flex: 4, child: _cell('full BoxConstraints')),
                  Expanded(flex: 4, child: _cell('Size + padding + textScale')),
                  Expanded(flex: 4, child: _cell('Orientation only')),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(flex: 3, child: _cell('rebuilds on')),
                  Expanded(flex: 4, child: _cell('constraint change')),
                  Expanded(flex: 4, child: _cell('window resize')),
                  Expanded(flex: 4, child: _cell('rotation')),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(flex: 3, child: _cell('scope')),
                  Expanded(flex: 4, child: _cell('subtree')),
                  Expanded(flex: 4, child: _cell('whole subtree dependent')),
                  Expanded(flex: 4, child: _cell('subtree')),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(flex: 3, child: _cell('phase')),
                  Expanded(flex: 4, child: _cell('layout', colour: _kAccent)),
                  Expanded(flex: 4, child: _cell('build', colour: _kAccentIndigo)),
                  Expanded(flex: 4, child: _cell('layout')),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(flex: 3, child: _cell('best for')),
                  Expanded(flex: 4, child: _cell('reusable components')),
                  Expanded(flex: 4, child: _cell('screen-level decisions')),
                  Expanded(flex: 4, child: _cell('portrait/landscape swap')),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - PITFALLS
  // -------------------------------------------------------------------------
  Widget _pitfall(String title, String body, {Color colour = _kAccentRed, IconData icon = Icons.warning_amber}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colour.withOpacity(0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: colour, size: 20.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: colour,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(body, style: _kBodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.warning_amber, color: _kAccentRed, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Pitfalls',
              subtitle: 'Six common mistakes when reaching for LayoutBuilder.',
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _pitfall(
          'Layout rebuild infinite loop',
          'If the widget returned by the builder DEPENDS on its own size (e.g. '
          'a Column whose height drives a conditional inside the builder), the '
          'engine can re-enter layout repeatedly. Always make the branching '
          'depend on the INPUT constraints, never on the OUTPUT size.',
          colour: _kAccentRed,
        ),
        _pitfall(
          'Using context.size inside the builder',
          '`context.size` is null until paint phase. Inside LayoutBuilder.builder '
          'you already have the constraints - use them. Reaching for findRenderObject() '
          'or context.size is both wrong and slow.',
          colour: _kAccentOrange,
          icon: Icons.dangerous,
        ),
        _pitfall(
          'Applying constraints over MediaQuery',
          'MediaQuery is the window or sub-window size; LayoutBuilder is the local '
          'parent envelope. Branching on MediaQuery for a card that lives in a 300dp '
          'side rail is wrong - the card thinks it has 1200dp.',
          colour: _kAccentIndigo,
          icon: Icons.layers,
        ),
        _pitfall(
          'Unbounded parent (infinity maxWidth/maxHeight)',
          'Inside a Row, a ListView main axis, or a Wrap, the parent can pass '
          'maxWidth or maxHeight = double.infinity. Branching with `< 600` then '
          'silently picks the "small" path forever. Always handle the unbounded '
          'case explicitly.',
          colour: _kAccentPink,
          icon: Icons.all_inclusive,
        ),
        _pitfall(
          'Sliver constraints are not box constraints',
          'SliverLayoutBuilder gives you SliverConstraints (axisDirection, '
          'scrollOffset, crossAxisExtent, remainingPaintExtent). They are NOT '
          'BoxConstraints - you cannot directly compare them to width breakpoints '
          'without going through crossAxisExtent.',
          colour: _kAccentTeal,
          icon: Icons.view_stream,
        ),
        _pitfall(
          'Performance cost vs static layout',
          'LayoutBuilder forces an extra layout pass for the subtree (children are '
          'instantiated only AFTER constraints settle). On long lists, prefer a '
          'single LayoutBuilder at the top and hoist its constants out, instead of '
          'wrapping every item.',
          colour: _kAccent,
          icon: Icons.speed,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - BREAKPOINT DESIGN GUIDE
  // -------------------------------------------------------------------------
  Widget _bpSketch({required Color tone, required int columns, required String label, required String range}) {
    final List<Widget> bars = <Widget>[];
    for (int c = 0; c < columns; c++) {
      bars.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(3.0),
            height: 70.0,
            decoration: BoxDecoration(
              color: tone.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: tone.withOpacity(0.4)),
            ),
          ),
        ),
      );
    }
    return Container(
      width: 220.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: tone,
            ),
          ),
          Text(range, style: _kCaptionStyle),
          const SizedBox(height: 8.0),
          Row(children: bars),
          const SizedBox(height: 6.0),
          Text(
            '$columns column${columns == 1 ? "" : "s"}',
            style: _kCaptionStyle,
          ),
        ],
      ),
    );
  }

  final Widget breakpointGuide = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.view_compact, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Breakpoint design guide',
              subtitle: 'Three Material-aligned width breakpoints with adjacent column sketches.',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _bpSketch(tone: _kAccentOrange, columns: 1, label: 'compact',  range: 'maxWidth < 600dp'),
            _bpSketch(tone: _kAccent,        columns: 2, label: 'medium',   range: '600 <= maxWidth < 900'),
            _bpSketch(tone: _kAccentIndigo,  columns: 3, label: 'expanded', range: 'maxWidth >= 900dp'),
          ],
        ),
        const SizedBox(height: 8.0),
        _kvRow('compact',  '< 600  - one column, full-bleed (phone portrait)'),
        _kvRow('medium',   '600 - 900 - two columns (tablet / small laptop)'),
        _kvRow('expanded', '>= 900 - three+ columns (desktop, side rails)'),
        const SizedBox(height: 8.0),
        _bullet(
          'These breakpoints match the Material 3 guidelines (compact/medium/'
          'expanded/large/extra-large). Aligning to them keeps your UI '
          'predictable across the ecosystem.',
          colour: _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  Widget _chip(String label, Color tone) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: tone.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: tone.withOpacity(0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: tone,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _chipGroup(String title, List<Widget> chips, IconData icon, Color tone) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: tone, size: 18.0),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: tone,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Wrap(children: chips),
        ],
      ),
    );
  }

  final Widget cheatSheet = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.menu_book, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Cheat sheet',
              subtitle: 'Classes, constraints, breakpoints and related widgets at a glance.',
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _chipGroup(
          'Classes',
          <Widget>[
            _chip('LayoutBuilder', _kAccent),
            _chip('ConstrainedLayoutBuilder<C>', _kAccent),
            _chip('SliverLayoutBuilder', _kAccent),
            _chip('RenderConstrainedLayoutBuilder', _kAccent),
          ],
          Icons.class_,
          _kAccent,
        ),
        _chipGroup(
          'Constraints',
          <Widget>[
            _chip('BoxConstraints.minWidth', _kAccentIndigo),
            _chip('BoxConstraints.maxWidth', _kAccentIndigo),
            _chip('BoxConstraints.minHeight', _kAccentIndigo),
            _chip('BoxConstraints.maxHeight', _kAccentIndigo),
            _chip('BoxConstraints.tight', _kAccentIndigo),
            _chip('BoxConstraints.loose', _kAccentIndigo),
            _chip('SliverConstraints.crossAxisExtent', _kAccentIndigo),
            _chip('SliverConstraints.scrollOffset', _kAccentIndigo),
            _chip('SliverConstraints.remainingPaintExtent', _kAccentIndigo),
          ],
          Icons.straighten,
          _kAccentIndigo,
        ),
        _chipGroup(
          'Breakpoints',
          <Widget>[
            _chip('compact  < 600', _kAccentOrange),
            _chip('medium  600..900', _kAccentOrange),
            _chip('expanded  >= 900', _kAccentOrange),
            _chip('large  >= 1240', _kAccentOrange),
            _chip('xLarge  >= 1600', _kAccentOrange),
          ],
          Icons.view_compact,
          _kAccentOrange,
        ),
        _chipGroup(
          'Related',
          <Widget>[
            _chip('MediaQuery.of(context)', _kAccentTeal),
            _chip('OrientationBuilder', _kAccentTeal),
            _chip('CustomMultiChildLayout', _kAccentTeal),
            _chip('Flow', _kAccentTeal),
            _chip('FractionallySizedBox', _kAccentTeal),
            _chip('AspectRatio', _kAccentTeal),
          ],
          Icons.link,
          _kAccentTeal,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF007AFF),
                Color(0xFF5856D6),
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Reach for LayoutBuilder when the SAME component must look '
            'different at different parent sizes. Reach for MediaQuery when '
            'you need the window. Reach for OrientationBuilder when only '
            'rotation matters. Anything else: just lay it out.',
            style: TextStyle(
              fontSize: 13.0,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // ASSEMBLE
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'Build vs Layout',     'When does the builder fire?'),
    phaseCard,
    _sectionHeader(3, 'BoxConstraints',      'minWidth / maxWidth / minHeight / maxHeight'),
    constraintsCard,
    _sectionHeader(4, 'Width breakpoints',   'Same widget at 350 / 700 / 1100 dp'),
    widthGallery,
    _sectionHeader(5, 'Aspect ratio',        'Portrait / square / landscape'),
    aspectGallery,
    _sectionHeader(6, 'SliverLayoutBuilder', 'List vs Grid by crossAxisExtent'),
    sliverGallery,
    _sectionDivider(),
    _sectionHeader(7, 'Code',                'Six idiomatic snippets'),
    codeSection,
    _sectionHeader(8, 'Comparison',          'LayoutBuilder vs MediaQuery vs OrientationBuilder'),
    comparisonTable,
    _sectionHeader(9, 'Pitfalls',            'Six things that bite'),
    pitfalls,
    _sectionHeader(10, 'Breakpoint guide',   'Compact / medium / expanded'),
    breakpointGuide,
    _sectionHeader(11, 'Cheat sheet',        'One last glance'),
    cheatSheet,
    const SizedBox(height: 28.0),
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kCanvas,
      primaryColor: _kAccent,
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: _kCardBg,
        elevation: 0.5,
        title: const Text(
          'LayoutBuilder',
          style: TextStyle(
            color: _kInk,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('LayoutBuilder deep visual demo built successfully');
  return app;
}
