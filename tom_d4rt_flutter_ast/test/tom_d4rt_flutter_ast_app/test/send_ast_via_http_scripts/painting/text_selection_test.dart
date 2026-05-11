// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// text_selection_test.dart
// -----------------------------------------------------------------------------
// Deep visual exploration of Flutter's text-selection model from
// `package:flutter/painting.dart`.  We dissect the four key types that the
// painting layer and EditableText use to describe selected ranges of text:
//
//   * TextRange      -- an unanchored [start, end) interval over a string.
//   * TextPosition   -- a cursor location plus a TextAffinity tie-breaker.
//   * TextAffinity   -- which side of an ambiguous offset the caret sits on.
//   * TextSelection  -- a directional selection with base + extent offsets.
//
// The aim is to make the semantics tactile rather than abstract: we paint the
// selected glyphs of a sample string, mark the base/extent positions with
// distinct caret colours, render line-break markers, and badge the affinity
// of each position.  Several worked examples revisit the same sample string
// with different bases, extents and affinities so the differences pop visually.
//
// File contract for the d4rt flutter_ast corpus:
//   * No `main`, no `runApp`, no `Timer`/`Future`/`Stream`.
//   * Top-level `dynamic build(BuildContext context)` returning a MaterialApp.
//   * Manual authoring -- no codegen, no generated comment headers.
// =============================================================================

import 'package:flutter/material.dart';

// =============================================================================
// Palette
// -----------------------------------------------------------------------------
// We use a single coherent palette across every section.  The accents map to
// semantic ideas in the selection model: base is teal, extent is amber, the
// caret line is purple, line-break markers are slate, and the selected glyphs
// receive a soft rose underlay.  Using a small fixed palette keeps the eye
// trained on the structural difference between the eight visual sections.
// =============================================================================

const Color _kBgDeep = Color(0xFF0F172A);
const Color _kBgMid = Color(0xFF1E293B);
const Color _kBgSoft = Color(0xFF273449);
const Color _kPanel = Color(0xFFF8FAFC);
const Color _kPanelAlt = Color(0xFFEFF6FF);
const Color _kPanelWarn = Color(0xFFFFFBEB);
const Color _kPanelInfo = Color(0xFFECFEFF);
const Color _kPanelOk = Color(0xFFECFDF5);

const Color _kInk = Color(0xFF0B1220);
const Color _kInkSoft = Color(0xFF334155);
const Color _kInkMute = Color(0xFF64748B);

const Color _kAccentBase = Color(0xFF0D9488); // teal -- base offset
const Color _kAccentExtent = Color(0xFFD97706); // amber -- extent offset
const Color _kAccentCaret = Color(0xFF7C3AED); // purple -- caret rod
const Color _kAccentSel = Color(0xFFFB7185); // rose -- selection underlay
const Color _kAccentBreak = Color(0xFF475569); // slate -- line break tick
const Color _kAccentUp = Color(0xFF2563EB); // blue -- upstream affinity
const Color _kAccentDown = Color(0xFF16A34A); // green -- downstream affinity

const double _kRadius = 18.0;

// =============================================================================
// CustomPainter: SelectionVisualizer
// -----------------------------------------------------------------------------
// Paints a single line of monospaced glyph cells, drawing:
//
//   * A rose underlay for every cell inside the [start, end) range.
//   * A teal caret rod for the base offset.
//   * An amber caret rod for the extent offset (if different from base).
//   * A small slate tick wherever a "\n" appears in the underlying string.
//   * A pair of affinity badges ("up"/"down") next to base and extent.
//
// We do not lay out the string with a real TextPainter for this anatomy
// diagram.  Instead we treat the string as a sequence of fixed-width cells.
// This keeps the geometry trivial and the visualisation honest: each cell
// is exactly one offset, so the relationship between offsets and pixels is
// explicit and unambiguous.
// =============================================================================

class _SelectionVisualizer extends CustomPainter {
  _SelectionVisualizer({
    required this.sample,
    required this.selection,
    required this.label,
  });

  final String sample;
  final TextSelection selection;
  final String label;

  static const double cellWidth = 22.0;
  static const double cellHeight = 38.0;
  static const double topPad = 30.0;
  static const double leftPad = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Frame background.
    final framePaint = Paint()..color = Colors.white;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(12),
    );
    canvas.drawRRect(rrect, framePaint);

    // Top label.
    final labelStyle = const TextStyle(
      color: _kInkSoft,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      fontFamily: 'monospace',
    );
    final labelTp = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 24);
    labelTp.paint(canvas, const Offset(12, 8));

    // Compute selection bounds (normalised) and other markers.
    final s = selection;
    final selStart = s.start;
    final selEnd = s.end;
    final base = s.baseOffset;
    final extent = s.extentOffset;

    // Selection underlay.
    if (selStart < selEnd) {
      final underlay = Paint()..color = _kAccentSel.withValues(alpha: 0.45);
      for (int i = selStart; i < selEnd; i++) {
        final r = Rect.fromLTWH(
          leftPad + i * cellWidth,
          topPad,
          cellWidth,
          cellHeight,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(4)),
          underlay,
        );
      }
    }

    // Glyph cells.
    final cellOutline = Paint()
      ..color = _kInkMute.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final glyphStyle = const TextStyle(
      color: _kInk,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'monospace',
    );

    for (int i = 0; i < sample.length; i++) {
      final r = Rect.fromLTWH(
        leftPad + i * cellWidth,
        topPad,
        cellWidth,
        cellHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        cellOutline,
      );

      final ch = sample[i];
      final shown = ch == '\n' ? '\u00B6' : ch;
      final tp = TextPainter(
        text: TextSpan(text: shown, style: glyphStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      final cx = leftPad + i * cellWidth + (cellWidth - tp.width) / 2;
      final cy = topPad + (cellHeight - tp.height) / 2;
      tp.paint(canvas, Offset(cx, cy));

      // Line break tick.
      if (ch == '\n') {
        final breakPaint = Paint()
          ..color = _kAccentBreak
          ..strokeWidth = 1.5;
        canvas.drawLine(
          Offset(leftPad + (i + 1) * cellWidth, topPad - 4),
          Offset(leftPad + (i + 1) * cellWidth, topPad + cellHeight + 4),
          breakPaint,
        );
      }
    }

    // Offset ruler beneath cells.
    final rulerStyle = const TextStyle(
      color: _kInkMute,
      fontSize: 9,
      fontFamily: 'monospace',
    );
    for (int i = 0; i <= sample.length; i++) {
      final tp = TextPainter(
        text: TextSpan(text: '$i', style: rulerStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      final cx = leftPad + i * cellWidth - tp.width / 2;
      tp.paint(canvas, Offset(cx, topPad + cellHeight + 4));
    }

    // Caret rods (base and extent).
    _paintCaret(canvas, base, _kAccentBase, _isUpstreamAt(base));
    if (extent != base) {
      _paintCaret(canvas, extent, _kAccentExtent, _isUpstreamAt(extent));
    }

    // Caret legend strip.
    final legendY = topPad + cellHeight + 22;
    _paintLegendDot(canvas, leftPad, legendY, _kAccentBase, 'base=$base');
    _paintLegendDot(
      canvas,
      leftPad + 110,
      legendY,
      _kAccentExtent,
      'extent=$extent',
    );
    final dirText = base == extent
        ? 'collapsed'
        : (base < extent ? 'forward >>' : 'backward <<');
    _paintLegendDot(canvas, leftPad + 230, legendY, _kAccentCaret, dirText);
  }

  bool _isUpstreamAt(int offset) {
    return selection.affinity == TextAffinity.upstream;
  }

  void _paintCaret(Canvas canvas, int offset, Color color, bool upstream) {
    final x = leftPad + offset * cellWidth;
    final caretPaint = Paint()
      ..color = color
      ..strokeWidth = 2.4;
    canvas.drawLine(
      Offset(x, topPad - 6),
      Offset(x, topPad + cellHeight + 6),
      caretPaint,
    );

    // Knob.
    canvas.drawCircle(Offset(x, topPad - 8), 4, Paint()..color = color);

    // Affinity badge.
    final badgeText = upstream ? 'up' : 'down';
    final badgeColor = upstream ? _kAccentUp : _kAccentDown;
    final badgeBg = Paint()..color = badgeColor.withValues(alpha: 0.15);
    final badgeRect = Rect.fromLTWH(x + 4, topPad - 16, 26, 14);
    canvas.drawRRect(
      RRect.fromRectAndRadius(badgeRect, const Radius.circular(7)),
      badgeBg,
    );
    final badgeStyle = TextStyle(
      color: badgeColor,
      fontSize: 9,
      fontWeight: FontWeight.w700,
      fontFamily: 'monospace',
    );
    final tp = TextPainter(
      text: TextSpan(text: badgeText, style: badgeStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x + 4 + (26 - tp.width) / 2, topPad - 15));
  }

  void _paintLegendDot(
    Canvas canvas,
    double x,
    double y,
    Color color,
    String text,
  ) {
    canvas.drawCircle(Offset(x + 5, y + 5), 4.5, Paint()..color = color);
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: _kInkSoft,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x + 14, y));
  }

  @override
  bool shouldRepaint(covariant _SelectionVisualizer old) {
    return old.sample != sample ||
        old.selection != selection ||
        old.label != label;
  }
}

// =============================================================================
// Section helpers
// -----------------------------------------------------------------------------
// Every section uses the same gradient-shadow frame to keep the document
// visually coherent.  The frame combines a multi-stop gradient with two
// shadow layers: a tight ambient drop and a softer spread.  Together they
// produce the lifted "card" effect requested in the visual rules.
// =============================================================================

BoxDecoration _sectionFrame({
  required List<Color> gradient,
  required Color shadowColor,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: gradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(_kRadius),
    boxShadow: [
      BoxShadow(
        color: shadowColor.withValues(alpha: 0.35),
        blurRadius: 24,
        spreadRadius: 1,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.18),
        blurRadius: 6,
        spreadRadius: 0,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

Widget _sectionTitle(String index, String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              index,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.4,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.78),
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ),
    ],
  );
}

Widget _prose(String text) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInk,
        fontSize: 13.5,
        height: 1.55,
      ),
    ),
  );
}

Widget _codeCard(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_kBgDeep, _kBgMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFE2E8F0),
        fontSize: 12.5,
        height: 1.45,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _kvRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            key,
            style: const TextStyle(
              color: _kInkSoft,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _kInk,
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _statCard({
  required String title,
  required String value,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    width: 168,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.22),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: accent),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: _kInk,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color.withValues(alpha: 0.7), width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =============================================================================
// Build entry point
// -----------------------------------------------------------------------------
// The d4rt harness invokes this top-level function with a BuildContext.  We
// return a MaterialApp so the harness can render it as an isolated page.  All
// state is scoped inside StatefulBuilder where needed.
// =============================================================================

dynamic build(BuildContext context) {
  // --- Construct canonical instances -----------------------------------------
  // These objects are referenced by both the prose and the diagrams.
  final pos0 = const TextPosition(offset: 0);
  final pos5 = const TextPosition(offset: 5);
  final posUp = const TextPosition(
    offset: 10,
    affinity: TextAffinity.upstream,
  );
  final posDown = const TextPosition(
    offset: 10,
    affinity: TextAffinity.downstream,
  );

  final range05 = const TextRange(start: 0, end: 5);
  final rangeFlipped = const TextRange(start: 5, end: 0);
  final rangeEmpty = TextRange.empty;
  final rangeCollapsed = const TextRange.collapsed(3);

  final selForward = const TextSelection(baseOffset: 0, extentOffset: 5);
  final selBackward = const TextSelection(baseOffset: 9, extentOffset: 2);
  final selCollapsed = const TextSelection.collapsed(offset: 7);
  final selFromPos = TextSelection.fromPosition(pos5);
  final selUp = const TextSelection(
    baseOffset: 3,
    extentOffset: 11,
    affinity: TextAffinity.upstream,
  );
  final selDown = const TextSelection(
    baseOffset: 3,
    extentOffset: 11,
    affinity: TextAffinity.downstream,
  );

  const sample = 'Hello,\nWorld!';
  const sampleSpaced = 'lorem ipsum';

  // Worked-example console output ---------------------------------------------
  print('-- text_selection_test.dart --');
  print('range05.isValid = ${range05.isValid}');
  print('range05.isNormalized = ${range05.isNormalized}');
  print('range05.isCollapsed = ${range05.isCollapsed}');
  print('rangeFlipped.isNormalized = ${rangeFlipped.isNormalized}');
  print('rangeEmpty.isCollapsed = ${rangeEmpty.isCollapsed}');
  print('rangeCollapsed.isCollapsed = ${rangeCollapsed.isCollapsed}');
  print('textBefore(0,5) = "${range05.textBefore(sample)}"');
  print('textInside(0,5) = "${range05.textInside(sample)}"');
  print('textAfter(0,5)  = "${range05.textAfter(sample)}"');
  print('pos0.affinity = ${pos0.affinity}');
  print('posUp.affinity = ${posUp.affinity}');
  print('posDown.affinity = ${posDown.affinity}');
  print('selForward.isCollapsed = ${selForward.isCollapsed}');
  print('selBackward base/extent = ${selBackward.baseOffset}/${selBackward.extentOffset}');
  print('selBackward.start..end = ${selBackward.start}..${selBackward.end}');
  print('selCollapsed.isCollapsed = ${selCollapsed.isCollapsed}');
  print('selFromPos.baseOffset = ${selFromPos.baseOffset}');
  print('selUp.affinity = ${selUp.affinity}');
  print('selDown.affinity = ${selDown.affinity}');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF1F5F9),
      textTheme: const TextTheme().apply(
        bodyColor: _kInk,
        displayColor: _kInk,
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------------------------------------------------------------
              // Hero header
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF1E3A8A), Color(0xFF7C3AED)],
                  shadowColor: const Color(0xFF7C3AED),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.format_quote,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Text(
                            'Anatomy of TextSelection',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'TextRange, TextPosition, TextAffinity and TextSelection are '
                      'the four small but load-bearing types that the Flutter '
                      'painting layer uses to describe selected ranges inside a '
                      'string.  EditableText, RenderEditable and the cursor '
                      'painter all read these structures every frame.  This '
                      'document explores them visually: we render the sample '
                      'string with selection underlays, mark base and extent '
                      'carets in distinct colours, and surface the affinity '
                      'tie-breaker as a small badge above each caret.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _chip('TextRange', _kAccentSel),
                        _chip('TextPosition', _kAccentCaret),
                        _chip('TextAffinity.up', _kAccentUp),
                        _chip('TextAffinity.down', _kAccentDown),
                        _chip('base', _kAccentBase),
                        _chip('extent', _kAccentExtent),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 1 -- TextRange semantics
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF0F766E), Color(0xFF14B8A6)],
                  shadowColor: const Color(0xFF14B8A6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '01',
                      'TextRange -- the unanchored interval',
                      'A half-open [start, end) slice over a string with no '
                      'direction and no caret.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'TextRange is the simplest of the four types.  It is a '
                      'plain value object holding two integer offsets: start '
                      'and end.  Conceptually it picks out the characters '
                      'whose indices lie in the half-open interval '
                      '[start, end).  The range carries no notion of '
                      'direction, no caret and no affinity; it is purely a '
                      'slice descriptor.  Three predicates summarise the '
                      'state of a TextRange: isValid means both offsets are '
                      'non-negative, isNormalized means start <= end, and '
                      'isCollapsed means start == end.  The constants '
                      'TextRange.empty and TextRange.collapsed(offset) cover '
                      'the two common degenerate cases.',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _kPanel,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _kvRow('sample', '"$sample"  (\\n is line break)'),
                          _kvRow(
                            'TextRange(0,5)',
                            'start=${range05.start} end=${range05.end} '
                            'valid=${range05.isValid} '
                            'normalised=${range05.isNormalized} '
                            'collapsed=${range05.isCollapsed}',
                          ),
                          _kvRow(
                            'TextRange(5,0)',
                            'start=${rangeFlipped.start} '
                            'end=${rangeFlipped.end} '
                            'normalised=${rangeFlipped.isNormalized}',
                            valueColor: _kAccentExtent,
                          ),
                          _kvRow(
                            'TextRange.empty',
                            'start=${rangeEmpty.start} end=${rangeEmpty.end} '
                            'collapsed=${rangeEmpty.isCollapsed} '
                            'valid=${rangeEmpty.isValid}',
                          ),
                          _kvRow(
                            'TextRange.collapsed(3)',
                            'start=${rangeCollapsed.start} '
                            'end=${rangeCollapsed.end} '
                            'collapsed=${rangeCollapsed.isCollapsed}',
                          ),
                          _kvRow(
                            'textBefore',
                            '"${range05.textBefore(sample)}"',
                          ),
                          _kvRow(
                            'textInside',
                            '"${range05.textInside(sample)}"',
                          ),
                          _kvRow(
                            'textAfter',
                            '"${range05.textAfter(sample).replaceAll('\n', '\\n')}"',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _codeCard(
                      'const r = TextRange(start: 0, end: 5);\n'
                      'r.isValid;       // true\n'
                      'r.isNormalized;  // true\n'
                      'r.isCollapsed;   // false\n'
                      'r.textBefore(s); // ""\n'
                      'r.textInside(s); // "Hello"\n'
                      'r.textAfter(s);  // ",\\nWorld!"\n\n'
                      'const e = TextRange.empty;\n'
                      'e.isValid;       // false  (start == -1)\n'
                      'e.isCollapsed;   // true   (start == end)\n\n'
                      'const c = TextRange.collapsed(3);\n'
                      'c.isCollapsed;   // true',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 2 -- TextPosition and TextAffinity
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF1D4ED8), Color(0xFF60A5FA)],
                  shadowColor: const Color(0xFF1D4ED8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '02',
                      'TextPosition + TextAffinity',
                      'An offset plus a tie-breaker for ambiguous caret '
                      'placements at line wraps.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'TextPosition pairs an integer offset with a '
                      'TextAffinity.  At most offsets the affinity is '
                      'irrelevant: there is exactly one place on screen for '
                      'the caret.  But at a soft line break, a single offset '
                      'can map to two visual positions: at the end of the '
                      'previous line (upstream) or at the start of the next '
                      'line (downstream).  The affinity selects between '
                      'those two visual interpretations.  Default affinity '
                      'is downstream, which matches the "type at the start '
                      'of the next line" behaviour most users expect.  '
                      'Upstream is what you get when you press End to land '
                      'at the visual end of the previous line.',
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        _statCard(
                          title: 'pos(0)',
                          value: 'down',
                          accent: _kAccentDown,
                          icon: Icons.south,
                        ),
                        _statCard(
                          title: 'pos(5)',
                          value: 'down',
                          accent: _kAccentDown,
                          icon: Icons.south,
                        ),
                        _statCard(
                          title: 'pos(10, up)',
                          value: 'up',
                          accent: _kAccentUp,
                          icon: Icons.north,
                        ),
                        _statCard(
                          title: 'pos(10, down)',
                          value: 'down',
                          accent: _kAccentDown,
                          icon: Icons.south,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _codeCard(
                      'const a = TextPosition(offset: 5);\n'
                      'a.affinity; // TextAffinity.downstream  (default)\n\n'
                      'const b = TextPosition(\n'
                      '  offset: 10,\n'
                      '  affinity: TextAffinity.upstream,\n'
                      ');\n'
                      'b.affinity; // TextAffinity.upstream\n\n'
                      '// At a soft wrap, two visual positions share an offset.\n'
                      '// upstream  -> end of previous line\n'
                      '// downstream-> start of next line',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 3 -- TextSelection forward direction
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFFB91C1C), Color(0xFFFB7185)],
                  shadowColor: const Color(0xFFFB7185),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '03',
                      'TextSelection forward (base < extent)',
                      'The base anchors the selection; the extent rides with '
                      'the user gesture.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'TextSelection extends TextRange with two additional '
                      'pieces of state: a baseOffset which records the '
                      'anchor point of the selection, and an extentOffset '
                      'which records the moving caret end.  When the user '
                      'drags left-to-right the base stays put and the '
                      'extent grows.  In the forward case base < extent so '
                      'start == base and end == extent.  The caret -- the '
                      'thing the user perceives as "where I am" -- is the '
                      'extent, not the start.  This subtle distinction '
                      'matters whenever you compose selections or react to '
                      'keyboard arrow events.',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomPaint(
                        painter: _SelectionVisualizer(
                          sample: sample,
                          selection: selForward,
                          label: 'TextSelection(base: 0, extent: 5) over "$sample"',
                        ),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _kPanelAlt,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _kvRow(
                            'baseOffset',
                            '${selForward.baseOffset}',
                            valueColor: _kAccentBase,
                          ),
                          _kvRow(
                            'extentOffset',
                            '${selForward.extentOffset}',
                            valueColor: _kAccentExtent,
                          ),
                          _kvRow('start', '${selForward.start}'),
                          _kvRow('end', '${selForward.end}'),
                          _kvRow(
                            'isCollapsed',
                            '${selForward.isCollapsed}',
                          ),
                          _kvRow(
                            'isDirectional',
                            '${selForward.isDirectional}',
                          ),
                          _kvRow('affinity', '${selForward.affinity}'),
                          _kvRow('textInside', '"${selForward.textInside(sample)}"'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _codeCard(
                      'const s = TextSelection(baseOffset: 0, extentOffset: 5);\n'
                      's.baseOffset;    // 0   (anchor)\n'
                      's.extentOffset;  // 5   (caret rides here)\n'
                      's.start;         // 0   (== min)\n'
                      's.end;           // 5   (== max)\n'
                      's.isCollapsed;   // false\n'
                      's.isDirectional; // false  (default)\n'
                      's.affinity;      // TextAffinity.downstream',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 4 -- TextSelection backward direction
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF7C2D12), Color(0xFFFB923C)],
                  shadowColor: const Color(0xFFFB923C),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '04',
                      'TextSelection backward (base > extent)',
                      'Same range, different orientation: the caret is on '
                      'the left, the anchor on the right.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'A backward selection arises when the user drags '
                      'right-to-left or extends a selection with the left '
                      'arrow key.  Internally base remains the original '
                      'anchor and extent moves leftward.  Crucially, start '
                      'and end always normalise: start is min(base, extent), '
                      'end is max(base, extent).  This means textInside, '
                      'textBefore and textAfter all behave identically '
                      'regardless of direction.  Only the perceived caret '
                      'position differs, because the extent in a backward '
                      'selection sits on the lower offset.',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomPaint(
                        painter: _SelectionVisualizer(
                          sample: sample,
                          selection: selBackward,
                          label: 'TextSelection(base: 9, extent: 2) over "$sample"',
                        ),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _kPanelWarn,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _kvRow(
                            'baseOffset',
                            '${selBackward.baseOffset}',
                            valueColor: _kAccentBase,
                          ),
                          _kvRow(
                            'extentOffset',
                            '${selBackward.extentOffset}',
                            valueColor: _kAccentExtent,
                          ),
                          _kvRow('start', '${selBackward.start}'),
                          _kvRow('end', '${selBackward.end}'),
                          _kvRow(
                            'isCollapsed',
                            '${selBackward.isCollapsed}',
                          ),
                          _kvRow(
                            'textInside',
                            '"${selBackward.textInside(sample).replaceAll('\n', '\\n')}"',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 5 -- Collapsed selection and fromPosition
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF065F46), Color(0xFF34D399)],
                  shadowColor: const Color(0xFF34D399),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '05',
                      'Collapsed selections',
                      'When base == extent the "selection" is really a bare '
                      'caret.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'A collapsed TextSelection has baseOffset == '
                      'extentOffset.  Visually it draws nothing but a caret '
                      'rod; nothing inside it is highlighted.  Even though '
                      'no characters are selected, the structure still '
                      'carries affinity, so a collapsed selection at a soft '
                      'wrap can still be visually upstream or downstream.  '
                      'The two factories TextSelection.collapsed(offset:) '
                      'and TextSelection.fromPosition(TextPosition) make '
                      'the common cases ergonomic: the former takes a raw '
                      'offset, while the latter forwards both offset and '
                      'affinity from an existing TextPosition.',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomPaint(
                        painter: _SelectionVisualizer(
                          sample: sample,
                          selection: selCollapsed,
                          label: 'TextSelection.collapsed(offset: 7) -- caret only',
                        ),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _kPanelOk,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _kvRow(
                            'collapsed.base',
                            '${selCollapsed.baseOffset}',
                          ),
                          _kvRow(
                            'collapsed.extent',
                            '${selCollapsed.extentOffset}',
                          ),
                          _kvRow(
                            'collapsed.isCollapsed',
                            '${selCollapsed.isCollapsed}',
                          ),
                          _kvRow(
                            'fromPosition.base',
                            '${selFromPos.baseOffset}',
                          ),
                          _kvRow(
                            'fromPosition.extent',
                            '${selFromPos.extentOffset}',
                          ),
                          _kvRow(
                            'fromPosition.isCollapsed',
                            '${selFromPos.isCollapsed}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _codeCard(
                      'const c = TextSelection.collapsed(offset: 7);\n'
                      'c.isCollapsed;   // true\n'
                      'c.start == c.end;// true\n\n'
                      'final p = TextPosition(offset: 5);\n'
                      'final s = TextSelection.fromPosition(p);\n'
                      's.baseOffset;    // 5\n'
                      's.extentOffset;  // 5\n'
                      's.affinity;      // mirrors p.affinity',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 6 -- Affinity at line breaks
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF1E293B), Color(0xFF334155)],
                  shadowColor: const Color(0xFF1E293B),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '06',
                      'Affinity at a soft wrap',
                      'Two selections, same offsets, different affinity, '
                      'different visual caret placement.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'To see affinity in action we contrast two selections '
                      'with identical baseOffset and extentOffset over a '
                      'string containing an explicit line break.  Even '
                      'though their start/end intervals are the same, the '
                      'upstream variant places the visual caret on the end '
                      'of the previous line, while the downstream variant '
                      'places it at the start of the next line.  In our '
                      'glyph-cell visualiser the affinity badge above the '
                      'extent caret reveals which way the selection leans.  '
                      'Real EditableText uses this exact flag to decide '
                      'where to paint the cursor between two visual rows.',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomPaint(
                        painter: _SelectionVisualizer(
                          sample: sample,
                          selection: selUp,
                          label: 'affinity: TextAffinity.upstream',
                        ),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomPaint(
                        painter: _SelectionVisualizer(
                          sample: sample,
                          selection: selDown,
                          label: 'affinity: TextAffinity.downstream',
                        ),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _decisionMatrix(),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 7 -- Interactive base/extent slider
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF6D28D9), Color(0xFFA855F7)],
                  shadowColor: const Color(0xFFA855F7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '07',
                      'Interactive base / extent',
                      'Drag the sliders to move base and extent over the '
                      'sample string and watch the carets dance.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'This scoped StatefulBuilder lets you reposition the '
                      'two endpoints of a selection without modifying any '
                      'state outside this widget.  Every change rebuilds '
                      'the visualiser with a fresh TextSelection, so the '
                      'underlay re-fills, the carets jump, and the kv panel '
                      'below recomputes start, end, isCollapsed, '
                      'isDirectional and textInside.  Moving extent across '
                      'base demonstrates the symmetry of forward and '
                      'backward selections: textInside is unaffected but '
                      'the visual caret swaps sides.',
                    ),
                    const SizedBox(height: 12),
                    StatefulBuilder(
                      builder: (context, setLocal) {
                        return _InteractivePanel(
                          sample: sampleSpaced,
                          rebuild: setLocal,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Section 8 -- Preset palette
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF0E7490), Color(0xFF22D3EE)],
                  shadowColor: const Color(0xFF22D3EE),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle(
                      '08',
                      'Selection presets palette',
                      'A row of named TextSelection presets, each chip '
                      'showing the constructor and a short description.',
                    ),
                    const SizedBox(height: 14),
                    _prose(
                      'Real-world editors expose a small zoo of selection '
                      'presets: select-all, select-word, select-line, '
                      'collapse-to-start, collapse-to-end, extend-to-end-of-'
                      'document.  Each is just a recipe for constructing a '
                      'TextSelection.  Below we list a representative set '
                      'as chips so the difference is concrete: the same '
                      'underlying type expresses every behaviour.  This '
                      'illustrates how a tiny value object becomes the '
                      'shared currency of an editor: undo, redo, IME and '
                      'gesture handling all speak in TextSelection.',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _kPanelInfo,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _chip('selectAll(0..n)', _kAccentSel),
                          _chip('collapseToStart(0)', _kAccentBase),
                          _chip('collapseToEnd(n)', _kAccentExtent),
                          _chip('word(2..7)', _kAccentCaret),
                          _chip('line(0..6)', _kAccentDown),
                          _chip('reverseWord(7..2)', _kAccentUp),
                          _chip('caretAt(3)', _kAccentBreak),
                          _chip('fromPos(5,up)', _kAccentUp),
                          _chip('fromPos(5,down)', _kAccentDown),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _codeCard(
                      '// A few common preset constructors:\n'
                      'TextSelection(baseOffset: 0, extentOffset: text.length); // all\n'
                      'TextSelection.collapsed(offset: 0);                       // home\n'
                      'TextSelection.collapsed(offset: text.length);             // end\n'
                      'TextSelection(baseOffset: 2, extentOffset: 7);            // word\n'
                      'TextSelection(baseOffset: 7, extentOffset: 2);            // reverse\n'
                      'TextSelection.fromPosition(\n'
                      '  TextPosition(offset: 5, affinity: TextAffinity.upstream),\n'
                      ');',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // ---------------------------------------------------------------
              // Reference card
              // ---------------------------------------------------------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: _sectionFrame(
                  gradient: const [Color(0xFF111827), _kBgSoft],
                  shadowColor: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Reference card',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _prose(
                      'A condensed table of the constructors used in this '
                      'document.  Use it as a cheat sheet when reading or '
                      'producing TextSelection values from a custom input '
                      'handler.  All four types are immutable value '
                      'objects, so they compare by content and can be '
                      'used as keys in collections without surprises.',
                    ),
                    const SizedBox(height: 10),
                    _constructorTable(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// _decisionMatrix -- DataTable of affinity behaviour
// =============================================================================

Widget _decisionMatrix() {
  TextStyle headStyle() => const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        fontFamily: 'monospace',
      );
  TextStyle cellStyle() => const TextStyle(
        color: _kInk,
        fontSize: 12,
        fontFamily: 'monospace',
      );
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.94),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(_kBgMid),
        columnSpacing: 28,
        columns: [
          DataColumn(label: Text('Affinity', style: headStyle())),
          DataColumn(label: Text('At line break', style: headStyle())),
          DataColumn(label: Text('Visual position', style: headStyle())),
          DataColumn(label: Text('Typical source', style: headStyle())),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('upstream', style: cellStyle())),
            DataCell(Text('end of previous line', style: cellStyle())),
            DataCell(Text('right edge, line N-1', style: cellStyle())),
            DataCell(Text('End key on prev row', style: cellStyle())),
          ]),
          DataRow(cells: [
            DataCell(Text('downstream', style: cellStyle())),
            DataCell(Text('start of next line', style: cellStyle())),
            DataCell(Text('left edge, line N', style: cellStyle())),
            DataCell(Text('default / typing', style: cellStyle())),
          ]),
          DataRow(cells: [
            DataCell(Text('n/a', style: cellStyle())),
            DataCell(Text('mid-line offset', style: cellStyle())),
            DataCell(Text('unique position', style: cellStyle())),
            DataCell(Text('arrow keys, taps', style: cellStyle())),
          ]),
        ],
      ),
    ),
  );
}

// =============================================================================
// _constructorTable -- summary of the four types
// =============================================================================

Widget _constructorTable() {
  TextStyle head() => const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        fontFamily: 'monospace',
      );
  TextStyle body() => const TextStyle(
        color: _kInk,
        fontSize: 11.5,
        fontFamily: 'monospace',
      );
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(_kBgMid),
        columnSpacing: 22,
        columns: [
          DataColumn(label: Text('Type', style: head())),
          DataColumn(label: Text('Constructor', style: head())),
          DataColumn(label: Text('Yields', style: head())),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('TextRange', style: body())),
            DataCell(Text('TextRange(start, end)', style: body())),
            DataCell(Text('[start, end) interval', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextRange', style: body())),
            DataCell(Text('TextRange.empty', style: body())),
            DataCell(Text('start=-1 end=-1 invalid', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextRange', style: body())),
            DataCell(Text('TextRange.collapsed(n)', style: body())),
            DataCell(Text('start=end=n', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextPosition', style: body())),
            DataCell(Text('TextPosition(offset, [affinity])', style: body())),
            DataCell(Text('caret + tie-breaker', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextAffinity', style: body())),
            DataCell(Text('TextAffinity.upstream', style: body())),
            DataCell(Text('cling to previous line', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextAffinity', style: body())),
            DataCell(Text('TextAffinity.downstream', style: body())),
            DataCell(Text('cling to next line', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextSelection', style: body())),
            DataCell(Text('TextSelection(base, extent)', style: body())),
            DataCell(Text('directional selection', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextSelection', style: body())),
            DataCell(Text('TextSelection.collapsed(offset)', style: body())),
            DataCell(Text('caret-only selection', style: body())),
          ]),
          DataRow(cells: [
            DataCell(Text('TextSelection', style: body())),
            DataCell(Text('TextSelection.fromPosition(p)', style: body())),
            DataCell(Text('collapsed at p with affinity', style: body())),
          ]),
        ],
      ),
    ),
  );
}

// =============================================================================
// _InteractivePanel -- scoped local sliders for base + extent
// -----------------------------------------------------------------------------
// The panel is stateless from the framework's point of view; the host
// StatefulBuilder owns the integer offsets in a closure and re-invokes
// the builder when a slider changes.  We hold the offsets in a tiny
// mutable holder so we do not need root setState.
// =============================================================================

class _InteractivePanel extends StatelessWidget {
  _InteractivePanel({required this.sample, required this.rebuild});

  final String sample;
  final void Function(VoidCallback) rebuild;
  final _OffsetHolder _holder = _OffsetHolder(base: 2, extent: 7);

  @override
  Widget build(BuildContext context) {
    final selection = TextSelection(
      baseOffset: _holder.base,
      extentOffset: _holder.extent,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 110,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: _SelectionVisualizer(
              sample: sample,
              selection: selection,
              label: 'base=${_holder.base}  extent=${_holder.extent}',
            ),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 12),
        _sliderRow(
          label: 'base',
          color: _kAccentBase,
          value: _holder.base,
          max: sample.length,
          onChanged: (v) => rebuild(() => _holder.base = v),
        ),
        _sliderRow(
          label: 'extent',
          color: _kAccentExtent,
          value: _holder.extent,
          max: sample.length,
          onChanged: (v) => rebuild(() => _holder.extent = v),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kvRow('base', '${selection.baseOffset}',
                  valueColor: _kAccentBase),
              _kvRow('extent', '${selection.extentOffset}',
                  valueColor: _kAccentExtent),
              _kvRow('start', '${selection.start}'),
              _kvRow('end', '${selection.end}'),
              _kvRow('isCollapsed', '${selection.isCollapsed}'),
              _kvRow('isDirectional', '${selection.isDirectional}'),
              _kvRow(
                'textInside',
                '"${selection.textInside(sample)}"',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sliderRow({
    required String label,
    required Color color,
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: color,
                thumbColor: color,
                inactiveTrackColor: color.withValues(alpha: 0.25),
                overlayColor: color.withValues(alpha: 0.15),
                valueIndicatorColor: color,
              ),
              child: Slider(
                value: value.toDouble(),
                min: 0,
                max: max.toDouble(),
                divisions: max,
                label: '$value',
                onChanged: (d) => onChanged(d.round()),
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: Text(
              '$value',
              style: const TextStyle(
                color: _kInk,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _OffsetHolder {
  _OffsetHolder({required this.base, required this.extent});
  int base;
  int extent;
}
