// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of `dart:ui` text data types.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)`
// - which is invoked a single time and returns a MaterialApp.
//
// The rendered output is a long static gallery that walks through every
// value type the Flutter text stack exposes - the ones that live on the
// engine boundary in `dart:ui`, and their wrappers re-exported from
// `package:flutter/painting.dart`. The classes covered:
//
//   * ui.TextStyle vs painting.TextStyle
//   * ui.ParagraphStyle, ui.StrutStyle, ui.TextHeightBehavior
//   * ui.TextBox, ui.TextRange, ui.TextPosition, ui.TextAffinity
//   * TextAlign, TextDirection, TextLeadingDistribution
//   * TextDecoration, TextDecorationStyle
//   * FontStyle, FontWeight
//   * ui.Locale
//   * ui.LineMetrics (value-only construction)
//
// Construction-only: we never build a `ui.Paragraph` via `ParagraphBuilder`
// because that requires a live engine; we only instantiate the value types
// and visualise them with custom painters. No `setState`, `Timer`, `Future`
// or `AnimationController` appears anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// `dart:ui` is the engine layer, so we lean on a calm, technical palette
// reminiscent of an architectural blueprint - off-white canvas, slate ink,
// and a single warm accent for the engine-layer chrome.
const Color _kCanvas = Color(0xFFF6F7FB);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1A1B1F);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF14161A);
const Color _kInkSecondary = Color(0xFF454952);
const Color _kInkTertiary = Color(0xFF8A8F99);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kAccent = Color(0xFFB45309); // engine amber
const Color _kAccentBlue = Color(0xFF1D4ED8);
const Color _kAccentGreen = Color(0xFF15803D);
const Color _kAccentRed = Color(0xFFB91C1C);
const Color _kAccentIndigo = Color(0xFF4338CA);
const Color _kAccentTeal = Color(0xFF0E7490);
const Color _kAccentPink = Color(0xFFBE185D);
const Color _kAccentViolet = Color(0xFF7C3AED);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
const Color _kGridLine = Color(0xFFD9DCE3);
const Color _kSelectBg = Color(0x331D4ED8);
const Color _kCaret = Color(0xFFB45309);

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
const TextStyle _kMonoStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
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

Widget _pill(String label, {Color colour = _kAccent, Color? textColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.35)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: textColor ?? colour,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
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
        Text(code, style: _kMonoStyle),
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

class _ChipOnDark extends StatelessWidget {
  const _ChipOnDark({required this.label});

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
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFFFFFF),
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

Widget _chipGroup(String heading, List<String> labels, Color accent) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        heading,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: accent,
          letterSpacing: 0.4,
        ),
      ),
      const SizedBox(height: 6.0),
      Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: <Widget>[
          for (final String label in labels) _pill(label, colour: accent),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// CUSTOM PAINTERS
// ---------------------------------------------------------------------------
// Painters used by Sections 3 (ParagraphStyle diagram), 4 (StrutStyle anatomy)
// and 5 (TextBox + selection + caret overlay). They are pure-value paint
// routines - they never read from external state and never animate.
// ---------------------------------------------------------------------------
class _ParagraphAnnotationPainter extends CustomPainter {
  const _ParagraphAnnotationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint hairline = Paint()
      ..color = _kGridLine
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Paint baseline = Paint()
      ..color = _kAccent
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final Paint dashedBound = Paint()
      ..color = _kAccentBlue.withOpacity(0.6)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    // Outer paragraph rect.
    final Rect outer = Rect.fromLTWH(20.0, 14.0, size.width - 40.0, size.height - 28.0);
    canvas.drawRect(outer, dashedBound);
    // Three baselines.
    for (int i = 0; i < 3; i++) {
      final double y = outer.top + 22.0 + i * 30.0;
      canvas.drawLine(Offset(outer.left + 6.0, y), Offset(outer.right - 6.0, y), baseline);
      // Faint x-height guide above baseline.
      canvas.drawLine(
        Offset(outer.left + 6.0, y - 10.0),
        Offset(outer.right - 6.0, y - 10.0),
        hairline,
      );
    }
    // Caret indicator at top-left.
    final Paint caret = Paint()
      ..color = _kCaret
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(outer.left + 6.0, outer.top + 8.0), Offset(outer.left + 6.0, outer.top + 30.0), caret);
    // Annotation tick marks on the right edge.
    final Paint tick = Paint()..color = _kInkTertiary..strokeWidth = 1.0;
    for (int i = 0; i < 3; i++) {
      final double y = outer.top + 22.0 + i * 30.0;
      canvas.drawLine(Offset(outer.right + 2.0, y), Offset(outer.right + 8.0, y), tick);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StrutAnatomyPainter extends CustomPainter {
  const _StrutAnatomyPainter({required this.leading, required this.forceStrutHeight});

  final ui.TextLeadingDistribution leading;
  final bool forceStrutHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint border = Paint()
      ..color = _kGridLine
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Paint ascentFill = Paint()..color = const Color(0x1F1D4ED8);
    final Paint descentFill = Paint()..color = const Color(0x1FB91C1C);
    final Paint leadingFill = Paint()..color = const Color(0x33B45309);
    final Paint baseline = Paint()
      ..color = _kAccent
      ..strokeWidth = 1.2;

    final double cx = size.width / 2.0;
    final double top = 16.0;
    final double bottom = size.height - 16.0;
    final double total = bottom - top;
    // Decide leading split.
    final double ascentRatio = 0.55;
    final double descentRatio = 0.20;
    final double leadingRatio = 1.0 - ascentRatio - descentRatio;
    final double leadingTop;
    final double leadingBottom;
    if (leading == ui.TextLeadingDistribution.proportional) {
      leadingTop = total * leadingRatio * (ascentRatio / (ascentRatio + descentRatio));
      leadingBottom = total * leadingRatio - leadingTop;
    } else {
      leadingTop = total * leadingRatio / 2.0;
      leadingBottom = total * leadingRatio / 2.0;
    }
    final double ascentHeight = total * ascentRatio;
    final double descentHeight = total * descentRatio;

    final Rect lineBox = Rect.fromLTWH(20.0, top, size.width - 40.0, total);
    // Leading top band.
    canvas.drawRect(
      Rect.fromLTWH(lineBox.left, lineBox.top, lineBox.width, leadingTop),
      leadingFill,
    );
    // Ascent band.
    canvas.drawRect(
      Rect.fromLTWH(lineBox.left, lineBox.top + leadingTop, lineBox.width, ascentHeight),
      ascentFill,
    );
    // Descent band.
    canvas.drawRect(
      Rect.fromLTWH(
        lineBox.left,
        lineBox.top + leadingTop + ascentHeight,
        lineBox.width,
        descentHeight,
      ),
      descentFill,
    );
    // Leading bottom band.
    canvas.drawRect(
      Rect.fromLTWH(
        lineBox.left,
        lineBox.top + leadingTop + ascentHeight + descentHeight,
        lineBox.width,
        leadingBottom,
      ),
      leadingFill,
    );
    canvas.drawRect(lineBox, border);

    // Baseline (between ascent and descent).
    final double baselineY = lineBox.top + leadingTop + ascentHeight;
    canvas.drawLine(
      Offset(lineBox.left + 4.0, baselineY),
      Offset(lineBox.right - 4.0, baselineY),
      baseline,
    );

    // Label glyph: a simple capital 'A' positioned on the baseline.
    final TextPainter glyph = TextPainter(
      text: TextSpan(
        text: 'Ag',
        style: TextStyle(
          fontSize: ascentHeight + descentHeight - 4.0,
          fontWeight: forceStrutHeight ? FontWeight.w700 : FontWeight.w500,
          color: _kInk,
          height: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    glyph.paint(canvas, Offset(cx - glyph.width / 2.0, baselineY - ascentHeight + 2.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LayoutOverlayPainter extends CustomPainter {
  const _LayoutOverlayPainter({required this.affinity});

  final ui.TextAffinity affinity;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paragraph = Paint()
      ..color = _kGridLine
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Paint selection = Paint()..color = _kSelectBg;
    final Paint caret = Paint()
      ..color = _kCaret
      ..strokeWidth = 2.0;

    final Rect outer = Rect.fromLTWH(14.0, 12.0, size.width - 28.0, size.height - 24.0);
    canvas.drawRect(outer, paragraph);

    // Three TextBox selection rectangles.
    final List<Rect> selectionBoxes = <Rect>[
      Rect.fromLTWH(outer.left + 6.0, outer.top + 8.0, 96.0, 22.0),
      Rect.fromLTWH(outer.left + 6.0, outer.top + 34.0, 168.0, 22.0),
      Rect.fromLTWH(outer.left + 6.0, outer.top + 60.0, 64.0, 22.0),
    ];
    for (final Rect r in selectionBoxes) {
      canvas.drawRect(r, selection);
      canvas.drawRect(r, Paint()
        ..color = _kAccentBlue
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke);
    }

    // Glyph row text painters for the three lines.
    const List<String> lines = <String>[
      'Hello, World!',
      'The quick brown fox jumps over.',
      'Affinity.',
    ];
    for (int i = 0; i < lines.length; i++) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: lines[i],
          style: const TextStyle(
            fontSize: 14.0,
            fontFamily: 'monospace',
            color: _kInk,
            height: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(outer.left + 8.0, outer.top + 10.0 + i * 26.0));
    }

    // Caret at TextPosition(offset: 12) - draw it where the 12th column lives.
    // We render it at the end of the second line for downstream, before the
    // 'q' of 'quick' for upstream, to illustrate affinity.
    final double caretX = affinity == ui.TextAffinity.downstream
        ? outer.left + 8.0 + 120.0
        : outer.left + 8.0 + 40.0;
    final double caretY = outer.top + 34.0;
    canvas.drawLine(Offset(caretX, caretY + 2.0), Offset(caretX, caretY + 20.0), caret);
    // Affinity hint glyph (small arrow).
    final Path arrow = Path();
    if (affinity == ui.TextAffinity.downstream) {
      arrow.moveTo(caretX + 1.0, caretY + 4.0);
      arrow.lineTo(caretX + 7.0, caretY + 11.0);
      arrow.lineTo(caretX + 1.0, caretY + 18.0);
    } else {
      arrow.moveTo(caretX - 1.0, caretY + 4.0);
      arrow.lineTo(caretX - 7.0, caretY + 11.0);
      arrow.lineTo(caretX - 1.0, caretY + 18.0);
    }
    canvas.drawPath(arrow, Paint()..color = _kCaret);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// Called exactly once by the interpreter. All locals live inside this
// function; widgets are assembled into a single `ListView` body inside a
// MaterialApp.
// ===========================================================================
dynamic build(BuildContext context) {
  print('dart:ui text data deep visual demo executing');
  final math.Random rng = math.Random(13);
  final int dummyEntropy = rng.nextInt(100);
  print('  rng warm-up: $dummyEntropy');

  // -------------------------------------------------------------------------
  // VALUE-TYPE INSTANTIATIONS
  // -------------------------------------------------------------------------
  // Every type we want to demo is constructed once up-front. We print a
  // human-readable summary so anyone tailing the d4rt log can see what was
  // built without having to introspect the widget tree.
  // -------------------------------------------------------------------------
  final ui.TextStyle uiTextStyle = ui.TextStyle(
    color: const Color(0xFF14161A),
    fontSize: 16.0,
    fontWeight: ui.FontWeight.w500,
    fontStyle: ui.FontStyle.normal,
    letterSpacing: 0.2,
    wordSpacing: 0.0,
    height: 1.4,
    locale: const ui.Locale('en', 'US'),
    decoration: ui.TextDecoration.underline,
    decorationColor: _kAccent,
    decorationStyle: ui.TextDecorationStyle.dashed,
    decorationThickness: 1.5,
  );
  print('  built ui.TextStyle: $uiTextStyle');

  const TextStyle paintingTextStyle = TextStyle(
    color: _kInk,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.2,
    height: 1.4,
    locale: Locale('en', 'GB'),
    decoration: TextDecoration.underline,
    decorationColor: _kAccentBlue,
    decorationStyle: TextDecorationStyle.wavy,
    decorationThickness: 1.5,
  );
  print('  built painting.TextStyle: $paintingTextStyle');

  final ui.ParagraphStyle paragraphStyle = ui.ParagraphStyle(
    textAlign: TextAlign.justify,
    textDirection: TextDirection.ltr,
    maxLines: 4,
    fontFamily: 'monospace',
    fontSize: 14.0,
    height: 1.4,
    textHeightBehavior: const ui.TextHeightBehavior(
      applyHeightToFirstAscent: true,
      applyHeightToLastDescent: false,
      leadingDistribution: ui.TextLeadingDistribution.even,
    ),
    strutStyle: ui.StrutStyle(
      fontFamily: 'monospace',
      fontSize: 14.0,
      height: 1.4,
      leading: 0.3,
      forceStrutHeight: true,
    ),
    ellipsis: '...',
    locale: const ui.Locale('en', 'US'),
  );
  print('  built ui.ParagraphStyle: $paragraphStyle');

  final ui.StrutStyle strutStyle = ui.StrutStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    height: 1.5,
    leading: 0.2,
    fontWeight: ui.FontWeight.w500,
    fontStyle: ui.FontStyle.normal,
    forceStrutHeight: true,
    leadingDistribution: ui.TextLeadingDistribution.proportional,
  );
  print('  built ui.StrutStyle: $strutStyle');

  final ui.TextBox box1 = ui.TextBox.fromLTRBD(10.0, 20.0, 110.0, 42.0, TextDirection.ltr);
  final ui.TextBox box2 = ui.TextBox.fromLTRBD(0.0, 50.0, 180.0, 72.0, TextDirection.ltr);
  final ui.TextBox boxRtl = ui.TextBox.fromLTRBD(0.0, 80.0, 64.0, 102.0, TextDirection.rtl);
  print('  built TextBoxes: $box1, $box2, $boxRtl');

  const ui.TextRange range = ui.TextRange(start: 7, end: 12);
  print('  built ui.TextRange(7,12): $range');

  const ui.TextPosition positionDown = ui.TextPosition(offset: 12, affinity: ui.TextAffinity.downstream);
  const ui.TextPosition positionUp = ui.TextPosition(offset: 12, affinity: ui.TextAffinity.upstream);
  print('  built TextPositions: $positionDown / $positionUp');

  const ui.Locale localeEnUs = ui.Locale('en', 'US');
  final ui.Locale localeJaJp = ui.Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP');
  final ui.Locale localeArEg = ui.Locale.fromSubtags(languageCode: 'ar', countryCode: 'EG');
  final ui.Locale localeZhHant = ui.Locale.fromSubtags(
    languageCode: 'zh',
    scriptCode: 'Hant',
    countryCode: 'TW',
  );
  print('  built Locales: $localeEnUs, $localeJaJp, $localeArEg, $localeZhHant');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero introduces dart:ui as the engine-level text layer, and shows
  // a strip of package chips identifying every layer that participates in
  // text rendering.
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1F2937),
          Color(0xFF312E81),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
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
            Icon(Icons.text_fields, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'dart:ui Text Data Types',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: -0.8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'engine-level value types, wrapped by flutter/painting',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'dart:ui sits at the very edge of the Flutter framework, where Dart code '
          'meets the C++ engine. Every paragraph the engine lays out, every glyph '
          'it shapes, every selection rectangle it reports back to your hit-test '
          'code, is described by one of the value types in this gallery. The '
          'painting.dart library wraps most of them with friendlier constructors '
          'and re-exports the rest so the same names work in both worlds.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.55,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: const <Widget>[
            _ChipOnDark(label: 'dart:ui'),
            _ChipOnDark(label: 'package:flutter/painting.dart'),
            _ChipOnDark(label: 'package:flutter/widgets.dart'),
            _ChipOnDark(label: 'package:flutter/material.dart'),
            _ChipOnDark(label: 'package:flutter/foundation.dart'),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            const Icon(Icons.bolt, color: Color(0xFFFCD34D), size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'painting.dart re-exports many of these types - alias dart:ui to '
                'disambiguate. We import it `as ui` everywhere in this file.',
                style: const TextStyle(
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
  // SECTION 2 - ui.TextStyle vs painting.TextStyle
  // -------------------------------------------------------------------------
  // Both packages expose a `TextStyle` class with overlapping fields. This
  // section explains the differences with a table: which fields are
  // engine-only, which are widget-only, and which are shared.
  // -------------------------------------------------------------------------
  Widget tableRow({
    required String field,
    required String ui,
    required String painting,
    required String use,
    bool isHeader = false,
  }) {
    final TextStyle base = TextStyle(
      fontSize: isHeader ? 11.5 : 12.0,
      fontWeight: isHeader ? FontWeight.w700 : FontWeight.w500,
      color: isHeader ? _kInkTertiary : _kInk,
      fontFamily: isHeader ? null : 'monospace',
      letterSpacing: isHeader ? 0.4 : 0.0,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isHeader ? const Color(0xFFF1F2F6) : _kCardBg,
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 130.0, child: Text(field, style: base)),
          SizedBox(width: 70.0, child: Text(ui, style: base, textAlign: TextAlign.center)),
          SizedBox(width: 90.0, child: Text(painting, style: base, textAlign: TextAlign.center)),
          Expanded(
            child: Text(
              use,
              style: TextStyle(
                fontSize: isHeader ? 11.5 : 12.0,
                fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
                color: isHeader ? _kInkTertiary : _kInkSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget textStyleTable = _card(
    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: _cardTitle(
            'ui.TextStyle  vs  painting.TextStyle',
            subtitle: 'When to reach for the engine struct, when to reach for the widget class.',
          ),
        ),
        tableRow(field: 'field', ui: 'ui', painting: 'painting', use: 'commentary', isHeader: true),
        tableRow(field: 'color',                ui: 'yes', painting: 'yes',     use: 'Both accept Color. painting also resolves MaterialStateColor.'),
        tableRow(field: 'backgroundColor',      ui: 'no',  painting: 'yes',     use: 'painting only; the engine takes a Paint via `background` instead.'),
        tableRow(field: 'background (Paint)',   ui: 'yes', painting: 'yes',     use: 'A Paint is what the engine actually consumes; painting wraps it.'),
        tableRow(field: 'foreground (Paint)',   ui: 'yes', painting: 'yes',     use: 'When set, color is ignored - foreground wins.'),
        tableRow(field: 'fontSize',             ui: 'yes', painting: 'yes',     use: 'Logical pixels. Identical semantics in both layers.'),
        tableRow(field: 'fontWeight',           ui: 'yes', painting: 'yes',     use: 'ui.FontWeight is re-exported as FontWeight in painting.'),
        tableRow(field: 'fontStyle',            ui: 'yes', painting: 'yes',     use: 'normal vs italic - same enum, same values.'),
        tableRow(field: 'fontFamily',           ui: 'yes', painting: 'yes',     use: 'Looked up against the asset registry; first match wins.'),
        tableRow(field: 'fontFamilyFallback',   ui: 'yes', painting: 'yes',     use: 'Used when the primary family has no glyph for a codepoint.'),
        tableRow(field: 'fontFeatures',         ui: 'yes', painting: 'yes',     use: 'OpenType feature tags - tabular figures, ligatures, etc.'),
        tableRow(field: 'fontVariations',       ui: 'yes', painting: 'yes',     use: 'Variable-font axes (`wght`, `slnt`, custom).'),
        tableRow(field: 'letterSpacing',        ui: 'yes', painting: 'yes',     use: 'Per-glyph in logical pixels (not em).'),
        tableRow(field: 'wordSpacing',          ui: 'yes', painting: 'yes',     use: 'Extra space added between space-separated words.'),
        tableRow(field: 'height',               ui: 'yes', painting: 'yes',     use: 'Line height as a multiplier of fontSize.'),
        tableRow(field: 'leadingDistribution',  ui: 'yes', painting: 'yes',     use: 'How extra leading is split above/below the glyph.'),
        tableRow(field: 'decoration',           ui: 'yes', painting: 'yes',     use: 'underline / overline / lineThrough or a combine of them.'),
        tableRow(field: 'decorationColor',      ui: 'yes', painting: 'yes',     use: 'Defaults to the text color when omitted.'),
        tableRow(field: 'decorationStyle',      ui: 'yes', painting: 'yes',     use: 'solid / double / dotted / dashed / wavy.'),
        tableRow(field: 'decorationThickness',  ui: 'yes', painting: 'yes',     use: 'Multiplier of the font-defined line thickness.'),
        tableRow(field: 'shadows',              ui: 'yes', painting: 'yes',     use: 'A List<Shadow> drawn behind every glyph.'),
        tableRow(field: 'locale',               ui: 'yes', painting: 'yes',     use: 'Affects glyph variant selection and line-break rules.'),
        tableRow(field: 'debugLabel',           ui: 'no',  painting: 'yes',     use: 'painting-only - used by toString and inheritance debugging.'),
        tableRow(field: 'inherit',              ui: 'no',  painting: 'yes',     use: 'painting-only - controls merge() behaviour against parent.'),
        tableRow(field: 'overflow',             ui: 'no',  painting: 'yes',     use: 'painting-only - widget-level overflow handling.'),
      ],
    ),
  );

  final Widget tldr = _card(
    background: const Color(0xFFFFF7ED),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.compare_arrows, color: _kAccent, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'When in doubt, use painting.TextStyle.',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _kInk),
              ),
              SizedBox(height: 4.0),
              Text(
                'It is what Text, RichText, TextSpan, and DefaultTextStyle expect. '
                'Reach for ui.TextStyle only when you are pushing styles through a '
                'ui.ParagraphBuilder by hand - typically in custom render objects '
                'or when shaping text without the widget layer.',
                style: TextStyle(fontSize: 12.5, color: _kInkSecondary, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - ui.ParagraphStyle constructor showcase
  // -------------------------------------------------------------------------
  // Six cards, each constructs a real ui.ParagraphStyle with one or two
  // parameters set, and renders a small visual annotation showing the
  // effect. The annotation is rendered with the _ParagraphAnnotationPainter
  // - we do NOT call ParagraphBuilder, only construct the value type.
  // -------------------------------------------------------------------------
  Widget paragraphStyleCard({
    required String title,
    required String body,
    required ui.ParagraphStyle ps,
  }) {
    return Container(
      width: 240.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: _kInk)),
          const SizedBox(height: 2.0),
          Text(body, style: const TextStyle(fontSize: 11.5, color: _kInkSecondary, height: 1.35)),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 96.0,
            width: double.infinity,
            child: CustomPaint(painter: const _ParagraphAnnotationPainter()),
          ),
          const SizedBox(height: 6.0),
          Text(
            ps.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: _kAccentBlue,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  final ui.ParagraphStyle psAlign = ui.ParagraphStyle(textAlign: TextAlign.center, textDirection: TextDirection.ltr);
  final ui.ParagraphStyle psMaxLines = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    maxLines: 3,
    ellipsis: '...',
  );
  final ui.ParagraphStyle psFont = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    fontFamily: 'monospace',
    fontSize: 16.0,
  );
  final ui.ParagraphStyle psHeight = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    fontSize: 14.0,
    height: 1.8,
  );
  final ui.ParagraphStyle psBehavior = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    textHeightBehavior: const ui.TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
      leadingDistribution: ui.TextLeadingDistribution.proportional,
    ),
  );
  final ui.ParagraphStyle psStrut = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    strutStyle: ui.StrutStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      height: 1.5,
      leading: 0.2,
      forceStrutHeight: true,
    ),
  );

  final Widget paragraphStyleSection = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ui.ParagraphStyle showcase',
          subtitle: 'Six literal constructions, each highlighting one parameter family.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            paragraphStyleCard(
              title: 'textAlign + textDirection',
              body: 'Where the lines hang against the rect. LTR vs RTL flips left/right edges.',
              ps: psAlign,
            ),
            paragraphStyleCard(
              title: 'maxLines + ellipsis',
              body: 'Truncate after N lines. ellipsis text is inserted on the final line.',
              ps: psMaxLines,
            ),
            paragraphStyleCard(
              title: 'fontFamily + fontSize',
              body: 'Defaults for spans that do not specify their own family or size.',
              ps: psFont,
            ),
            paragraphStyleCard(
              title: 'height multiplier',
              body: 'Line height = fontSize * height. 1.0 hugs the metrics box.',
              ps: psHeight,
            ),
            paragraphStyleCard(
              title: 'textHeightBehavior',
              body: 'Skip the height multiplier on the first ascent and last descent.',
              ps: psBehavior,
            ),
            paragraphStyleCard(
              title: 'strutStyle',
              body: 'Force every line to use a fixed metric box. See section 4.',
              ps: psStrut,
            ),
          ],
        ),
      ],
    ),
  );

  final Widget paragraphStyleCode = _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.code, color: _kCodeAccent, size: 18.0),
            const SizedBox(width: 6.0),
            const Text(
              'verbatim constructor',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: _kCodeAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        _codeBlock(
          'final ui.ParagraphStyle ps = ui.ParagraphStyle(\n'
          '  textAlign: TextAlign.justify,\n'
          '  textDirection: TextDirection.ltr,\n'
          '  maxLines: 4,\n'
          '  fontFamily: \'monospace\',\n'
          '  fontSize: 14.0,\n'
          '  height: 1.4,\n'
          '  textHeightBehavior: const ui.TextHeightBehavior(\n'
          '    applyHeightToFirstAscent: true,\n'
          '    applyHeightToLastDescent: false,\n'
          '    leadingDistribution: ui.TextLeadingDistribution.even,\n'
          '  ),\n'
          '  textLeadingDistribution: ui.TextLeadingDistribution.even,\n'
          '  strutStyle: ui.StrutStyle(\n'
          '    fontFamily: \'monospace\',\n'
          '    fontSize: 14.0,\n'
          '    height: 1.4,\n'
          '    leading: 0.3,\n'
          '    forceStrutHeight: true,\n'
          '  ),\n'
          '  ellipsis: \'...\',\n'
          '  locale: const ui.Locale(\'en\', \'US\'),\n'
          ');',
          title: 'paragraph_style.dart',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - StrutStyle anatomy
  // -------------------------------------------------------------------------
  // The strut is an invisible vertical reference glyph that controls line
  // height. Two diagrams illustrate the proportional vs even leading
  // distribution, followed by a table of cells showing how forceStrutHeight
  // forces every line to the same metric box.
  // -------------------------------------------------------------------------
  Widget strutCell({
    required String title,
    required String legend,
    required ui.TextLeadingDistribution leading,
    required bool force,
  }) {
    return Container(
      width: 230.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kHairline),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _kInk)),
          const SizedBox(height: 4.0),
          Text(legend, style: const TextStyle(fontSize: 11.0, color: _kInkSecondary, height: 1.35)),
          const SizedBox(height: 6.0),
          SizedBox(
            height: 120.0,
            width: double.infinity,
            child: CustomPaint(
              painter: _StrutAnatomyPainter(leading: leading, forceStrutHeight: force),
            ),
          ),
          const SizedBox(height: 6.0),
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: <Widget>[
              _pill(
                leading == ui.TextLeadingDistribution.proportional ? 'proportional' : 'even',
                colour: _kAccentBlue,
              ),
              _pill(force ? 'forceStrutHeight' : 'soft strut', colour: force ? _kAccentRed : _kAccentTeal),
            ],
          ),
        ],
      ),
    );
  }

  final Widget strutAnatomy = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ui.StrutStyle anatomy',
          subtitle: 'Half-leading vs proportional, plus the forceStrutHeight switch.',
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF5EB),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.info_outline, color: _kAccent, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Each cell paints the box that surrounds one line. Amber bands are '
                  'leading, blue is ascent, red is descent. The horizontal amber '
                  'line is the baseline.',
                  style: TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            strutCell(
              title: 'proportional + soft strut',
              legend: 'Leading split proportionally to ascent/descent.',
              leading: ui.TextLeadingDistribution.proportional,
              force: false,
            ),
            strutCell(
              title: 'even + soft strut',
              legend: 'Half-leading: extra space is split equally top/bottom.',
              leading: ui.TextLeadingDistribution.even,
              force: false,
            ),
            strutCell(
              title: 'proportional + forced',
              legend: 'forceStrutHeight ignores per-span height: every line gets the strut box.',
              leading: ui.TextLeadingDistribution.proportional,
              force: true,
            ),
            strutCell(
              title: 'even + forced',
              legend: 'Same as above but with even leading - the most predictable layout.',
              leading: ui.TextLeadingDistribution.even,
              force: true,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _codeBlock(
          'final ui.StrutStyle s = ui.StrutStyle(\n'
          '  fontFamily: \'Roboto\',\n'
          '  fontSize: 16.0,\n'
          '  height: 1.5,\n'
          '  leading: 0.2,\n'
          '  fontWeight: ui.FontWeight.w500,\n'
          '  fontStyle: ui.FontStyle.normal,\n'
          '  forceStrutHeight: true,\n'
          '  leadingDistribution: ui.TextLeadingDistribution.proportional,\n'
          ');',
          title: 'strut_style.dart',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - TextBox + TextRange + TextPosition + TextAffinity
  // -------------------------------------------------------------------------
  // We construct one instance of each, print the constructor output, then
  // render a CustomPainter that imitates a laid-out paragraph with three
  // selection rectangles (TextBoxes), a caret at TextPosition(offset: 12)
  // and a small arrow indicating the affinity.
  // -------------------------------------------------------------------------
  Widget layoutOverlayCard({required ui.TextAffinity affinity, required String label}) {
    return Container(
      width: 320.0,
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
          Text(label, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: _kInk)),
          const SizedBox(height: 4.0),
          Text(
            'TextPosition(offset: 12, affinity: '
            '${affinity == ui.TextAffinity.downstream ? "downstream" : "upstream"})',
            style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kAccentBlue),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            height: 110.0,
            width: double.infinity,
            child: CustomPaint(painter: _LayoutOverlayPainter(affinity: affinity)),
          ),
        ],
      ),
    );
  }

  final Widget textBoxSection = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'TextBox + TextRange + TextPosition + TextAffinity',
          subtitle: 'Engine returns these four when reporting selection geometry.',
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'const ui.TextRange range = ui.TextRange(start: 7, end: 12);\n'
          'final ui.TextBox box = ui.TextBox.fromLTRBD(10, 20, 110, 42, TextDirection.ltr);\n'
          'const ui.TextPosition pos = ui.TextPosition(\n'
          '  offset: 12,\n'
          '  affinity: ui.TextAffinity.downstream,\n'
          ');\n'
          'print(box.toRect()); // Rect.fromLTRB(10.0, 20.0, 110.0, 42.0)\n'
          'print(range.isCollapsed); // false\n'
          'print(range.textInside(\'Hello, World!\')); // World',
          title: 'selection_geometry.dart',
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: <Widget>[
            layoutOverlayCard(affinity: ui.TextAffinity.downstream, label: 'affinity: downstream'),
            layoutOverlayCard(affinity: ui.TextAffinity.upstream, label: 'affinity: upstream'),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F2F6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Constructor values',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: _kInkTertiary, letterSpacing: 0.4),
              ),
              const SizedBox(height: 6.0),
              Text('TextRange.start         = ${range.start}',         style: _kBodyStyle),
              Text('TextRange.end           = ${range.end}',           style: _kBodyStyle),
              Text('TextRange.isCollapsed   = ${range.isCollapsed}',   style: _kBodyStyle),
              Text('TextRange.isNormalized  = ${range.isNormalized}',  style: _kBodyStyle),
              Text('TextPosition.offset     = ${positionDown.offset}', style: _kBodyStyle),
              Text('TextPosition.affinity   = ${positionDown.affinity}', style: _kBodyStyle),
              Text('TextBox.toRect()        = ${box1.toRect()}',       style: _kBodyStyle),
              Text('TextBox.direction       = ${box1.direction}',      style: _kBodyStyle),
              Text('boxRtl.direction        = ${boxRtl.direction}',    style: _kBodyStyle),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - TextAlign x TextDirection grid
  // -------------------------------------------------------------------------
  // 12 cells (4 align values x 3 direction-or-system rules). Each cell is a
  // small paragraph laid out by Flutter's regular Text widget so the
  // alignment is visually obvious.
  // -------------------------------------------------------------------------
  const String sampleParagraph =
      'The Engine Lays Out Text One Glyph At A Time, Aligning Lines To Edges Defined By The Caller.';
  Widget alignCell({required TextAlign align, required TextDirection dir, required String label}) {
    return Container(
      width: 220.0,
      height: 130.0,
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
          Text(label, style: const TextStyle(fontSize: 11.0, color: _kAccentBlue, fontFamily: 'monospace')),
          const SizedBox(height: 6.0),
          Expanded(
            child: Directionality(
              textDirection: dir,
              child: Text(
                sampleParagraph,
                textAlign: align,
                style: const TextStyle(fontSize: 11.5, height: 1.35, color: _kInk),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget alignGrid = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'TextAlign x TextDirection',
          subtitle: 'Twelve cells: four alignments against three direction rules.',
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: <Widget>[
            alignCell(align: TextAlign.left,    dir: TextDirection.ltr, label: 'left   / ltr'),
            alignCell(align: TextAlign.right,   dir: TextDirection.ltr, label: 'right  / ltr'),
            alignCell(align: TextAlign.center,  dir: TextDirection.ltr, label: 'center / ltr'),
            alignCell(align: TextAlign.justify, dir: TextDirection.ltr, label: 'justify/ ltr'),
            alignCell(align: TextAlign.left,    dir: TextDirection.rtl, label: 'left   / rtl'),
            alignCell(align: TextAlign.right,   dir: TextDirection.rtl, label: 'right  / rtl'),
            alignCell(align: TextAlign.center,  dir: TextDirection.rtl, label: 'center / rtl'),
            alignCell(align: TextAlign.justify, dir: TextDirection.rtl, label: 'justify/ rtl'),
            alignCell(align: TextAlign.start,   dir: TextDirection.ltr, label: 'start  / ltr (= left)'),
            alignCell(align: TextAlign.end,     dir: TextDirection.ltr, label: 'end    / ltr (= right)'),
            alignCell(align: TextAlign.start,   dir: TextDirection.rtl, label: 'start  / rtl (= right)'),
            alignCell(align: TextAlign.end,     dir: TextDirection.rtl, label: 'end    / rtl (= left)'),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentBlue.withOpacity(0.25)),
          ),
          child: const Text(
            'start/end follow ambient TextDirection; left/right are absolute. '
            'Use start/end in bilingual UIs - users will switch languages.',
            style: TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - TextDecoration variants gallery
  // -------------------------------------------------------------------------
  // ~15 cards covering the cross product of (underline / overline /
  // lineThrough) x (solid / double / dotted / dashed / wavy) plus a couple
  // of color variants and a combine() example.
  // -------------------------------------------------------------------------
  Widget decoCard(String label, TextDecoration deco, TextDecorationStyle style, Color color) {
    return Container(
      width: 170.0,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 10.5, color: _kInkTertiary, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Hello, World',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: _kInk,
              decoration: deco,
              decorationStyle: style,
              decorationColor: color,
              decorationThickness: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  final TextDecoration combinedUnderOver = TextDecoration.combine(<TextDecoration>[
    TextDecoration.underline,
    TextDecoration.overline,
  ]);
  final TextDecoration combinedAllThree = TextDecoration.combine(<TextDecoration>[
    TextDecoration.underline,
    TextDecoration.overline,
    TextDecoration.lineThrough,
  ]);

  final Widget decorationGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'TextDecoration x TextDecorationStyle',
          subtitle: 'Underline, overline, lineThrough crossed with five line styles and a few colors.',
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: <Widget>[
            decoCard('underline / solid',     TextDecoration.underline,   TextDecorationStyle.solid,  _kInk),
            decoCard('underline / double',    TextDecoration.underline,   TextDecorationStyle.double, _kAccentBlue),
            decoCard('underline / dotted',    TextDecoration.underline,   TextDecorationStyle.dotted, _kAccentRed),
            decoCard('underline / dashed',    TextDecoration.underline,   TextDecorationStyle.dashed, _kAccent),
            decoCard('underline / wavy',      TextDecoration.underline,   TextDecorationStyle.wavy,   _kAccentGreen),
            decoCard('overline / solid',      TextDecoration.overline,    TextDecorationStyle.solid,  _kInk),
            decoCard('overline / double',     TextDecoration.overline,    TextDecorationStyle.double, _kAccentTeal),
            decoCard('overline / dashed',     TextDecoration.overline,    TextDecorationStyle.dashed, _kAccentIndigo),
            decoCard('lineThrough / solid',   TextDecoration.lineThrough, TextDecorationStyle.solid,  _kInk),
            decoCard('lineThrough / double',  TextDecoration.lineThrough, TextDecorationStyle.double, _kAccentRed),
            decoCard('lineThrough / dotted',  TextDecoration.lineThrough, TextDecorationStyle.dotted, _kAccentBlue),
            decoCard('lineThrough / dashed',  TextDecoration.lineThrough, TextDecorationStyle.dashed, _kAccentPink),
            decoCard('lineThrough / wavy',    TextDecoration.lineThrough, TextDecorationStyle.wavy,   _kAccentViolet),
            decoCard('combine: under+over',   combinedUnderOver,          TextDecorationStyle.solid,  _kAccent),
            decoCard('combine: all three',    combinedAllThree,           TextDecorationStyle.wavy,   _kAccentIndigo),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.tips_and_updates, color: _kAccent, size: 18.0),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'TextDecoration.combine([a, b]).contains(a) is your friend for '
                  'composing complex decorations. The set semantics make it cheap '
                  'to add/remove a single line.',
                  style: const TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - FontWeight x FontStyle gallery
  // -------------------------------------------------------------------------
  // 9 weights (w100..w900) x 2 styles (normal, italic) = 18 chips arranged
  // in a tidy grid. The actual rendered weight depends on the font having
  // a matching variant; for common system fonts most weights are present.
  // -------------------------------------------------------------------------
  Widget weightChip(FontWeight weight, FontStyle style, String label) {
    return Container(
      width: 140.0,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: const TextStyle(fontSize: 10.5, color: _kInkTertiary, fontFamily: 'monospace')),
          const SizedBox(height: 4.0),
          Text(
            'Aa Bb 123',
            style: TextStyle(fontSize: 18.0, color: _kInk, fontWeight: weight, fontStyle: style),
          ),
        ],
      ),
    );
  }

  final List<MapEntry<FontWeight, String>> _weights = const <MapEntry<FontWeight, String>>[
    MapEntry(FontWeight.w100, 'w100 Thin'),
    MapEntry(FontWeight.w200, 'w200 ExtraLight'),
    MapEntry(FontWeight.w300, 'w300 Light'),
    MapEntry(FontWeight.w400, 'w400 Normal'),
    MapEntry(FontWeight.w500, 'w500 Medium'),
    MapEntry(FontWeight.w600, 'w600 SemiBold'),
    MapEntry(FontWeight.w700, 'w700 Bold'),
    MapEntry(FontWeight.w800, 'w800 ExtraBold'),
    MapEntry(FontWeight.w900, 'w900 Black'),
  ];

  final Widget weightGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'FontWeight x FontStyle',
          subtitle: 'Nine numeric weights crossed with normal/italic.',
        ),
        const SizedBox(height: 10.0),
        const Text(
          'normal',
          style: TextStyle(fontSize: 12.0, color: _kInkTertiary, fontWeight: FontWeight.w700, letterSpacing: 0.4),
        ),
        const SizedBox(height: 4.0),
        Wrap(
          children: <Widget>[
            for (final MapEntry<FontWeight, String> e in _weights)
              weightChip(e.key, FontStyle.normal, e.value),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'italic',
          style: TextStyle(fontSize: 12.0, color: _kInkTertiary, fontWeight: FontWeight.w700, letterSpacing: 0.4),
        ),
        const SizedBox(height: 4.0),
        Wrap(
          children: <Widget>[
            for (final MapEntry<FontWeight, String> e in _weights)
              weightChip(e.key, FontStyle.italic, e.value),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'FontWeight is an opaque class wrapping a numeric index. FontWeight.normal == w400 and '
            'FontWeight.bold == w700. Variable fonts honour any value via fontVariations: '
            'FontVariation(\'wght\', N).',
            style: TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - ui.Locale construction
  // -------------------------------------------------------------------------
  // Eight cards. Each builds a Locale via either the two-arg constructor or
  // fromSubtags, and prints both the toString form and the toLanguageTag().
  // -------------------------------------------------------------------------
  Widget localeCard({
    required ui.Locale loc,
    required String constructor,
    required String hint,
  }) {
    return Container(
      width: 240.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
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
              const Icon(Icons.language, color: _kAccent, size: 18.0),
              const SizedBox(width: 6.0),
              Text(
                loc.toString(),
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _kInk, fontFamily: 'monospace'),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            constructor,
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _kAccentBlue,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'toLanguageTag(): ${loc.toLanguageTag()}',
            style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInkSecondary),
          ),
          if (loc.scriptCode != null) ...<Widget>[
            const SizedBox(height: 2.0),
            Text(
              'scriptCode: ${loc.scriptCode}',
              style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInkSecondary),
            ),
          ],
          const SizedBox(height: 6.0),
          Text(hint, style: const TextStyle(fontSize: 11.5, color: _kInkSecondary, height: 1.35)),
        ],
      ),
    );
  }

  final Widget localeSection = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ui.Locale construction',
          subtitle: 'Eight named locales, demonstrating two-arg vs fromSubtags constructors.',
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: <Widget>[
            localeCard(
              loc: const ui.Locale('en', 'US'),
              constructor: "const ui.Locale('en', 'US')",
              hint: 'American English. Decimal point, MDY dates, USD currency.',
            ),
            localeCard(
              loc: const ui.Locale('en', 'GB'),
              constructor: "const ui.Locale('en', 'GB')",
              hint: 'British English. DMY dates, GBP currency.',
            ),
            localeCard(
              loc: const ui.Locale('fr', 'FR'),
              constructor: "const ui.Locale('fr', 'FR')",
              hint: 'French. Comma as decimal separator.',
            ),
            localeCard(
              loc: ui.Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
              constructor: "ui.Locale.fromSubtags(\n  languageCode: 'ja',\n  countryCode: 'JP',\n)",
              hint: 'Japanese. CJK linebreaks differ; vertical writing if asked.',
            ),
            localeCard(
              loc: ui.Locale.fromSubtags(languageCode: 'ar', countryCode: 'EG'),
              constructor: "ui.Locale.fromSubtags(\n  languageCode: 'ar',\n  countryCode: 'EG',\n)",
              hint: 'Arabic (Egypt). Right-to-left script; contextual glyph forms.',
            ),
            localeCard(
              loc: const ui.Locale('de', 'DE'),
              constructor: "const ui.Locale('de', 'DE')",
              hint: 'German. Long compound words may exceed expected widths.',
            ),
            localeCard(
              loc: ui.Locale.fromSubtags(
                languageCode: 'zh',
                scriptCode: 'Hans',
                countryCode: 'CN',
              ),
              constructor: "ui.Locale.fromSubtags(\n  languageCode: 'zh',\n  scriptCode: 'Hans',\n  countryCode: 'CN',\n)",
              hint: 'Chinese, simplified script, mainland China.',
            ),
            localeCard(
              loc: ui.Locale.fromSubtags(
                languageCode: 'zh',
                scriptCode: 'Hant',
                countryCode: 'TW',
              ),
              constructor: "ui.Locale.fromSubtags(\n  languageCode: 'zh',\n  scriptCode: 'Hant',\n  countryCode: 'TW',\n)",
              hint: 'Chinese, traditional script, Taiwan. Different glyph variants.',
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _codeBlock(
          '// Serialization round-trip\n'
          "const ui.Locale a = ui.Locale('en', 'US');\n"
          "assert(a.toString()        == 'en_US');\n"
          "assert(a.toLanguageTag()   == 'en-US');\n"
          "assert(a.languageCode      == 'en');\n"
          "assert(a.countryCode       == 'US');\n"
          "assert(a.scriptCode        == null);",
          title: 'locale_round_trip.dart',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - Pitfalls
  // -------------------------------------------------------------------------
  // Five callouts covering the most common ways to misuse the text data
  // types: copyWith null collisions, dart:ui vs painting confusion, strut +
  // height interaction, locale-sensitive metrics, deprecated decorations.
  // -------------------------------------------------------------------------
  Widget pitfallRow(IconData icon, String title, String body, Color colour) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colour.withOpacity(0.14),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: colour, size: 16.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: _kInk)),
                const SizedBox(height: 2.0),
                Text(body, style: const TextStyle(fontSize: 12.5, height: 1.45, color: _kInkSecondary)),
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
            const Icon(Icons.warning_amber_rounded, color: _kAccent, size: 22.0),
            const SizedBox(width: 8.0),
            _cardTitle(
              'Pitfalls',
              subtitle: 'Five misuses of the text value types that ship far too often.',
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        pitfallRow(
          Icons.copy_all,
          'TextStyle.copyWith null collisions',
          'copyWith only replaces fields you name; it cannot clear a field back to null. '
          "To remove an inherited color, use TextStyle(inherit: false, ...) instead of copyWith(color: null).",
          _kAccentRed,
        ),
        pitfallRow(
          Icons.compare,
          'dart:ui vs painting confusion',
          'ui.TextStyle has no debugLabel, inherit or overflow fields. If you write ui.TextStyle '
          "expecting the painting API, the analyzer will complain about missing parameters. Alias dart:ui as `ui` to keep them visually distinct.",
          _kAccentBlue,
        ),
        pitfallRow(
          Icons.stacked_line_chart,
          'strut + height interaction',
          'TextStyle.height and StrutStyle.height are independent. With forceStrutHeight: true, the strut wins '
          'and per-span heights are ignored. Without it, the engine takes the max of strut and span heights.',
          _kAccentIndigo,
        ),
        pitfallRow(
          Icons.translate,
          'locale-sensitive glyph metrics',
          'The same codepoint can be shaped to different glyphs in zh-Hans vs zh-Hant or in ja-JP vs zh-CN. '
          'Always pass a locale on TextStyle (or ParagraphStyle) when text contains CJK content.',
          _kAccentTeal,
        ),
        pitfallRow(
          Icons.do_not_disturb_alt,
          'deprecated TextDecoration.none chains',
          'Old code sometimes uses copyWith(decoration: TextDecoration.none) to clear inherited decoration. '
          'This still works, but DefaultTextStyle.merge plus the modern decoration cascade are cleaner and avoid surprises.',
          _kAccentPink,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // BONUS - ui.LineMetrics value-only construction
  // -------------------------------------------------------------------------
  // We do not call Paragraph.computeLineMetrics() because that requires an
  // engine paragraph. Instead we construct a sample LineMetrics value with
  // sensible numbers and surface the field set, so callers can see what the
  // engine would normally return.
  // -------------------------------------------------------------------------
  final ui.LineMetrics sampleMetrics = ui.LineMetrics(
    hardBreak: false,
    ascent: 12.4,
    descent: 3.2,
    unscaledAscent: 11.7,
    height: 19.0,
    width: 234.5,
    left: 0.0,
    baseline: 15.4,
    lineNumber: 0,
  );
  print('  built ui.LineMetrics: $sampleMetrics');

  final Widget lineMetricsCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ui.LineMetrics (value only)',
          subtitle: 'The struct the engine returns from Paragraph.computeLineMetrics().',
        ),
        const SizedBox(height: 8.0),
        _codeBlock(
          'const ui.LineMetrics m = ui.LineMetrics(\n'
          '  hardBreak: false,\n'
          '  ascent: 12.4,\n'
          '  descent: 3.2,\n'
          '  unscaledAscent: 11.7,\n'
          '  height: 19.0,\n'
          '  width: 234.5,\n'
          '  left: 0.0,\n'
          '  baseline: 15.4,\n'
          '  lineNumber: 0,\n'
          ');',
          title: 'line_metrics.dart',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: <Widget>[
              _pill('hardBreak: ${sampleMetrics.hardBreak}',  colour: _kAccentBlue),
              _pill('ascent: ${sampleMetrics.ascent}',        colour: _kAccent),
              _pill('descent: ${sampleMetrics.descent}',      colour: _kAccentRed),
              _pill('height: ${sampleMetrics.height}',        colour: _kAccentGreen),
              _pill('width: ${sampleMetrics.width}',          colour: _kAccentIndigo),
              _pill('baseline: ${sampleMetrics.baseline}',    colour: _kAccentTeal),
              _pill('lineNumber: ${sampleMetrics.lineNumber}', colour: _kAccentViolet),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - Footer cheat-sheet
  // -------------------------------------------------------------------------
  // A dark card with four chip groups (Style, Geometry, Enums, Locale)
  // plus an API tagline.
  // -------------------------------------------------------------------------
  final Widget footer = Container(
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
            Icon(Icons.bookmark, color: Color(0xFFFCD34D), size: 22.0),
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
          'every text value type in this gallery, sorted by family.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 14.0),
        DefaultTextStyle(
          style: const TextStyle(color: _kInkOnDark),
          child: Wrap(
            spacing: 24.0,
            runSpacing: 14.0,
            children: <Widget>[
              _chipGroup('Style classes', const <String>[
                'ui.TextStyle',
                'painting.TextStyle',
                'ui.ParagraphStyle',
                'ui.StrutStyle',
                'ui.TextHeightBehavior',
              ], const Color(0xFFFCD34D)),
              _chipGroup('Geometry', const <String>[
                'ui.TextBox',
                'ui.TextRange',
                'ui.TextPosition',
                'ui.LineMetrics',
              ], const Color(0xFF93C5FD)),
              _chipGroup('Enums', const <String>[
                'TextAlign',
                'TextDirection',
                'TextAffinity',
                'TextLeadingDistribution',
                'TextDecoration',
                'TextDecorationStyle',
                'FontStyle',
                'FontWeight',
              ], const Color(0xFFFCA5A5)),
              _chipGroup('Locale', const <String>[
                'ui.Locale',
                'Locale.fromSubtags',
                'toLanguageTag()',
              ], const Color(0xFFA7F3D0)),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF26282E),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.bolt, color: Color(0xFFFCD34D), size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'dart:ui is the engine boundary; painting.dart wraps it; widgets layer on top. '
                  'Use painting.TextStyle for widget trees, ui.TextStyle for ParagraphBuilder, '
                  'and reach for the geometry types only when computing selection / hit-test '
                  'rectangles by hand.',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: _kInkOnDark,
                    height: 1.45,
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
  // ASSEMBLE THE GALLERY
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sections = <Widget>[
    heroIntro,
    _sectionHeader(2, 'TextStyle table',     'ui.TextStyle vs painting.TextStyle, field by field'),
    textStyleTable,
    tldr,
    _sectionHeader(3, 'ParagraphStyle',      'Six literal constructions with annotation diagrams'),
    paragraphStyleSection,
    paragraphStyleCode,
    _sectionHeader(4, 'StrutStyle anatomy',  'Half-leading vs proportional, forceStrutHeight'),
    strutAnatomy,
    _sectionHeader(5, 'TextBox + friends',   'Selection geometry: TextBox / TextRange / TextPosition / TextAffinity'),
    textBoxSection,
    _sectionDivider(),
    _sectionHeader(6, 'Align grid',          'TextAlign x TextDirection, 12 cells'),
    alignGrid,
    _sectionHeader(7, 'Decoration gallery',  'TextDecoration crossed with TextDecorationStyle'),
    decorationGallery,
    _sectionHeader(8, 'Weight + style',      'FontWeight x FontStyle - 18 sample chips'),
    weightGallery,
    _sectionHeader(9, 'Locale',              'ui.Locale and Locale.fromSubtags - 8 named locales'),
    localeSection,
    _sectionHeader(10, 'Pitfalls',           'Five common mistakes'),
    pitfalls,
    lineMetricsCard,
    _sectionHeader(11, 'Cheat sheet',        'Every type, grouped by family'),
    footer,
  ];
  print('  section widget count: ${sections.length}');

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kCanvas,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        title: const Text('dart:ui Text Data Types'),
        backgroundColor: _kCardDark,
        foregroundColor: _kInkOnDark,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sections,
        ),
      ),
    ),
  );

  print('dart:ui text data deep visual demo built successfully');
  return app;
}
