// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// =============================================================================
// D4rt Test Script: The Inline-Span Composer
// =============================================================================
// THEME: "The Inline-Span Composer" — a typographic atelier where TextSpan,
// WidgetSpan, RichText, and Text.rich are studied as composable instruments
// for mixing characters, widgets, and semantics into a single continuous flow.
//
// API SURFACE COVERED:
//   - TextSpan(text, style, children, semanticsLabel)
//   - TextSpan.toPlainText()
//   - TextSpan equality (operator==)
//   - WidgetSpan(child, alignment, baseline)
//   - PlaceholderAlignment (top, middle, bottom, baseline, aboveBaseline,
//     belowBaseline)
//   - TextBaseline (alphabetic / ideographic)
//   - RichText(text: ...)
//   - Text.rich(...)
//
// AUTHORING CONSTRAINTS:
//   - No StatefulWidget / StatelessWidget subclasses.
//   - No setState, no AnimationController, no streams, no Timer, no Future,
//     no async/await.
//   - Top-level Widget helper functions only.
//   - Entry point: dynamic build(BuildContext context) => MaterialApp(...).
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// PALETTE CONSTANTS
// -----------------------------------------------------------------------------
// Each section uses a unique palette so the showcase reads as a stack of
// distinct studios in the same atelier.

const Color _heroDeep = Color(0xFF1A1B2E);
const Color _heroMid = Color(0xFF2D2F5F);
const Color _heroAccent = Color(0xFFE8C547);
const Color _heroSoft = Color(0xFFB8B8D1);

const Color _overviewBg = Color(0xFFF6F1E7);
const Color _overviewBorder = Color(0xFFD4C28C);
const Color _overviewInk = Color(0xFF3B2F1B);
const Color _overviewAccent = Color(0xFF8B6F32);

const Color _s1Bg = Color(0xFFE3F2FD);
const Color _s1Border = Color(0xFF64B5F6);
const Color _s1Ink = Color(0xFF0D47A1);
const Color _s1Tile = Color(0xFFBBDEFB);

const Color _s2Bg = Color(0xFFE8F5E9);
const Color _s2Border = Color(0xFF66BB6A);
const Color _s2Ink = Color(0xFF1B5E20);
const Color _s2Tile = Color(0xFFC8E6C9);

const Color _s3Bg = Color(0xFFFFF3E0);
const Color _s3Border = Color(0xFFFFA726);
const Color _s3Ink = Color(0xFFE65100);
const Color _s3Tile = Color(0xFFFFE0B2);

const Color _s4Bg = Color(0xFFF3E5F5);
const Color _s4Border = Color(0xFFBA68C8);
const Color _s4Ink = Color(0xFF4A148C);
const Color _s4Tile = Color(0xFFE1BEE7);

const Color _s5Bg = Color(0xFFFCE4EC);
const Color _s5Border = Color(0xFFF06292);
const Color _s5Ink = Color(0xFF880E4F);
const Color _s5Tile = Color(0xFFF8BBD0);

const Color _s6Bg = Color(0xFFE0F7FA);
const Color _s6Border = Color(0xFF4DD0E1);
const Color _s6Ink = Color(0xFF006064);
const Color _s6Tile = Color(0xFFB2EBF2);

const Color _s7Bg = Color(0xFFEDE7F6);
const Color _s7Border = Color(0xFF9575CD);
const Color _s7Ink = Color(0xFF311B92);
const Color _s7Tile = Color(0xFFD1C4E9);

const Color _s8Bg = Color(0xFFFFFDE7);
const Color _s8Border = Color(0xFFFFD54F);
const Color _s8Ink = Color(0xFF827717);
const Color _s8Tile = Color(0xFFFFF59D);

const Color _glossaryBg = Color(0xFFECEFF1);
const Color _glossaryBorder = Color(0xFF90A4AE);
const Color _glossaryInk = Color(0xFF263238);

const Color _epilogueDeep = Color(0xFF1B1B2F);
const Color _epilogueMid = Color(0xFF393E5C);
const Color _epilogueAccent = Color(0xFFF5C518);

// =============================================================================
// ENTRY POINT
// =============================================================================
dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // SHARED SPAN DATA — built once, surfaced in many sections.
  // ---------------------------------------------------------------------------

  // Simple span.
  final TextSpan simpleSpan = TextSpan(text: 'Hello World');

  // Styled span.
  final TextSpan styledSpan = TextSpan(
    text: 'Styled text',
    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  );

  // Parent span with children of varied colors.
  final TextSpan parentSpan = TextSpan(
    text: 'Parent ',
    style: TextStyle(fontSize: 16.0),
    children: [
      TextSpan(text: 'child1 ', style: TextStyle(color: Colors.blue)),
      TextSpan(text: 'child2 ', style: TextStyle(color: Colors.green)),
      TextSpan(text: 'child3', style: TextStyle(color: Colors.red)),
    ],
  );

  // Tappable-looking styled span (no recognizer in D4rt).
  final TextSpan tappableSpan = TextSpan(
    text: 'Tappable text',
    style: TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  );

  // Span with a semanticsLabel that re-labels an emoji.
  final TextSpan semanticSpan = TextSpan(
    text: '🎉',
    semanticsLabel: 'party popper',
  );

  // Equality probes.
  final TextSpan spanA = TextSpan(text: 'test');
  final TextSpan spanB = TextSpan(text: 'test');
  final TextSpan spanC = TextSpan(text: 'other');
  final bool spanAEqB = spanA == spanB;
  final bool spanAEqC = spanA == spanC;

  // toPlainText probe.
  final String parentPlain = parentSpan.toPlainText();
  final String simplePlain = simpleSpan.toPlainText();

  // Children count probe.
  final int parentChildrenCount = parentSpan.children?.length ?? 0;

  // ---------------------------------------------------------------------------
  // SECTION 4 DATA — alignment matrix for WidgetSpan.
  // ---------------------------------------------------------------------------
  final List<Map<String, dynamic>> alignmentRows = <Map<String, dynamic>>[
    {
      'name': 'top',
      'alignment': PlaceholderAlignment.top,
      'description': 'Top of widget aligns with top of text line',
      'use': 'Tall badges above the line',
    },
    {
      'name': 'middle',
      'alignment': PlaceholderAlignment.middle,
      'description': 'Widget centered on the text line midpoint',
      'use': 'Inline icons next to text',
    },
    {
      'name': 'bottom',
      'alignment': PlaceholderAlignment.bottom,
      'description': 'Bottom of widget aligns with bottom of text line',
      'use': 'Footnote markers',
    },
    {
      'name': 'baseline',
      'alignment': PlaceholderAlignment.baseline,
      'description': 'Widget sits on the text baseline (needs baseline arg)',
      'use': 'Typographic glyph swaps',
    },
    {
      'name': 'aboveBaseline',
      'alignment': PlaceholderAlignment.aboveBaseline,
      'description': 'Bottom of widget aligns with the baseline',
      'use': 'Superscript-style widgets',
    },
    {
      'name': 'belowBaseline',
      'alignment': PlaceholderAlignment.belowBaseline,
      'description': 'Top of widget aligns with the baseline',
      'use': 'Subscript-style widgets',
    },
  ];

  // ---------------------------------------------------------------------------
  // SECTION 7 DATA — rating widget pattern stats.
  // ---------------------------------------------------------------------------
  final List<Map<String, dynamic>> ratingStats = <Map<String, dynamic>>[
    {'label': 'Atelier Espresso', 'score': 4.5, 'reviews': 218},
    {'label': 'Inkwell Bistro', 'score': 3.0, 'reviews': 92},
    {'label': 'Serif & Sans Cafe', 'score': 5.0, 'reviews': 401},
    {'label': 'Kerning Kitchen', 'score': 2.5, 'reviews': 47},
  ];

  // ---------------------------------------------------------------------------
  // SECTION 8 DATA — equality and toPlainText cases.
  // ---------------------------------------------------------------------------
  final List<Map<String, dynamic>> equalityCases = <Map<String, dynamic>>[
    {
      'left': "TextSpan(text: 'test')",
      'right': "TextSpan(text: 'test')",
      'equal': spanAEqB,
      'note': 'Same text, no style, no children → equal',
    },
    {
      'left': "TextSpan(text: 'test')",
      'right': "TextSpan(text: 'other')",
      'equal': spanAEqC,
      'note': 'Different text → not equal',
    },
    {
      'left': "Styled red 'Styled text'",
      'right': "Styled red 'Styled text'",
      'equal': styledSpan ==
          TextSpan(
            text: 'Styled text',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
      'note': 'Identical style + text → equal',
    },
  ];

  final List<Map<String, dynamic>> plainTextCases = <Map<String, dynamic>>[
    {
      'source': "TextSpan(text: 'Hello World')",
      'plain': simplePlain,
      'len': simplePlain.length,
    },
    {
      'source': "Parent + 3 children",
      'plain': parentPlain,
      'len': parentPlain.length,
    },
    {
      'source': "Emoji + semantics label",
      'plain': semanticSpan.toPlainText(),
      'len': semanticSpan.toPlainText().length,
    },
  ];

  // ---------------------------------------------------------------------------
  // ASSEMBLE THE MATERIALAPP
  // ---------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heroHeader(),
            SizedBox(height: 24.0),
            _conceptOverview(),
            SizedBox(height: 24.0),
            _sectionOne(simpleSpan, styledSpan, tappableSpan),
            SizedBox(height: 20.0),
            _sectionTwo(parentSpan, parentChildrenCount),
            SizedBox(height: 20.0),
            _sectionThree(),
            SizedBox(height: 20.0),
            _sectionFour(semanticSpan),
            SizedBox(height: 20.0),
            _sectionFive(alignmentRows),
            SizedBox(height: 20.0),
            _sectionSix(parentSpan),
            SizedBox(height: 20.0),
            _sectionSeven(ratingStats),
            SizedBox(height: 20.0),
            _sectionEight(equalityCases, plainTextCases),
            SizedBox(height: 24.0),
            _glossaryPanel(),
            SizedBox(height: 24.0),
            _epilogue(),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// HERO HEADER
// =============================================================================
Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_heroDeep, _heroMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _heroAccent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                '✒',
                style: TextStyle(fontSize: 22.0, color: _heroDeep),
              ),
            ),
            SizedBox(width: 14.0),
            Text(
              'The Inline-Span Composer',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'A typographic atelier for TextSpan, WidgetSpan,\n'
          'RichText and Text.rich — composed for the D4rt interpreter.',
          style: TextStyle(
            fontSize: 15.0,
            color: _heroSoft,
            height: 1.5,
          ),
        ),
        SizedBox(height: 18.0),
        Row(
          children: [
            _heroPill('TextSpan'),
            SizedBox(width: 8.0),
            _heroPill('WidgetSpan'),
            SizedBox(width: 8.0),
            _heroPill('RichText'),
            SizedBox(width: 8.0),
            _heroPill('Text.rich'),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            _heroPill('semanticsLabel'),
            SizedBox(width: 8.0),
            _heroPill('PlaceholderAlignment'),
            SizedBox(width: 8.0),
            _heroPill('toPlainText'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroPill(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Color(0x55FFFFFF), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// =============================================================================
// CONCEPT OVERVIEW
// =============================================================================
Widget _conceptOverview() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _overviewBg,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _overviewBorder, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _overviewAccent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '📜',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              'The Composer\'s Manifesto',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: _overviewInk,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'In Flutter, a paragraph is not a single string. It is a tree of '
          'InlineSpan objects: TextSpans for characters and styles, WidgetSpans '
          'for embedded widgets. RichText paints the tree; Text.rich is the '
          'sugar-coated front door.',
          style: TextStyle(fontSize: 14.0, color: _overviewInk, height: 1.55),
        ),
        SizedBox(height: 14.0),
        Text(
          'Why a tree?',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: _overviewInk,
          ),
        ),
        SizedBox(height: 6.0),
        _bullet('Styles inherit from parent span to child span.'),
        _bullet('Children can mix TextSpan and WidgetSpan freely.'),
        _bullet('Semantics labels override visible text for assistive tech.'),
        _bullet('Equality is structural — same text + style ⇒ equal.'),
        _bullet('toPlainText() walks the tree and concatenates characters.'),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•  ',
          style: TextStyle(
            fontSize: 14.0,
            color: _overviewAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: _overviewInk,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1: TEXTSPAN BASICS
// =============================================================================
Widget _sectionOne(
  TextSpan simpleSpan,
  TextSpan styledSpan,
  TextSpan tappableSpan,
) {
  return _sectionFrame(
    bg: _s1Bg,
    border: _s1Border,
    ink: _s1Ink,
    number: '1',
    title: 'TextSpan Basics',
    subtitle: 'text, style — the smallest atom of inline composition',
    accent: _s1Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _demoTile(
          tileColor: _s1Tile,
          label: 'Bare TextSpan',
          content: Text.rich(simpleSpan),
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s1Tile,
          label: 'Styled TextSpan (red + bold)',
          content: Text.rich(styledSpan),
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s1Tile,
          label: 'Underlined "tappable" TextSpan',
          content: Text.rich(tappableSpan),
        ),
        SizedBox(height: 16.0),
        _recipeCard(
          accent: _s1Ink,
          title: 'Recipe — bare span',
          lines: const <String>[
            "TextSpan(",
            "  text: 'Hello World',",
            ")",
          ],
        ),
        SizedBox(height: 10.0),
        _recipeCard(
          accent: _s1Ink,
          title: 'Recipe — styled span',
          lines: const <String>[
            "TextSpan(",
            "  text: 'Styled text',",
            "  style: TextStyle(",
            "    color: Colors.red,",
            "    fontWeight: FontWeight.bold,",
            "  ),",
            ")",
          ],
        ),
        SizedBox(height: 16.0),
        _twoColTable(
          inkColor: _s1Ink,
          tileColor: _s1Tile,
          headerLeft: 'Field',
          headerRight: 'Purpose',
          rows: const <List<String>>[
            ['text', 'The string this span contributes to the paragraph'],
            ['style', 'TextStyle merged onto inherited parent style'],
            ['children', 'Sub-spans rendered after `text`'],
            ['semanticsLabel', 'Override of `text` for assistive technologies'],
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2: NESTED CHILDREN
// =============================================================================
Widget _sectionTwo(TextSpan parentSpan, int childCount) {
  return _sectionFrame(
    bg: _s2Bg,
    border: _s2Border,
    ink: _s2Ink,
    number: '2',
    title: 'Nested Children',
    subtitle:
        'Parent text plus typed children — each child inherits the parent style',
    accent: _s2Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _demoTile(
          tileColor: _s2Tile,
          label: 'Parent (size 16) + 3 colored children',
          content: Text.rich(parentSpan),
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s2Tile,
          label: 'Children count',
          content: Text(
            'parentSpan.children?.length = $childCount',
            style: TextStyle(
              fontSize: 13.0,
              fontFamily: 'monospace',
              color: _s2Ink,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        _recipeCard(
          accent: _s2Ink,
          title: 'Recipe — parent + children',
          lines: const <String>[
            "TextSpan(",
            "  text: 'Parent ',",
            "  style: TextStyle(fontSize: 16.0),",
            "  children: [",
            "    TextSpan(text: 'child1 ',",
            "      style: TextStyle(color: Colors.blue)),",
            "    TextSpan(text: 'child2 ',",
            "      style: TextStyle(color: Colors.green)),",
            "    TextSpan(text: 'child3',",
            "      style: TextStyle(color: Colors.red)),",
            "  ],",
            ")",
          ],
        ),
        SizedBox(height: 16.0),
        _twoColTable(
          inkColor: _s2Ink,
          tileColor: _s2Tile,
          headerLeft: 'Layer',
          headerRight: 'Effective style',
          rows: const <List<String>>[
            ['parent', 'fontSize: 16'],
            ['child1', 'fontSize: 16 + color: blue'],
            ['child2', 'fontSize: 16 + color: green'],
            ['child3', 'fontSize: 16 + color: red'],
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3: STYLED SPAN MEDLEY
// =============================================================================
Widget _sectionThree() {
  final TextSpan medley = TextSpan(
    style: TextStyle(fontSize: 15.0, color: Color(0xFF2C1810)),
    children: [
      TextSpan(text: 'Composing '),
      TextSpan(
        text: 'bold',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ', '),
      TextSpan(
        text: 'italic',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      TextSpan(text: ', '),
      TextSpan(
        text: 'underline',
        style: TextStyle(decoration: TextDecoration.underline),
      ),
      TextSpan(text: ', '),
      TextSpan(
        text: 'strike',
        style: TextStyle(decoration: TextDecoration.lineThrough),
      ),
      TextSpan(text: ', and '),
      TextSpan(
        text: 'color',
        style: TextStyle(color: _s3Ink, fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' in one paragraph.'),
    ],
  );

  final TextSpan letterSpaced = TextSpan(
    text: 'L E T T E R S P A C E D',
    style: TextStyle(
      fontSize: 13.0,
      letterSpacing: 2.4,
      color: _s3Ink,
      fontWeight: FontWeight.w600,
    ),
  );

  final TextSpan heightSpan = TextSpan(
    style: TextStyle(fontSize: 14.0, height: 1.8, color: Color(0xFF2C1810)),
    children: [
      TextSpan(text: 'Line one stretches above and below.\n'),
      TextSpan(text: 'Line two breathes with `height: 1.8`.\n'),
      TextSpan(text: 'Line three closes the breathing exercise.'),
    ],
  );

  return _sectionFrame(
    bg: _s3Bg,
    border: _s3Border,
    ink: _s3Ink,
    number: '3',
    title: 'Styled Span Medley',
    subtitle: 'Mixing fontStyle, decoration, letterSpacing, and height',
    accent: _s3Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _demoTile(
          tileColor: _s3Tile,
          label: 'Inline styles',
          content: Text.rich(medley),
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s3Tile,
          label: 'letterSpacing',
          content: Text.rich(letterSpaced),
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s3Tile,
          label: 'height (line-height)',
          content: Text.rich(heightSpan),
        ),
        SizedBox(height: 16.0),
        _recipeCard(
          accent: _s3Ink,
          title: 'Recipe — mixed inline styles',
          lines: const <String>[
            "TextSpan(",
            "  children: [",
            "    TextSpan(text: 'Composing '),",
            "    TextSpan(text: 'bold',",
            "      style: TextStyle(fontWeight: FontWeight.bold)),",
            "    TextSpan(text: ', italic',",
            "      style: TextStyle(fontStyle: FontStyle.italic)),",
            "  ],",
            ")",
          ],
        ),
        SizedBox(height: 16.0),
        _twoColTable(
          inkColor: _s3Ink,
          tileColor: _s3Tile,
          headerLeft: 'TextStyle field',
          headerRight: 'Effect',
          rows: const <List<String>>[
            ['fontWeight', 'Bold / weight gradations'],
            ['fontStyle', 'Italic vs normal'],
            ['decoration', 'underline / lineThrough / overline'],
            ['letterSpacing', 'Horizontal space between glyphs'],
            ['height', 'Multiplier on line height'],
            ['color', 'Glyph fill color'],
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4: SEMANTICS LABELS
// =============================================================================
Widget _sectionFour(TextSpan semanticSpan) {
  final TextSpan abbrSpan = TextSpan(
    text: 'API',
    style: TextStyle(fontWeight: FontWeight.bold, color: _s4Ink),
    semanticsLabel: 'Application Programming Interface',
  );

  final TextSpan emojiSentence = TextSpan(
    style: TextStyle(fontSize: 15.0, color: Color(0xFF2C1810)),
    children: [
      TextSpan(text: 'Ship the release '),
      TextSpan(text: '🚀', semanticsLabel: 'rocket'),
      TextSpan(text: ' and celebrate '),
      TextSpan(text: '🎉', semanticsLabel: 'party popper'),
      TextSpan(text: ' the milestone.'),
    ],
  );

  return _sectionFrame(
    bg: _s4Bg,
    border: _s4Border,
    ink: _s4Ink,
    number: '4',
    title: 'Semantics Labels',
    subtitle: 'Override visible text for screen readers via semanticsLabel',
    accent: _s4Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _demoTile(
          tileColor: _s4Tile,
          label: 'Single emoji with label',
          content: Row(
            children: [
              Text.rich(semanticSpan, style: TextStyle(fontSize: 28.0)),
              SizedBox(width: 14.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: _s4Ink,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'reads as: "${semanticSpan.semanticsLabel}"',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s4Tile,
          label: 'Abbreviation with expanded label',
          content: Row(
            children: [
              Text.rich(abbrSpan, style: TextStyle(fontSize: 18.0)),
              SizedBox(width: 14.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: _s4Ink,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'reads as: "${abbrSpan.semanticsLabel}"',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s4Tile,
          label: 'Mixed emoji sentence',
          content: Text.rich(emojiSentence),
        ),
        SizedBox(height: 16.0),
        _recipeCard(
          accent: _s4Ink,
          title: 'Recipe — semanticsLabel',
          lines: const <String>[
            "TextSpan(",
            "  text: '🎉',",
            "  semanticsLabel: 'party popper',",
            ")",
          ],
        ),
        SizedBox(height: 16.0),
        _twoColTable(
          inkColor: _s4Ink,
          tileColor: _s4Tile,
          headerLeft: 'Visible text',
          headerRight: 'Announced label',
          rows: const <List<String>>[
            ['🎉', 'party popper'],
            ['🚀', 'rocket'],
            ['API', 'Application Programming Interface'],
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5: WIDGETSPAN ALIGNMENT MATRIX
// =============================================================================
Widget _sectionFive(List<Map<String, dynamic>> alignmentRows) {
  Widget chip(Color c, String label) => Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      );

  Widget alignmentDemo(PlaceholderAlignment alignment) {
    final TextSpan demo = TextSpan(
      style: TextStyle(fontSize: 18.0, color: Color(0xFF2C1810)),
      children: [
        TextSpan(text: 'text '),
        WidgetSpan(
          alignment: alignment,
          // Flutter asserts baseline != null for aboveBaseline / belowBaseline /
          // baseline alignments (widget_span.dart line 83). Supply it for all
          // three; ignored by the other three alignments.
          baseline: (alignment == PlaceholderAlignment.baseline ||
                  alignment == PlaceholderAlignment.aboveBaseline ||
                  alignment == PlaceholderAlignment.belowBaseline)
              ? TextBaseline.alphabetic
              : null,
          child: Container(
            width: 26.0,
            height: 26.0,
            decoration: BoxDecoration(
              color: _s5Ink,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                '★',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),
        ),
        TextSpan(text: ' text'),
      ],
    );
    return Text.rich(demo);
  }

  return _sectionFrame(
    bg: _s5Bg,
    border: _s5Border,
    ink: _s5Ink,
    number: '5',
    title: 'WidgetSpan Alignment Matrix',
    subtitle:
        'PlaceholderAlignment — top, middle, bottom, baseline, above, below',
    accent: _s5Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final row in alignmentRows)
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _s5Tile,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      chip(_s5Ink, row['name'] as String),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          row['description'] as String,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: _s5Ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: _s5Border, width: 1.0),
                    ),
                    child: alignmentDemo(
                      row['alignment'] as PlaceholderAlignment,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Use it for: ${row['use']}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: _s5Ink,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 4.0),
        _recipeCard(
          accent: _s5Ink,
          title: 'Recipe — baseline alignment',
          lines: const <String>[
            "WidgetSpan(",
            "  alignment: PlaceholderAlignment.baseline,",
            "  baseline: TextBaseline.alphabetic,",
            "  child: Container(",
            "    width: 16.0,",
            "    height: 16.0,",
            "    decoration: BoxDecoration(",
            "      color: Colors.red,",
            "      shape: BoxShape.circle,",
            "    ),",
            "  ),",
            ")",
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6: RICHTEXT VS TEXT.RICH
// =============================================================================
Widget _sectionSix(TextSpan parentSpan) {
  final RichText richDemo = RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16.0, color: Color(0xFF2C1810)),
      children: [
        TextSpan(text: 'Hello '),
        WidgetSpan(
          child: Icon(Icons.favorite, size: 16.0, color: Colors.red),
        ),
        TextSpan(text: ' World '),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            width: 60.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: _s6Ink,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Center(
              child: Text(
                'inline',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        TextSpan(text: ' end'),
      ],
    ),
  );

  final Widget textRichDemo = Text.rich(parentSpan);

  return _sectionFrame(
    bg: _s6Bg,
    border: _s6Border,
    ink: _s6Ink,
    number: '6',
    title: 'RichText vs Text.rich',
    subtitle: 'Both render an InlineSpan tree — choose by ergonomics',
    accent: _s6Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _demoTile(
          tileColor: _s6Tile,
          label: 'RichText(text: TextSpan(children: [...]))',
          content: richDemo,
        ),
        SizedBox(height: 10.0),
        _demoTile(
          tileColor: _s6Tile,
          label: 'Text.rich(parentSpan)',
          content: textRichDemo,
        ),
        SizedBox(height: 16.0),
        _recipeCard(
          accent: _s6Ink,
          title: 'Recipe — RichText with mixed spans',
          lines: const <String>[
            "RichText(",
            "  text: TextSpan(",
            "    style: TextStyle(fontSize: 16.0),",
            "    children: [",
            "      TextSpan(text: 'Hello '),",
            "      WidgetSpan(",
            "        child: Icon(Icons.favorite, size: 16.0),",
            "      ),",
            "      TextSpan(text: ' World'),",
            "    ],",
            "  ),",
            ")",
          ],
        ),
        SizedBox(height: 16.0),
        _twoColTable(
          inkColor: _s6Ink,
          tileColor: _s6Tile,
          headerLeft: 'Choice',
          headerRight: 'When to pick it',
          rows: const <List<String>>[
            ['RichText', 'Need a raw, low-level painter for InlineSpans'],
            ['Text.rich', 'Want default text style + Text widget conveniences'],
            ['Text(...)', 'Plain string, no inline children or widgets'],
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7: RATINGS WIDGET PATTERN
// =============================================================================
Widget _sectionSeven(List<Map<String, dynamic>> ratingStats) {
  Widget ratingRowFor(double score) {
    final List<InlineSpan> stars = <InlineSpan>[];
    for (int i = 0; i < 5; i++) {
      final double diff = score - i;
      IconData icon;
      Color color;
      if (diff >= 1.0) {
        icon = Icons.star;
        color = _s7Ink;
      } else if (diff >= 0.5) {
        icon = Icons.star_half;
        color = _s7Ink;
      } else {
        icon = Icons.star_border;
        color = Color(0xFFB39DDB);
      }
      stars.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(icon, size: 18.0, color: color),
        ),
      );
    }
    return Text.rich(
      TextSpan(
        children: [
          ...stars,
          WidgetSpan(child: SizedBox(width: 8.0)),
          TextSpan(
            text: score.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: _s7Ink,
            ),
          ),
        ],
      ),
    );
  }

  return _sectionFrame(
    bg: _s7Bg,
    border: _s7Border,
    ink: _s7Ink,
    number: '7',
    title: 'Ratings Widget Pattern',
    subtitle: 'Stars-as-WidgetSpans — a classic real-world use case',
    accent: _s7Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final stat in ratingStats)
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: _s7Tile,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      stat['label'] as String,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: _s7Ink,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ratingRowFor(stat['score'] as double),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${stat['reviews']} reviews',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: _s7Ink,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 6.0),
        _recipeCard(
          accent: _s7Ink,
          title: 'Recipe — star rating',
          lines: const <String>[
            "Text.rich(",
            "  TextSpan(children: [",
            "    WidgetSpan(child: Icon(Icons.star,",
            "      size: 16.0, color: Colors.amber)),",
            "    WidgetSpan(child: Icon(Icons.star_half,",
            "      size: 16.0, color: Colors.amber)),",
            "    WidgetSpan(child: Icon(Icons.star_border,",
            "      size: 16.0, color: Colors.grey)),",
            "  ]),",
            ")",
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8: EQUALITY + TOPLAINTEXT
// =============================================================================
Widget _sectionEight(
  List<Map<String, dynamic>> equalityCases,
  List<Map<String, dynamic>> plainTextCases,
) {
  return _sectionFrame(
    bg: _s8Bg,
    border: _s8Border,
    ink: _s8Ink,
    number: '8',
    title: 'Equality & toPlainText',
    subtitle: 'Structural equality + tree-walking text extraction',
    accent: _s8Border,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TextSpan equality',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: _s8Ink,
          ),
        ),
        SizedBox(height: 8.0),
        for (final c in equalityCases)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _s8Tile,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: (c['equal'] as bool)
                          ? Color(0xFF66BB6A)
                          : Color(0xFFE57373),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        (c['equal'] as bool) ? '=' : '≠',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${c['left']}  vs  ${c['right']}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            color: _s8Ink,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          c['note'] as String,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: _s8Ink,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 16.0),
        Text(
          'toPlainText() walkthrough',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: _s8Ink,
          ),
        ),
        SizedBox(height: 8.0),
        for (final c in plainTextCases)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _s8Tile,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['source'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: _s8Ink,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: _s8Border,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      '"${c['plain']}"  (len: ${c['len']})',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: _s8Ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 12.0),
        _recipeCard(
          accent: _s8Ink,
          title: 'Recipe — equality + toPlainText',
          lines: const <String>[
            "final a = TextSpan(text: 'test');",
            "final b = TextSpan(text: 'test');",
            "assert(a == b);",
            "",
            "final p = TextSpan(",
            "  text: 'A',",
            "  children: [TextSpan(text: 'B')],",
            ");",
            "assert(p.toPlainText() == 'AB');",
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// GLOSSARY PANEL
// =============================================================================
Widget _glossaryPanel() {
  final List<List<String>> entries = const <List<String>>[
    ['InlineSpan', 'Abstract base — TextSpan & WidgetSpan extend it.'],
    ['TextSpan', 'Inline string fragment with optional style and children.'],
    ['WidgetSpan', 'Embeds a full Widget inside a paragraph.'],
    ['PlaceholderAlignment', 'How a WidgetSpan aligns to surrounding text.'],
    ['TextBaseline', 'alphabetic / ideographic — used with baseline alignment.'],
    ['RichText', 'Low-level widget that paints an InlineSpan tree.'],
    ['Text.rich', 'Text widget constructor that accepts an InlineSpan tree.'],
    ['semanticsLabel', 'Accessibility override for the visible text.'],
    ['toPlainText', 'Concatenates all text nodes in the span tree.'],
  ];

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _glossaryBg,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _glossaryBorder, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _glossaryInk,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '📖',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              'Glossary of the Atelier',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: _glossaryInk,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final entry in entries)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: _glossaryInk,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    entry[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    entry[1],
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _glossaryInk,
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
}

// =============================================================================
// EPILOGUE
// =============================================================================
Widget _epilogue() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_epilogueDeep, _epilogueMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _epilogueAccent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '🪶',
                style: TextStyle(fontSize: 18.0, color: _epilogueDeep),
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              'Epilogue — leaving the atelier',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Inline composition is a tree, not a string. Treat TextSpan as the '
          'character-bearing leaf, WidgetSpan as the structural insert, '
          'RichText and Text.rich as the painters, and semanticsLabel as your '
          'contract with assistive tech. Compose, nest, equate, and extract.',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFFE0E0E0),
            height: 1.6,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0x22FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0x55FFFFFF), width: 1.0),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white,
                height: 1.5,
              ),
              children: [
                TextSpan(text: 'Final flourish: '),
                TextSpan(
                  text: 'rich ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'text ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: 'is ',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.auto_awesome,
                    color: _epilogueAccent,
                    size: 16.0,
                  ),
                ),
                TextSpan(
                  text: ' just inline composition.',
                  style: TextStyle(color: _epilogueAccent),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SHARED VISUAL HELPERS
// =============================================================================
Widget _sectionFrame({
  required Color bg,
  required Color border,
  required Color ink,
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: border, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: ink,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: ink,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        body,
      ],
    ),
  );
}

Widget _demoTile({
  required Color tileColor,
  required String label,
  required Widget content,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: tileColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: content,
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required Color accent,
  required String title,
  required List<String> lines,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: accent,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        for (final line in lines)
          Text(
            line.isEmpty ? ' ' : line,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFFE0E0E0),
              height: 1.45,
            ),
          ),
      ],
    ),
  );
}

Widget _twoColTable({
  required Color inkColor,
  required Color tileColor,
  required String headerLeft,
  required String headerRight,
  required List<List<String>> rows,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: tileColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                headerLeft,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: inkColor,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                headerRight,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: inkColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(height: 1.0, color: inkColor),
        SizedBox(height: 6.0),
        for (final row in rows)
          Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    row[0],
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: inkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    row[1],
                    style: TextStyle(
                      fontSize: 11.0,
                      color: inkColor,
                      height: 1.35,
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
