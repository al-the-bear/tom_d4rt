// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the rendering layer's sizing family.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static gallery that explains how Flutter's
// box layout protocol works through the lens of the RenderObject sizing
// primitives. Constraints flow *down* from a parent to its child, and the
// resulting Size flows *up* from the child to the parent. Eleven thematic
// sections cover:
//
//   1. Hero intro - the parent-passes-constraints, child-returns-size
//      contract that underlies every RenderBox in the framework.
//   2. Constraints flow diagram (CustomPainter) - arrows pointing down for
//      BoxConstraints and arrows pointing up for the resulting Size, drawn
//      on top of a stylised parent/child layout sandwich.
//   3. AspectRatio gallery - 16:9, 4:3, 1:1 and 9:16 cards built on top of
//      RenderAspectRatio, showing how the render object picks a Size from a
//      fixed numerical ratio.
//   4. ConstrainedBox / LimitedBox tour - tightFor, loose, expand, etc., as
//      visualised by RenderConstrainedBox plus the looser cousins
//      RenderLimitedBox and RenderUnconstrainedBox.
//   5. OverflowBox family grid - RenderConstrainedOverflowBox,
//      RenderFractionallySizedOverflowBox and RenderSizedOverflowBox, each
//      annotated with the constraint manipulation it performs.
//   6. Intrinsic worked example - the before/after for IntrinsicHeight and
//      IntrinsicWidth, including the intuition that these are O(N^2) probes.
//   7. RenderBaseline panel - the typographic anchor that shifts a child by
//      its alphabetic/ideographic baseline.
//   8. RenderObject sizing comparison matrix - one row per class, with
//      columns for "owns constraints", "owns size", "can overflow parent"
//      and "typical use-case".
//   9. Recipe cards - six code snippets you will reach for over and over.
//  10. Pitfalls panel - six callouts about loose vs tight constraints,
//      unbounded constraints, infinite intrinsic loops, AspectRatio with
//      unbounded width, ConstrainedBox vs SizedBox, and the
//      double-probe cost of IntrinsicHeight.
//  11. Cheat-sheet footer - chip groups for the sizing surface area.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `AnimationController`, no `Tween.animate(...).value` reads, and no
// `for (final x in bridgedList)` loops over Flutter-bridged collections.
// The script returns a fully-static widget tree.
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
// Literal ARGB values keep the demo theme-independent. The palette borrows
// from Material's "indigo on porcelain" mood since the rendering layer is
// part of the cross-platform widgets stack, not Cupertino specifically.
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
const Color _kAccent = Color(0xFF4F46E5); // indigo
const Color _kAccentSoft = Color(0xFFEEF2FF);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kFocusRing = Color(0xFF60A5FA);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
const Color _kArrowDown = Color(0xFF2563EB); // constraints flow down
const Color _kArrowUp = Color(0xFF14B8A6); // sizes flow up

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
// Helpers are top-level private functions returning Widgets. They are kept
// out of StatelessWidget subclasses so the file can be read top-to-bottom.

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
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
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
    margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
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
              color: _kInkSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: valueColour,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletList(List<String> items) {
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    children.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 7.0, right: 9.0),
              width: 6.0,
              height: 6.0,
              decoration: const BoxDecoration(
                color: _kAccent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(child: Text(items[i], style: _kBodySoftStyle)),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children,
  );
}

// ===========================================================================
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------
// Sets the mental model: parent passes BoxConstraints down, child returns a
// Size up. The rest of the file is variations on that theme.
// ===========================================================================

Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.only(
      top: 18.0,
      left: 18.0,
      right: 18.0,
      bottom: 6.0,
    ),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF111827), Color(0xFF312E81)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x29111827),
          offset: Offset(0.0, 6.0),
          blurRadius: 14.0,
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
                color: _kAccent.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(color: _kAccent.withOpacity(0.5)),
              ),
              child: const Text(
                'rendering . sizing primitives',
                style: TextStyle(
                  color: Color(0xFFC7D2FE),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'parent -> constraints | child -> size',
              style: TextStyle(
                color: Color(0xFFA3A6B8),
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'RenderObject sizing primitives',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'How BoxConstraints flow down and Size flows up: AspectRatio, '
          'ConstrainedBox, OverflowBox, FractionallySizedBox, LimitedBox, '
          'SizedOverflowBox, UnconstrainedBox, IntrinsicHeight/Width and '
          'Baseline - drawn, tabulated and recipe-carded.',
          style: TextStyle(
            color: Color(0xFFD1D5DB),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('BoxConstraints', colour: _kAccentBlue),
            _pill('Size', colour: _kAccentTeal),
            _pill('RenderAspectRatio', colour: _kAccentViolet),
            _pill('RenderConstrainedBox', colour: _kAccent),
            _pill('RenderLimitedBox', colour: _kAccentAmber),
            _pill('RenderUnconstrainedBox', colour: _kAccentRose),
            _pill('RenderOverflowBox', colour: _kAccentGreen),
            _pill('IntrinsicHeight', colour: _kAccentBlue),
            _pill('IntrinsicWidth', colour: _kAccentBlue),
            _pill('RenderBaseline', colour: _kAccentTeal),
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
          'Two values, one contract',
          subtitle:
              'Every RenderBox is parameterised by BoxConstraints and reports back a Size.',
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Flutter\'s box protocol is breathtakingly small. A parent calls '
          'child.layout(constraints) with a BoxConstraints record carrying '
          'four numbers: minWidth, maxWidth, minHeight, maxHeight. The child '
          'must pick a Size strictly inside that envelope. The size is then '
          'cached on the child and used by the parent to position it.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Most of the sizing primitives below are render objects that '
          'transform the incoming constraints before they reach the child, '
          'or rewrite the returned size before they hand it back up. That '
          'is the entire trick - everything else is shorthand.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('constraints in', colour: _kArrowDown),
            _pill('size out', colour: _kArrowUp),
            _pill('parent positions child', colour: _kInkTertiary),
            _pill('layout is single-pass', colour: _kAccentViolet),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2 - CONSTRAINTS FLOW DIAGRAM CUSTOMPAINTER
// ---------------------------------------------------------------------------
// A two-layer sandwich: an outer "parent" rectangle, an inner "child"
// rectangle. Blue arrows point down carrying BoxConstraints, teal arrows
// point up carrying Size.
// ===========================================================================

class _ConstraintsFlowPainter extends CustomPainter {
  const _ConstraintsFlowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint outerStroke = Paint()
      ..color = _kAccentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final Paint outerFill = Paint()
      ..color = _kAccentBlue.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    final Paint innerStroke = Paint()
      ..color = _kAccentTeal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final Paint innerFill = Paint()
      ..color = _kAccentTeal.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    final Rect outer =
        Rect.fromLTWH(20.0, 16.0, size.width - 40.0, size.height - 32.0);
    final Rect inner = Rect.fromLTWH(
      outer.left + 60.0,
      outer.top + 60.0,
      outer.width - 120.0,
      outer.height - 120.0,
    );
    final RRect outerRr =
        RRect.fromRectAndRadius(outer, const Radius.circular(14.0));
    final RRect innerRr =
        RRect.fromRectAndRadius(inner, const Radius.circular(10.0));
    canvas.drawRRect(outerRr, outerFill);
    canvas.drawRRect(outerRr, outerStroke);
    canvas.drawRRect(innerRr, innerFill);
    canvas.drawRRect(innerRr, innerStroke);

    const TextStyle labelStyle = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: _kInk,
    );
    _label(canvas, 'Parent RenderBox',
        Offset(outer.left + 12.0, outer.top + 8.0), labelStyle);
    _label(
      canvas,
      'Child RenderBox',
      Offset(inner.left + 12.0, inner.top + 8.0),
      labelStyle.copyWith(color: _kAccentTeal),
    );

    // Down arrows (constraints).
    final Paint downPaint = Paint()
      ..color = _kArrowDown
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    _arrow(canvas, downPaint,
        Offset(outer.left + outer.width * 0.30, outer.top + 30.0),
        Offset(inner.left + inner.width * 0.30, inner.top - 4.0));
    _arrow(canvas, downPaint,
        Offset(outer.left + outer.width * 0.50, outer.top + 30.0),
        Offset(inner.left + inner.width * 0.50, inner.top - 4.0));
    _arrow(canvas, downPaint,
        Offset(outer.left + outer.width * 0.70, outer.top + 30.0),
        Offset(inner.left + inner.width * 0.70, inner.top - 4.0));
    _label(
      canvas,
      'BoxConstraints',
      Offset(outer.left + outer.width * 0.50 - 46.0, outer.top + 34.0),
      const TextStyle(
        color: _kArrowDown,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
      ),
    );

    // Up arrows (size).
    final Paint upPaint = Paint()
      ..color = _kArrowUp
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    _arrow(canvas, upPaint,
        Offset(inner.left + inner.width * 0.30, inner.bottom + 4.0),
        Offset(outer.left + outer.width * 0.30, outer.bottom - 24.0));
    _arrow(canvas, upPaint,
        Offset(inner.left + inner.width * 0.50, inner.bottom + 4.0),
        Offset(outer.left + outer.width * 0.50, outer.bottom - 24.0));
    _arrow(canvas, upPaint,
        Offset(inner.left + inner.width * 0.70, inner.bottom + 4.0),
        Offset(outer.left + outer.width * 0.70, outer.bottom - 24.0));
    _label(
      canvas,
      'Size',
      Offset(outer.left + outer.width * 0.50 - 14.0, outer.bottom - 22.0),
      const TextStyle(
        color: _kArrowUp,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
      ),
    );

    // Tag the parent edges with min/max numbers to add concreteness.
    _label(
      canvas,
      'min: 0, max: 360',
      Offset(outer.left + 12.0, outer.bottom - 22.0),
      const TextStyle(color: _kInkTertiary, fontSize: 10.5),
    );
    _label(
      canvas,
      'min: 0, max: 200',
      Offset(outer.right - 130.0, outer.bottom - 22.0),
      const TextStyle(color: _kInkTertiary, fontSize: 10.5),
    );
  }

  void _arrow(Canvas canvas, Paint paint, Offset from, Offset to) {
    canvas.drawLine(from, to, paint);
    final double dx = to.dx - from.dx;
    final double dy = to.dy - from.dy;
    final double angle = math.atan2(dy, dx);
    const double headLen = 8.0;
    final Path head = Path();
    head.moveTo(to.dx, to.dy);
    head.lineTo(
      to.dx - headLen * math.cos(angle - math.pi / 7.0),
      to.dy - headLen * math.sin(angle - math.pi / 7.0),
    );
    head.lineTo(
      to.dx - headLen * math.cos(angle + math.pi / 7.0),
      to.dy - headLen * math.sin(angle + math.pi / 7.0),
    );
    head.close();
    final Paint fill = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;
    canvas.drawPath(head, fill);
  }

  void _label(Canvas canvas, String text, Offset origin, TextStyle style) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, origin);
  }

  @override
  bool shouldRepaint(covariant _ConstraintsFlowPainter oldDelegate) => false;
}

Widget _flowDiagramSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Constraints flow down, sizes flow up',
          subtitle:
              'A parent RenderBox passes BoxConstraints to its child; the child returns a Size.',
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 280.0,
          child: CustomPaint(
            painter: const _ConstraintsFlowPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'A child cannot pick a size outside the envelope it is handed. '
          'The render objects in the next sections all play with one half '
          'of this contract: they either translate the incoming '
          'BoxConstraints (Constrained, Limited, OverflowBox, Aspect, '
          'Intrinsic) or rewrite the size that goes up (SizedOverflowBox, '
          'Baseline).',
          style: _kBodySoftStyle,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('downward = constraints', colour: _kArrowDown),
            _pill('upward = size', colour: _kArrowUp),
            _pill('one pass', colour: _kAccentViolet),
            _pill('no relayout from size', colour: _kInkTertiary),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3 - ASPECTRATIO GALLERY
// ---------------------------------------------------------------------------
// Four cards showing what RenderAspectRatio does with a numerical ratio.
// 16:9, 4:3, 1:1, 9:16. The body of each card draws a stylised "frame" with
// the aspect ratio so the eye can compare instantly.
// ===========================================================================

Widget _aspectCard(
  String label,
  double ratio,
  Color colour,
  String narrative,
) {
  return _card(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: colour.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: colour,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              'aspectRatio: ${ratio.toStringAsFixed(3)}',
              style: const TextStyle(
                fontSize: 12.0,
                color: _kInkSecondary,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 110.0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AspectRatio(
              aspectRatio: ratio,
              child: Container(
                decoration: BoxDecoration(
                  color: colour.withOpacity(0.10),
                  border: Border.all(color: colour, width: 1.4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    color: colour,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(narrative, style: _kBodySoftStyle),
      ],
    ),
  );
}

Widget _aspectRatioSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'AspectRatio gallery',
              subtitle:
                  'RenderAspectRatio picks the largest size whose width/height matches the ratio.',
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Given BoxConstraints, RenderAspectRatio tries: take the '
              'incoming maxWidth, derive height = width / ratio. If that '
              'height fits the incoming constraints, done. Otherwise it '
              'takes maxHeight and derives width = height * ratio. The '
              'final Size respects both the aspect ratio and the parent\'s '
              'envelope.',
              style: _kBodySoftStyle,
            ),
          ],
        ),
      ),
      _aspectCard(
        '16 : 9',
        16.0 / 9.0,
        _kAccentBlue,
        'Widescreen video. The render object picks width = parent.maxWidth, '
            'height = width / 1.777, then clamps if the parent height is tighter.',
      ),
      _aspectCard(
        '4 : 3',
        4.0 / 3.0,
        _kAccentTeal,
        'Classic monitor. Slightly squarer than 16:9; very common for photo '
            'thumbnails and tile-grid layouts.',
      ),
      _aspectCard(
        '1 : 1',
        1.0,
        _kAccentViolet,
        'Square. Width equals height. Useful for avatars, icons and grid tiles.',
      ),
      _aspectCard(
        '9 : 16',
        9.0 / 16.0,
        _kAccentRose,
        'Portrait video. RenderAspectRatio cannot grow the height beyond '
            'the parent\'s maxHeight, so it picks the largest width that fits.',
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Pitfall: unbounded width',
              titleColor: _kAccentRose,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'If the incoming BoxConstraints has maxWidth = double.infinity '
              '(for example inside an unbounded Row), RenderAspectRatio cannot '
              'pick a width. It will throw a layout error in debug mode. '
              'Wrap in an Expanded, SizedBox(width: ...) or LimitedBox to '
              'recover.',
              style: _kBodyStyle,
            ),
          ],
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 4 - CONSTRAINEDBOX / LIMITEDBOX TOUR
// ---------------------------------------------------------------------------
// Visual tour of the constraint manipulation primitives. Each card draws a
// stylised "box-in-a-box" so the difference between tight, loose, expand,
// limited, unconstrained, etc., is immediate.
// ===========================================================================

Widget _miniSwatch(String label, Color colour, {double height = 36.0}) {
  return Container(
    margin: const EdgeInsets.only(top: 4.0),
    height: height,
    decoration: BoxDecoration(
      color: colour.withOpacity(0.16),
      border: Border.all(color: colour, width: 1.2),
      borderRadius: BorderRadius.circular(6.0),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        color: colour,
        fontWeight: FontWeight.w600,
        fontSize: 12.5,
      ),
    ),
  );
}

Widget _constraintRow(
  String constructor,
  String description,
  Widget visual,
  Color colour,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: colour.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: colour.withOpacity(0.3)),
            ),
            child: Text(
              constructor,
              style: TextStyle(
                color: colour,
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: Text(description, style: _kBodySoftStyle),
        ),
        const SizedBox(width: 12.0),
        Expanded(flex: 2, child: visual),
      ],
    ),
  );
}

Widget _constraintsTourSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'BoxConstraints constructors',
          subtitle:
              'Six common factory shapes and what RenderConstrainedBox does with each.',
        ),
        const SizedBox(height: 6.0),
        const Divider(color: _kHairline, height: 12.0),
        _constraintRow(
          'BoxConstraints()',
          'Default constructor with explicit min/max for each axis. The most general form; everything else is a shortcut.',
          _miniSwatch('min..max', _kInkSecondary),
          _kInkSecondary,
        ),
        _constraintRow(
          'BoxConstraints.tight(Size)',
          'Forces both min and max to the same value on each axis. The child has no choice - its size is fully determined.',
          _miniSwatch('tight 120x40', _kAccentBlue),
          _kAccentBlue,
        ),
        _constraintRow(
          'BoxConstraints.tightFor(width:height:)',
          'Tightens only the supplied axis. Passing only width leaves the height range untouched.',
          _miniSwatch('tightFor width', _kAccentTeal),
          _kAccentTeal,
        ),
        _constraintRow(
          'BoxConstraints.loose(Size)',
          'min = 0, max = the supplied size. The child may be anything from a single pixel up to the supplied Size.',
          _miniSwatch('loose 200x60', _kAccentGreen),
          _kAccentGreen,
        ),
        _constraintRow(
          'BoxConstraints.expand()',
          'Forces both axes to the parent\'s max. Equivalent to tight(Size.infinite) inside a bounded parent.',
          _miniSwatch('expand', _kAccentViolet),
          _kAccentViolet,
        ),
        _constraintRow(
          'BoxConstraints(maxWidth: 200)',
          'min stays at 0, max bounded. Useful for "no wider than 200, otherwise shrink to fit".',
          _miniSwatch('max 200', _kAccentAmber),
          _kAccentAmber,
        ),
      ],
    ),
  );
}

Widget _constrainedRenderRow() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'RenderConstrainedBox, RenderLimitedBox, RenderUnconstrainedBox',
          subtitle:
              'The render objects behind ConstrainedBox, LimitedBox and UnconstrainedBox.',
        ),
        const SizedBox(height: 10.0),
        _kvRow('RenderConstrainedBox', 'tighten(c) before passing down'),
        _kvRow('RenderLimitedBox',
            'only applies max if incoming max is infinite'),
        _kvRow('RenderUnconstrainedBox',
            'drops constraints entirely (use carefully)'),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 80.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: _kAccentBlue.withOpacity(0.10),
                  border: Border.all(color: _kAccentBlue, width: 1.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'ConstrainedBox\nminWidth: 120\nmaxHeight: 60',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _kAccentBlue,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 80.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: _kAccentAmber.withOpacity(0.10),
                  border: Border.all(color: _kAccentAmber, width: 1.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'LimitedBox\nmaxWidth: 240\n(only if unbounded)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _kAccentAmber,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 80.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: _kAccentRose.withOpacity(0.10),
                  border: Border.all(color: _kAccentRose, width: 1.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'UnconstrainedBox\nno bounds passed\n(careful!)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _kAccentRose,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 - OVERFLOWBOX FAMILY GRID
// ---------------------------------------------------------------------------
// Three render objects: ConstrainedOverflowBox, SizedOverflowBox, and
// FractionallySizedOverflowBox. They share the trick of letting the child
// pick a size bigger than the parent's incoming constraints would normally
// allow.
// ===========================================================================

Widget _overflowSampleGrid() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'The OverflowBox family',
          subtitle:
              'Three render objects that let a child exceed its parent\'s constraints.',
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 200.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: _kAccentBlue.withOpacity(0.06),
                    border:
                        Border.all(color: _kAccentBlue.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'RenderConstrainedOverflowBox',
                        style: TextStyle(
                          color: _kAccentBlue,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      const Text(
                        'Imposes new min/max on the child while keeping its '
                        'own size from the parent.',
                        style: _kBodySoftStyle,
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ClipRect(
                          child: OverflowBox(
                            minWidth: 140.0,
                            maxWidth: 140.0,
                            minHeight: 40.0,
                            maxHeight: 40.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _kAccentBlue.withOpacity(0.18),
                                border: Border.all(
                                    color: _kAccentBlue, width: 1.2),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '140x40\nin narrow parent',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _kAccentBlue,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: _kAccentTeal.withOpacity(0.06),
                    border:
                        Border.all(color: _kAccentTeal.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'RenderSizedOverflowBox',
                        style: TextStyle(
                          color: _kAccentTeal,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      const Text(
                        'Parent reports a fixed Size up the tree; child '
                        'gets loose constraints derived from it.',
                        style: _kBodySoftStyle,
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ClipRect(
                          child: SizedOverflowBox(
                            size: const Size(120.0, 30.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _kAccentTeal.withOpacity(0.18),
                                border: Border.all(color: _kAccentTeal),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(6.0),
                              child: const Text(
                                'size up = 120x30',
                                style: TextStyle(
                                  color: _kAccentTeal,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: _kAccentRose.withOpacity(0.06),
                    border:
                        Border.all(color: _kAccentRose.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'RenderFractionallySizedOverflowBox',
                        style: TextStyle(
                          color: _kAccentRose,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      const Text(
                        'Tightens child to a fraction of parent\'s max. '
                        'widthFactor=0.7 means 70% of parent max width.',
                        style: _kBodySoftStyle,
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ClipRect(
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            heightFactor: 0.6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _kAccentRose.withOpacity(0.18),
                                border: Border.all(color: _kAccentRose),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '0.7 x 0.6',
                                style: TextStyle(
                                  color: _kAccentRose,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

Widget _fractionalGrid() {
  // A 4-column grid showing four widthFactors at the same heightFactor.
  final List<double> factors = <double>[0.25, 0.5, 0.75, 1.0];
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < factors.length; i++) {
    final double f = factors[i];
    tiles.add(
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(4.0),
          height: 90.0,
          decoration: BoxDecoration(
            color: _kAccentSoft,
            border: Border.all(color: _kAccent.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: f,
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.20),
                border: Border.all(color: _kAccent, width: 1.2),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'w: ${f.toStringAsFixed(2)}\nh: 0.50',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'FractionallySizedBox sample grid',
          subtitle:
              'widthFactor sweep at heightFactor=0.5 inside identical parents.',
        ),
        const SizedBox(height: 8.0),
        Row(children: tiles),
        const SizedBox(height: 10.0),
        const Text(
          'The child receives BoxConstraints whose max is parent.max * '
          'factor. Pass null for a factor to defer to the incoming '
          'constraint on that axis.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 - INTRINSIC HEIGHT / WIDTH WORKED EXAMPLE
// ---------------------------------------------------------------------------
// Two stacked rows of three coloured tiles. Without IntrinsicHeight the
// tiles take whatever height their inner content imposes (so the row is
// ragged at the bottom). With IntrinsicHeight, each tile is grown to the
// tallest sibling's intrinsic height.
// ===========================================================================

Widget _intrinsicTile(String body, Color colour, double padding) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      border: Border.all(color: colour, width: 1.2),
      borderRadius: BorderRadius.circular(8.0),
    ),
    width: 110.0,
    child: Text(
      body,
      style: TextStyle(color: colour, fontSize: 12.0, height: 1.3),
    ),
  );
}

Widget _intrinsicSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'IntrinsicHeight and IntrinsicWidth: a worked example',
          subtitle:
              'Probe-then-layout render objects that align siblings to their tallest/widest peer.',
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Before: a vanilla Row with three tiles of different content. '
          'Each tile sizes itself independently.',
          style: _kBodySoftStyle,
        ),
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _intrinsicTile('short', _kAccentBlue, 8.0),
            _intrinsicTile('medium length\nthat wraps', _kAccentTeal, 8.0),
            _intrinsicTile(
              'long body of text\nthat wraps over multiple\nphysical lines',
              _kAccentRose,
              8.0,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'After: the same Row wrapped in IntrinsicHeight. Each tile is '
          'stretched to the height of the tallest one.',
          style: _kBodySoftStyle,
        ),
        const SizedBox(height: 8.0),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _intrinsicTile('short', _kAccentBlue, 8.0),
              _intrinsicTile('medium length\nthat wraps', _kAccentTeal, 8.0),
              _intrinsicTile(
                'long body of text\nthat wraps over multiple\nphysical lines',
                _kAccentRose,
                8.0,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentAmber.withOpacity(0.10),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentAmber.withOpacity(0.4)),
          ),
          child: const Text(
            'Cost note: IntrinsicHeight does an extra layout-style pass to '
            'measure each child\'s intrinsic height before doing the real '
            'layout. This makes the operation O(N^2) on deep trees; reach '
            'for it sparingly.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF8B5A1A),
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'IntrinsicWidth works symmetrically on the horizontal axis: it '
          'finds the widest preferred child width and tightens each child '
          'to it. Useful for "match the widest label" columns.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 - RENDERBASELINE PANEL
// ---------------------------------------------------------------------------
// RenderBaseline shifts a child down so its first baseline (alphabetic or
// ideographic) lines up with the supplied number.
// ===========================================================================

Widget _baselineSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'RenderBaseline',
          subtitle:
              'Aligns a child to a typographic baseline rather than to a layout edge.',
        ),
        const SizedBox(height: 10.0),
        const Text(
          'RenderBaseline takes a baseline offset and a TextBaseline. It '
          'asks the child for its baseline (e.g. via the Text\'s computed '
          'metrics) and translates the child so the baseline lands exactly '
          'on the supplied offset.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 80.0,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            border: Border.all(color: _kAccent.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Baseline(
                baseline: 40.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('Hello',
                    style: TextStyle(fontSize: 26.0, color: _kInk)),
              ),
              SizedBox(width: 12.0),
              Baseline(
                baseline: 40.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('World',
                    style: TextStyle(fontSize: 18.0, color: _kAccent)),
              ),
              SizedBox(width: 12.0),
              Baseline(
                baseline: 40.0,
                baselineType: TextBaseline.alphabetic,
                child: Text('again',
                    style: TextStyle(fontSize: 12.0, color: _kAccentRose)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Notice how every child sits on the same horizontal line despite '
          'having wildly different font sizes. That common line is the '
          'alphabetic baseline at y = 40.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 - RENDEROBJECT SIZING COMPARISON MATRIX
// ---------------------------------------------------------------------------
// One row per render object. Columns: "owns constraints", "owns size",
// "can overflow parent", typical use-case.
// ===========================================================================

Widget _matrixCell(
  String text, {
  bool header = false,
  Color colour = _kInk,
  Alignment align = Alignment.centerLeft,
  int flex = 1,
}) {
  return Expanded(
    flex: flex,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      alignment: align,
      decoration: BoxDecoration(
        color: header ? _kCardSoft : null,
        border: const Border(
          right: BorderSide(color: _kHairline, width: 0.6),
          bottom: BorderSide(color: _kHairline, width: 0.6),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colour,
          fontSize: header ? 11.5 : 11.5,
          fontWeight: header ? FontWeight.w700 : FontWeight.w500,
          letterSpacing: header ? 0.4 : 0.0,
          fontFamily: header ? null : 'monospace',
        ),
        textAlign:
            align == Alignment.center ? TextAlign.center : TextAlign.left,
      ),
    ),
  );
}

Widget _matrixRow(List<Widget> cells) {
  return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: cells);
}

Widget _matrixSection() {
  return _card(
    padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: _cardTitle(
            'Sizing render objects compared',
            subtitle:
                'Eleven render objects on four axes. Pick the one whose row matches your situation.',
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: _kHairline, width: 0.6)),
          ),
          child: Column(
            children: <Widget>[
              _matrixRow(<Widget>[
                _matrixCell('Render object',
                    header: true, flex: 3, align: Alignment.centerLeft),
                _matrixCell('Owns constraints',
                    header: true, flex: 2, align: Alignment.center),
                _matrixCell('Owns size',
                    header: true, flex: 2, align: Alignment.center),
                _matrixCell('Can overflow parent',
                    header: true, flex: 2, align: Alignment.center),
                _matrixCell('Typical use',
                    header: true, flex: 4, align: Alignment.centerLeft),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderConstrainedBox',
                    flex: 3, colour: _kAccentBlue),
                _matrixCell('YES',
                    flex: 2, align: Alignment.center, colour: _kAccentGreen),
                _matrixCell('via child',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('no',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('clamp width, set min, etc.', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderLimitedBox',
                    flex: 3, colour: _kAccentAmber),
                _matrixCell('only if unbounded',
                    flex: 2, align: Alignment.center, colour: _kAccentAmber),
                _matrixCell('via child',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('no',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('cap unbounded scroll/list parents', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderUnconstrainedBox',
                    flex: 3, colour: _kAccentRose),
                _matrixCell('drops them',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('via child',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('YES',
                    flex: 2, align: Alignment.center, colour: _kAccentGreen),
                _matrixCell('let child be its natural size', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderAspectRatio',
                    flex: 3, colour: _kAccentViolet),
                _matrixCell('derives',
                    flex: 2, align: Alignment.center, colour: _kAccentBlue),
                _matrixCell('derives',
                    flex: 2, align: Alignment.center, colour: _kAccentBlue),
                _matrixCell('no',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('lock width/height to a fixed ratio', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderConstrainedOverflowBox',
                    flex: 3, colour: _kAccentBlue),
                _matrixCell('rewrites',
                    flex: 2, align: Alignment.center, colour: _kAccentBlue),
                _matrixCell('from parent',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('YES',
                    flex: 2, align: Alignment.center, colour: _kAccentGreen),
                _matrixCell('bleed background outside a card', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderSizedOverflowBox',
                    flex: 3, colour: _kAccentTeal),
                _matrixCell('loose from size',
                    flex: 2, align: Alignment.center, colour: _kAccentTeal),
                _matrixCell('fixed Size',
                    flex: 2, align: Alignment.center, colour: _kAccentGreen),
                _matrixCell('YES',
                    flex: 2, align: Alignment.center, colour: _kAccentGreen),
                _matrixCell('report fixed size while child overflows', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderFractionallySizedOverflowBox',
                    flex: 3, colour: _kAccentRose),
                _matrixCell('parent.max * factor',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('from child',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('YES',
                    flex: 2, align: Alignment.center, colour: _kAccentGreen),
                _matrixCell('% sizing inside dialogs and modals', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderIntrinsicHeight',
                    flex: 3, colour: _kAccent),
                _matrixCell('tightens height',
                    flex: 2, align: Alignment.center, colour: _kAccent),
                _matrixCell('from child',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('no',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('match siblings to tallest row', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderIntrinsicWidth',
                    flex: 3, colour: _kAccent),
                _matrixCell('tightens width',
                    flex: 2, align: Alignment.center, colour: _kAccent),
                _matrixCell('from child',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('no',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('match siblings to widest cell', flex: 4),
              ]),
              _matrixRow(<Widget>[
                _matrixCell('RenderBaseline', flex: 3, colour: _kAccentTeal),
                _matrixCell('passthrough',
                    flex: 2, align: Alignment.center, colour: _kAccentTeal),
                _matrixCell('from child',
                    flex: 2, align: Alignment.center, colour: _kInkSecondary),
                _matrixCell('no',
                    flex: 2, align: Alignment.center, colour: _kAccentRose),
                _matrixCell('typographic alignment across siblings', flex: 4),
              ]),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 - RECIPE CARDS
// ---------------------------------------------------------------------------
// Six idiomatic code snippets you will reach for over and over.
// ===========================================================================

Widget _recipesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(
        title: 'recipe_01_constrained_card.dart',
        '// Cap a child to 320pt wide; let it grow vertically as needed.\n'
        'ConstrainedBox(\n'
        '  constraints: const BoxConstraints(maxWidth: 320.0),\n'
        '  child: const _ProductCard(),\n'
        ');',
      ),
      _codeBlock(
        title: 'recipe_02_aspect_thumb.dart',
        '// Photo thumbnail with a 4:3 ratio inside a list tile.\n'
        'AspectRatio(\n'
        '  aspectRatio: 4.0 / 3.0,\n'
        '  child: Image.network(photo.url, fit: BoxFit.cover),\n'
        ');',
      ),
      _codeBlock(
        title: 'recipe_03_fractional_modal.dart',
        '// Modal that takes 80% of available width and 60% of height.\n'
        'FractionallySizedBox(\n'
        '  widthFactor: 0.8,\n'
        '  heightFactor: 0.6,\n'
        '  child: _ModalContents(),\n'
        ');',
      ),
      _codeBlock(
        title: 'recipe_04_intrinsic_row.dart',
        '// Three cards in a Row stretched to the tallest one.\n'
        'IntrinsicHeight(\n'
        '  child: Row(\n'
        '    crossAxisAlignment: CrossAxisAlignment.stretch,\n'
        '    children: <Widget>[\n'
        '      Expanded(child: _CardA()),\n'
        '      Expanded(child: _CardB()),\n'
        '      Expanded(child: _CardC()),\n'
        '    ],\n'
        '  ),\n'
        ');',
      ),
      _codeBlock(
        title: 'recipe_05_limited_in_scroll.dart',
        '// LimitedBox saves us when the parent (e.g. ListView shrinkWrap)\n'
        '// hands us infinite maxHeight. The child gets a sensible cap.\n'
        'LimitedBox(\n'
        '  maxHeight: 240.0,\n'
        '  child: const _Chart(),\n'
        ');',
      ),
      _codeBlock(
        title: 'recipe_06_overflow_decoration.dart',
        '// Let a glow effect extend past the card edge without affecting\n'
        '// the parent layout. ClipRect outside, OverflowBox inside.\n'
        'ClipRect(\n'
        '  child: OverflowBox(\n'
        '    maxWidth: double.infinity,\n'
        '    maxHeight: double.infinity,\n'
        '    child: const _Glow(),\n'
        '  ),\n'
        ');',
      ),
    ],
  );
}

// ===========================================================================
// SECTION 10 - PITFALLS PANEL
// ---------------------------------------------------------------------------
// Six callouts that bite Flutter engineers in production.
// ===========================================================================

Widget _pitfall(String emojiLike, String title, String body, Color accent) {
  return _card(
    padding: const EdgeInsets.all(14.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withOpacity(0.16),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accent.withOpacity(0.4)),
          ),
          child: Text(
            emojiLike,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
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

Widget _pitfallsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _pitfall(
        'TT',
        'tight vs loose constraints',
        'A tight constraint (min == max) gives the child no choice. A '
            'loose constraint (min == 0, max > 0) lets the child pick. '
            'Most layout bugs come from a child receiving tight where you '
            'expected loose, or vice versa.',
        _kAccentBlue,
      ),
      _pitfall(
        'UB',
        'unbounded constraints',
        'Inside a Row, Column or ListView the cross axis may be bounded '
            'but the main axis is often unbounded. AspectRatio, '
            'FractionallySizedBox and Expanded all need a bound on the '
            'axis they care about; reach for SizedBox or LimitedBox first.',
        _kAccentRose,
      ),
      _pitfall(
        'IL',
        'intrinsic infinite loops',
        'A child whose intrinsic*() implementation calls layout() (or '
            'reads parent constraints) will recurse forever inside '
            'IntrinsicHeight. Custom RenderObjects must implement '
            'computeIntrinsic* directly.',
        _kAccentAmber,
      ),
      _pitfall(
        'AR',
        'AspectRatio with infinite width',
        'AspectRatio cannot pick a width if maxWidth is infinite. The '
            'usual fix is Expanded (in a Row) or a SizedBox(width: ...) '
            'wrapper. In a Column, FractionallySizedBox(heightFactor:) '
            'works as the dual.',
        _kAccentViolet,
      ),
      _pitfall(
        'CB',
        'ConstrainedBox != SizedBox',
        'SizedBox forces a single fixed Size. ConstrainedBox tightens '
            'the incoming envelope but the child can still shrink. Reach '
            'for SizedBox when you really want one number; reach for '
            'ConstrainedBox when you want a range.',
        _kAccentGreen,
      ),
      _pitfall(
        'IH',
        'IntrinsicHeight is O(N^2)',
        'IntrinsicHeight probes every child for its intrinsic height '
            'before doing the real layout. In deep trees this multiplies '
            'cost; profile with the Flutter inspector before reaching for '
            'it in a hot list.',
        _kAccentTeal,
      ),
    ],
  );
}

// ===========================================================================
// SECTION 11 - CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
// Compact chip groups for the sizing surface area.
// ===========================================================================

Widget _chipGroup(String title, List<String> chips, Color colour) {
  final List<Widget> widgets = <Widget>[];
  for (int i = 0; i < chips.length; i++) {
    widgets.add(_pill(chips[i], colour: colour));
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: TextStyle(
            color: colour,
            fontSize: 11.0,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(spacing: 6.0, runSpacing: 6.0, children: widgets),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'A compact map of the rendering layer\'s sizing surface.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 12.0),
        _chipGroup('Constraint shapes', const <String>[
          'tight',
          'tightFor',
          'tightForFinite',
          'loose',
          'expand',
          'isTight',
          'isNormalized',
          'hasBoundedWidth',
          'hasBoundedHeight',
        ], _kAccentBlue),
        _chipGroup('Single-child sizing', const <String>[
          'ConstrainedBox',
          'LimitedBox',
          'UnconstrainedBox',
          'OverflowBox',
          'SizedOverflowBox',
          'FractionallySizedBox',
          'AspectRatio',
          'Baseline',
        ], _kAccentTeal),
        _chipGroup('Intrinsics', const <String>[
          'IntrinsicHeight',
          'IntrinsicWidth',
          'getMinIntrinsicWidth',
          'getMaxIntrinsicWidth',
          'getMinIntrinsicHeight',
          'getMaxIntrinsicHeight',
        ], _kAccent),
        _chipGroup('Sizes & corners', const <String>[
          'Size.zero',
          'Size.infinite',
          'Size.square',
          'Size.fromRadius',
          'Size.fromWidth',
          'Size.fromHeight',
          'topLeft',
          'bottomRight',
        ], _kAccentAmber),
        _chipGroup('Combinators', const <String>[
          'BoxConstraints.tighten',
          'BoxConstraints.loosen',
          'BoxConstraints.enforce',
          'BoxConstraints.deflate',
          'BoxConstraints.copyWith',
          'BoxConstraints.constrain',
        ], _kAccentRose),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All "state" is local;
// nothing schedules a frame because there is no second build pass.
// ===========================================================================
dynamic build(BuildContext context) {
  print('RenderObject sizing deep visual demo: building widget tree');

  // BoxConstraints samples that the demo references in text but does not
  // bind into the tree. They illustrate the constructor surface.
  const BoxConstraints tight =
      BoxConstraints.tightFor(width: 120.0, height: 40.0);
  const BoxConstraints loose =
      BoxConstraints(maxWidth: 200.0, maxHeight: 60.0);
  const BoxConstraints expand = BoxConstraints.expand();
  print('tight.isTight=${tight.isTight}');
  print('loose.maxWidth=${loose.maxWidth}');
  print('expand.hasBoundedHeight=${expand.hasBoundedHeight}');
  print('kDebugMode=$kDebugMode');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Section 1
          _heroBanner(),
          _sectionHeader(1, 'The box layout contract',
              'Constraints flow down, sizes flow up. That is the whole protocol.'),
          _heroIntroCard(),
          _sectionDivider(),

          // Section 2
          _sectionHeader(2, 'Constraints flow diagram',
              'Blue arrows: constraints down. Teal arrows: size up.'),
          _flowDiagramSection(),
          _sectionDivider(),

          // Section 3
          _sectionHeader(3, 'AspectRatio gallery',
              '16:9, 4:3, 1:1 and 9:16 - the four ratios you will meet most.'),
          _aspectRatioSection(),
          _sectionDivider(),

          // Section 4
          _sectionHeader(4, 'Constraint primitives',
              'BoxConstraints constructors and the render objects behind them.'),
          _constraintsTourSection(),
          _constrainedRenderRow(),
          _sectionDivider(),

          // Section 5
          _sectionHeader(5, 'The OverflowBox family',
              'Three render objects that let a child grow past its parent.'),
          _overflowSampleGrid(),
          _fractionalGrid(),
          _sectionDivider(),

          // Section 6
          _sectionHeader(6, 'Intrinsic worked example',
              'Before/after for IntrinsicHeight and IntrinsicWidth.'),
          _intrinsicSection(),
          _sectionDivider(),

          // Section 7
          _sectionHeader(7, 'RenderBaseline',
              'Align children by typographic baseline.'),
          _baselineSection(),
          _sectionDivider(),

          // Section 8
          _sectionHeader(8, 'Sizing comparison matrix',
              'Eleven render objects on four axes.'),
          _matrixSection(),
          _sectionDivider(),

          // Section 9
          _sectionHeader(9, 'Recipe cards',
              'Six idiomatic snippets to copy-paste with confidence.'),
          _recipesSection(),
          _sectionDivider(),

          // Section 10
          _sectionHeader(10, 'Pitfalls',
              'Six callouts about loose/tight, unbounded, intrinsics and more.'),
          _pitfallsSection(),
          _sectionDivider(),

          // Section 11
          _sectionHeader(11, 'Cheat-sheet',
              'A compact map of the rendering layer\'s sizing surface.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
