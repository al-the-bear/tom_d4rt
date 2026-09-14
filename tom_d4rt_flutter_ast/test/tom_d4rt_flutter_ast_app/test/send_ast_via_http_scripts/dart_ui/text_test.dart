// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for dart:ui text primitives
// (TextStyle, ParagraphStyle, StrutStyle, ParagraphBuilder, Paragraph)
//
// =====================================================================
// dart:ui Text Primitives  --  Deep Visual Demo
// =====================================================================
//
// This file is part of the D4rt flutter-test corpus. It is intentionally
// designed to be executed by an analyzer-free, sandboxed Dart interpreter
// that supports Flutter widgets. The single entry point is
//
//     dynamic build(BuildContext context) { ... return Widget; }
//
// The build function is invoked exactly once. No state is kept, no
// timers fire, no async work is scheduled. Every value is computed
// synchronously and the resulting `Widget` is mounted into the test
// harness as a `MaterialApp`.
//
// ---------------------------------------------------------------------
// Scope
// ---------------------------------------------------------------------
//
// The classes covered here are the LOW-LEVEL text types that ship in
// `dart:ui` (the so-called "engine boundary"):
//
//   * ui.TextStyle         -- a span-level style: colour, weight, size,
//                             decoration, font features, etc.
//   * ui.ParagraphStyle    -- a paragraph-level style: alignment,
//                             direction, max lines, strut style, default
//                             font, ellipsis.
//   * ui.StrutStyle        -- a "structure" line-height constraint that
//                             forces every line to share a baseline.
//   * ui.ParagraphBuilder  -- a stateful builder that combines a
//                             ParagraphStyle with one or more pushed
//                             ui.TextStyle scopes plus text runs.
//   * ui.Paragraph         -- the immutable, laid-out result. Owns
//                             `width`, `height`, `lineMetrics`, etc.
//                             Painted via `Canvas.drawParagraph`.
//   * ui.LineMetrics       -- per-line measurement values (ascent,
//                             descent, baseline, hard).
//   * ui.TextHeightBehavior, ui.TextLeadingDistribution
//                          -- fine-grained line-height controls.
//   * ui.PlaceholderAlignment
//                          -- how a placeholder rectangle is vertically
//                             aligned within a text run.
//   * ui.FontWeight, ui.FontStyle
//                          -- enum-like value types.
//   * ui.TextAlign, ui.TextDirection
//                          -- paragraph-axis alignment.
//   * ui.TextDecoration / ui.TextDecorationStyle
//                          -- underline / overline / line-through and
//                             their stroke style (solid, dashed, ...).
//
// We also draw a deliberate contrast against the HIGHER-LEVEL
// `painting.TextStyle` (re-exported by `package:flutter/material.dart`
// as `TextStyle`), which is the type widgets like `Text` and `TextSpan`
// actually accept. Internally, `painting.TextStyle` is converted into a
// `ui.TextStyle` by `RenderParagraph` before reaching the engine.
//
// ---------------------------------------------------------------------
// Rendering technique
// ---------------------------------------------------------------------
//
// To prove that the dart:ui types compose into a real paragraph, this
// demo embeds several `CustomPaint` widgets whose `CustomPainter.paint`
// method:
//
//   1. Builds a `ui.ParagraphBuilder` from a `ui.ParagraphStyle`.
//   2. Pushes one or more `ui.TextStyle` scopes.
//   3. Adds text runs (and sometimes placeholders).
//   4. Calls `builder.build()` to materialise a `ui.Paragraph`.
//   5. Calls `paragraph.layout(ParagraphConstraints(width: ...))`.
//   6. Calls `canvas.drawParagraph(paragraph, offset)`.
//
// `Paragraph.layout` is synchronous in dart:ui. The D4rt interpreter
// understands the call and routes it to the underlying Flutter engine
// implementation; no `Future` is involved.
//
// =====================================================================

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------

const double _kPagePad = 20.0;
const double _kSectionPad = 18.0;
const double _kCardRadius = 16.0;
const double _kCardGap = 18.0;
const double _kGapXs = 4.0;
const double _kGapSm = 8.0;
const double _kGapMd = 12.0;
const double _kGapLg = 20.0;

// Ink / surface palette tuned to feel like a printed reference card.
const Color _kInkDark = Color(0xFF111827);
const Color _kInkBody = Color(0xFF1F2937);
const Color _kInkMuted = Color(0xFF6B7280);
const Color _kSurface = Color(0xFFFFFFFF);
const Color _kSurfaceAlt = Color(0xFFF8FAFC);
const Color _kBorder = Color(0xFFE5E7EB);
const Color _kBorderStrong = Color(0xFFCBD5E1);

// Accent palette used to colour-code sections.
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentIndigo = Color(0xFF4F46E5);
const Color _kAccentPurple = Color(0xFF7C3AED);
const Color _kAccentPink = Color(0xFFDB2777);
const Color _kAccentRed = Color(0xFFDC2626);
const Color _kAccentAmber = Color(0xFFD97706);
const Color _kAccentGreen = Color(0xFF059669);
const Color _kAccentTeal = Color(0xFF0D9488);
const Color _kAccentCyan = Color(0xFF0891B2);

// Section accent ordered the same way as the section list itself, so
// that section index maps directly to a colour.
const List<Color> _kSectionAccents = <Color>[
  _kAccentBlue,
  _kAccentIndigo,
  _kAccentPurple,
  _kAccentPink,
  _kAccentRed,
  _kAccentAmber,
  _kAccentGreen,
  _kAccentTeal,
  _kAccentCyan,
];

// =====================================================================
// build() entry point
// =====================================================================

dynamic build(BuildContext context) {
  print('==============================================================');
  print('dart:ui text primitives demo  --  build() invoked');
  print('==============================================================');

  // Pre-flight: enumerate the canonical ui.FontWeight ladder and
  // ui.FontStyle values. We do this once so each section can refer to
  // the same prepared data without rebuilding it.
  print('-- ui.FontWeight ladder --');
  final List<ui.FontWeight> weightLadder = <ui.FontWeight>[
    ui.FontWeight.w100,
    ui.FontWeight.w200,
    ui.FontWeight.w300,
    ui.FontWeight.w400,
    ui.FontWeight.w500,
    ui.FontWeight.w600,
    ui.FontWeight.w700,
    ui.FontWeight.w800,
    ui.FontWeight.w900,
  ];
  for (int i = 0; i < weightLadder.length; i++) {
    print('  w${(i + 1) * 100} -> ${weightLadder[i]}');
  }
  print('  ui.FontWeight.normal == w400: ${ui.FontWeight.normal == ui.FontWeight.w400}');
  print('  ui.FontWeight.bold   == w700: ${ui.FontWeight.bold == ui.FontWeight.w700}');

  print('-- ui.FontStyle values --');
  print('  ui.FontStyle.normal : ${ui.FontStyle.normal}');
  print('  ui.FontStyle.italic : ${ui.FontStyle.italic}');

  // Common reusable text strings used by several sections.
  const String pangram =
      'Sphinx of black quartz, judge my vow -- pack my box with five dozen liquor jugs.';
  const String multiline =
      'Line one of a wrapped paragraph that demonstrates layout flow.\n'
      'Line two adds a hard newline, forcing the engine to break.\n'
      'Line three closes the paragraph with a final clause.';
  final List<String> sampleRuns = <String>[
    'normal ',
    'BOLD ',
    'italic ',
    'wide ',
    'tight ',
    'colored.',
  ];

  // Build the page model. Every section is a `Widget` we glue into a
  // single scrolling `ListView` at the bottom.
  final List<Widget> sections = <Widget>[];

  // ---------------------------------------------------------------
  // SECTION 1 -- Hero
  // ---------------------------------------------------------------
  print('-- SECTION 1 / hero --');
  sections.add(_buildHero());

  // ---------------------------------------------------------------
  // SECTION 2 -- ui.TextStyle vs painting.TextStyle
  // ---------------------------------------------------------------
  print('-- SECTION 2 / ui.TextStyle vs painting.TextStyle --');
  sections.add(_buildLayerComparison());

  // ---------------------------------------------------------------
  // SECTION 3 -- ParagraphStyle parameter showcase (CustomPaint)
  // ---------------------------------------------------------------
  print('-- SECTION 3 / ParagraphStyle showcase --');
  sections.add(_buildParagraphStyleShowcase(pangram, multiline));

  // ---------------------------------------------------------------
  // SECTION 4 -- StrutStyle anatomy
  // ---------------------------------------------------------------
  print('-- SECTION 4 / StrutStyle anatomy --');
  sections.add(_buildStrutAnatomy());

  // ---------------------------------------------------------------
  // SECTION 5 -- LineMetrics card
  // ---------------------------------------------------------------
  print('-- SECTION 5 / LineMetrics card --');
  sections.add(_buildLineMetricsCard());

  // ---------------------------------------------------------------
  // SECTION 6 -- ParagraphBuilder recipe (multi-run)
  // ---------------------------------------------------------------
  print('-- SECTION 6 / ParagraphBuilder recipe --');
  sections.add(_buildParagraphBuilderRecipe(sampleRuns));

  // ---------------------------------------------------------------
  // SECTION 7 -- TextDecoration gallery
  // ---------------------------------------------------------------
  print('-- SECTION 7 / TextDecoration gallery --');
  sections.add(_buildDecorationGallery());

  // ---------------------------------------------------------------
  // SECTION 8 -- TextAlign + TextDirection grid
  // ---------------------------------------------------------------
  print('-- SECTION 8 / TextAlign + TextDirection grid --');
  sections.add(_buildAlignmentGrid());

  // ---------------------------------------------------------------
  // SECTION 9 -- Cheat sheet
  // ---------------------------------------------------------------
  print('-- SECTION 9 / cheat sheet --');
  sections.add(_buildCheatSheet());

  print('-- build() returning MaterialApp --');

  return MaterialApp(
    title: 'dart:ui text primitives',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: _kAccentBlue,
      scaffoldBackgroundColor: _kSurfaceAlt,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInkBody, fontSize: 13.5, height: 1.45),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kSurfaceAlt,
      appBar: AppBar(
        backgroundColor: _kSurface,
        foregroundColor: _kInkDark,
        elevation: 0.0,
        title: const Text(
          'dart:ui Text Primitives',
          style: TextStyle(
            color: _kInkDark,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: SizedBox(height: 1.0, child: ColoredBox(color: _kBorder)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          _kPagePad,
          _kPagePad,
          _kPagePad,
          _kPagePad + 24.0,
        ),
        children: sections,
      ),
    ),
  );
}

// =====================================================================
// Reusable atoms
// =====================================================================

Widget _sectionShell({
  required int index,
  required String tag,
  required String title,
  required String subtitle,
  required Widget child,
}) {
  final Color accent = _kSectionAccents[index % _kSectionAccents.length];
  return Container(
    margin: const EdgeInsets.only(bottom: _kCardGap),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: _kBorder),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(_kSectionPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(color: accent.withOpacity(0.4)),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: accent,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: _kGapSm),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kInkDark,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: _kGapXs),
          Text(
            subtitle,
            style: const TextStyle(
              color: _kInkMuted,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: _kGapLg),
          child,
        ],
      ),
    ),
  );
}

Widget _paragraphCard({
  required String title,
  required String body,
  Color? titleColor,
}) {
  return Container(
    padding: const EdgeInsets.all(_kGapMd),
    margin: const EdgeInsets.only(bottom: _kGapSm),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: titleColor ?? _kInkDark,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          body,
          style: const TextStyle(
            color: _kInkBody,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(_kGapMd),
    margin: const EdgeInsets.only(top: _kGapSm, bottom: _kGapSm),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF1E293B)),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFE2E8F0),
        fontFamily: 'monospace',
        fontSize: 11.5,
        height: 1.5,
      ),
    ),
  );
}

Widget _keyValueRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160.0,
          child: Text(
            key,
            style: const TextStyle(
              color: _kInkMuted,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _kInkBody,
              fontSize: 12.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _divider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: _kGapMd),
    child: SizedBox(
      height: 1.0,
      child: ColoredBox(color: _kBorder),
    ),
  );
}

// =====================================================================
// SECTION 1 -- Hero
// =====================================================================

Widget _buildHero() {
  return Container(
    margin: const EdgeInsets.only(bottom: _kCardGap),
    padding: const EdgeInsets.all(_kSectionPad + 4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(_kCardRadius),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E3A8A),
          Color(0xFF4338CA),
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 28.0,
          offset: const Offset(0.0, 14.0),
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
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'dart:ui',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: _kGapMd),
        const Text(
          'Text Primitives Tour',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1.05,
          ),
        ),
        const SizedBox(height: _kGapXs),
        const Text(
          'TextStyle - ParagraphStyle - StrutStyle - ParagraphBuilder - Paragraph',
          style: TextStyle(
            color: Color(0xFFC7D2FE),
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: _kGapLg),
        const Text(
          'This page walks through the low-level text types that '
          'live on the engine boundary. Most Flutter apps never touch '
          'them directly -- a `Text` widget hides everything behind '
          '`painting.TextStyle`. But the moment you write a custom '
          'painter, a render object, or a text input field, the '
          '`dart:ui` types become very real, very fast.',
          style: TextStyle(
            color: Color(0xFFE0E7FF),
            fontSize: 14.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: _kGapLg),
        Row(
          children: <Widget>[
            _heroChip('ui.TextStyle'),
            const SizedBox(width: _kGapSm),
            _heroChip('ui.ParagraphStyle'),
            const SizedBox(width: _kGapSm),
            _heroChip('ui.StrutStyle'),
          ],
        ),
        const SizedBox(height: _kGapSm),
        Row(
          children: <Widget>[
            _heroChip('ui.ParagraphBuilder'),
            const SizedBox(width: _kGapSm),
            _heroChip('ui.Paragraph'),
            const SizedBox(width: _kGapSm),
            _heroChip('Canvas.drawParagraph'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white.withOpacity(0.18)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// =====================================================================
// SECTION 2 -- ui.TextStyle vs painting.TextStyle
// =====================================================================
//
// Two columns side-by-side: on the left, the painting-layer TextStyle
// the widgets consume; on the right, the engine-layer ui.TextStyle that
// `ParagraphBuilder.pushStyle` actually accepts.
// =====================================================================

Widget _buildLayerComparison() {
  // Construct one example of each type so we can `toString()` them and
  // also show how they look applied to text.
  final TextStyle paintingStyle = const TextStyle(
    color: _kAccentBlue,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.3,
    height: 1.4,
    decoration: TextDecoration.underline,
    decorationColor: _kAccentBlue,
    decorationStyle: TextDecorationStyle.wavy,
    decorationThickness: 1.4,
  );
  print('  painting.TextStyle ->');
  print('    $paintingStyle');

  final ui.TextStyle engineStyle = ui.TextStyle(
    color: _kAccentIndigo,
    fontSize: 18.0,
    fontWeight: ui.FontWeight.w600,
    fontStyle: ui.FontStyle.italic,
    letterSpacing: 0.3,
    height: 1.4,
    decoration: ui.TextDecoration.underline,
    decorationColor: _kAccentIndigo,
    decorationStyle: ui.TextDecorationStyle.wavy,
    decorationThickness: 1.4,
  );
  print('  ui.TextStyle ->');
  print('    $engineStyle');

  return _sectionShell(
    index: 1,
    tag: 'LAYERS',
    title: 'ui.TextStyle  vs  painting.TextStyle',
    subtitle:
        'Two types share a name. Only the painting-layer TextStyle is '
        'reachable from widget code; the dart:ui one lives one layer '
        'below.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _layerColumn(
                title: 'painting.TextStyle',
                accent: _kAccentBlue,
                bullets: const <String>[
                  'Re-exported by `material.dart` as `TextStyle`.',
                  'Used by `Text`, `TextSpan`, `RichText`.',
                  'Carries theme inheritance via `inherit`.',
                  'Supports `merge` and `copyWith`.',
                  'Converted to ui.TextStyle by RenderParagraph.',
                ],
                preview: Text(
                  'painting.TextStyle preview',
                  style: paintingStyle,
                ),
              ),
            ),
            const SizedBox(width: _kGapMd),
            Expanded(
              child: _layerColumn(
                title: 'ui.TextStyle',
                accent: _kAccentIndigo,
                bullets: const <String>[
                  'Lives in `dart:ui`. Engine value type.',
                  'Accepted by `ParagraphBuilder.pushStyle`.',
                  'No theme inheritance -- must be fully specified.',
                  'No `merge` -- builder pushes / pops a stack.',
                  'Carries font features, variations, foreground/background Paint.',
                ],
                preview: _CustomPaintBox(
                  height: 56.0,
                  painter: _SimpleParagraphPainter(
                    text: 'ui.TextStyle preview',
                    paragraphStyle: ui.ParagraphStyle(
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      fontSize: 18.0,
                    ),
                    textStyle: engineStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
        _divider(),
        const Text(
          'Round-trip conversion',
          style: TextStyle(
            color: _kInkDark,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: _kGapXs),
        const Text(
          'painting.TextStyle has a `getTextStyle()` method that '
          'returns its lowered `ui.TextStyle`. RenderParagraph calls '
          'that during layout. The conversion fills in fonts, weight '
          'fallback, decoration positioning, and locale.',
          style: TextStyle(color: _kInkBody, fontSize: 12.5, height: 1.5),
        ),
        _codeBlock(
          'final TextStyle painting = TextStyle(\n'
          '  color: Color(0xFF2563EB),\n'
          '  fontSize: 18.0,\n'
          '  fontWeight: FontWeight.w600,\n'
          ');\n'
          '\n'
          '// One way down:\n'
          'final ui.TextStyle lowered = painting.getTextStyle();\n'
          '\n'
          '// Used by the engine:\n'
          'builder.pushStyle(lowered);\n'
          'builder.addText("hello");',
        ),
      ],
    ),
  );
}

Widget _layerColumn({
  required String title,
  required Color accent,
  required List<String> bullets,
  required Widget preview,
}) {
  return Container(
    padding: const EdgeInsets.all(_kGapMd),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: _kGapSm),
        for (int i = 0; i < bullets.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '- ',
                  style: TextStyle(
                    color: accent,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Expanded(
                  child: Text(
                    bullets[i],
                    style: const TextStyle(
                      color: _kInkBody,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: _kGapMd),
        Container(
          padding: const EdgeInsets.all(_kGapSm),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kBorderStrong),
          ),
          child: preview,
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 3 -- ParagraphStyle parameter showcase
// =====================================================================
//
// Six cards, each builds a real `ui.Paragraph` inside a `CustomPaint`
// using a `ui.ParagraphStyle` that highlights one parameter.
// =====================================================================

Widget _buildParagraphStyleShowcase(String pangram, String multiline) {
  return _sectionShell(
    index: 2,
    tag: 'STYLE',
    title: 'ui.ParagraphStyle parameter showcase',
    subtitle:
        'Every card constructs a fresh ParagraphBuilder + Paragraph and '
        'paints it via Canvas.drawParagraph. The label above each card '
        'names the parameter being demonstrated.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _paragraphStyleCard(
          label: 'textAlign: TextAlign.start',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            fontSize: 14.0,
            maxLines: 3,
          ),
          text: pangram,
          width: 360.0,
          height: 70.0,
        ),
        _paragraphStyleCard(
          label: 'textAlign: TextAlign.center',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            fontSize: 14.0,
            maxLines: 3,
          ),
          text: pangram,
          width: 360.0,
          height: 70.0,
        ),
        _paragraphStyleCard(
          label: 'textAlign: TextAlign.end',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.end,
            textDirection: TextDirection.ltr,
            fontSize: 14.0,
            maxLines: 3,
          ),
          text: pangram,
          width: 360.0,
          height: 70.0,
        ),
        _paragraphStyleCard(
          label: 'textAlign: TextAlign.justify',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.justify,
            textDirection: TextDirection.ltr,
            fontSize: 14.0,
            maxLines: 4,
          ),
          text: pangram,
          width: 360.0,
          height: 80.0,
        ),
        _paragraphStyleCard(
          label: 'textDirection: TextDirection.rtl',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.start,
            textDirection: TextDirection.rtl,
            fontSize: 14.0,
            maxLines: 3,
          ),
          text: pangram,
          width: 360.0,
          height: 70.0,
        ),
        _paragraphStyleCard(
          label: 'maxLines: 2  +  ellipsis: "..."',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            fontSize: 14.0,
            maxLines: 2,
            ellipsis: '...',
          ),
          text:
              'The quick brown fox jumps over the lazy dog, and then the '
              'fox does it again, just so we can demonstrate ellipsis '
              'truncation when the rendered paragraph exceeds maxLines.',
          width: 360.0,
          height: 50.0,
        ),
        _paragraphStyleCard(
          label: 'height: 2.0   (line height multiplier)',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            fontSize: 14.0,
            height: 2.0,
            maxLines: 3,
          ),
          text: multiline,
          width: 360.0,
          height: 100.0,
        ),
        _paragraphStyleCard(
          label: 'fontFamily: "monospace"   fontSize: 12.0',
          paragraphStyle: ui.ParagraphStyle(
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            fontFamily: 'monospace',
            fontSize: 12.0,
            maxLines: 3,
          ),
          text: 'final ui.ParagraphStyle ps = ui.ParagraphStyle(...);',
          width: 360.0,
          height: 50.0,
        ),
        _divider(),
        _paragraphCard(
          title: 'Why a separate ParagraphStyle?',
          body:
              'ParagraphStyle holds settings that apply to the WHOLE '
              'paragraph and cannot vary span by span -- alignment, '
              'direction, max lines, ellipsis, strut. ui.TextStyle, '
              'pushed on top of the builder, supplies the span-level '
              'overrides for colour, weight, decoration, and so on.',
        ),
      ],
    ),
  );
}

Widget _paragraphStyleCard({
  required String label,
  required ui.ParagraphStyle paragraphStyle,
  required String text,
  required double width,
  required double height,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: _kGapMd),
    padding: const EdgeInsets.all(_kGapMd),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _kAccentPurple,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: _kGapSm),
        _CustomPaintBox(
          height: height,
          width: width,
          painter: _SimpleParagraphPainter(
            text: text,
            paragraphStyle: paragraphStyle,
            textStyle: ui.TextStyle(color: _kInkDark, fontSize: 14.0),
            constraintWidth: width,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 4 -- StrutStyle anatomy
// =====================================================================
//
// Three side-by-side mini paragraphs: no strut, strut with leading,
// and forceStrutHeight. Each one paints baselines / line tops so the
// reader can see the effect.
// =====================================================================

Widget _buildStrutAnatomy() {
  return _sectionShell(
    index: 3,
    tag: 'STRUT',
    title: 'ui.StrutStyle anatomy',
    subtitle:
        'StrutStyle defines a "structure line" -- a synthetic '
        'first-character line whose ascent/descent floor every real '
        'line in the paragraph. It guarantees a minimum line height '
        'independent of run-level font size.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _strutCard(
                title: 'No strut',
                description:
                    'Default line height is driven by the largest run.',
                strut: null,
              ),
            ),
            const SizedBox(width: _kGapMd),
            Expanded(
              child: _strutCard(
                title: 'Strut height 1.6',
                description:
                    'Every line gets at least 1.6x font-size of height.',
                strut: ui.StrutStyle(
                  fontFamily: 'sans-serif',
                  fontSize: 14.0,
                  height: 1.6,
                  leading: 0.0,
                ),
              ),
            ),
            const SizedBox(width: _kGapMd),
            Expanded(
              child: _strutCard(
                title: 'forceStrutHeight: true',
                description:
                    'Strut OVERRIDES per-run height. Useful for code '
                    'editors and table cells where you need pixel-perfect '
                    'line stride regardless of mixed font sizes.',
                strut: ui.StrutStyle(
                  fontFamily: 'sans-serif',
                  fontSize: 14.0,
                  height: 2.0,
                  forceStrutHeight: true,
                ),
              ),
            ),
          ],
        ),
        _divider(),
        const Text(
          'Field reference',
          style: TextStyle(
            color: _kInkDark,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: _kGapSm),
        _keyValueRow('fontFamily', 'Single family or null (inherits).'),
        _keyValueRow('fontSize', 'Strut em size in logical pixels.'),
        _keyValueRow('height', 'Multiplier; final stride = fontSize * height.'),
        _keyValueRow('leading', 'Extra leading expressed as fraction of em.'),
        _keyValueRow('fontWeight', 'Strut weight (affects metrics tables).'),
        _keyValueRow('fontStyle', 'Strut style: normal or italic.'),
        _keyValueRow(
          'leadingDistribution',
          'Even = split leading equally above/below; Proportional = pre-em.',
        ),
        _keyValueRow(
          'forceStrutHeight',
          'true = ignore per-run heights, use strut for every line.',
        ),
        _codeBlock(
          'const ui.StrutStyle strut = ui.StrutStyle(\n'
          '  fontFamily: "Roboto",\n'
          '  fontSize: 14.0,\n'
          '  height: 1.6,\n'
          '  leading: 0.0,\n'
          '  forceStrutHeight: true,\n'
          ');\n'
          '\n'
          'final ui.ParagraphStyle ps = ui.ParagraphStyle(\n'
          '  textAlign: TextAlign.start,\n'
          '  textDirection: TextDirection.ltr,\n'
          '  strutStyle: strut,\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _strutCard({
  required String title,
  required String description,
  required ui.StrutStyle? strut,
}) {
  return Container(
    padding: const EdgeInsets.all(_kGapMd),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: _kAccentPink,
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          description,
          style: const TextStyle(
            color: _kInkBody,
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: _kGapMd),
        _CustomPaintBox(
          height: 120.0,
          painter: _StrutDemoPainter(strut: strut),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 5 -- LineMetrics card
// =====================================================================
//
// We construct a small set of sample LineMetrics by hand (the
// constructor is positional) and render them as an annotated diagram.
// The "left" column shows the value of each field; the "right" column
// shows where that field sits relative to the line box.
// =====================================================================

Widget _buildLineMetricsCard() {
  // Build three plausible LineMetrics values. The constructor signature
  // is hardCount, ascent, descent, unscaledAscent, height, width, left,
  // baseline, lineNumber.
  final ui.LineMetrics line0 = ui.LineMetrics(
    hardBreak: true,
    ascent: 13.0,
    descent: 3.5,
    unscaledAscent: 13.0,
    height: 18.0,
    width: 290.0,
    left: 0.0,
    baseline: 13.0,
    lineNumber: 0,
  );
  final ui.LineMetrics line1 = ui.LineMetrics(
    hardBreak: false,
    ascent: 13.0,
    descent: 3.5,
    unscaledAscent: 13.0,
    height: 18.0,
    width: 312.0,
    left: 0.0,
    baseline: 31.0,
    lineNumber: 1,
  );
  final ui.LineMetrics line2 = ui.LineMetrics(
    hardBreak: true,
    ascent: 13.0,
    descent: 3.5,
    unscaledAscent: 13.0,
    height: 18.0,
    width: 156.0,
    left: 0.0,
    baseline: 49.0,
    lineNumber: 2,
  );
  print('  LineMetrics 0: $line0');
  print('  LineMetrics 1: $line1');
  print('  LineMetrics 2: $line2');

  final List<ui.LineMetrics> lines = <ui.LineMetrics>[line0, line1, line2];

  return _sectionShell(
    index: 4,
    tag: 'METRICS',
    title: 'ui.LineMetrics  --  per-line measurements',
    subtitle:
        'After Paragraph.layout(), each rendered line is described by a '
        'LineMetrics value. The fields below are sample values laid out '
        'against an annotated diagram so the geometry is concrete.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(_kGapMd),
                decoration: BoxDecoration(
                  color: _kSurfaceAlt,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Fields',
                      style: TextStyle(
                        color: _kInkDark,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: _kGapSm),
                    _keyValueRow(
                      'hardBreak',
                      'true if the line ended at \\n or eof',
                    ),
                    _keyValueRow(
                      'ascent',
                      'distance from line top to baseline',
                    ),
                    _keyValueRow(
                      'descent',
                      'distance from baseline to line bottom',
                    ),
                    _keyValueRow(
                      'unscaledAscent',
                      'ascent before any per-run height multiplier',
                    ),
                    _keyValueRow(
                      'height',
                      'total line stride (= ascent + descent)',
                    ),
                    _keyValueRow(
                      'width',
                      'horizontal extent of the rendered glyph run',
                    ),
                    _keyValueRow(
                      'left',
                      'horizontal start position of the line content',
                    ),
                    _keyValueRow(
                      'baseline',
                      'vertical position of the line baseline',
                    ),
                    _keyValueRow(
                      'lineNumber',
                      '0-based index inside the paragraph',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: _kGapMd),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(_kGapMd),
                decoration: BoxDecoration(
                  color: _kSurfaceAlt,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Diagram',
                      style: TextStyle(
                        color: _kInkDark,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: _kGapSm),
                    _CustomPaintBox(
                      height: 200.0,
                      painter: _LineMetricsPainter(lines: lines),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        _divider(),
        _paragraphCard(
          title: 'Reading LineMetrics from a real paragraph',
          body:
              'Call `paragraph.computeLineMetrics()` after `layout()` '
              'to get a `List<LineMetrics>` covering every visible '
              'line. The list ends at maxLines if one was specified.',
        ),
        _codeBlock(
          'final ui.ParagraphBuilder pb = ui.ParagraphBuilder(\n'
          '  ui.ParagraphStyle(textDirection: TextDirection.ltr),\n'
          ')\n'
          '  ..pushStyle(ui.TextStyle(fontSize: 16.0))\n'
          '  ..addText("multi-line\\nparagraph");\n'
          'final ui.Paragraph p = pb.build()\n'
          '  ..layout(const ui.ParagraphConstraints(width: 320));\n'
          'final List<ui.LineMetrics> lm = p.computeLineMetrics();',
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 6 -- ParagraphBuilder recipe
// =====================================================================
//
// Walks through the exact API call sequence and renders the result.
// Two cards: one with multiple pushStyle scopes, one with a placeholder.
// =====================================================================

Widget _buildParagraphBuilderRecipe(List<String> runs) {
  return _sectionShell(
    index: 5,
    tag: 'BUILDER',
    title: 'ui.ParagraphBuilder recipe',
    subtitle:
        'ParagraphBuilder is the only mutable type in the bunch. It '
        'collects a paragraph style, a STACK of text styles, and a '
        'sequence of text and placeholder runs, then materialises an '
        'immutable Paragraph.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _codeBlock(
          '// 1. Construct with paragraph-wide options.\n'
          'final pb = ui.ParagraphBuilder(\n'
          '  ui.ParagraphStyle(\n'
          '    textAlign: TextAlign.left,\n'
          '    textDirection: TextDirection.ltr,\n'
          '    fontSize: 14.0,\n'
          '  ),\n'
          ');\n'
          '\n'
          '// 2. Push and pop ui.TextStyle scopes.\n'
          'pb.pushStyle(ui.TextStyle(color: Color(0xFF1F2937)));\n'
          'pb.addText("normal ");\n'
          'pb.pushStyle(ui.TextStyle(\n'
          '  color: Color(0xFFDC2626),\n'
          '  fontWeight: ui.FontWeight.w800,\n'
          '));\n'
          'pb.addText("RED-BOLD ");\n'
          'pb.pop();\n'
          'pb.addText("back to normal.");\n'
          '\n'
          '// 3. Build and layout.\n'
          'final ui.Paragraph p = pb.build()\n'
          '  ..layout(const ui.ParagraphConstraints(width: 360));\n'
          '\n'
          '// 4. Paint inside a CustomPainter.paint(canvas, size).\n'
          'canvas.drawParagraph(p, Offset.zero);',
        ),
        const SizedBox(height: _kGapMd),
        _paragraphCard(
          title: 'Live result of the snippet above',
          body: 'Below: the exact pushStyle / addText sequence rendered.',
        ),
        Container(
          padding: const EdgeInsets.all(_kGapMd),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kBorder),
          ),
          child: _CustomPaintBox(
            height: 64.0,
            painter: _MultiRunParagraphPainter(runs: runs),
          ),
        ),
        const SizedBox(height: _kGapMd),
        _paragraphCard(
          title: 'addPlaceholder + PlaceholderAlignment',
          body:
              'Builders can also call addPlaceholder(...) which reserves '
              'an inline rectangle. The vertical alignment is one of '
              'baseline / aboveBaseline / belowBaseline / top / middle / '
              'bottom. The text engine treats the rectangle as a single '
              'glyph during layout.',
        ),
        Container(
          padding: const EdgeInsets.all(_kGapMd),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kBorder),
          ),
          child: _CustomPaintBox(
            height: 70.0,
            painter: _PlaceholderParagraphPainter(),
          ),
        ),
        _divider(),
        const Text(
          'pushStyle stack semantics',
          style: TextStyle(
            color: _kInkDark,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: _kGapXs),
        const Text(
          'Each pushStyle pushes onto a stack, and addText emits runs '
          'using the merged effective style at the top. pop() removes '
          'the most recent push. Forgetting to pop is not an error; '
          'the stack is discarded at build().',
          style: TextStyle(color: _kInkBody, fontSize: 12.5, height: 1.5),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 7 -- TextDecoration gallery
// =====================================================================
//
// A 4x4-ish grid. The Y axis sweeps decoration LINE (underline,
// overline, lineThrough, combined). The X axis sweeps decoration STYLE
// (solid, double, dotted, dashed, wavy).
// =====================================================================

Widget _buildDecorationGallery() {
  final List<ui.TextDecoration> decorations = <ui.TextDecoration>[
    ui.TextDecoration.underline,
    ui.TextDecoration.overline,
    ui.TextDecoration.lineThrough,
    ui.TextDecoration.combine(<ui.TextDecoration>[
      ui.TextDecoration.underline,
      ui.TextDecoration.overline,
    ]),
  ];
  final List<String> decorationNames = <String>[
    'underline',
    'overline',
    'lineThrough',
    'under+over',
  ];
  final List<ui.TextDecorationStyle> styles = <ui.TextDecorationStyle>[
    ui.TextDecorationStyle.solid,
    ui.TextDecorationStyle.double,
    ui.TextDecorationStyle.dotted,
    ui.TextDecorationStyle.dashed,
    ui.TextDecorationStyle.wavy,
  ];
  final List<String> styleNames = <String>[
    'solid',
    'double',
    'dotted',
    'dashed',
    'wavy',
  ];
  for (int i = 0; i < decorations.length; i++) {
    print('  decoration ${decorationNames[i]} -> ${decorations[i]}');
  }
  for (int i = 0; i < styles.length; i++) {
    print('  decoration-style ${styleNames[i]} -> ${styles[i]}');
  }

  return _sectionShell(
    index: 6,
    tag: 'DECOR',
    title: 'ui.TextDecoration  x  TextDecorationStyle gallery',
    subtitle:
        'Rows are decoration LINES; columns are decoration STYLES. Each '
        'cell paints a real ui.Paragraph through Canvas.drawParagraph.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Header row
        Row(
          children: <Widget>[
            const SizedBox(width: 100.0),
            for (int s = 0; s < styles.length; s++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    styleNames[s],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: _kAccentRed,
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: _kGapXs),
        for (int d = 0; d < decorations.length; d++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                  child: Text(
                    decorationNames[d],
                    style: const TextStyle(
                      color: _kAccentRed,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                for (int s = 0; s < styles.length; s++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: _kSurfaceAlt,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: _kBorder),
                        ),
                        child: _CustomPaintBox(
                          height: 28.0,
                          painter: _DecorationCellPainter(
                            decoration: decorations[d],
                            decorationStyle: styles[s],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        _divider(),
        _paragraphCard(
          title: 'TextDecoration.combine',
          body:
              'TextDecoration is a bit-flag value. `TextDecoration.combine` '
              'returns a new value that contains both underlying line '
              'kinds. `contains(...)` queries individual flags.',
        ),
        _codeBlock(
          'final ui.TextDecoration both =\n'
          '    ui.TextDecoration.combine(<ui.TextDecoration>[\n'
          '      ui.TextDecoration.underline,\n'
          '      ui.TextDecoration.overline,\n'
          '    ]);\n'
          '\n'
          'print(both.contains(ui.TextDecoration.underline)); // true\n'
          'print(both.contains(ui.TextDecoration.lineThrough)); // false',
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 8 -- TextAlign + TextDirection grid
// =====================================================================

Widget _buildAlignmentGrid() {
  final List<TextAlign> aligns = <TextAlign>[
    TextAlign.start,
    TextAlign.center,
    TextAlign.end,
    TextAlign.left,
    TextAlign.right,
    TextAlign.justify,
  ];
  final List<String> alignNames = <String>[
    'start',
    'center',
    'end',
    'left',
    'right',
    'justify',
  ];
  final List<TextDirection> directions = <TextDirection>[
    TextDirection.ltr,
    TextDirection.rtl,
  ];
  final List<String> directionNames = <String>['ltr', 'rtl'];

  const String sampleText =
      'Sample paragraph used to demonstrate alignment plus direction.';

  return _sectionShell(
    index: 7,
    tag: 'ALIGN',
    title: 'TextAlign  x  TextDirection grid',
    subtitle:
        'TextAlign.start / end depend on TextDirection. left / right '
        'do not. justify spreads inter-word whitespace.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (int dIdx = 0; dIdx < directions.length; dIdx++)
          Container(
            margin: const EdgeInsets.only(bottom: _kGapMd),
            padding: const EdgeInsets.all(_kGapMd),
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TextDirection.${directionNames[dIdx]}',
                  style: const TextStyle(
                    color: _kAccentTeal,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: _kGapSm),
                for (int aIdx = 0; aIdx < aligns.length; aIdx++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'TextAlign.${alignNames[aIdx]}',
                          style: const TextStyle(
                            color: _kInkMuted,
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: _kGapXs),
                        _CustomPaintBox(
                          height: 50.0,
                          painter: _SimpleParagraphPainter(
                            text: sampleText,
                            paragraphStyle: ui.ParagraphStyle(
                              textAlign: aligns[aIdx],
                              textDirection: directions[dIdx],
                              fontSize: 13.0,
                              maxLines: 2,
                            ),
                            textStyle: ui.TextStyle(
                              color: _kInkDark,
                              fontSize: 13.0,
                            ),
                            constraintWidth: 360.0,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 9 -- Cheat sheet
// =====================================================================

Widget _buildCheatSheet() {
  return _sectionShell(
    index: 8,
    tag: 'RECAP',
    title: 'Cheat sheet -- which layer to use when',
    subtitle:
        'Most code stays one layer above the engine boundary. The '
        'tour finishes with a decision matrix for the four common '
        'cases.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _cheatRow(
          situation: 'You want a `Text("hello")` with custom colour.',
          choice: 'painting.TextStyle (re-exported as TextStyle).',
          rationale:
              'Widgets only accept the painting layer. The engine '
              'conversion is invisible.',
        ),
        _cheatRow(
          situation: 'You are writing a `CustomPainter` that draws a label.',
          choice: 'EITHER TextPainter(text: TextSpan(...)) OR '
              'ui.ParagraphBuilder + ui.TextStyle.',
          rationale:
              'TextPainter is easier and uses painting.TextStyle. '
              'ParagraphBuilder is leaner -- no widget framework.',
        ),
        _cheatRow(
          situation: 'You need per-line metrics (ascent, descent, baseline).',
          choice: 'ui.ParagraphBuilder -> Paragraph -> computeLineMetrics().',
          rationale: 'TextPainter exposes only height/width/baseline.',
        ),
        _cheatRow(
          situation: 'You are implementing a text editor or terminal.',
          choice: 'Direct dart:ui (ParagraphBuilder + strut).',
          rationale:
              'You need fixed line stride, glyph-level positioning, '
              'and shaping control. forceStrutHeight is essential.',
        ),
        _divider(),
        _paragraphCard(
          title: 'Final reminder',
          body:
              'painting.TextStyle and ui.TextStyle are NOT '
              'interchangeable in the type system. They share many '
              'parameter names by design, but only painting.TextStyle '
              'gives you `merge`, theme inheritance, and `copyWith`. '
              'ui.TextStyle is a flat data record consumed by the engine.',
        ),
        _codeBlock(
          '// Lowering a painting.TextStyle to ui.TextStyle\n'
          'final TextStyle pStyle = TextStyle(color: Color(0xFF1F2937));\n'
          'final ui.TextStyle uStyle = pStyle.getTextStyle();\n'
          '\n'
          '// There is NO way back. ui.TextStyle is a one-way descent.',
        ),
      ],
    ),
  );
}

Widget _cheatRow({
  required String situation,
  required String choice,
  required String rationale,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(_kGapMd),
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          situation,
          style: const TextStyle(
            color: _kInkDark,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          'Choice: $choice',
          style: const TextStyle(
            color: _kAccentCyan,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          rationale,
          style: const TextStyle(
            color: _kInkBody,
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// CustomPaint glue
// =====================================================================
//
// We wrap every CustomPainter in a fixed-size box so that the layout
// is predictable regardless of how Paragraph.layout behaves at the
// edge of the viewport.
// =====================================================================

class _CustomPaintBox extends StatelessWidget {
  const _CustomPaintBox({
    required this.height,
    required this.painter,
    this.width,
  });

  final double height;
  final double? width;
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    if (width != null) {
      return SizedBox(
        height: height,
        width: width,
        child: CustomPaint(painter: painter, size: Size(width!, height)),
      );
    }
    return SizedBox(
      height: height,
      child: CustomPaint(painter: painter, size: Size.infinite),
    );
  }
}

// ---------------------------------------------------------------------
// _SimpleParagraphPainter
// ---------------------------------------------------------------------
// Builds one ui.Paragraph from a (ParagraphStyle, TextStyle, text)
// triple and draws it at (0,0). The constraintWidth parameter is the
// width used for `Paragraph.layout`; if null, we use the size.width
// supplied by the framework at paint time.
// ---------------------------------------------------------------------

class _SimpleParagraphPainter extends CustomPainter {
  _SimpleParagraphPainter({
    required this.text,
    required this.paragraphStyle,
    required this.textStyle,
    this.constraintWidth,
  });

  final String text;
  final ui.ParagraphStyle paragraphStyle;
  final ui.TextStyle textStyle;
  final double? constraintWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = constraintWidth ?? size.width;
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(text);
    final ui.Paragraph paragraph = builder.build()
      ..layout(ui.ParagraphConstraints(width: w));
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// _StrutDemoPainter
// ---------------------------------------------------------------------
// Renders a small two-line paragraph using a mixed run of small + large
// font sizes. The optional StrutStyle is applied to the ParagraphStyle.
// Faint horizontal guide lines are drawn at the line boundaries so the
// reader can SEE the change in line stride.
// ---------------------------------------------------------------------

class _StrutDemoPainter extends CustomPainter {
  _StrutDemoPainter({this.strut});

  final ui.StrutStyle? strut;

  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphStyle ps = ui.ParagraphStyle(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      fontSize: 14.0,
      strutStyle: strut,
    );
    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(ps)
      ..pushStyle(ui.TextStyle(color: _kInkDark, fontSize: 11.0))
      ..addText('small\n')
      ..pop()
      ..pushStyle(ui.TextStyle(color: _kInkDark, fontSize: 20.0))
      ..addText('LARGE\n')
      ..pop()
      ..pushStyle(ui.TextStyle(color: _kInkDark, fontSize: 11.0))
      ..addText('small again');

    final ui.Paragraph paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset.zero);

    // Draw faint baselines / line tops via computeLineMetrics
    final Paint guide = Paint()
      ..color = _kBorderStrong
      ..strokeWidth = 0.8;
    final List<ui.LineMetrics> metrics = paragraph.computeLineMetrics();
    for (int i = 0; i < metrics.length; i++) {
      final ui.LineMetrics lm = metrics[i];
      final double top = lm.baseline - lm.ascent;
      canvas.drawLine(
        Offset(0.0, top),
        Offset(size.width, top),
        guide,
      );
      // baseline as dashed-ish (we just draw a slightly bolder line)
      final Paint baseline = Paint()
        ..color = _kAccentPink.withOpacity(0.6)
        ..strokeWidth = 0.6;
      canvas.drawLine(
        Offset(0.0, lm.baseline),
        Offset(size.width, lm.baseline),
        baseline,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// _LineMetricsPainter
// ---------------------------------------------------------------------
// Renders three stacked rectangles (one per LineMetrics) with their
// baselines indicated, plus tiny labels showing ascent/descent.
// ---------------------------------------------------------------------

class _LineMetricsPainter extends CustomPainter {
  _LineMetricsPainter({required this.lines});

  final List<ui.LineMetrics> lines;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint box = Paint()..color = const Color(0xFFEFF6FF);
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = _kBorderStrong;
    final Paint baselinePaint = Paint()
      ..color = _kAccentPink
      ..strokeWidth = 1.2;
    final Paint ascentPaint = Paint()
      ..color = _kAccentBlue.withOpacity(0.7)
      ..strokeWidth = 1.0;

    for (int i = 0; i < lines.length; i++) {
      final ui.LineMetrics lm = lines[i];
      final double top = lm.baseline - lm.ascent + 6.0;
      final double bottom = lm.baseline + lm.descent + 6.0;
      final Rect lineBox = Rect.fromLTRB(8.0, top, 8.0 + lm.width, bottom);
      canvas.drawRect(lineBox, box);
      canvas.drawRect(lineBox, border);

      // Baseline
      final double baselineY = lm.baseline + 6.0;
      canvas.drawLine(
        Offset(lineBox.left, baselineY),
        Offset(lineBox.right, baselineY),
        baselinePaint,
      );

      // Ascent tick on the left edge
      canvas.drawLine(
        Offset(lineBox.left + 2.0, top),
        Offset(lineBox.left + 2.0, baselineY),
        ascentPaint,
      );

      // Build a tiny annotation paragraph for this line.
      final ui.ParagraphBuilder pb = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          fontSize: 10.0,
        ),
      )
        ..pushStyle(ui.TextStyle(color: _kInkMuted, fontSize: 10.0))
        ..addText(
          'line ${lm.lineNumber}  '
          'ascent=${lm.ascent.toStringAsFixed(1)}  '
          'descent=${lm.descent.toStringAsFixed(1)}  '
          'width=${lm.width.toStringAsFixed(0)}  '
          'hardBreak=${lm.hardBreak}',
        );
      final ui.Paragraph annotation = pb.build()
        ..layout(const ui.ParagraphConstraints(width: 360.0));
      canvas.drawParagraph(
        annotation,
        Offset(lineBox.right + 8.0, top - 2.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// _MultiRunParagraphPainter
// ---------------------------------------------------------------------
// Demonstrates push / pop of multiple ui.TextStyle scopes plus mixed
// inline runs (the same recipe the section explains in code).
// ---------------------------------------------------------------------

class _MultiRunParagraphPainter extends CustomPainter {
  _MultiRunParagraphPainter({required this.runs});

  final List<String> runs;

  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        fontSize: 16.0,
      ),
    );

    // run 0: normal
    pb.pushStyle(ui.TextStyle(color: _kInkDark, fontSize: 16.0));
    pb.addText(runs[0]);
    pb.pop();
    // run 1: BOLD red
    pb.pushStyle(ui.TextStyle(
      color: _kAccentRed,
      fontSize: 16.0,
      fontWeight: ui.FontWeight.w800,
    ));
    pb.addText(runs[1]);
    pb.pop();
    // run 2: italic indigo
    pb.pushStyle(ui.TextStyle(
      color: _kAccentIndigo,
      fontSize: 16.0,
      fontStyle: ui.FontStyle.italic,
    ));
    pb.addText(runs[2]);
    pb.pop();
    // run 3: wide green
    pb.pushStyle(ui.TextStyle(
      color: _kAccentGreen,
      fontSize: 16.0,
      letterSpacing: 2.0,
    ));
    pb.addText(runs[3]);
    pb.pop();
    // run 4: tight blue
    pb.pushStyle(ui.TextStyle(
      color: _kAccentBlue,
      fontSize: 16.0,
      letterSpacing: -1.0,
    ));
    pb.addText(runs[4]);
    pb.pop();
    // run 5: amber + underline
    pb.pushStyle(ui.TextStyle(
      color: _kAccentAmber,
      fontSize: 16.0,
      decoration: ui.TextDecoration.underline,
      decorationColor: _kAccentAmber,
      decorationStyle: ui.TextDecorationStyle.solid,
    ));
    pb.addText(runs[5]);
    pb.pop();

    final ui.Paragraph paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// _PlaceholderParagraphPainter
// ---------------------------------------------------------------------
// Uses ParagraphBuilder.addPlaceholder to reserve an inline rectangle
// inside a flowing paragraph, then draws a small coloured rectangle in
// the same spot so the reader sees the gap.
// ---------------------------------------------------------------------

class _PlaceholderParagraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        fontSize: 16.0,
      ),
    )
      ..pushStyle(ui.TextStyle(color: _kInkDark, fontSize: 16.0))
      ..addText('A widget can sit ')
      ..addPlaceholder(
        28.0,
        18.0,
        ui.PlaceholderAlignment.middle,
        baseline: ui.TextBaseline.alphabetic,
      )
      ..addText(' inside running text.')
      ..pop();

    final ui.Paragraph paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset.zero);

    // The engine returns placeholder rects after layout. We paint a
    // little chip on top so the placeholder is visible.
    final List<ui.TextBox> boxes = paragraph.getBoxesForPlaceholders();
    final Paint chip = Paint()..color = _kAccentTeal;
    final Paint chipBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = _kAccentCyan;
    for (int i = 0; i < boxes.length; i++) {
      final ui.TextBox b = boxes[i];
      final Rect rect = Rect.fromLTRB(b.left, b.top, b.right, b.bottom);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4.0)),
        chip,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4.0)),
        chipBorder,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------
// _DecorationCellPainter
// ---------------------------------------------------------------------
// One cell of the decoration gallery grid. Renders the word "AaBbCc"
// with a single decoration + style combination, plus a faint baseline
// guide so the reader can compare across cells.
// ---------------------------------------------------------------------

class _DecorationCellPainter extends CustomPainter {
  _DecorationCellPainter({
    required this.decoration,
    required this.decorationStyle,
  });

  final ui.TextDecoration decoration;
  final ui.TextDecorationStyle decorationStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        fontSize: 14.0,
      ),
    )
      ..pushStyle(ui.TextStyle(
        color: _kInkDark,
        fontSize: 14.0,
        decoration: decoration,
        decorationColor: _kAccentRed,
        decorationStyle: decorationStyle,
        decorationThickness: 1.4,
      ))
      ..addText('AaBbCc');
    final ui.Paragraph paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
