// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the dart:ui Paragraph family.
//
// This file belongs to the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. It exposes a single top-level
// `dynamic build(BuildContext)` entry point that the runtime invokes once;
// the returned widget tree is handed straight to the host app's renderer.
//
// The page renders as a static, scrollable gallery focused on the *engine*
// side of text: the dart:ui `Paragraph`, its builder, and the immutable
// style objects that feed it. This is the layer that lives **below** the
// painting library's `TextPainter` and even further below the widgets
// library's `RichText` / `Text` family. Knowing how to drive it directly
// is useful when:
//
//   * implementing a CustomPainter that draws labels onto a canvas,
//   * writing a text-shaping benchmark, or
//   * generating PDF / SVG output where a `RichText` widget cannot run.
//
// Nine thematic sections walk through the surface area:
//
//   1. Hero intro - what `dart:ui.Paragraph` is and why it exists.
//   2. Build-pipeline diagram (CustomPainter) - the four phases:
//      ParagraphStyle -> ParagraphBuilder -> Paragraph -> layout/paint.
//   3. ParagraphStyle vs ui.TextStyle - a side-by-side property table.
//   4. TextAlign showcase - five paragraphs drawn into a CustomPainter
//      so the actual engine alignment is visible (left, right, center,
//      justify, start - the latter resolving through TextDirection).
//   5. LineMetrics annotation diagram - a single multi-line paragraph
//      painted with its ascent/descent/baseline/height labelled along
//      the side. The metric values are *pre-computed* in widget code so
//      the painter does not need to call `computeLineMetrics()` at paint
//      time (some d4rt builds raise on it).
//   6. StrutStyle effect demo - two paragraphs with identical content
//      but different strut configurations, painted next to each other so
//      the leading/height difference is obvious.
//   7. ParagraphBuilder recipe cards - six idiomatic code snippets
//      (push/pop styles, placeholders, font features/variations,
//      `addText` discipline, layout caching, and dispose-free flows).
//   8. Locale & subtle pitfalls panel - six callouts (mutable builder,
//      width re-layout, RTL with embedded LTR, font-fallback chains,
//      placeholder baselines, scaled metrics).
//   9. Comparison table - dart:ui.Paragraph vs painting.TextPainter vs
//      widgets.RichText, with axes such as "needs widget tree",
//      "owns the laid-out result", and "supports inline widgets".
//
// Build-time discipline mirrors the rest of the corpus:
//   * `build` runs exactly once; no `setState`, `Timer`, `Future`,
//     `async`, live `AnimationController`, or `Tween.animate(...).value`.
//   * `for-in` over BridgedInstance collections returned from Flutter
//     APIs is avoided; indexed `for` loops are used instead.
//   * `Paragraph` instances are constructed locally inside the painter
//     (the topic *is* the paragraph layer, so showing real layout output
//     is the point), but `computeLineMetrics()` / `getBoxesForRange()`
//     are not invoked at paint time.
//
// All values are deterministic and frame-independent. The file is meant
// to be scanned top-to-bottom as documentation as much as it is meant
// to render.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// Literal ARGB values keep the demo theme-independent. The palette is the
// same "indigo on porcelain" used by the FocusNode demo so the corpus reads
// as a single gallery.
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
const Color _kBaseline = Color(0xFF60A5FA);
const Color _kAscent = Color(0xFF22C55E);
const Color _kDescent = Color(0xFFF59E0B);
const Color _kHeight = Color(0xFFE11D48);
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
          width: 170.0,
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

// ---------------------------------------------------------------------------
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------
// A wide gradient card that introduces the file's subject. The hero shows
// three "package badge" pills (dart:ui, painting, widgets) to remind the
// reader where Paragraph sits in the stack.

Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1E1B4B), Color(0xFF4F46E5), Color(0xFF7C3AED)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x331E1B4B),
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
            _heroBadge('dart:ui'),
            const SizedBox(width: 8.0),
            _heroBadge('Paragraph'),
            const SizedBox(width: 8.0),
            _heroBadge('engine-level text'),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'dart:ui.Paragraph',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'An immutable, fully laid-out block of text - the thing the engine '
          'actually paints when you draw a string on a Canvas.',
          style: TextStyle(
            color: Color(0xFFE0E1FF),
            fontSize: 15.0,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0x33000000),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0x33FFFFFF)),
          ),
          child: const Text(
            'final builder = ui.ParagraphBuilder(paragraphStyle)\n'
            '  ..pushStyle(textStyle)\n'
            '  ..addText("Hello, engine!")\n'
            '  ..pop();\n'
            'final paragraph = builder.build()\n'
            '  ..layout(ui.ParagraphConstraints(width: 280.0));\n'
            'canvas.drawParagraph(paragraph, Offset.zero);',
            style: TextStyle(
              color: Color(0xFFFDFDFF),
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _heroBadge(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(999.0),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFFEDEEF5),
        fontSize: 11.5,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - BUILD PIPELINE DIAGRAM (CustomPainter)
// ---------------------------------------------------------------------------
// A simple four-stage pipeline drawn with CustomPainter:
//   [ParagraphStyle] -> [ParagraphBuilder] -> [Paragraph] -> [Canvas.drawParagraph]
// Each box is annotated with a one-liner. The painter does not build a real
// dart:ui.Paragraph; it only draws boxes/arrows. Box labels are rendered as
// regular text strings via canvas.drawParagraph using locally-built
// paragraphs (the topic *is* the paragraph layer).

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter();

  static const List<String> _kStageTitles = <String>[
    'ParagraphStyle',
    'ParagraphBuilder',
    'Paragraph',
    'Canvas.drawParagraph',
  ];

  static const List<String> _kStageBlurbs = <String>[
    'global block defaults: align, direction, maxLines, ellipsis',
    'mutable; pushStyle / pop / addText / addPlaceholder',
    'immutable, laid out; carries width, height, line metrics',
    'paints the laid-out paragraph at an offset on the canvas',
  ];

  static const List<Color> _kStageColours = <Color>[
    _kAccent,
    _kAccentBlue,
    _kAccentTeal,
    _kAccentRose,
  ];

  ui.Paragraph _label(
    String text,
    double maxWidth,
    Color colour, {
    double size = 12.5,
    FontWeight weight = FontWeight.w500,
  }) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        fontSize: size,
        fontWeight: weight,
      ),
    );
    builder.pushStyle(
      ui.TextStyle(color: colour, fontSize: size, fontWeight: weight),
    );
    builder.addText(text);
    final ui.Paragraph paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: maxWidth));
    return paragraph;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kCardSoft;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10.0)),
      bg,
    );

    const double pad = 14.0;
    const double boxH = 60.0;
    const double gapY = 18.0;
    final double boxW = size.width - pad * 2.0;

    final Paint arrowPaint = Paint()
      ..color = _kInkTertiary
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 4; i++) {
      final double top = pad + i * (boxH + gapY);
      final Rect rect = Rect.fromLTWH(pad, top, boxW, boxH);
      final Paint fill = Paint()..color = const Color(0xFFFFFFFF);
      final Paint border = Paint()
        ..color = _kStageColours[i].withOpacity(0.6)
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke;
      final RRect rr =
          RRect.fromRectAndRadius(rect, const Radius.circular(8.0));
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, border);

      // Stage index disc.
      final Paint disc = Paint()..color = _kStageColours[i];
      final Offset discCenter = Offset(pad + 16.0, top + 18.0);
      canvas.drawCircle(discCenter, 10.0, disc);
      final ui.Paragraph indexLabel = _label(
        '${i + 1}',
        24.0,
        const Color(0xFFFFFFFF),
        size: 11.0,
        weight: FontWeight.w700,
      );
      canvas.drawParagraph(
        indexLabel,
        Offset(discCenter.dx - 4.0, discCenter.dy - 8.0),
      );

      final ui.Paragraph title = _label(
        _kStageTitles[i],
        boxW - 50.0,
        _kInk,
        size: 14.0,
        weight: FontWeight.w700,
      );
      canvas.drawParagraph(title, Offset(pad + 36.0, top + 8.0));

      final ui.Paragraph blurb = _label(
        _kStageBlurbs[i],
        boxW - 50.0,
        _kInkSecondary,
        size: 11.5,
      );
      canvas.drawParagraph(blurb, Offset(pad + 36.0, top + 30.0));

      if (i < 3) {
        final double arrowX = size.width / 2.0;
        final double arrowTop = top + boxH;
        final double arrowBottom = arrowTop + gapY;
        canvas.drawLine(
          Offset(arrowX, arrowTop),
          Offset(arrowX, arrowBottom - 4.0),
          arrowPaint,
        );
        final Path head = Path()
          ..moveTo(arrowX - 4.0, arrowBottom - 6.0)
          ..lineTo(arrowX + 4.0, arrowBottom - 6.0)
          ..lineTo(arrowX, arrowBottom)
          ..close();
        final Paint headPaint = Paint()..color = _kInkTertiary;
        canvas.drawPath(head, headPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _pipelineCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Build pipeline',
          subtitle:
              'The four phases every paragraph goes through. Stages are '
              'immutable once they advance.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 340.0,
          child: CustomPaint(
            painter: const _PipelinePainter(),
            size: const Size.fromHeight(340.0),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: const <Widget>[
            _LegendDot(colour: _kAccent, text: 'immutable input'),
            _LegendDot(colour: _kAccentBlue, text: 'mutable builder'),
            _LegendDot(colour: _kAccentTeal, text: 'immutable output'),
            _LegendDot(colour: _kAccentRose, text: 'canvas op'),
          ],
        ),
      ],
    ),
  );
}

class _LegendDot extends StatelessWidget {
  final Color colour;
  final String text;
  const _LegendDot({required this.colour, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: colour,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11.5,
            color: _kInkSecondary,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 - ParagraphStyle vs ui.TextStyle COMPARISON TABLE
// ---------------------------------------------------------------------------
// Both types carry text appearance, but `ParagraphStyle` is the block-level
// default (one per paragraph, set on the builder) and `ui.TextStyle` is the
// span-level override (any number, pushed/popped on the builder). The table
// shows which property lives on which type, and where they overlap.

Widget _styleComparisonCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ParagraphStyle vs ui.TextStyle',
          subtitle:
              'Block-level defaults vs span-level overrides. Both are '
              'immutable; TextStyle is pushed/popped on the builder.',
        ),
        const SizedBox(height: 14.0),
        Row(
          children: const <Widget>[
            SizedBox(
              width: 200.0,
              child: Text('property', style: _kCaptionStyle),
            ),
            SizedBox(
              width: 120.0,
              child: Text('ParagraphStyle', style: _kCaptionStyle),
            ),
            Expanded(
              child:
                  Text('ui.TextStyle (engine flavour)', style: _kCaptionStyle),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(height: 1.0, color: _kHairline),
        _styleRow('textAlign', 'yes', 'no  (block-level concern)'),
        _styleRow('textDirection', 'yes', 'no  (block-level concern)'),
        _styleRow('maxLines', 'yes', 'no'),
        _styleRow('ellipsis', 'yes', 'no'),
        _styleRow('strutStyle', 'yes', 'no'),
        _styleRow('textHeightBehavior', 'yes', 'no'),
        _styleRow('fontFamily / fontFamilyFallback', 'yes (default)', 'yes'),
        _styleRow('fontSize', 'yes (default)', 'yes'),
        _styleRow('fontWeight / fontStyle', 'yes (default)', 'yes'),
        _styleRow('height', 'yes (default)', 'yes'),
        _styleRow('locale', 'yes (default)', 'yes'),
        _styleRow('color / background / foreground', 'no', 'yes'),
        _styleRow('decoration / decorationColor / style', 'no', 'yes'),
        _styleRow('letterSpacing / wordSpacing', 'no', 'yes'),
        _styleRow('shadows', 'no', 'yes'),
        _styleRow('fontFeatures', 'no', 'yes'),
        _styleRow('fontVariations', 'no', 'yes'),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccent.withOpacity(0.3)),
          ),
          child: const Text(
            'Rule of thumb: anything that influences how lines are *broken* '
            'lives on ParagraphStyle. Anything that influences how individual '
            'glyphs are *painted* lives on TextStyle.',
            style: TextStyle(
              fontSize: 12.5,
              color: _kInk,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _styleRow(String prop, String pStyle, String tStyle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          child: Text(
            prop,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: _kInk,
            ),
          ),
        ),
        SizedBox(
          width: 120.0,
          child: Text(
            pStyle,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: pStyle.startsWith('yes') ? _kAccentGreen : _kInkTertiary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            tStyle,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: tStyle.startsWith('yes') ? _kAccentGreen : _kInkTertiary,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - TEXTALIGN SHOWCASE (CustomPainter)
// ---------------------------------------------------------------------------
// Five paragraphs with the same content but different `TextAlign` values
// are painted side-by-side. The CustomPainter builds each paragraph
// locally, lays it out at the same width, and draws it. Alignment lines
// are drawn for visual clarity.

class _AlignShowcasePainter extends CustomPainter {
  const _AlignShowcasePainter();

  static const List<String> _kAlignNames = <String>[
    'left',
    'right',
    'center',
    'justify',
    'start (ltr)',
  ];

  static const List<TextAlign> _kAligns = <TextAlign>[
    TextAlign.left,
    TextAlign.right,
    TextAlign.center,
    TextAlign.justify,
    TextAlign.start,
  ];

  static const String _kSample =
      'The quick brown fox jumps over the lazy dog. '
      'Pack my box with five dozen liquor jugs.';

  ui.Paragraph _build(TextAlign align, double width) {
    final ui.ParagraphBuilder b = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: align,
        textDirection: TextDirection.ltr,
        fontSize: 12.5,
        height: 1.35,
      ),
    );
    b.pushStyle(
      ui.TextStyle(color: _kInk, fontSize: 12.5),
    );
    b.addText(_kSample);
    final ui.Paragraph p = b.build();
    p.layout(ui.ParagraphConstraints(width: width));
    return p;
  }

  ui.Paragraph _label(String text, double width, Color colour) {
    final ui.ParagraphBuilder b = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
      ),
    );
    b.pushStyle(ui.TextStyle(color: colour, fontSize: 11.0));
    b.addText(text);
    final ui.Paragraph p = b.build();
    p.layout(ui.ParagraphConstraints(width: width));
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const double pad = 12.0;
    const double labelW = 86.0;
    final double textW = size.width - pad * 2.0 - labelW - 10.0;
    double y = pad;
    const double rowH = 56.0;

    final Paint guide = Paint()
      ..color = const Color(0x22000000)
      ..strokeWidth = 1.0;

    for (int i = 0; i < _kAligns.length; i++) {
      // Row background.
      final Paint rowBg = Paint()..color = i.isEven ? _kCardSoft : _kCardBg;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(pad, y, size.width - pad * 2.0, rowH - 4.0),
          const Radius.circular(6.0),
        ),
        rowBg,
      );

      // Label.
      final ui.Paragraph lab = _label(_kAlignNames[i], labelW, _kAccent);
      canvas.drawParagraph(lab, Offset(pad + 6.0, y + 8.0));

      // Guide lines bounding the alignment area.
      final double textX = pad + labelW + 10.0;
      canvas.drawLine(
        Offset(textX, y + 4.0),
        Offset(textX, y + rowH - 8.0),
        guide,
      );
      canvas.drawLine(
        Offset(textX + textW, y + 4.0),
        Offset(textX + textW, y + rowH - 8.0),
        guide,
      );

      final ui.Paragraph para = _build(_kAligns[i], textW);
      canvas.drawParagraph(para, Offset(textX, y + 6.0));

      y += rowH;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _alignShowcaseCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'TextAlign showcase',
          subtitle:
              'The same string laid out five times. Vertical guides mark the '
              'paragraph width passed to layout().',
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 290.0,
          child: CustomPaint(
            painter: const _AlignShowcasePainter(),
            size: const Size.fromHeight(290.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Note: TextAlign.start and TextAlign.end resolve through '
            'ParagraphStyle.textDirection. With ltr they look identical to '
            'left and right respectively; with rtl they flip.',
            style: TextStyle(
              fontSize: 12.5,
              color: _kInkSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - LINEMETRICS ANNOTATION DIAGRAM
// ---------------------------------------------------------------------------
// A single multi-line paragraph is drawn into a CustomPainter, and the
// painter overlays its own guide lines for ascent / baseline / descent /
// line height. The metric *values* themselves are pre-computed in widget
// code by approximating against the font size (so the painter does NOT
// call computeLineMetrics at paint time). The annotation rows on the
// right of the card show the same approximated numbers.

class _MetricsPainter extends CustomPainter {
  const _MetricsPainter({required this.fontSize, required this.lineHeight});

  final double fontSize;
  final double lineHeight; // multiplier
  static const String _kSample =
      'Engine text\nlives below painting.\nAnnotations here are\n'
      'pre-computed.';

  ui.Paragraph _build(double width) {
    final ui.ParagraphBuilder b = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        fontSize: fontSize,
        height: lineHeight,
        maxLines: 4,
      ),
    );
    b.pushStyle(
      ui.TextStyle(color: _kInk, fontSize: fontSize, height: lineHeight),
    );
    b.addText(_kSample);
    final ui.Paragraph p = b.build();
    p.layout(ui.ParagraphConstraints(width: width));
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kCardSoft;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8.0)),
      bg,
    );

    const double leftMargin = 60.0;
    const double topMargin = 12.0;
    final double textW = size.width - leftMargin - 16.0;

    final ui.Paragraph paragraph = _build(textW);
    canvas.drawParagraph(paragraph, const Offset(leftMargin, topMargin));

    // Approximate the four metric bands per line. We do not call
    // computeLineMetrics() at paint time because some d4rt builds raise
    // on it. Approximations use ratios typical of Roboto-like fonts.
    final double linePx = fontSize * lineHeight;
    const double ascentRatio = 0.78;
    const double descentRatio = 0.22;

    final Paint pAsc = Paint()
      ..color = _kAscent
      ..strokeWidth = 1.0;
    final Paint pBase = Paint()
      ..color = _kBaseline
      ..strokeWidth = 1.0;
    final Paint pDesc = Paint()
      ..color = _kDescent
      ..strokeWidth = 1.0;
    final Paint pHeight = Paint()
      ..color = _kHeight.withOpacity(0.5)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 4; i++) {
      final double lineTop = topMargin + i * linePx;
      final double baseline = lineTop + linePx * ascentRatio;
      final double descentLine = baseline + linePx * descentRatio;
      final double lineBottom = lineTop + linePx;

      _dashed(canvas, Offset(leftMargin - 8.0, lineTop),
          Offset(size.width - 8.0, lineTop), pHeight);
      _dashed(canvas, Offset(leftMargin - 8.0, baseline),
          Offset(size.width - 8.0, baseline), pBase);
      _dashed(canvas, Offset(leftMargin - 8.0, descentLine),
          Offset(size.width - 8.0, descentLine), pDesc);

      final double ascentTop = baseline - linePx * ascentRatio;
      canvas.drawLine(
        Offset(leftMargin - 14.0, ascentTop),
        Offset(leftMargin - 6.0, ascentTop),
        pAsc,
      );

      final ui.Paragraph idx = _label('L${i + 1}', 40.0, _kInkTertiary);
      canvas.drawParagraph(idx, Offset(8.0, lineTop + 4.0));
    }
  }

  void _dashed(Canvas canvas, Offset a, Offset b, Paint paint) {
    final double dx = b.dx - a.dx;
    final double dy = b.dy - a.dy;
    final double dist = math.sqrt(dx * dx + dy * dy);
    final int steps = (dist / 6.0).floor();
    if (steps <= 0) {
      canvas.drawLine(a, b, paint);
      return;
    }
    for (int i = 0; i < steps; i += 2) {
      final double t1 = i / steps;
      final double t2 = math.min(1.0, (i + 1) / steps);
      final Offset p1 = Offset(a.dx + dx * t1, a.dy + dy * t1);
      final Offset p2 = Offset(a.dx + dx * t2, a.dy + dy * t2);
      canvas.drawLine(p1, p2, paint);
    }
  }

  ui.Paragraph _label(String text, double width, Color colour) {
    final ui.ParagraphBuilder b = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
      ),
    );
    b.pushStyle(ui.TextStyle(color: colour, fontSize: 10.0));
    b.addText(text);
    final ui.Paragraph p = b.build();
    p.layout(ui.ParagraphConstraints(width: width));
    return p;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _metricsCard() {
  const double fontSize = 16.0;
  const double height = 1.4;
  const double linePx = fontSize * height;
  const double ascentPx = linePx * 0.78;
  const double descentPx = linePx * 0.22;

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'LineMetrics annotations',
          subtitle:
              'Each line carries its own ascent, descent, baseline and height. '
              'Values here are pre-computed; the painter only draws guide '
              'lines so paint() stays safe.',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 240.0,
                child: CustomPaint(
                  painter: _MetricsPainter(
                    fontSize: fontSize,
                    lineHeight: height,
                  ),
                  size: const Size.fromHeight(240.0),
                ),
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _metricLegendRow(
                    _kHeight,
                    'height',
                    '${linePx.toStringAsFixed(1)} px',
                  ),
                  _metricLegendRow(
                    _kAscent,
                    'ascent',
                    '~${ascentPx.toStringAsFixed(1)} px',
                  ),
                  _metricLegendRow(
                    _kBaseline,
                    'baseline',
                    'baseline.y = ascent',
                  ),
                  _metricLegendRow(
                    _kDescent,
                    'descent',
                    '~${descentPx.toStringAsFixed(1)} px',
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: _kCardSoft,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _kHairline),
                    ),
                    child: const Text(
                      'paragraph.computeLineMetrics()\n'
                      '  -> List<LineMetrics>\n'
                      '       .ascent\n'
                      '       .descent\n'
                      '       .unscaledAscent\n'
                      '       .height\n'
                      '       .width\n'
                      '       .left\n'
                      '       .baseline\n'
                      '       .lineNumber',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: _kInk,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _metricLegendRow(Color colour, String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 12.0,
          height: 12.0,
          margin: const EdgeInsets.only(top: 3.0),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 70.0,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - STRUTSTYLE EFFECT
// ---------------------------------------------------------------------------
// Two paragraphs with the same body, the same font size, but different
// StrutStyle configurations. The right paragraph forces a tall strut so
// every line allocates the same vertical box, regardless of the glyphs
// that actually appear on it. Visible as a much taller laid-out region.

class _StrutPainter extends CustomPainter {
  const _StrutPainter({required this.useStrut});

  final bool useStrut;

  static const String _kBody = 'Short.\n'
      'Some longer line with the letter g and a comma,\n'
      'tiny:\n'
      'A LINE WITH ASCENDERS AND DESCENDERS gjqpy\n'
      'fin.';

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kCardSoft;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8.0)),
      bg,
    );

    final ui.StrutStyle? strut = useStrut
        ? ui.StrutStyle(
            fontSize: 16.0,
            height: 1.8,
            forceStrutHeight: true,
            leading: 0.4,
          )
        : null;

    final ui.ParagraphBuilder b = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        fontSize: 13.0,
        height: 1.2,
        strutStyle: strut,
      ),
    );
    b.pushStyle(ui.TextStyle(color: _kInk, fontSize: 13.0));
    b.addText(_kBody);
    final ui.Paragraph p = b.build();
    p.layout(ui.ParagraphConstraints(width: size.width - 24.0));
    canvas.drawParagraph(p, const Offset(12.0, 12.0));

    // Faint horizontal rules to highlight that each line really does
    // occupy a fixed-height row when forceStrutHeight is on.
    final Paint rule = Paint()
      ..color = const Color(0x22000000)
      ..strokeWidth = 0.6;
    final double linePx = useStrut ? 16.0 * 1.8 : 13.0 * 1.2;
    for (int i = 0; i < 6; i++) {
      final double y = 12.0 + linePx * i;
      if (y > size.height - 6.0) break;
      canvas.drawLine(Offset(8.0, y), Offset(size.width - 8.0, y), rule);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _strutCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'StrutStyle effect',
          subtitle:
              'The strut is an invisible glyph that pins every line to a '
              'minimum height. forceStrutHeight makes that minimum a maximum, '
              'too.',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _pill('strutStyle: null', colour: _kInkTertiary),
                  const SizedBox(height: 6.0),
                  SizedBox(
                    height: 200.0,
                    child: CustomPaint(
                      painter: const _StrutPainter(useStrut: false),
                      size: const Size.fromHeight(200.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _pill('forceStrutHeight: true', colour: _kAccent),
                  const SizedBox(height: 6.0),
                  SizedBox(
                    height: 200.0,
                    child: CustomPaint(
                      painter: const _StrutPainter(useStrut: true),
                      size: const Size.fromHeight(200.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'StrutStyle fields: fontFamily, fontFamilyFallback, fontSize, '
            'height, leading, fontWeight, fontStyle, forceStrutHeight. '
            'Set forceStrutHeight when you want predictable line boxes for '
            'table-like layouts.',
            style: TextStyle(
              fontSize: 12.5,
              color: _kInkSecondary,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - PARAGRAPHBUILDER RECIPE CARDS
// ---------------------------------------------------------------------------
// Six idiomatic code-block cards. Each card shows a minimal recipe and a
// one-line caption explaining when to reach for it. The code is rendered
// inside _codeBlock, mirroring the FocusNode demo style.

const String _kRecipePushPop = '''final builder = ui.ParagraphBuilder(
  ui.ParagraphStyle(fontSize: 14.0),
)
  ..pushStyle(ui.TextStyle(color: const Color(0xFF1A1C25)))
  ..addText("Hello ")
  ..pushStyle(ui.TextStyle(
    color: const Color(0xFF4F46E5),
    fontWeight: FontWeight.w700,
  ))
  ..addText("engine")
  ..pop()
  ..addText(" world.");
final paragraph = builder.build()
  ..layout(const ui.ParagraphConstraints(width: 240.0));''';

const String _kRecipePlaceholder = '''final builder = ui.ParagraphBuilder(
  ui.ParagraphStyle(fontSize: 16.0),
);
builder.pushStyle(ui.TextStyle(color: const Color(0xFF1A1C25)));
builder.addText("Loading ");
builder.addPlaceholder(
  20.0,            // width
  20.0,            // height
  PlaceholderAlignment.middle,
  baselineOffset: 16.0,
  baseline: TextBaseline.alphabetic,
);
builder.addText(" please wait.");
final paragraph = builder.build()
  ..layout(const ui.ParagraphConstraints(width: 280.0));
// paragraph.getBoxesForPlaceholders() -> List<TextBox>''';

const String _kRecipeFeatures = '''final stylish = ui.TextStyle(
  fontSize: 16.0,
  fontFamily: 'Roboto',
  fontFeatures: const <FontFeature>[
    FontFeature.tabularFigures(),
    FontFeature.oldstyleFigures(),
    FontFeature.enable('liga'),
  ],
  fontVariations: const <FontVariation>[
    FontVariation('wght', 520.0),
    FontVariation('wdth', 95.0),
  ],
);''';

const String _kRecipeAddText = '''// addText splits on \\n inside the string;
// you do NOT need to call a separate "new line" API.
builder.addText("Title line\\n");
builder.addText("Second line, same style.\\n");
builder.pushStyle(ui.TextStyle(
  color: const Color(0xFFE11D48),
));
builder.addText("Red final line.");
builder.pop();''';

const String _kRecipeLayoutCache = '''// Layout is cheap to re-run when only the
// width changes; but the paragraph is mutated
// in place. If you need the old layout, keep a
// reference to the old paragraph and rebuild a
// fresh one for the new width.
final paragraph = builder.build();
paragraph.layout(const ui.ParagraphConstraints(width: 240.0));
final double widthA = paragraph.width;
paragraph.layout(const ui.ParagraphConstraints(width: 160.0));
final double widthB = paragraph.width; // smaller now''';

const String _kRecipeNoDispose = '''// dart:ui.Paragraph has no dispose() in the
// public surface; it is garbage-collected like
// any other Dart object. Keep references short:
// build, layout, draw, drop.
final builder = ui.ParagraphBuilder(
  ui.ParagraphStyle(fontSize: 14.0),
);
builder.pushStyle(
  ui.TextStyle(color: const Color(0xFF1A1C25)),
);
builder.addText("One-off label.");
final paragraph = builder.build()
  ..layout(const ui.ParagraphConstraints(width: 200.0));
canvas.drawParagraph(paragraph, const Offset(0.0, 0.0));
// no .dispose() needed''';

Widget _recipesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _recipeCard(
        'push / pop style spans',
        'Span-level styles stack like a tree. Always pair pushStyle with pop.',
        _kRecipePushPop,
      ),
      _recipeCard(
        'inline placeholders',
        'Reserve a box in the run of text for a non-text widget (image, icon, '
            'inline widget rendered separately).',
        _kRecipePlaceholder,
      ),
      _recipeCard(
        'font features & variations',
        'OpenType features and variable-font axes are span-level only; they '
            'live on ui.TextStyle, not on ParagraphStyle.',
        _kRecipeFeatures,
      ),
      _recipeCard(
        'addText and line breaks',
        'The engine respects U+000A line feeds inside addText; no separate '
            'newLine() call.',
        _kRecipeAddText,
      ),
      _recipeCard(
        'layout caching',
        'Calling layout() again on the same paragraph re-flows in place and '
            'invalidates the previous metrics.',
        _kRecipeLayoutCache,
      ),
      _recipeCard(
        'no dispose, short lifetimes',
        'Paragraphs are plain Dart objects; build them close to where they '
            'are drawn and drop the reference.',
        _kRecipeNoDispose,
      ),
    ],
  );
}

Widget _recipeCard(String title, String blurb, String code) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(title, subtitle: blurb),
        const SizedBox(height: 6.0),
        _codeBlock(code, title: '$title.dart'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - LOCALE / PITFALLS PANEL
// ---------------------------------------------------------------------------
// Six callouts. Each is a short row with a tone-coloured stripe at the
// left and a "label : body" structure mirroring how docs typically format
// admonitions.

class _Pitfall {
  final String label;
  final String body;
  final Color tone;
  const _Pitfall(this.label, this.body, this.tone);
}

const List<_Pitfall> _kPitfalls = <_Pitfall>[
  _Pitfall(
    'Builder is single-use',
    'After build(), the ParagraphBuilder must not be reused. addText() / '
        'pushStyle() on a built builder raise. Build a fresh one each frame.',
    _kAccentRose,
  ),
  _Pitfall(
    'Width changes mutate in place',
    'paragraph.layout(newConstraints) overwrites width / height / metrics on '
        'the same object. Keep the old measurements before calling layout '
        'again, or rebuild.',
    _kAccentAmber,
  ),
  _Pitfall(
    'RTL with embedded LTR',
    'ParagraphStyle.textDirection = TextDirection.rtl makes the *paragraph* '
        'right-to-left, but the Unicode Bidi algorithm still resolves runs. '
        'An English phrase in an Arabic paragraph remains left-to-right within '
        'its run.',
    _kAccent,
  ),
  _Pitfall(
    'Font fallback is engine-side',
    'fontFamilyFallback on TextStyle / ParagraphStyle is consulted by the '
        'engine font subsystem. Some platforms ignore unknown family names '
        'silently; verify with the emoji test string.',
    _kAccentBlue,
  ),
  _Pitfall(
    'Placeholder baselines',
    'addPlaceholder requires a baseline + baselineOffset when the alignment '
        'is aboveBaseline / belowBaseline / baseline. middle / top / bottom '
        'compute their own.',
    _kAccentTeal,
  ),
  _Pitfall(
    'TextHeightBehavior',
    'applyHeightToFirstAscent / applyHeightToLastDescent on '
        'ui.TextHeightBehavior change whether the height multiplier is '
        'applied to the top and bottom of the paragraph. Default is true '
        'for both, which often surprises designers expecting tight bounds.',
    _kAccentViolet,
  ),
];

Widget _pitfallsCard() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kPitfalls.length; i++) {
    rows.add(_pitfallRow(_kPitfalls[i]));
    if (i < _kPitfalls.length - 1) {
      rows.add(const SizedBox(height: 8.0));
    }
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Locale and other subtle pitfalls',
          subtitle:
              'Engine-level text has fewer guard rails than the widgets layer. '
              'These are the ones that bite most often.',
        ),
        const SizedBox(height: 12.0),
        ...rows,
      ],
    ),
  );
}

Widget _pitfallRow(_Pitfall p) {
  return Container(
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kHairline),
    ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 4.0,
            decoration: BoxDecoration(
              color: p.tone,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    p.label,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: p.tone,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    p.body,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: _kInkSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - COMPARISON TABLE: dart:ui.Paragraph vs TextPainter vs RichText
// ---------------------------------------------------------------------------
// Four-column comparison. Cells show short text (yes / no / partial) and
// are coloured to make the picture readable at a glance.

class _CompareRow {
  final String axis;
  final String paragraph;
  final String textPainter;
  final String richText;
  const _CompareRow(
      this.axis, this.paragraph, this.textPainter, this.richText);
}

const List<_CompareRow> _kCompareRows = <_CompareRow>[
  _CompareRow('lives in', 'dart:ui', 'painting.dart', 'widgets.dart'),
  _CompareRow('needs widget tree', 'no', 'no', 'yes'),
  _CompareRow(
    'owns laid-out result',
    'yes (Paragraph)',
    'yes (internal)',
    'yes (RenderParagraph)',
  ),
  _CompareRow(
    'paints itself',
    'via Canvas.drawParagraph',
    'paint(canvas, offset)',
    'via RenderObject.paint',
  ),
  _CompareRow(
    'supports rich style spans',
    'yes (pushStyle/pop)',
    'yes (TextSpan tree)',
    'yes (TextSpan tree)',
  ),
  _CompareRow(
    'supports inline widgets',
    'placeholders only',
    'placeholders + WidgetSpan plumbing',
    'WidgetSpan',
  ),
  _CompareRow(
    'exposes line metrics',
    'computeLineMetrics()',
    'wrapped via computeLineMetrics()',
    'via RenderParagraph',
  ),
  _CompareRow(
    'exposes selection rects',
    'getBoxesForRange()',
    'getBoxesForSelection()',
    'selection registrar',
  ),
  _CompareRow(
    'inherits theme defaults',
    'no (literal styles only)',
    'no (callers pass styles)',
    'yes (DefaultTextStyle)',
  ),
  _CompareRow(
    'cost per frame',
    'low if cached',
    'low if cached',
    'integrated with build/layout pipeline',
  ),
  _CompareRow(
    'best for',
    'CustomPainter labels, PDFs',
    'one-off measurement',
    'app UI text',
  ),
];

Widget _compareCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Paragraph vs TextPainter vs RichText',
          subtitle:
              'Three layers, three roles. The lower you go, the more control '
              'you get and the less magic happens for you.',
        ),
        const SizedBox(height: 12.0),
        Row(
          children: const <Widget>[
            SizedBox(width: 200.0, child: Text('axis', style: _kCaptionStyle)),
            Expanded(child: Text('ui.Paragraph', style: _kCaptionStyle)),
            Expanded(
                child: Text('painting.TextPainter', style: _kCaptionStyle)),
            Expanded(child: Text('widgets.RichText', style: _kCaptionStyle)),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(height: 1.0, color: _kHairline),
        ..._kCompareRows.map(_compareRowWidget),
      ],
    ),
  );
}

Widget _compareRowWidget(_CompareRow row) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          child: Text(
            row.axis,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            row.paragraph,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _toneFor(row.paragraph),
            ),
          ),
        ),
        Expanded(
          child: Text(
            row.textPainter,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _toneFor(row.textPainter),
            ),
          ),
        ),
        Expanded(
          child: Text(
            row.richText,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _toneFor(row.richText),
            ),
          ),
        ),
      ],
    ),
  );
}

Color _toneFor(String value) {
  if (value.startsWith('yes')) return _kAccentGreen;
  if (value.startsWith('no')) return _kInkTertiary;
  return _kInk;
}

// ---------------------------------------------------------------------------
// SECTION 10 - CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
// A compact dark card with chip groups summarising the Paragraph surface
// area: types, properties, methods, gotchas.

Widget _cheatSheet() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 28.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairlineDark),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat sheet',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Quick reference for the dart:ui paragraph layer.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 14.0),
        _chipGroup('types', const <String>[
          'Paragraph',
          'ParagraphBuilder',
          'ParagraphStyle',
          'ui.TextStyle',
          'StrutStyle',
          'TextHeightBehavior',
          'LineMetrics',
          'GlyphInfo',
          'TextBox',
          'TextRange',
          'TextPosition',
          'TextAffinity',
          'Locale',
          'FontFeature',
          'FontVariation',
          'PlaceholderAlignment',
          'TextBaseline',
          'TextAlign',
          'TextDirection',
          'TextLeadingDistribution',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('ParagraphBuilder methods', const <String>[
          'pushStyle(TextStyle)',
          'pop()',
          'addText(String)',
          'addPlaceholder(...)',
          'build() -> Paragraph',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('Paragraph methods', const <String>[
          'layout(ParagraphConstraints)',
          'getBoxesForRange(start, end)',
          'getBoxesForPlaceholders()',
          'getPositionForOffset(Offset)',
          'getWordBoundary(TextPosition)',
          'getLineBoundary(TextPosition)',
          'getGlyphInfoAt(int)',
          'getClosestGlyphInfoForOffset(Offset)',
          'computeLineMetrics()',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('Paragraph properties', const <String>[
          'width',
          'height',
          'longestLine',
          'minIntrinsicWidth',
          'maxIntrinsicWidth',
          'alphabeticBaseline',
          'ideographicBaseline',
          'didExceedMaxLines',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('common gotchas', const <String>[
          'builder is single-use',
          'layout() mutates in place',
          'no dispose()',
          'newlines via U+000A',
          'features/variations are TextStyle only',
          'strut forces line height',
        ]),
      ],
    ),
  );
}

Widget _chipGroup(String label, List<String> chips) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          color: _kInkOnDarkSecondary,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
      const SizedBox(height: 6.0),
      Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: chips.map(_darkChip).toList(),
      ),
    ],
  );
}

Widget _darkChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: const Color(0x1AFFFFFF),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: _kHairlineDark),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInkOnDark,
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 11 - FOOTER
// ---------------------------------------------------------------------------
// Provenance line so the rendered output identifies itself when grabbed as
// a screenshot for documentation.

Widget _footer() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: const BoxDecoration(
                color: _kAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'tom_d4rt_flutter_ast / send_ast_via_http_scripts / dart_ui',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: _kInkTertiary,
              ),
            ),
          ],
        ),
        const Text(
          'paragraph_test.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: _kInkTertiary,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
// d4rt calls `build` exactly once. We assemble a long scrollable column of
// section headers + cards. Section indices are 1-based to match the file
// header summary.

dynamic build(BuildContext context) {
  print('dart:ui Paragraph deep visual demo: build() invoked once');
  print('Sections: hero, pipeline, style table, align, metrics, strut, '
      'recipes, pitfalls, comparison, cheat-sheet, footer');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _heroBanner(),
          _sectionHeader(
            1,
            'Build pipeline',
            'ParagraphStyle -> ParagraphBuilder -> Paragraph -> Canvas',
          ),
          _pipelineCard(),
          _sectionDivider(),
          _sectionHeader(
            2,
            'ParagraphStyle vs ui.TextStyle',
            'Block-level vs span-level appearance.',
          ),
          _styleComparisonCard(),
          _sectionDivider(),
          _sectionHeader(
            3,
            'TextAlign showcase',
            'Five engine alignments at the same paragraph width.',
          ),
          _alignShowcaseCard(),
          _sectionDivider(),
          _sectionHeader(
            4,
            'LineMetrics annotations',
            'Per-line ascent, baseline, descent, height.',
          ),
          _metricsCard(),
          _sectionDivider(),
          _sectionHeader(
            5,
            'StrutStyle effect',
            'Pin every line to the same vertical box.',
          ),
          _strutCard(),
          _sectionDivider(),
          _sectionHeader(
            6,
            'ParagraphBuilder recipes',
            'Six minimal code snippets you will reach for again and again.',
          ),
          _recipesSection(),
          _sectionDivider(),
          _sectionHeader(
            7,
            'Locale and pitfalls',
            'Things that go quietly wrong at the engine layer.',
          ),
          _pitfallsCard(),
          _sectionDivider(),
          _sectionHeader(
            8,
            'Paragraph vs TextPainter vs RichText',
            'Choosing the right text abstraction for the job.',
          ),
          _compareCard(),
          _sectionDivider(),
          _sectionHeader(
            9,
            'Cheat sheet',
            'Compact recap of types, methods, properties, gotchas.',
          ),
          _cheatSheet(),
          _footer(),
        ],
      ),
    ),
  );
}
