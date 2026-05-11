// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_import, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt deep visual demo: InputBorder and its concrete subclasses in
// `package:flutter/material.dart`.
//
// This file is a hand-authored corpus entry that exercises the InputBorder
// surface area: `InputBorder` (the abstract base, plus the
// `InputBorder.none` sentinel), `OutlineInputBorder`, `UnderlineInputBorder`,
// `BorderSide`, `BorderRadius`, the `gapPadding` parameter, and the
// `InputDecoration` / `InputDecorationTheme` glue. It renders a fully styled,
// scrollable poster — section banners with gradients, anatomy diagrams via a
// `CustomPainter`, state-matrix tables, gallery grids of `TextField` widgets
// in every interesting border configuration, theming cards and code-snippet
// boxes.
//
// The demo is 100% static: no `setState`, no `Timer`, no `Future`, no
// `AnimationController`. Every `TextField` is disabled or uses a fixed
// `TextEditingController` to keep the visual frozen so the corpus runner can
// snapshot it reliably.

import 'dart:math' as math;
import 'dart:ui' show PathMetric;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ─────────────────────────────────────────────────────────────────────────
// Painter: anatomy diagram of an OutlineInputBorder with gap padding around
// a floating label. Draws the rounded rectangle border, a stylised floating
// label sitting in the top edge, gapPadding markers on either side of it,
// and labelled vertices.
// ─────────────────────────────────────────────────────────────────────────
class _OutlineAnatomyPainter extends CustomPainter {
  const _OutlineAnatomyPainter({
    required this.frameColor,
    required this.labelColor,
    required this.gapColor,
    required this.annotationColor,
  });

  final Color frameColor;
  final Color labelColor;
  final Color gapColor;
  final Color annotationColor;

  @override
  void paint(Canvas canvas, Size size) {
    const double inset = 18.0;
    const double radius = 12.0;
    const double labelGap = 90.0;
    const double labelStart = 36.0;
    const double labelHeight = 14.0;

    final Rect frame =
        Rect.fromLTWH(inset, inset, size.width - inset * 2, size.height - inset * 2);
    final RRect frameR = RRect.fromRectAndRadius(frame, const Radius.circular(radius));

    final Paint framePaint = Paint()
      ..color = frameColor
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;

    // Build a path that has the gap removed from the top edge.
    final Path framePath = Path()..addRRect(frameR);
    final Rect gapRect = Rect.fromLTWH(
      frame.left + labelStart - 4,
      frame.top - 6,
      labelGap + 8,
      12,
    );
    final Path gapClear = Path()..addRect(gapRect);
    final Path drawn = Path.combine(PathOperation.difference, framePath, gapClear);
    canvas.drawPath(drawn, framePaint);

    // Floating label rect.
    final Rect labelRect = Rect.fromLTWH(
      frame.left + labelStart,
      frame.top - labelHeight / 2,
      labelGap,
      labelHeight,
    );
    final Paint labelBg = Paint()..color = Colors.white;
    canvas.drawRect(labelRect, labelBg);

    final TextPainter labelTp = TextPainter(
      text: TextSpan(
        text: 'floating label',
        style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    );
    labelTp.layout(maxWidth: labelGap);
    labelTp.paint(canvas, Offset(labelRect.left + 4, labelRect.top + 1));

    // gapPadding annotations on each side of the label.
    final Paint gapPaint = Paint()
      ..color = gapColor
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(labelRect.left - 6, frame.top),
      Offset(labelRect.left, frame.top),
      gapPaint,
    );
    canvas.drawLine(
      Offset(labelRect.right, frame.top),
      Offset(labelRect.right + 6, frame.top),
      gapPaint,
    );

    // Annotated vertices.
    final List<Offset> corners = <Offset>[
      frame.topLeft + const Offset(radius, 0),
      frame.topRight + const Offset(-radius, 0),
      frame.bottomLeft + const Offset(radius, 0),
      frame.bottomRight + const Offset(-radius, 0),
    ];
    final List<String> cornerLabels = <String>['TL', 'TR', 'BL', 'BR'];
    final Paint dot = Paint()..color = annotationColor;
    for (int i = 0; i < corners.length; i++) {
      canvas.drawCircle(corners[i], 3.4, dot);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: cornerLabels[i],
          style: TextStyle(color: annotationColor, fontSize: 10, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      final double dx = (i.isEven) ? -tp.width - 6 : 6;
      final double dy = (i < 2) ? -tp.height - 4 : 4;
      tp.paint(canvas, corners[i] + Offset(dx, dy));
    }

    // gapPadding callout text.
    final TextPainter gapTp = TextPainter(
      text: TextSpan(
        text: 'gapPadding',
        style: TextStyle(color: gapColor, fontSize: 10, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    );
    gapTp.layout();
    gapTp.paint(canvas, Offset(labelRect.center.dx - gapTp.width / 2, frame.top - 22));
  }

  @override
  bool shouldRepaint(covariant _OutlineAnatomyPainter old) {
    return old.frameColor != frameColor ||
        old.labelColor != labelColor ||
        old.gapColor != gapColor ||
        old.annotationColor != annotationColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: mimic a dashed border for an InputBorder slot using a series of
// short segments. Used to show how to fake a "dashed" feel even though
// `OutlineInputBorder` does not expose a dash pattern.
// ─────────────────────────────────────────────────────────────────────────
class _DashedFramePainter extends CustomPainter {
  const _DashedFramePainter({
    required this.color,
    this.dashWidth = 6.0,
    this.dashGap = 4.0,
    this.radius = 8.0,
    this.strokeWidth = 1.6,
  });

  final Color color;
  final double dashWidth;
  final double dashGap;
  final double radius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final Path framePath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));
    for (final PathMetric metric in framePath.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = math.min(distance + dashWidth, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedFramePainter old) {
    return old.color != color ||
        old.dashWidth != dashWidth ||
        old.dashGap != dashGap ||
        old.radius != radius ||
        old.strokeWidth != strokeWidth;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: stack-rank diagram of InputBorder subclasses. Shows the abstract
// `InputBorder` at the top forking into `OutlineInputBorder`,
// `UnderlineInputBorder`, and the `InputBorder.none` sentinel.
// ─────────────────────────────────────────────────────────────────────────
class _BorderHierarchyPainter extends CustomPainter {
  const _BorderHierarchyPainter({
    required this.boxColor,
    required this.edgeColor,
    required this.textColor,
  });

  final Color boxColor;
  final Color edgeColor;
  final Color textColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxPaint = Paint()..color = boxColor;
    final Paint edgePaint = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    void drawBox(Rect r, String label) {
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
      canvas.drawRRect(rr, boxPaint);
      canvas.drawRRect(rr, edgePaint);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: textColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: r.width - 8);
      tp.paint(canvas, Offset(r.left + (r.width - tp.width) / 2, r.top + (r.height - tp.height) / 2));
    }

    final double centerX = size.width / 2;
    final Rect parent = Rect.fromCenter(center: Offset(centerX, 22), width: 200, height: 32);
    drawBox(parent, 'InputBorder (abstract)');

    final double childY = 96;
    final double childW = (size.width - 32) / 3;
    final Rect c1 = Rect.fromLTWH(8, childY, childW, 32);
    final Rect c2 = Rect.fromLTWH(16 + childW, childY, childW, 32);
    final Rect c3 = Rect.fromLTWH(24 + childW * 2, childY, childW, 32);
    drawBox(c1, 'OutlineInputBorder');
    drawBox(c2, 'UnderlineInputBorder');
    drawBox(c3, 'InputBorder.none');

    for (final Rect r in <Rect>[c1, c2, c3]) {
      canvas.drawLine(
        Offset(centerX, parent.bottom),
        Offset(r.center.dx, r.top),
        edgePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BorderHierarchyPainter old) {
    return old.boxColor != boxColor ||
        old.edgeColor != edgeColor ||
        old.textColor != textColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Top-level harness.
// ─────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ─── Palette: indigo / teal / slate ───
  const Color indigo = Color(0xFF4338CA);
  const Color indigoDeep = Color(0xFF312E81);
  const Color indigoLight = Color(0xFFE0E7FF);
  const Color teal = Color(0xFF0D9488);
  const Color tealDeep = Color(0xFF134E4A);
  const Color tealLight = Color(0xFFCCFBF1);
  const Color slate = Color(0xFF334155);
  const Color slateDeep = Color(0xFF0F172A);
  const Color slateLight = Color(0xFFE2E8F0);
  const Color paper = Color(0xFFF8FAFC);
  const Color rose = Color(0xFFE11D48);
  const Color roseLight = Color(0xFFFFE4E6);
  const Color amber = Color(0xFFD97706);
  const Color amberLight = Color(0xFFFEF3C7);
  const Color disabledGray = Color(0xFF94A3B8);

  print('===== INPUT BORDERS DEEP VISUAL DEMO =====');

  // ─── Reusable text editing controllers (static content) ───
  final TextEditingController emptyCtrl = TextEditingController(text: '');
  final TextEditingController helloCtrl = TextEditingController(text: 'Hello, world');
  final TextEditingController emailCtrl = TextEditingController(text: 'alex@example.org');
  final TextEditingController errorCtrl = TextEditingController(text: 'not-an-email');
  final TextEditingController focusedCtrl = TextEditingController(text: 'pretend-focused');
  final TextEditingController numbersCtrl = TextEditingController(text: '12 34 56');
  final TextEditingController longCtrl = TextEditingController(text: 'A longer pre-filled sentence');

  // ─── Borders constructed up front so they can be reused ───
  const InputBorder noBorder = InputBorder.none;
  const UnderlineInputBorder defaultUnderline = UnderlineInputBorder();
  const UnderlineInputBorder thickUnderline = UnderlineInputBorder(
    borderSide: BorderSide(color: indigo, width: 2.4),
  );
  const UnderlineInputBorder roseUnderline = UnderlineInputBorder(
    borderSide: BorderSide(color: rose, width: 1.6),
  );
  const UnderlineInputBorder hairlineUnderline = UnderlineInputBorder(
    borderSide: BorderSide(color: slate, width: 0.5),
  );
  final OutlineInputBorder defaultOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
  );
  final OutlineInputBorder roundedOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: indigo, width: 1.4),
    gapPadding: 4.0,
  );
  final OutlineInputBorder stadiumOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
    borderSide: const BorderSide(color: teal, width: 1.6),
    gapPadding: 6.0,
  );
  const OutlineInputBorder cornerOutline = OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    ),
    borderSide: BorderSide(color: indigoDeep, width: 1.4),
  );
  const OutlineInputBorder heavyOutline = OutlineInputBorder(
    borderSide: BorderSide(color: slateDeep, width: 3.2),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    gapPadding: 8.0,
  );
  const OutlineInputBorder hairlineOutline = OutlineInputBorder(
    borderSide: BorderSide(color: slate, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  );
  const OutlineInputBorder errorOutline = OutlineInputBorder(
    borderSide: BorderSide(color: rose, width: 1.6),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  );
  const OutlineInputBorder disabledOutline = OutlineInputBorder(
    borderSide: BorderSide(color: disabledGray, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  );
  const OutlineInputBorder focusedOutline = OutlineInputBorder(
    borderSide: BorderSide(color: indigo, width: 2.4),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    gapPadding: 4.0,
  );

  print('Outline gapPadding: ${roundedOutline.gapPadding}');
  print('Outline radius:    ${roundedOutline.borderRadius}');
  print('Underline side:    ${thickUnderline.borderSide}');
  print('InputBorder.none:  $noBorder');

  // ─── Local widget helpers ───────────────────────────────────────────────

  Widget sectionBanner(String number, String title, List<Color> gradient) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 28, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.45),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.18),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.55),
                width: 1.4,
              ),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget proseBox(String text, {Color? bg, Color? border}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg ?? paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border ?? slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: indigo.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          height: 1.55,
          color: slateDeep.withValues(alpha: 0.92),
        ),
      ),
    );
  }

  Widget infoCard(String heading, Widget content,
      {List<Color>? headerGradient, Color? bodyColor}) {
    final List<Color> gradient = headerGradient ?? <Color>[indigoDeep, indigo];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bodyColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.07),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.10),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              heading,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14), child: content),
        ],
      ),
    );
  }

  Widget dataRow(String label, String value, {Color? labelColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: labelColor ?? slateDeep,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12, color: slate),
            ),
          ),
        ],
      ),
    );
  }

  Widget chipTag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: bg.withValues(alpha: 0.30),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }

  Widget codeSnippetCard(String title, String code, {Color? accent}) {
    final Color a = accent ?? teal;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: slateDeep,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: a.withValues(alpha: 0.18),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: a.withValues(alpha: 0.20),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFB7185),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCD34D),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34D399),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12,
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Wraps a styled field in a card with a heading and an explanatory note.
  Widget galleryEntry({
    required String title,
    required String note,
    required Widget field,
    List<Color>? headerGradient,
    Color? bodyColor,
  }) {
    final List<Color> gradient = headerGradient ?? <Color>[indigo, teal];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bodyColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                field,
                const SizedBox(height: 8),
                Text(
                  note,
                  style: TextStyle(fontSize: 11, color: slate, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Section 1 — Intro: what is an InputBorder?
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 1] Intro');

  final Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '01',
        'What is an InputBorder?',
        const <Color>[indigoDeep, indigo],
      ),
      proseBox(
        '`InputBorder` is the abstract base class for the rectangular border '
        'that frames the inner content of any Material text input. It extends '
        '`ShapeBorder`, which is why it can paint along arbitrary paths, and '
        'it adds one extra piece of state: the ability to leave a gap in the '
        'top edge for a floating label to sit in. There are exactly two '
        'concrete subclasses you will use day to day — `OutlineInputBorder` '
        'and `UnderlineInputBorder` — plus the `InputBorder.none` sentinel '
        'that disables the border entirely.',
      ),
      proseBox(
        '`InputDecoration` exposes five border slots: `border`, `enabledBorder`, '
        '`focusedBorder`, `errorBorder`, and `disabledBorder` (with a focused '
        'sibling for error states). Material picks the right one based on the '
        'field\'s focus, enabled, and error state and feeds it into the '
        'underlying `InputDecorator` widget. Forgetting to set the matching '
        '`focusedBorder` when you customise `enabledBorder` is the single '
        'most common mistake — the field appears to "snap back" to defaults '
        'when the user taps it.',
      ),
      infoCard(
        'Core InputBorder API',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('InputBorder', 'abstract; extends ShapeBorder'),
            dataRow('InputBorder.none', 'sentinel — paints nothing'),
            dataRow('OutlineInputBorder', 'rounded rect with optional label gap'),
            dataRow('UnderlineInputBorder', 'single bottom line, optional top radii'),
            dataRow('borderSide', 'BorderSide(color,width,style)'),
            dataRow('borderRadius', 'BorderRadius for the corners'),
            dataRow('gapPadding', 'padding around the floating label'),
            dataRow('isOutline', 'true for OutlineInputBorder, false for Underline'),
          ],
        ),
        headerGradient: const <Color>[indigoDeep, indigo],
      ),
      Container(
        width: double.infinity,
        height: 160,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: paper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
        ),
        child: CustomPaint(
          painter: _BorderHierarchyPainter(
            boxColor: indigoLight,
            edgeColor: indigoDeep,
            textColor: indigoDeep,
          ),
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 2 — Anatomy of an OutlineInputBorder.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 2] Anatomy');

  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '02',
        'Anatomy of an OutlineInputBorder',
        const <Color>[indigo, teal],
      ),
      proseBox(
        'The diagram below renders an `OutlineInputBorder` with a floating '
        'label cut out of the top edge. The corner radii are labelled (TL, TR, '
        'BL, BR), and the small ticks on either side of the label illustrate '
        'how `gapPadding` adds extra clear space around the label so that the '
        'character glyphs do not touch the stroke. Internally, Flutter builds '
        'the top-edge path by walking from TL clockwise to the gap, lifting '
        'the pen, jumping over the label region, and continuing toward TR.',
      ),
      Container(
        width: double.infinity,
        height: 220,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[paper, indigoLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: indigo.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CustomPaint(
          painter: _OutlineAnatomyPainter(
            frameColor: indigoDeep,
            labelColor: indigoDeep,
            gapColor: teal,
            annotationColor: rose,
          ),
        ),
      ),
      infoCard(
        'Geometry summary',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('top edge', 'starts at TL+r, ends at TR-r'),
            dataRow('label gap', 'cleared region in top stroke'),
            dataRow('gapPadding (px)', 'each side of label, default 4.0'),
            dataRow('floating label sits', 'centered vertically on the top edge'),
            dataRow('paint order', 'fill first, then stroke, then label'),
            dataRow('hit testing', 'inherits from ShapeBorder via getOuterPath'),
          ],
        ),
        headerGradient: const <Color>[teal, indigo],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 3 — Gallery grid: every interesting variant.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 3] Gallery grid');

  Widget makeField({
    required String label,
    required String hint,
    required InputBorder border,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? disabledBorder,
    String? errorText,
    bool enabled = true,
    bool filled = false,
    Color? fillColor,
    TextEditingController? controller,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller ?? emptyCtrl,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        filled: filled,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        disabledBorder: disabledBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '03',
        'Gallery — Every Interesting Variant',
        const <Color>[teal, indigo],
      ),
      proseBox(
        'Each card below isolates one configuration so you can see exactly '
        'which knob produces which visual. The text shown is static; an '
        '`enabled: false` field with a controller is more reliable for a '
        'corpus snapshot than relying on focus. The note under each field '
        'explains the parameters that matter.',
      ),
      galleryEntry(
        title: 'InputBorder.none',
        note: 'No painted border at all. Useful inside a Card or Container '
            'where the parent already provides visual containment, or when '
            'you want a search field that looks like a plain label.',
        field: makeField(
          label: 'No border',
          hint: 'type a query',
          border: noBorder,
          controller: emptyCtrl,
          enabled: false,
        ),
        headerGradient: const <Color>[slate, slateDeep],
      ),
      galleryEntry(
        title: 'Default underline (no override)',
        note: 'Omitting `border` entirely yields the Material default, a thin '
            'underline that grows to the theme primary colour when focused. '
            'This is what almost every TextField in Material apps looks like.',
        field: makeField(
          label: 'Default',
          hint: 'no border override',
          border: defaultUnderline,
          controller: helloCtrl,
          enabled: false,
        ),
      ),
      galleryEntry(
        title: 'UnderlineInputBorder with custom BorderSide',
        note: 'A custom colour and thickness on the bottom edge. The other '
            'three edges stay invisible. Useful for chat composers or rows '
            'of inline editors.',
        field: makeField(
          label: 'Thick underline',
          hint: 'BorderSide(color: indigo, width: 2.4)',
          border: thickUnderline,
          controller: helloCtrl,
          enabled: false,
        ),
        headerGradient: const <Color>[indigoDeep, indigo],
      ),
      galleryEntry(
        title: 'OutlineInputBorder, default radius (r=4)',
        note: 'The plain rounded outline you get from `OutlineInputBorder()` '
            'with no parameters: 4-pixel corner radius, 1-pixel stroke.',
        field: makeField(
          label: 'Outline',
          hint: 'OutlineInputBorder()',
          border: defaultOutline,
          controller: helloCtrl,
          enabled: false,
        ),
      ),
      galleryEntry(
        title: 'OutlineInputBorder with circular radius',
        note: 'A 12-pixel radius gives a friendlier shape. Pair the radius '
            'with a slightly larger `gapPadding` so the label clears the '
            'curve cleanly.',
        field: makeField(
          label: 'Rounded outline',
          hint: 'radius 12, gap 4',
          border: roundedOutline,
          controller: helloCtrl,
          enabled: false,
        ),
        headerGradient: const <Color>[indigo, teal],
      ),
      galleryEntry(
        title: 'OutlineInputBorder, stadium shape',
        note: 'A very large radius (≥ field height / 2) flattens into a pill. '
            'When stadium fields are used, set the radius to a constant that '
            '\u2265 28 to make sure short and tall fields look identical.',
        field: makeField(
          label: 'Stadium',
          hint: 'radius 32',
          border: stadiumOutline,
          controller: emailCtrl,
          enabled: false,
          prefixIcon: const Icon(Icons.search),
        ),
        headerGradient: const <Color>[teal, tealDeep],
      ),
      galleryEntry(
        title: 'OutlineInputBorder with specific corners',
        note: 'BorderRadius.only(topLeft: …, bottomRight: …) yields '
            'asymmetric corners. Use this sparingly; it is most often seen in '
            'chat bubbles, where one corner matches the avatar position.',
        field: makeField(
          label: 'Mixed corners',
          hint: 'tl + br rounded',
          border: cornerOutline,
          controller: longCtrl,
          enabled: false,
        ),
      ),
      galleryEntry(
        title: 'Heavy weight outline (BorderSide width 3.2)',
        note: 'A bold stroke is sometimes used to indicate the primary input '
            'on a form. Keep `gapPadding` larger so the floating label still '
            'has breathing room (here 8.0).',
        field: makeField(
          label: 'Heavy',
          hint: 'width 3.2',
          border: heavyOutline,
          controller: helloCtrl,
          enabled: false,
        ),
        headerGradient: const <Color>[slateDeep, indigoDeep],
      ),
      galleryEntry(
        title: 'Hairline outline (BorderSide width 0.5)',
        note: 'A 0.5-pixel stroke produces a subtle, document-style edge. On '
            'high-DPI screens this still resolves to a single physical pixel.',
        field: makeField(
          label: 'Hairline',
          hint: 'width 0.5',
          border: hairlineOutline,
          controller: helloCtrl,
          enabled: false,
        ),
      ),
      galleryEntry(
        title: 'Hairline underline (BorderSide width 0.5)',
        note: 'The hairline trick applies to UnderlineInputBorder too. Pair '
            'it with a muted grey to evoke a printed form.',
        field: makeField(
          label: 'Hairline underline',
          hint: 'width 0.5, slate grey',
          border: hairlineUnderline,
          controller: helloCtrl,
          enabled: false,
        ),
      ),
      galleryEntry(
        title: 'Dashed-feel border (CustomPainter overlay)',
        note: '`OutlineInputBorder` does not expose a dash pattern, so to '
            'fake one we paint a dashed rectangle behind the field and set '
            '`InputBorder.none`. The painter walks `Path.computeMetrics()` '
            'and stamps `dashWidth` segments separated by `dashGap`.',
        field: SizedBox(
          height: 56,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(
                  painter: const _DashedFramePainter(color: teal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: makeField(
                  label: 'Dashed',
                  hint: 'mimic via painter',
                  border: noBorder,
                  controller: helloCtrl,
                  enabled: false,
                ),
              ),
            ],
          ),
        ),
        headerGradient: const <Color>[teal, indigo],
      ),
      galleryEntry(
        title: 'Error state (red border)',
        note: 'When `errorText` is non-null, Material uses `errorBorder` (or '
            'falls back to the default error colour from `ColorScheme`). The '
            'helper text below the field flips red automatically.',
        field: makeField(
          label: 'Email',
          hint: 'must be an email',
          border: errorOutline,
          errorBorder: errorOutline,
          controller: errorCtrl,
          enabled: true,
          errorText: 'Not a valid email address',
          prefixIcon: const Icon(Icons.error, color: rose),
        ),
        headerGradient: const <Color>[rose, indigoDeep],
      ),
      galleryEntry(
        title: 'Disabled state (gray dim border)',
        note: 'Setting `enabled: false` swaps to `disabledBorder` and dims '
            'the label/text colours. Always provide a `disabledBorder` if '
            'you have customised the enabled one — Material will not invent '
            'one for you.',
        field: makeField(
          label: 'Disabled',
          hint: 'cannot edit',
          border: disabledOutline,
          disabledBorder: disabledOutline,
          controller: helloCtrl,
          enabled: false,
        ),
        headerGradient: const <Color>[disabledGray, slate],
      ),
      galleryEntry(
        title: 'Focused state (primary colour, width 2.4)',
        note: 'We cannot actually focus a field in a static demo, but this '
            'card shows the visual you would get: an outline matching '
            '`focusedBorder`. Note `gapPadding` should match between '
            '`enabledBorder` and `focusedBorder`, or the label will jump '
            'when the field is tapped.',
        field: makeField(
          label: 'Looks focused',
          hint: 'static preview',
          border: focusedOutline,
          enabledBorder: focusedOutline,
          controller: focusedCtrl,
          enabled: false,
        ),
        headerGradient: const <Color>[indigo, teal],
      ),
      galleryEntry(
        title: 'Filled + UnderlineInputBorder',
        note: 'Setting `filled: true` adds a fill colour underneath the '
            'border. UnderlineInputBorder is a classic match because the '
            'fill substitutes for the missing top/left/right strokes.',
        field: makeField(
          label: 'Filled underline',
          hint: 'classic Material look',
          border: roseUnderline,
          controller: helloCtrl,
          enabled: false,
          filled: true,
          fillColor: roseLight,
        ),
        headerGradient: const <Color>[rose, amber],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 4 — State matrix table.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 4] State matrix');

  Widget matrixCell(InputBorder border, {bool enabled = true, String? errorText}) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: SizedBox(
        height: 56,
        child: TextField(
          controller: helloCtrl,
          enabled: enabled,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'sample',
            errorText: errorText,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            disabledBorder: border,
            errorBorder: border,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          ),
        ),
      ),
    );
  }

  TableRow matrixRow(String label, Color color, Widget outlineCell, Widget underlineCell) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        outlineCell,
        underlineCell,
      ],
    );
  }

  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '04',
        'State Matrix — Outline vs Underline',
        const <Color>[indigoDeep, teal],
      ),
      proseBox(
        'The matrix shows the four important states of a TextField side by '
        'side, with one column per concrete `InputBorder` subclass. Read it '
        'top-to-bottom to confirm that your border choices read correctly '
        'across states — most regression bugs in Material forms come from '
        'one cell in this matrix looking subtly different from the others.',
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
            },
            border: TableBorder.all(color: slateLight),
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: indigoLight),
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'state',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: indigoDeep,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'OutlineInputBorder',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: indigoDeep,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'UnderlineInputBorder',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: indigoDeep,
                      ),
                    ),
                  ),
                ],
              ),
              matrixRow(
                'enabled',
                indigoDeep,
                matrixCell(hairlineOutline, enabled: true),
                matrixCell(defaultUnderline, enabled: true),
              ),
              matrixRow(
                'focused',
                indigo,
                matrixCell(focusedOutline, enabled: true),
                matrixCell(thickUnderline, enabled: true),
              ),
              matrixRow(
                'disabled',
                disabledGray,
                matrixCell(disabledOutline, enabled: false),
                matrixCell(hairlineUnderline, enabled: false),
              ),
              matrixRow(
                'errored',
                rose,
                matrixCell(errorOutline, enabled: true, errorText: 'bad'),
                matrixCell(roseUnderline, enabled: true, errorText: 'bad'),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 5 — InputDecorationTheme wiring.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 5] Theming');

  final InputDecorationTheme themedDecoration = InputDecorationTheme(
    border: roundedOutline,
    enabledBorder: roundedOutline,
    focusedBorder: focusedOutline,
    errorBorder: errorOutline,
    disabledBorder: disabledOutline,
    labelStyle: const TextStyle(color: indigoDeep),
    hintStyle: TextStyle(color: slate.withValues(alpha: 0.6)),
    errorStyle: const TextStyle(color: rose, fontWeight: FontWeight.w600),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    filled: true,
    fillColor: indigoLight,
    focusColor: indigoLight,
    hoverColor: slateLight,
  );

  print('Theme border:        ${themedDecoration.border}');
  print('Theme focusedBorder: ${themedDecoration.focusedBorder}');
  print('Theme errorBorder:   ${themedDecoration.errorBorder}');

  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '05',
        'InputDecorationTheme — Plumb It Globally',
        const <Color>[teal, indigoDeep],
      ),
      proseBox(
        'Setting borders per field is fine for one-off cases, but once you '
        'have more than three or four inputs you should hoist the borders '
        'into an `InputDecorationTheme` on `ThemeData`. Every `TextField`, '
        '`TextFormField`, and `DropdownButtonFormField` then inherits the '
        'theme unless it overrides a specific slot. This keeps the focus, '
        'error, and disabled visuals aligned across an entire screen.',
      ),
      infoCard(
        'themedDecoration — values',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('border', 'roundedOutline (radius 12)'),
            dataRow('enabledBorder', 'roundedOutline'),
            dataRow('focusedBorder', 'focusedOutline (indigo, w=2.4)'),
            dataRow('errorBorder', 'errorOutline (rose)'),
            dataRow('disabledBorder', 'disabledOutline (gray)'),
            dataRow('floatingLabelBehavior', 'auto'),
            dataRow('floatingLabelAlignment', 'start'),
            dataRow('filled / fillColor', 'true / indigoLight'),
            dataRow('contentPadding', 'h12 v10'),
          ],
        ),
        headerGradient: const <Color>[indigo, teal],
      ),
      infoCard(
        'Themed fields preview',
        Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: indigoDeep),
            inputDecorationTheme: themedDecoration,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: helloCtrl,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Themed enabled',
                  hintText: 'inherits everything',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailCtrl,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Themed with icon',
                  hintText: 'auto-applies theme',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: errorCtrl,
                decoration: const InputDecoration(
                  labelText: 'Themed errored',
                  hintText: 'errorText triggers errorBorder',
                  errorText: 'inherited error styling',
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Themed disabled',
                  hintText: 'inherits disabledBorder',
                ),
              ),
            ],
          ),
        ),
        headerGradient: const <Color>[teal, tealDeep],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 6 — Code snippets.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 6] Code snippets');

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '06',
        'Code Snippets — Common Setups',
        const <Color>[indigo, rose],
      ),
      proseBox(
        'Three patterns cover 90% of real apps: an outline form, an underline '
        'composer, and a theme-driven application. Copy these as starting '
        'points and customise the radii, weights, and colours to match your '
        'visual language.',
      ),
      codeSnippetCard(
        'outline_form.dart',
        '// Outline field with explicit state borders.\n'
        'TextField(\n'
        '  decoration: InputDecoration(\n'
        '    labelText: \'Email\',\n'
        '    hintText: \'you@example.com\',\n'
        '    border: OutlineInputBorder(\n'
        '      borderRadius: BorderRadius.circular(12),\n'
        '      borderSide: BorderSide(color: Colors.indigo, width: 1.4),\n'
        '      gapPadding: 4,\n'
        '    ),\n'
        '    focusedBorder: OutlineInputBorder(\n'
        '      borderRadius: BorderRadius.circular(12),\n'
        '      borderSide: BorderSide(color: Colors.indigo, width: 2.4),\n'
        '      gapPadding: 4,\n'
        '    ),\n'
        '    errorBorder: OutlineInputBorder(\n'
        '      borderRadius: BorderRadius.circular(12),\n'
        '      borderSide: BorderSide(color: Colors.red, width: 1.6),\n'
        '    ),\n'
        '    disabledBorder: OutlineInputBorder(\n'
        '      borderRadius: BorderRadius.circular(12),\n'
        '      borderSide: BorderSide(color: Colors.grey, width: 1.0),\n'
        '    ),\n'
        '  ),\n'
        ');\n',
        accent: indigo,
      ),
      codeSnippetCard(
        'underline_composer.dart',
        '// Chat composer with only an underline that thickens on focus.\n'
        'TextField(\n'
        '  decoration: InputDecoration(\n'
        '    hintText: \'Type a message\',\n'
        '    border: UnderlineInputBorder(\n'
        '      borderSide: BorderSide(color: Colors.grey, width: 1.0),\n'
        '    ),\n'
        '    focusedBorder: UnderlineInputBorder(\n'
        '      borderSide: BorderSide(color: Colors.teal, width: 2.0),\n'
        '    ),\n'
        '    filled: true,\n'
        '    fillColor: Color(0xFFF1F5F9),\n'
        '  ),\n'
        ');\n',
        accent: teal,
      ),
      codeSnippetCard(
        'themed_app.dart',
        '// Hoist borders into ThemeData so every field inherits.\n'
        'MaterialApp(\n'
        '  theme: ThemeData(\n'
        '    inputDecorationTheme: InputDecorationTheme(\n'
        '      border: OutlineInputBorder(\n'
        '        borderRadius: BorderRadius.circular(12),\n'
        '      ),\n'
        '      focusedBorder: OutlineInputBorder(\n'
        '        borderRadius: BorderRadius.circular(12),\n'
        '        borderSide: BorderSide(color: Colors.indigo, width: 2.4),\n'
        '      ),\n'
        '      filled: true,\n'
        '      fillColor: Color(0xFFE0E7FF),\n'
        '      isDense: true,\n'
        '    ),\n'
        '  ),\n'
        '  home: const MyForm(),\n'
        ');\n',
        accent: rose,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 7 — Pitfalls.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 7] Pitfalls');

  Widget pitfallCard(String title, String body, List<Color> headerColors) {
    return infoCard(
      title,
      Text(
        body,
        style: TextStyle(
          fontSize: 12,
          height: 1.55,
          color: slateDeep.withValues(alpha: 0.92),
        ),
      ),
      headerGradient: headerColors,
    );
  }

  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '07',
        'Pitfalls — Things That Will Bite You',
        const <Color>[rose, indigoDeep],
      ),
      proseBox(
        'Six small mistakes are responsible for almost every "the border is '
        'wrong" bug. Each pitfall below is worth a code-review checklist '
        'item; together they catch the majority of regressions when designers '
        'tweak input styling.',
      ),
      pitfallCard(
        'Forgetting Material ancestor',
        'TextField uses ink wells and tooltip overlays internally. If you '
        'place a TextField outside a Material ancestor (for example, inside '
        'a raw Container that is not under a Scaffold), the border can '
        'render but selection and hover effects will be broken. Always wrap '
        'standalone fields in a `Material` widget with `type: '
        'MaterialType.transparency` if necessary.',
        const <Color>[rose, amber],
      ),
      pitfallCard(
        'gapPadding too small for the label',
        'When `floatingLabelBehavior` is `always` or the field has long '
        'label text, a tiny `gapPadding` (the default 4.0 is fine for short '
        'labels) lets the glyphs visually touch the stroke. Bump '
        '`gapPadding` to 6 or 8 if your labels are long or use bold weights.',
        const <Color>[amber, rose],
      ),
      pitfallCard(
        'BorderSide.none misuse',
        '`BorderSide.none` makes a side zero-width, but the rest of the '
        'border may still paint. To turn off the border entirely use '
        '`InputBorder.none`. To turn off just one side of an outline you '
        'cannot — `OutlineInputBorder` always paints all four sides.',
        const <Color>[indigoDeep, rose],
      ),
      pitfallCard(
        'Mismatched borderRadius between states',
        'If `enabledBorder` and `focusedBorder` have different '
        '`borderRadius` values, the field will visibly snap when focus '
        'changes. Always copy the same radius (or compose with '
        '`OutlineInputBorder.copyWith`) so the only thing that changes is '
        '`borderSide`.',
        const <Color>[indigo, teal],
      ),
      pitfallCard(
        'Missing disabledBorder',
        'If you customise `enabledBorder` but omit `disabledBorder`, the '
        'disabled state falls back to the theme default — which is a '
        'subtle grey underline regardless of how you styled the rest. '
        'Always supply a matching disabled border.',
        const <Color>[disabledGray, slate],
      ),
      pitfallCard(
        'Setting border but no enabledBorder',
        'The single `border` slot is a fallback for all states. The '
        'instant you set `enabledBorder`, `focusedBorder`, etc., the '
        '`border` value is ignored. A common bug is to spend an hour '
        'editing `border` while `enabledBorder` is set elsewhere — '
        'changes appear to have no effect.',
        const <Color>[slate, indigoDeep],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 8 — Glossary.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 8] Glossary');

  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '08',
        'Glossary — Quick Reference',
        const <Color>[indigoDeep, teal],
      ),
      proseBox(
        'A glossary of every type touched in this file. Definitions match '
        'the official dartdoc wording so readers can switch between this '
        'corpus entry and the SDK without seeing contradictions.',
      ),
      infoCard(
        'Definitions',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('InputBorder', 'abstract ShapeBorder with a label gap'),
            dataRow('OutlineInputBorder', 'rounded rectangle border'),
            dataRow('UnderlineInputBorder', 'bottom-edge-only border'),
            dataRow('InputBorder.none', 'sentinel for "no border at all"'),
            dataRow('BorderSide', '(color, width, style, strokeAlign)'),
            dataRow('BorderRadius', 'four Radii: tl, tr, bl, br'),
            dataRow('gapPadding', 'pixels of clear space around floating label'),
            dataRow('InputDecoration', 'value object passed to TextField'),
            dataRow('InputDecorationTheme', 'ThemeData-wide defaults'),
            dataRow('InputDecorator', 'private widget that paints the border'),
            dataRow('FloatingLabelBehavior', 'auto, always, never'),
            dataRow('FloatingLabelAlignment', 'start, center'),
          ],
        ),
        headerGradient: const <Color>[indigo, indigoDeep],
      ),
      Wrap(
        spacing: 6,
        runSpacing: 6,
        children: <Widget>[
          chipTag('InputBorder', indigoLight, indigoDeep),
          chipTag('OutlineInputBorder', indigoLight, indigoDeep),
          chipTag('UnderlineInputBorder', tealLight, tealDeep),
          chipTag('BorderSide', amberLight, amber),
          chipTag('BorderRadius', amberLight, amber),
          chipTag('gapPadding', tealLight, tealDeep),
          chipTag('InputDecoration', indigoLight, indigoDeep),
          chipTag('InputDecorationTheme', indigoLight, indigoDeep),
          chipTag('FloatingLabelBehavior', tealLight, tealDeep),
          chipTag('FloatingLabelAlignment', tealLight, tealDeep),
          chipTag('InputBorder.none', roseLight, rose),
        ],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 9 — Cheat sheet.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 9] Cheat sheet');

  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '09',
        'Cheat Sheet — Pick The Right Border',
        const <Color>[teal, indigo],
      ),
      proseBox(
        'When you sit down to wire a new form, scan the cheat sheet first. '
        'It maps a one-line intent ("I want a chat composer") to the '
        'concrete `InputBorder` recipe that matches. Each recipe lists the '
        'three knobs you actually care about — radius, side, and gapPadding '
        '— while everything else falls back to Material defaults.',
      ),
      infoCard(
        'Intent → recipe',
        DataTable(
          headingRowColor: WidgetStateProperty.all(indigoLight),
          columnSpacing: 18,
          headingTextStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: indigoDeep,
          ),
          dataTextStyle: const TextStyle(fontSize: 11, color: slateDeep),
          columns: const <DataColumn>[
            DataColumn(label: Text('intent')),
            DataColumn(label: Text('subclass')),
            DataColumn(label: Text('radius')),
            DataColumn(label: Text('width')),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Material default form')),
              DataCell(Text('Underline')),
              DataCell(Text('—')),
              DataCell(Text('1.0')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Modern card form')),
              DataCell(Text('Outline')),
              DataCell(Text('12')),
              DataCell(Text('1.4')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Search bar')),
              DataCell(Text('Outline')),
              DataCell(Text('32 (stadium)')),
              DataCell(Text('1.6')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Chat composer')),
              DataCell(Text('Underline + filled')),
              DataCell(Text('—')),
              DataCell(Text('1.0')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Plain inline edit')),
              DataCell(Text('InputBorder.none')),
              DataCell(Text('—')),
              DataCell(Text('0')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Bold primary field')),
              DataCell(Text('Outline (heavy)')),
              DataCell(Text('6')),
              DataCell(Text('3.2')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Document-style entry')),
              DataCell(Text('Outline (hairline)')),
              DataCell(Text('6')),
              DataCell(Text('0.5')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Asymmetric chat bubble field')),
              DataCell(Text('Outline (corner radii)')),
              DataCell(Text('16 tl/br')),
              DataCell(Text('1.4')),
            ]),
          ],
        ),
        headerGradient: const <Color>[indigo, teal],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 10 — copyWith showcase.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 10] copyWith');

  final OutlineInputBorder baseOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: slate, width: 1.0),
    gapPadding: 4.0,
  );
  final OutlineInputBorder copyFocused = baseOutline.copyWith(
    borderSide: const BorderSide(color: indigo, width: 2.4),
  );
  final OutlineInputBorder copyError = baseOutline.copyWith(
    borderSide: const BorderSide(color: rose, width: 1.6),
  );
  final OutlineInputBorder copyDisabled = baseOutline.copyWith(
    borderSide: const BorderSide(color: disabledGray, width: 1.0),
  );

  print('copyFocused side:  ${copyFocused.borderSide}');
  print('copyError side:    ${copyError.borderSide}');
  print('copyDisabled side: ${copyDisabled.borderSide}');

  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '10',
        'copyWith — Borders Without Duplication',
        const <Color>[indigo, slateDeep],
      ),
      proseBox(
        'Both concrete `InputBorder` subclasses ship a `copyWith` method that '
        'lets you derive new instances by swapping a single field. The '
        'cleanest pattern is to declare one base border with the shared '
        'radius and gapPadding, then derive the four state variants by '
        'calling `copyWith(borderSide: ...)`. This guarantees the radius '
        'and label gap stay consistent across states.',
      ),
      codeSnippetCard(
        'copy_with_pattern.dart',
        'final base = OutlineInputBorder(\n'
        '  borderRadius: BorderRadius.circular(10),\n'
        '  borderSide: BorderSide(color: Colors.slate, width: 1.0),\n'
        '  gapPadding: 4,\n'
        ');\n'
        '\n'
        'final focused = base.copyWith(\n'
        '  borderSide: BorderSide(color: Colors.indigo, width: 2.4),\n'
        ');\n'
        '\n'
        'final error = base.copyWith(\n'
        '  borderSide: BorderSide(color: Colors.red, width: 1.6),\n'
        ');\n'
        '\n'
        'final disabled = base.copyWith(\n'
        '  borderSide: BorderSide(color: Colors.grey, width: 1.0),\n'
        ');\n',
        accent: indigo,
      ),
      infoCard(
        'Live preview — derived borders',
        Column(
          children: <Widget>[
            makeField(
              label: 'Base',
              hint: 'shared radius + gap',
              border: baseOutline,
              controller: helloCtrl,
              enabled: false,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'copyWith → focused',
              hint: 'BorderSide(indigo, 2.4)',
              border: copyFocused,
              controller: helloCtrl,
              enabled: false,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'copyWith → error',
              hint: 'BorderSide(rose, 1.6)',
              border: copyError,
              errorBorder: copyError,
              controller: errorCtrl,
              errorText: 'demo error',
              enabled: true,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'copyWith → disabled',
              hint: 'BorderSide(gray, 1.0)',
              border: copyDisabled,
              disabledBorder: copyDisabled,
              controller: helloCtrl,
              enabled: false,
            ),
          ],
        ),
        headerGradient: const <Color>[indigoDeep, teal],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 11 — BorderSide deep dive.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 11] BorderSide');

  final Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '11',
        'BorderSide — Width, Colour, Style, Align',
        const <Color>[teal, indigo],
      ),
      proseBox(
        '`BorderSide` is the value object that describes a single stroked '
        'edge: its `color`, `width`, `style` (`solid` or `none`), and the '
        '`strokeAlign` (inside, center, outside). For input borders, the '
        '`style` is effectively always solid (Flutter ignores '
        '`BorderStyle.none` differently from `width: 0`), and `strokeAlign` '
        'defaults to `BorderSide.strokeAlignInside` so the painted line sits '
        'just inside the geometric edge.',
      ),
      infoCard(
        'BorderSide field reference',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('color', 'stroke colour (Color)'),
            dataRow('width', 'logical pixels; 0 = hairline'),
            dataRow('style', 'BorderStyle.solid | none'),
            dataRow('strokeAlign', 'inside (-1), center (0), outside (+1)'),
            dataRow('BorderSide.none', 'width 0, style none — invisible'),
            dataRow('copyWith', 'returns a new BorderSide with overrides'),
          ],
        ),
        headerGradient: const <Color>[teal, tealDeep],
      ),
      infoCard(
        'BorderSide variants — visual',
        Column(
          children: <Widget>[
            makeField(
              label: 'width: 0.5',
              hint: 'hairline',
              border: hairlineOutline,
              controller: helloCtrl,
              enabled: false,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'width: 1.4',
              hint: 'default-ish',
              border: roundedOutline,
              controller: helloCtrl,
              enabled: false,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'width: 3.2',
              hint: 'heavy primary field',
              border: heavyOutline,
              controller: helloCtrl,
              enabled: false,
            ),
          ],
        ),
        headerGradient: const <Color>[indigo, teal],
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────────
  // Section 12 — BorderRadius deep dive.
  // ─────────────────────────────────────────────────────────────────────────
  print('[Section 12] BorderRadius');

  final Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '12',
        'BorderRadius — Corner Geometry',
        const <Color>[indigoDeep, rose],
      ),
      proseBox(
        '`BorderRadius` controls the four corner radii of an '
        '`OutlineInputBorder`. The constructors split along two axes: '
        'symmetric (`circular`, `all`, `vertical`, `horizontal`) and '
        'asymmetric (`only`). For input borders, the radius is clamped to '
        'half the field height; setting a radius larger than that yields a '
        'stadium shape. The `UnderlineInputBorder` only honours the '
        '`topLeft` and `topRight` radii because it paints only the bottom '
        'line — the top radii curve the gap-cut into the floating label.',
      ),
      infoCard(
        'BorderRadius variants — visual',
        Column(
          children: <Widget>[
            makeField(
              label: 'radius: 4',
              hint: 'default',
              border: defaultOutline,
              controller: helloCtrl,
              enabled: false,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'radius: 12',
              hint: 'rounded',
              border: roundedOutline,
              controller: helloCtrl,
              enabled: false,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'radius: 32 (stadium)',
              hint: 'pill shape',
              border: stadiumOutline,
              controller: helloCtrl,
              enabled: false,
            ),
            const SizedBox(height: 8),
            makeField(
              label: 'tl + br only',
              hint: 'asymmetric corners',
              border: cornerOutline,
              controller: helloCtrl,
              enabled: false,
            ),
          ],
        ),
        headerGradient: const <Color>[indigo, rose],
      ),
      infoCard(
        'BorderRadius constructors',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('circular(r)', 'all four corners r'),
            dataRow('all(Radius.circular(r))', 'same as circular(r)'),
            dataRow('vertical(top, bottom)', 'top and bottom pairs only'),
            dataRow('horizontal(left, right)', 'left and right pairs only'),
            dataRow('only(tl,tr,bl,br)', 'each corner individually'),
            dataRow('zero', 'sharp 90° corners'),
          ],
        ),
        headerGradient: const <Color>[indigoDeep, indigo],
      ),
    ],
  );

  print('===== END INPUT BORDERS DEEP VISUAL DEMO =====');

  // ─── Assemble the harness ───
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: indigoDeep,
      colorScheme: ColorScheme.fromSeed(seedColor: indigoDeep),
      scaffoldBackgroundColor: paper,
    ),
    home: Scaffold(
      backgroundColor: paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[indigoDeep, indigo, teal],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: indigoDeep.withValues(alpha: 0.40),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: teal.withValues(alpha: 0.20),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'InputBorder — Deep Visual Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'package:flutter/material.dart — InputBorder, '
                      'OutlineInputBorder, UnderlineInputBorder, BorderSide, '
                      'BorderRadius, gapPadding, InputDecoration, '
                      'InputDecorationTheme.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              section1,
              section2,
              section3,
              section4,
              section5,
              section6,
              section7,
              section8,
              section9,
              section10,
              section11,
              section12,
            ],
          ),
        ),
      ),
    ),
  );
}
