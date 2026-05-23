// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// D4rt deep visual demo of the Flutter `Placeholder` widget.
//
// Placeholder is the rectangle-with-an-X primitive used to reserve space
// while UI is being scaffolded. It is a paint-only leaf widget: it draws
// a stroked rectangle plus its two diagonals, in a configurable colour
// and stroke width, and falls back to a configurable size when it sits
// in an unbounded slot. The fields are:
//
//     Placeholder({
//       Color color = const Color(0xFF455A64),
//       double strokeWidth = 2.0,
//       double fallbackWidth = 400.0,
//       double fallbackHeight = 400.0,
//       Widget? child,
//     })
//
// This script is consumed by the d4rt AST/HTTP bridge. The host wraps the
// returned widget in its own MaterialApp/Scaffold, so this file exposes a
// single static `dynamic build(BuildContext context)` entry point and a
// pile of top-level helper functions. There are no StatefulWidgets, no
// AnimationControllers, and no subclasses of Flutter abstracts.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// PALETTE — graph-paper / blueprint
// ---------------------------------------------------------------------------
//
// The palette is intentionally cool and architectural. Placeholders are
// drafting tools, so the demo borrows from technical drawing: cyan ink
// on cream paper, slate framing, accent strokes pulled from a printer's
// classic four-colour ramp.

const Color kPaper = Color(0xFFFAF7EE);
const Color kPaperShade = Color(0xFFF1ECDC);
const Color kPaperFrame = Color(0xFFE3DCC4);
const Color kInk = Color(0xFF15243A);
const Color kInkSoft = Color(0xFF324A6E);
const Color kInkMute = Color(0xFF6E7C97);
const Color kInkFaint = Color(0xFFA8B1C2);

const Color kHero = Color(0xFF1F3D6E);
const Color kHeroDeep = Color(0xFF0F2244);
const Color kAnatomy = Color(0xFF205B7E);
const Color kSizes = Color(0xFF1F6A6A);
const Color kPalette = Color(0xFF7B3F6F);
const Color kFallback = Color(0xFF8E5F1B);
const Color kWireframe = Color(0xFF38525E);
const Color kForm = Color(0xFF3F5733);
const Color kCards = Color(0xFF6E2F47);
const Color kBad = Color(0xFFAA3C3C);
const Color kStyle = Color(0xFF2D466A);
const Color kPitfall = Color(0xFF7A3315);
const Color kFooter = Color(0xFF1A2332);

// Eight-stop colour wheel used by the palette section.
const Color kWheelRed = Color(0xFFD9534F);
const Color kWheelOrange = Color(0xFFE89B3C);
const Color kWheelMustard = Color(0xFFCCAA22);
const Color kWheelGreen = Color(0xFF55A24B);
const Color kWheelTeal = Color(0xFF2F8A8A);
const Color kWheelBlue = Color(0xFF3870C8);
const Color kWheelIndigo = Color(0xFF5C49AC);
const Color kWheelMagenta = Color(0xFFB13C8F);

// ---------------------------------------------------------------------------
// VALUE CLASSES (no Widget subclassing — d4rt forbids that here)
// ---------------------------------------------------------------------------

class SizeSample {
  final String label;
  final double size;
  final String note;
  const SizeSample(this.label, this.size, this.note);
}

class ColourSample {
  final String label;
  final Color colour;
  final String note;
  const ColourSample(this.label, this.colour, this.note);
}

class StrokeSample {
  final double strokeWidth;
  final String label;
  const StrokeSample(this.strokeWidth, this.label);
}

class FallbackCell {
  final String label;
  final String description;
  final double? containerHeight;
  final double? fallbackWidth;
  final double? fallbackHeight;
  const FallbackCell({
    required this.label,
    required this.description,
    this.containerHeight,
    this.fallbackWidth,
    this.fallbackHeight,
  });
}

class CompareEntry {
  final String name;
  final String summary;
  final String paints;
  final String useFor;
  final Color tint;
  const CompareEntry({
    required this.name,
    required this.summary,
    required this.paints,
    required this.useFor,
    required this.tint,
  });
}

class PitfallNote {
  final String title;
  final String body;
  final Color tint;
  const PitfallNote(this.title, this.body, this.tint);
}

// ---------------------------------------------------------------------------
// build() — entry point. Sections are appended to a scrolling column.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('[placeholder_test] build() entered');
  print('[placeholder_test] sections: anatomy / sizes / palette / fallback / '
      'wireframe / form / card-grid / bad-layouts / style / pitfalls / footer');

  final List<Widget> sections = <Widget>[];
  sections.add(buildHeroBanner());
  sections.add(const SizedBox(height: 28));
  sections.add(buildIntroParagraph());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 1: anatomy');
  sections.add(buildAnatomySection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 2: sized container sizes');
  sections.add(buildSizesSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 3: colour palette x stroke ramp');
  sections.add(buildColourPaletteSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 4: fallback width/height');
  sections.add(buildFallbackSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 5: full app screen wireframe');
  sections.add(buildAppWireframeSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 6: form / settings sketch');
  sections.add(buildFormMockupSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 7: 4x3 card grid mockup');
  sections.add(buildCardGridSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 8: bad layouts caught by Placeholder');
  sections.add(buildBadLayoutsSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 9: stroke width style guide');
  sections.add(buildStrokeStyleSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 10: pitfalls / when not to use');
  sections.add(buildPitfallSection());
  sections.add(const SizedBox(height: 32));

  print('[placeholder_test] -> section 11: footer');
  sections.add(buildFooterSection());
  sections.add(const SizedBox(height: 40));

  return Scaffold(
    backgroundColor: kPaper,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sections,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Cross-section helpers
// ---------------------------------------------------------------------------

Widget buildSectionFrame({
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: accent.withValues(alpha: 0.32), width: 1.1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.08),
          blurRadius: 18,
          offset: const Offset(0, 7),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildSectionTitleRow(
          number: number,
          title: title,
          subtitle: subtitle,
          accent: accent,
        ),
        const SizedBox(height: 18),
        body,
      ],
    ),
  );
}

Widget buildSectionTitleRow({
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: accent.withValues(alpha: 0.45)),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: accent,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: kInkMute,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildProse(String text, {Color tone = kInkSoft}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 12.8,
      height: 1.5,
      color: tone,
    ),
  );
}

Widget buildChip(String text, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: tint.withValues(alpha: 0.45)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: tint,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget buildLabelTag(String text, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: tint.withValues(alpha: 0.55)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: tint,
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget buildDivider({Color tint = kInkFaint, double thickness = 0.9}) {
  return Container(
    height: thickness,
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.55),
    ),
  );
}

// ---------------------------------------------------------------------------
// HERO BANNER + INTRO
// ---------------------------------------------------------------------------

Widget buildHeroBanner() {
  return Container(
    height: 178,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kHeroDeep, kHero, kAnatomy],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kHeroDeep.withValues(alpha: 0.32),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          right: -24,
          top: -32,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
        ),
        Positioned(
          right: 80,
          bottom: -50,
          child: Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ),
        Positioned(
          right: 22,
          top: 22,
          width: 110,
          height: 86,
          child: buildHeroSamplePlaceholder(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'WIDGETS / DEBUG / SCAFFOLDING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Placeholder — the rectangle with an X',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A debugging primitive. Reserves space, crosses itself out, '
                'and patiently waits to be replaced with the real widget.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13.4,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildHeroSamplePlaceholder() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white.withValues(alpha: 0.32)),
    ),
    padding: const EdgeInsets.all(6),
    child: Placeholder(
      color: Colors.white.withValues(alpha: 0.85),
      strokeWidth: 1.5,
    ),
  );
}

Widget buildIntroParagraph() {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kPaperFrame),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 28,
              decoration: BoxDecoration(
                color: kHero,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'What is Placeholder?',
              style: TextStyle(
                color: kInk,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 12),
            buildChip('LEAF WIDGET', kHero),
          ],
        ),
        const SizedBox(height: 12),
        buildProse(
          'Placeholder paints a stroked rectangle and the two diagonals of '
          'that rectangle. It accepts no children — it is a paint-only leaf '
          'widget, intended for sketching layouts. Its `color` and '
          '`strokeWidth` shape the look. Its `fallbackWidth` and '
          '`fallbackHeight` only kick in when the parent fails to bound it '
          'on that axis. Its `child` parameter exists but is unusual: when '
          'set, the rectangle still paints and the child is laid out '
          'inside, useful for mocking a slot that already has a known '
          'inner widget.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 — ANATOMY
// ---------------------------------------------------------------------------
//
// The anatomy panel uses a single oversized Placeholder and a column of
// labelled callouts on the side. Each callout names one of the visual
// parts: the outer frame, the diagonals, the cross intersection, and the
// stroke colour and width.

Widget buildAnatomySection() {
  return buildSectionFrame(
    number: '01',
    title: 'Anatomy of a Placeholder',
    subtitle: 'Stroked rectangle plus two diagonals. That is the entire paint.',
    accent: kAnatomy,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'A Placeholder draws four edges and two diagonals. There is no '
          'fill, no shadow, no rounded corner. The paint is deliberately '
          'rough so it is impossible to mistake for a real component.',
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: 240,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: kPaperShade,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kPaperFrame),
                ),
                child: Placeholder(
                  color: kAnatomy,
                  strokeWidth: 2.4,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildAnatomyCallout(
                    'Outer frame',
                    'Stroked rectangle, top/right/bottom/left edges drawn '
                    'at the configured strokeWidth.',
                    kAnatomy,
                  ),
                  const SizedBox(height: 10),
                  buildAnatomyCallout(
                    'Diagonals',
                    'Two corner-to-corner lines: top-left to bottom-right '
                    'and top-right to bottom-left.',
                    kAnatomy,
                  ),
                  const SizedBox(height: 10),
                  buildAnatomyCallout(
                    'Cross intersection',
                    'Centre of the shape. Visually identifies the box '
                    'and confirms it has non-zero area.',
                    kAnatomy,
                  ),
                  const SizedBox(height: 10),
                  buildAnatomyCallout(
                    'Colour & strokeWidth',
                    'Same colour and pen-width is used for the frame and '
                    'both diagonals. There is no separate fill.',
                    kAnatomy,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        buildAnatomyParameterTable(),
        const SizedBox(height: 16),
        buildAnatomyParameterDiagram(),
      ],
    ),
  );
}

Widget buildAnatomyCallout(String title, String body, Color tint) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tint.withValues(alpha: 0.28)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: tint,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style: const TextStyle(
            color: kInkSoft,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget buildAnatomyParameterTable() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kPaperFrame),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Constructor parameters',
          style: TextStyle(
            color: kAnatomy,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        buildParamRow('color',
            'Colour of the stroked rectangle and diagonals. Defaults to a '
                'cool blue-grey.'),
        buildParamRow('strokeWidth',
            'Pen width in logical pixels. Defaults to 2.0. Used uniformly '
                'across frame and diagonals.'),
        buildParamRow('fallbackWidth',
            'Width to use when the parent supplies an unbounded width '
                'constraint. Defaults to 400.0.'),
        buildParamRow('fallbackHeight',
            'Height to use when the parent supplies an unbounded height '
                'constraint. Defaults to 400.0.'),
        buildParamRow('child',
            'Optional child laid out inside the placeholder rectangle. '
                'Useful for mocking a slot whose inner widget is already '
                'known.'),
      ],
    ),
  );
}

Widget buildParamRow(String name, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: kAnatomy,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAnatomyParameterDiagram() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kAnatomy.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Visual diagram',
          style: TextStyle(
            color: kAnatomy,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: buildDiagramTile(
                title: 'color',
                tint: kWheelBlue,
                placeholder: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Placeholder(color: kWheelBlue, strokeWidth: 2),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDiagramTile(
                title: 'strokeWidth',
                tint: kWheelMustard,
                placeholder: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Placeholder(color: kWheelMustard, strokeWidth: 4),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildDiagramTile(
                title: 'child',
                tint: kWheelGreen,
                placeholder: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Placeholder(
                    color: kWheelGreen,
                    strokeWidth: 2,
                    child: const Center(
                      child: Text(
                        'child',
                        style: TextStyle(
                          color: kInk,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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

Widget buildDiagramTile({
  required String title,
  required Color tint,
  required Widget placeholder,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            color: tint,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        placeholder,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — DEFAULT PLACEHOLDER AT 5 SIZES
// ---------------------------------------------------------------------------
//
// Each size is wrapped in a SizedBox so the placeholder has a definite
// box. The default colour and stroke width are used; only the size
// changes. A label and a metric chip live next to each.

Widget buildSizesSection() {
  final List<SizeSample> samples = const <SizeSample>[
    SizeSample('xs', 50, 'Inline-sized — barely room for the X.'),
    SizeSample('sm', 100, 'Small avatar / icon swap-target.'),
    SizeSample('md', 150, 'Default thumb. Comfortable to read.'),
    SizeSample('lg', 200, 'Card-image stand-in.'),
    SizeSample('xl', 300, 'Hero banner stand-in.'),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    final SizeSample s = samples[i];
    rows.add(buildSizeRow(s, i));
    if (i != samples.length - 1) rows.add(const SizedBox(height: 12));
  }

  return buildSectionFrame(
    number: '02',
    title: 'Default Placeholder at five sizes',
    subtitle: 'Same widget, only the bounding SizedBox differs.',
    accent: kSizes,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'When the parent supplies a definite size, Placeholder simply '
          'fills it. The diagonals stretch from corner to corner, so very '
          'wide and very tall placeholders end up with very long X arms. '
          'Notice that strokeWidth does not scale with size — at 50px the '
          'default 2.0 stroke is heavy, at 300px it is delicate.',
        ),
        const SizedBox(height: 14),
        ...rows,
      ],
    ),
  );
}

Widget buildSizeRow(SizeSample s, int index) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: kPaperFrame),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildLabelTag(s.label.toUpperCase(), kSizes),
              const SizedBox(height: 4),
              Text(
                '#${index + 1}',
                style: const TextStyle(
                  color: kInkMute,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: s.size,
          height: s.size,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: kPaper,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kSizes.withValues(alpha: 0.3)),
          ),
          child: const Placeholder(),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${s.size.toStringAsFixed(0)} x ${s.size.toStringAsFixed(0)} px',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: kSizes,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              buildProse(s.note),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — COLOUR PALETTE x STROKE WIDTH RAMP
// ---------------------------------------------------------------------------
//
// A grid of 8 columns (one per palette colour) by 4 rows (stroke widths
// 1, 2, 3, 4). Each cell renders one Placeholder with the chosen colour
// and stroke. The grid is laid out by hand using nested Rows.

Widget buildColourPaletteSection() {
  final List<ColourSample> palette = const <ColourSample>[
    ColourSample('red', kWheelRed, 'High urgency, alert tone.'),
    ColourSample('orange', kWheelOrange, 'Warm caution, mid energy.'),
    ColourSample('mustard', kWheelMustard, 'Neutral warm, easy on cream.'),
    ColourSample('green', kWheelGreen, 'Positive, growth.'),
    ColourSample('teal', kWheelTeal, 'Calm secondary.'),
    ColourSample('blue', kWheelBlue, 'Informational, default-ish.'),
    ColourSample('indigo', kWheelIndigo, 'Cool, deep.'),
    ColourSample('magenta', kWheelMagenta, 'Standout, section accent.'),
  ];
  final List<double> strokes = const <double>[1.0, 2.0, 3.0, 4.0];

  return buildSectionFrame(
    number: '03',
    title: 'Colour palette and stroke ramp',
    subtitle:
        'Eight tints across four pen widths — 32 placeholders side by side.',
    accent: kPalette,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'In a real wireframe it can help to colour-code placeholders by '
          'role: media, copy, controls, chrome. A heavier strokeWidth '
          'reads as "important", a lighter stroke as "secondary slot". '
          'Below, each column is a colour from the eight-stop wheel; each '
          'row is a strokeWidth from 1.0 (whisper) to 4.0 (assertion).',
        ),
        const SizedBox(height: 14),
        buildPaletteHeaderRow(palette),
        const SizedBox(height: 8),
        for (int r = 0; r < strokes.length; r++) ...<Widget>[
          buildPaletteRow(palette, strokes[r]),
          if (r != strokes.length - 1) const SizedBox(height: 8),
        ],
        const SizedBox(height: 16),
        buildPaletteLegend(palette),
      ],
    ),
  );
}

Widget buildPaletteHeaderRow(List<ColourSample> palette) {
  final List<Widget> cells = <Widget>[];
  cells.add(const SizedBox(width: 46));
  for (int i = 0; i < palette.length; i++) {
    cells.add(Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          decoration: BoxDecoration(
            color: palette[i].colour.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: palette[i].colour.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text(
              palette[i].label.toUpperCase(),
              style: TextStyle(
                color: palette[i].colour,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ),
      ),
    ));
  }
  return Row(children: cells);
}

Widget buildPaletteRow(List<ColourSample> palette, double stroke) {
  final List<Widget> cells = <Widget>[];
  cells.add(SizedBox(
    width: 46,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: kPalette.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kPalette.withValues(alpha: 0.4)),
      ),
      child: Center(
        child: Text(
          stroke.toStringAsFixed(0),
          style: const TextStyle(
            fontFamily: 'monospace',
            color: kPalette,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  ));
  for (int i = 0; i < palette.length; i++) {
    cells.add(Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: SizedBox(
          height: 64,
          child: Placeholder(
            color: palette[i].colour,
            strokeWidth: stroke,
          ),
        ),
      ),
    ));
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: cells,
  );
}

Widget buildPaletteLegend(List<ColourSample> palette) {
  final List<Widget> entries = <Widget>[];
  for (int i = 0; i < palette.length; i++) {
    entries.add(buildPaletteLegendEntry(palette[i]));
  }
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: entries,
  );
}

Widget buildPaletteLegendEntry(ColourSample s) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 7, 12, 7),
    decoration: BoxDecoration(
      color: s.colour.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: s.colour.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: s.colour,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '${s.label} · ${s.note}',
          style: TextStyle(
            color: s.colour,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — FALLBACK WIDTH / HEIGHT
// ---------------------------------------------------------------------------
//
// Inside Align, the parent's tightest constraint may collapse one axis
// to unbounded. Placeholder then uses fallbackWidth / fallbackHeight on
// that axis. Below we render four cells. Each cell pairs an Align with
// a Placeholder, deliberately providing custom fallback dimensions so
// the engagement is visible.

Widget buildFallbackSection() {
  final List<FallbackCell> cells = const <FallbackCell>[
    FallbackCell(
      label: 'A',
      description: 'Align (loose horizontal) + small fallbackWidth = 80',
      containerHeight: 130,
      fallbackWidth: 80,
      fallbackHeight: 80,
    ),
    FallbackCell(
      label: 'B',
      description: 'Align (loose horizontal) + medium fallbackWidth = 140',
      containerHeight: 130,
      fallbackWidth: 140,
      fallbackHeight: 80,
    ),
    FallbackCell(
      label: 'C',
      description: 'Align (loose horizontal) + tall fallbackHeight = 110',
      containerHeight: 140,
      fallbackWidth: 100,
      fallbackHeight: 110,
    ),
    FallbackCell(
      label: 'D',
      description: 'Align (loose horizontal) + wide fallbackWidth = 220',
      containerHeight: 130,
      fallbackWidth: 220,
      fallbackHeight: 70,
    ),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < cells.length; i += 2) {
    final FallbackCell left = cells[i];
    final FallbackCell? right = i + 1 < cells.length ? cells[i + 1] : null;
    rows.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: buildFallbackCell(left)),
        const SizedBox(width: 12),
        Expanded(
          child: right != null
              ? buildFallbackCell(right)
              : const SizedBox.shrink(),
        ),
      ],
    ));
    if (i + 2 < cells.length) rows.add(const SizedBox(height: 12));
  }

  return buildSectionFrame(
    number: '04',
    title: 'fallbackWidth and fallbackHeight',
    subtitle:
        'Engaged only when an axis is unbounded — Align is the typical example.',
    accent: kFallback,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'In a sized box, fallbackWidth and fallbackHeight do nothing — '
          'the parent\'s constraints win. Inside Align (which passes loose '
          'constraints with no minimum to its child), the unbounded axis '
          'falls back to those defaults. The four cells below all sit '
          'inside an Align in a fixed-height container, so the height '
          'axis is bounded and only the width fallback engages — except '
          'in cell C, where we deliberately let the height sag so the '
          'fallbackHeight has a turn as well.',
        ),
        const SizedBox(height: 14),
        ...rows,
      ],
    ),
  );
}

Widget buildFallbackCell(FallbackCell c) {
  final double height = c.containerHeight ?? 130;
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: kFallback.withValues(alpha: 0.32)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            buildLabelTag(c.label, kFallback),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'fbW=${(c.fallbackWidth ?? 400).toStringAsFixed(0)}  '
                'fbH=${(c.fallbackHeight ?? 400).toStringAsFixed(0)}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: kFallback,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: kPaper,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: kFallback.withValues(alpha: 0.3)),
          ),
          alignment: Alignment.centerLeft,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Placeholder(
              color: kFallback,
              strokeWidth: 2.0,
              fallbackWidth: c.fallbackWidth ?? 400,
              fallbackHeight: c.fallbackHeight ?? 400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          c.description,
          style: const TextStyle(
            color: kInkSoft,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — FULL APP SCREEN WIREFRAME
// ---------------------------------------------------------------------------
//
// A single composed mockup of an entire app screen made entirely from
// Placeholder boxes. Header bar across the top, sidebar on the left,
// content tiles in the middle, and a footer along the bottom. Layout is
// done with Stack/Column/Row/Expanded.

Widget buildAppWireframeSection() {
  return buildSectionFrame(
    number: '05',
    title: 'Full app screen wireframe',
    subtitle: 'Header, sidebar, content tiles, footer — all Placeholders.',
    accent: kWireframe,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'When sketching a screen, it is faster to type Placeholder than '
          'to draw boxes in a separate tool. The whole frame below is one '
          'Column. Each region picks its colour and stroke from the same '
          'palette as the rest of the demo. The layout uses Expanded and '
          'Flexible to share space — there is no fixed pixel-width math.',
        ),
        const SizedBox(height: 14),
        Container(
          height: 480,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kPaperShade,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kWireframe.withValues(alpha: 0.4)),
          ),
          child: buildAppFrame(),
        ),
        const SizedBox(height: 14),
        buildWireframeLegend(),
      ],
    ),
  );
}

Widget buildAppFrame() {
  return Column(
    children: <Widget>[
      // Header
      SizedBox(
        height: 56,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 56,
              child: Placeholder(color: kWheelMagenta, strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: Placeholder(color: kWheelBlue, strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Placeholder(color: kWheelTeal, strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 56,
              child: Placeholder(color: kWheelMustard, strokeWidth: 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      // Body
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Sidebar
            SizedBox(
              width: 96,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Placeholder(color: kWheelIndigo, strokeWidth: 2),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 1,
                    child: Placeholder(color: kWheelIndigo, strokeWidth: 2),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 1,
                    child: Placeholder(color: kWheelIndigo, strokeWidth: 2),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 1,
                    child: Placeholder(color: kWheelIndigo, strokeWidth: 2),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 2,
                    child: Placeholder(color: kWheelIndigo, strokeWidth: 2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Main content
            Expanded(
              child: Column(
                children: <Widget>[
                  // Hero strip
                  SizedBox(
                    height: 72,
                    child: Placeholder(color: kWheelOrange, strokeWidth: 2.5),
                  ),
                  const SizedBox(height: 8),
                  // Tile grid 2x2
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Placeholder(
                                    color: kWheelGreen, strokeWidth: 2),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Placeholder(
                                    color: kWheelGreen, strokeWidth: 2),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Placeholder(
                                    color: kWheelGreen, strokeWidth: 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Placeholder(
                                    color: kWheelRed, strokeWidth: 2),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 1,
                                child: Placeholder(
                                    color: kWheelRed, strokeWidth: 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Bottom bar
                  SizedBox(
                    height: 38,
                    child: Placeholder(color: kWheelBlue, strokeWidth: 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      // Footer
      SizedBox(
        height: 36,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Placeholder(color: kWheelMagenta, strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Placeholder(color: kWheelMustard, strokeWidth: 2),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 90,
              child: Placeholder(color: kWheelTeal, strokeWidth: 2),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildWireframeLegend() {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: <Widget>[
      buildPaletteLegendEntry(
          const ColourSample('logo', kWheelMagenta, 'app icon slot')),
      buildPaletteLegendEntry(
          const ColourSample('search', kWheelBlue, 'top-bar input')),
      buildPaletteLegendEntry(
          const ColourSample('actions', kWheelTeal, 'header CTAs')),
      buildPaletteLegendEntry(
          const ColourSample('avatar', kWheelMustard, 'user menu')),
      buildPaletteLegendEntry(
          const ColourSample('nav', kWheelIndigo, 'sidebar items')),
      buildPaletteLegendEntry(
          const ColourSample('hero', kWheelOrange, 'hero strip')),
      buildPaletteLegendEntry(
          const ColourSample('tiles', kWheelGreen, 'content cards')),
      buildPaletteLegendEntry(
          const ColourSample('feature', kWheelRed, 'spotlight tile')),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — FORM / SETTINGS MOCKUP
// ---------------------------------------------------------------------------
//
// A settings-style form sketched out: a top banner, an avatar, a series
// of label-and-field rows, a pair of toggle rows, and an action bar at
// the bottom. The "fields" are Placeholder strips of fixed height; the
// "labels" are tiny gray bars made out of Container with BoxDecoration
// (placeholder is overkill for a tiny label).

Widget buildFormMockupSection() {
  return buildSectionFrame(
    number: '06',
    title: 'Settings page sketch',
    subtitle: 'Banner, avatar, fields, toggles, action bar.',
    accent: kForm,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'A typical settings screen has a small number of recurring '
          'shapes: a banner at the top, an avatar (round or square), '
          'rows of label/field pairs, switches, and an action bar at '
          'the bottom. Sketching all of those with Placeholder lets us '
          'check spacing and proportions before wiring real widgets.',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kPaperShade,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kForm.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 110,
                child: Placeholder(color: kForm, strokeWidth: 2.5),
              ),
              // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #124, P8):
              // original used `SizedBox(height: -42)` to pull the avatar up
              // and overlap the banner. A negative-height SizedBox triggers
              // "BoxConstraints has a negative minimum height" because
              // `RenderConstrainedBox` rejects non-normalised constraints
              // (`h=-42.0; NOT NORMALIZED`). Clamp the spacer to 0 (the
              // canonical >= 0 fix) and recreate the visual overlap with
              // `Transform.translate(offset: Offset(0, -42))` on the avatar —
              // transforms shift only the paint phase and do not feed any
              // negative value into the layout pipeline.
              const SizedBox.shrink(),
              Transform.translate(
                offset: const Offset(0, -42),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, top: 12),
                  child: Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      color: kPaper,
                      borderRadius: BorderRadius.circular(43),
                      border: Border.all(
                        color: kForm.withValues(alpha: 0.6),
                        width: 1.4,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: ClipOval(
                      child: Placeholder(color: kForm, strokeWidth: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              buildFormLabel('Display name'),
              const SizedBox(height: 6),
              SizedBox(
                height: 38,
                child: Placeholder(color: kWheelBlue, strokeWidth: 1.5),
              ),
              const SizedBox(height: 12),
              buildFormLabel('Email address'),
              const SizedBox(height: 6),
              SizedBox(
                height: 38,
                child: Placeholder(color: kWheelBlue, strokeWidth: 1.5),
              ),
              const SizedBox(height: 12),
              buildFormLabel('Bio'),
              const SizedBox(height: 6),
              SizedBox(
                height: 78,
                child: Placeholder(color: kWheelBlue, strokeWidth: 1.5),
              ),
              const SizedBox(height: 14),
              buildFormToggleRow('Receive email updates', kWheelGreen),
              const SizedBox(height: 8),
              buildFormToggleRow('Allow notifications', kWheelTeal),
              const SizedBox(height: 8),
              buildFormToggleRow('Use dark theme by default', kWheelIndigo),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 42,
                      child: Placeholder(color: kInkMute, strokeWidth: 1.6),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 42,
                      child: Placeholder(color: kForm, strokeWidth: 2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFormLabel(String text) {
  return Row(
    children: <Widget>[
      Container(
        width: 4,
        height: 14,
        decoration: BoxDecoration(
          color: kForm,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        text,
        style: const TextStyle(
          color: kForm,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    ],
  );
}

Widget buildFormToggleRow(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(9),
      border: Border.all(color: tint.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 46,
          height: 22,
          child: Placeholder(color: tint, strokeWidth: 1.5),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — 4x3 PRODUCT CARD GRID
// ---------------------------------------------------------------------------
//
// Each card has a Placeholder for the product image, then three text
// "lines" rendered as rounded Containers (a Container with BoxDecoration
// looks like a typeset line of text without committing to copy).

Widget buildCardGridSection() {
  final List<int> productIndices = const <int>[
    0, 1, 2, 3,
    4, 5, 6, 7,
    8, 9, 10, 11,
  ];

  final List<Widget> rows = <Widget>[];
  for (int r = 0; r < 3; r++) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < 4; c++) {
      final int idx = productIndices[r * 4 + c];
      cells.add(Expanded(child: buildProductCard(idx)));
      if (c != 3) cells.add(const SizedBox(width: 10));
    }
    rows.add(Row(children: cells));
    if (r != 2) rows.add(const SizedBox(height: 10));
  }

  return buildSectionFrame(
    number: '07',
    title: 'Card grid mockup (4x3)',
    subtitle: 'Twelve product cards. Image is Placeholder; rows are bars.',
    accent: kCards,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'Container with BoxDecoration is fine for tiny shapes — labels, '
          'tags, and the rounded bars used here for text rows. Placeholder '
          'is reserved for larger content slots where we genuinely need to '
          'see "this is a media area, not a margin". Each card chooses a '
          'tint from the wheel so the grid does not look uniform.',
        ),
        const SizedBox(height: 14),
        ...rows,
      ],
    ),
  );
}

Widget buildProductCard(int idx) {
  final List<Color> wheel = const <Color>[
    kWheelRed,
    kWheelOrange,
    kWheelMustard,
    kWheelGreen,
    kWheelTeal,
    kWheelBlue,
    kWheelIndigo,
    kWheelMagenta,
  ];
  final Color tint = wheel[idx % wheel.length];
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: tint.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.4,
          child: Placeholder(color: tint, strokeWidth: 2),
        ),
        const SizedBox(height: 8),
        buildTextLine(width: double.infinity, height: 9, tint: kInkMute),
        const SizedBox(height: 6),
        buildTextLine(width: 90, height: 9, tint: kInkMute),
        const SizedBox(height: 6),
        buildTextLine(width: 60, height: 12, tint: tint),
      ],
    ),
  );
}

Widget buildTextLine({
  required double width,
  required double height,
  required Color tint,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(height / 2),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — BAD LAYOUTS CAUGHT BY PLACEHOLDER
// ---------------------------------------------------------------------------
//
// Placeholder is excellent at exposing layout failures because it is
// extremely vocal: an X across the whole region is impossible to miss.
// Here we set up three intentionally bad arrangements and add a
// commentary block beside each.
//
// We deliberately do NOT actually render the broken arrangements (they
// would throw layout errors at runtime), but we mock what they would
// look like, then explain how Placeholder makes the failure obvious.

Widget buildBadLayoutsSection() {
  return buildSectionFrame(
    number: '08',
    title: 'Bad layouts caught by Placeholder',
    subtitle: 'Three mocked failure modes and how the X gives them away.',
    accent: kBad,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'Placeholder is an investigator. When a Row inside a Column has '
          'no Expanded, when a list with intrinsic-height items hits an '
          'unbounded parent, when an axis collapses to fallbackWidth — '
          'a Placeholder shows the shape it ended up with, immediately, '
          'instead of throwing or rendering nothing.',
        ),
        const SizedBox(height: 14),
        buildBadLayoutCase(
          number: 'A',
          title: 'Row in Column without Expanded',
          summary:
              'A Row tries to take all available width in a Column. Without '
              'Expanded, the placeholder shows up in its intrinsic width — '
              'you immediately see the row is not stretched.',
          mock: buildBadCaseAMock(),
        ),
        const SizedBox(height: 12),
        buildBadLayoutCase(
          number: 'B',
          title: 'Unbounded height inside ListView',
          summary:
              'Placing a vertical Column with Expanded children inside a '
              'ListView. Without a fixed height the placeholder collapses '
              'to fallbackHeight, revealing the unbounded constraint.',
          mock: buildBadCaseBMock(),
        ),
        const SizedBox(height: 12),
        buildBadLayoutCase(
          number: 'C',
          title: 'Wide content inside Align without bounds',
          summary:
              'Align passes loose constraints. A wide content slot under '
              'Align with no explicit width snaps to fallbackWidth (400 by '
              'default) — and the X on the result tells you exactly which '
              'box is the misbehaving one.',
          mock: buildBadCaseCMock(),
        ),
      ],
    ),
  );
}

Widget buildBadLayoutCase({
  required String number,
  required String title,
  required String summary,
  required Widget mock,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: kBad.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: kBad.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kBad.withValues(alpha: 0.45)),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: kBad,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: kBad,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              buildProse(summary),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPaper,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: kBad.withValues(alpha: 0.3)),
                ),
                child: mock,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBadCaseAMock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(width: 80, height: 36, child: Placeholder(color: kBad)),
          const SizedBox(width: 6),
          SizedBox(width: 60, height: 36, child: Placeholder(color: kBad)),
        ],
      ),
      const SizedBox(height: 6),
      buildLabelTag('not stretched', kBad),
    ],
  );
}

Widget buildBadCaseBMock() {
  return SizedBox(
    height: 110,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kPaperShade,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: kBad.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  child: Placeholder(color: kBad, strokeWidth: 1.4),
                ),
                const SizedBox(height: 4),
                Expanded(child: Placeholder(color: kBad, strokeWidth: 1.4)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildLabelTag('collapsed', kBad),
              const SizedBox(height: 6),
              buildProse(
                'Bottom row falls back to fallbackHeight inside a list.',
                tone: kInkMute,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBadCaseCMock() {
  // Cluster H follow-up: the right SizedBox(width: 110) Column packs
  // buildLabelTag ('fallback hit') + SizedBox(6) + buildProse text
  // ('Align gives loose constraints; width = fallbackWidth.' — 50
  // chars). buildProse renders at fontSize 12.8 with line-height 1.5
  // (19.2 px/line). In the 110-px column the prose wraps to 4 lines at
  // tight render widths = 77 px; adding tag (~22 px) and SizedBox (6)
  // = 105 px natural, exceeding the 90 px SizedBox by ~14 px. Bumped
  // the SizedBox height to 110 to accommodate the 4-line prose with
  // a small headroom. Left Container (height: 80) still fits — Row
  // crossAxisAlignment.center keeps both children visually centred.
  return SizedBox(
    height: 110,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: kPaperShade,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: kBad.withValues(alpha: 0.3)),
            ),
            alignment: Alignment.centerLeft,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Placeholder(
                color: kBad,
                strokeWidth: 2,
                fallbackWidth: 180,
                fallbackHeight: 50,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildLabelTag('fallback hit', kBad),
              const SizedBox(height: 6),
              buildProse(
                'Align gives loose constraints; width = fallbackWidth.',
                tone: kInkMute,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — STROKE WIDTH STYLE GUIDE
// ---------------------------------------------------------------------------
//
// Side-by-side comparison of strokeWidth at 1.0, 2.0, 4.0, and 8.0.
// Each tile shows the same square Placeholder so the only variable is
// the pen width. A tick-mark scale runs across the bottom for a sense
// of pixel weight.

Widget buildStrokeStyleSection() {
  final List<StrokeSample> ramp = const <StrokeSample>[
    StrokeSample(1.0, 'whisper'),
    StrokeSample(2.0, 'default'),
    StrokeSample(4.0, 'bold'),
    StrokeSample(8.0, 'shout'),
  ];

  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < ramp.length; i++) {
    tiles.add(Expanded(child: buildStrokeTile(ramp[i])));
    if (i != ramp.length - 1) tiles.add(const SizedBox(width: 12));
  }

  return buildSectionFrame(
    number: '09',
    title: 'strokeWidth style guide',
    subtitle: 'Same shape, four pen weights — 1.0 / 2.0 / 4.0 / 8.0.',
    accent: kStyle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'Pick a strokeWidth based on the role of the placeholder. '
          'A whisper-weight 1.0 stroke fades into the page and is great '
          'for tertiary slots. The default 2.0 reads as "real content '
          'goes here". Bold 4.0 is for hero or required content; 8.0 is '
          'almost a fill — useful when you want the sketch to nag.',
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tiles,
        ),
        const SizedBox(height: 14),
        buildStrokeScale(ramp),
      ],
    ),
  );
}

Widget buildStrokeTile(StrokeSample s) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kStyle.withValues(alpha: 0.36)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            buildLabelTag('${s.strokeWidth.toStringAsFixed(1)}px', kStyle),
            const SizedBox(width: 6),
            Text(
              s.label,
              style: const TextStyle(
                color: kStyle,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 1.0,
          child: Placeholder(color: kStyle, strokeWidth: s.strokeWidth),
        ),
      ],
    ),
  );
}

Widget buildStrokeScale(List<StrokeSample> ramp) {
  final List<Widget> ticks = <Widget>[];
  for (int i = 0; i < ramp.length; i++) {
    ticks.add(Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: ramp[i].strokeWidth * 2 + 2,
            decoration: BoxDecoration(
              color: kStyle,
              borderRadius:
                  BorderRadius.circular(ramp[i].strokeWidth * 0.6 + 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ramp[i].strokeWidth.toStringAsFixed(1),
            style: const TextStyle(
              fontFamily: 'monospace',
              color: kStyle,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ));
    if (i != ramp.length - 1) ticks.add(const SizedBox(width: 14));
  }
  return Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kStyle.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'pen weight scale',
          style: TextStyle(
            color: kStyle,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: ticks,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 — PITFALLS & WHEN NOT TO USE
// ---------------------------------------------------------------------------
//
// Two side-by-side panels: a comparison table (Placeholder vs SizedBox /
// ColoredBox / Container(color:) / DebugPaintBox) and a pitfall list
// (do not ship this in production, it is not a Container, it is not a
// styling component).

Widget buildPitfallSection() {
  return buildSectionFrame(
    number: '10',
    title: 'When NOT to use Placeholder',
    subtitle: 'Production code, layout shaping, styling — pick a real widget.',
    accent: kPitfall,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProse(
          'Placeholder is a debug/sketch primitive. It is not a layout '
          'tool, not a coloured rectangle, not a slot. The sections below '
          'spell out the differences from each lookalike, and the recurring '
          'mistakes worth avoiding.',
        ),
        const SizedBox(height: 14),
        buildCompareTable(),
        const SizedBox(height: 14),
        buildPitfallList(),
      ],
    ),
  );
}

Widget buildCompareTable() {
  final List<CompareEntry> entries = const <CompareEntry>[
    CompareEntry(
      name: 'Placeholder',
      summary: 'Crossed rectangle. Designed for sketching layouts.',
      paints: 'Outline + diagonals.',
      useFor: 'Mockups, wireframes, scaffolding TODOs.',
      tint: kAnatomy,
    ),
    CompareEntry(
      name: 'SizedBox.shrink()',
      summary: 'Zero-sized box that occupies no space.',
      paints: 'Nothing.',
      useFor: 'Conditional empty branches, gap-free spacers.',
      tint: kInkMute,
    ),
    CompareEntry(
      name: 'ColoredBox',
      summary: 'Solid-fill rectangle. Cheaper than Container(color:).',
      paints: 'Solid rectangle.',
      useFor: 'Fixed background colour, no decoration.',
      tint: kForm,
    ),
    CompareEntry(
      name: 'Container(color:)',
      summary: 'Decorated box with optional padding/decoration/colour.',
      paints: 'Whatever decoration you supply.',
      useFor: 'Real chrome, real backgrounds, real boxes.',
      tint: kCards,
    ),
    CompareEntry(
      name: 'DebugPaintBox-style overlay',
      summary: 'A separate overlay used for engine layout debugging.',
      paints: 'Coloured outlines and rules over the real tree.',
      useFor: 'Inspecting an existing layout, not sketching new ones.',
      tint: kStyle,
    ),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    rows.add(buildCompareEntryRow(entries[i]));
    if (i != entries.length - 1) rows.add(const SizedBox(height: 8));
  }

  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kPitfall.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Lookalikes',
          style: TextStyle(
            color: kPitfall,
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 10),
        ...rows,
      ],
    ),
  );
}

Widget buildCompareEntryRow(CompareEntry e) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(9),
      border: Border.all(color: e.tint.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            e.name,
            style: TextStyle(
              fontFamily: 'monospace',
              color: e.tint,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                e.summary,
                style: const TextStyle(
                  color: kInkSoft,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildLabelTag('paints', e.tint),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      e.paints,
                      style: const TextStyle(
                        color: kInkMute,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildLabelTag('use for', e.tint),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      e.useFor,
                      style: const TextStyle(
                        color: kInkMute,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPitfallList() {
  final List<PitfallNote> notes = const <PitfallNote>[
    PitfallNote(
      'Do not ship Placeholder',
      'It is a sketching tool. Search-and-replace before merging — a stray '
          'Placeholder in production reads as "the engineer forgot".',
      kPitfall,
    ),
    PitfallNote(
      'It is not a Container',
      'Container has padding, decoration, child layout, alignment. '
          'Placeholder has none of those — even its child slot is unusual. '
          'If you want a coloured rectangle, use Container(color:) or '
          'ColoredBox.',
      kCards,
    ),
    PitfallNote(
      'Stroke does not scale with size',
      'A 2.0 stroke in a 32x32 box reads as a thick frame; in a 600x400 '
          'box it disappears. Pick strokeWidth proportional to the slot.',
      kStyle,
    ),
    PitfallNote(
      'Fallbacks fire silently',
      'In an unbounded slot, Placeholder happily renders at fallbackWidth '
          'or fallbackHeight without a warning — the X is the only signal '
          'that something is unbounded.',
      kFallback,
    ),
    PitfallNote(
      'Inside SliverList: needs an explicit size',
      'Slivers want a height. Wrap the Placeholder in a SizedBox(height:) '
          'or it will fall back to fallbackHeight (typically too tall for '
          'a list cell).',
      kWireframe,
    ),
    PitfallNote(
      'Children are unusual',
      'You can pass a child but it does not add the Placeholder paint to '
          'the child — the rectangle still draws over and around it. Often '
          'better to wrap the placeholder in a Stack or a separate widget.',
      kForm,
    ),
  ];

  final List<Widget> items = <Widget>[];
  for (int i = 0; i < notes.length; i++) {
    items.add(buildPitfallItem(notes[i], i + 1));
    if (i != notes.length - 1) items.add(const SizedBox(height: 8));
  }

  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPaperShade,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kPitfall.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Pitfalls',
          style: TextStyle(
            color: kPitfall,
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 10),
        ...items,
      ],
    ),
  );
}

Widget buildPitfallItem(PitfallNote n, int index) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    decoration: BoxDecoration(
      color: kPaper,
      borderRadius: BorderRadius.circular(9),
      border: Border.all(color: n.tint.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: n.tint.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: n.tint.withValues(alpha: 0.45)),
          ),
          child: Center(
            child: Text(
              '$index',
              style: TextStyle(
                color: n.tint,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                n.title,
                style: TextStyle(
                  color: n.tint,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              buildProse(n.body),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 11 — FOOTER
// ---------------------------------------------------------------------------
//
// A summary banner with a tiny placeholder gallery, a copyright stripe,
// and a final reminder line.

Widget buildFooterSection() {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kFooter, kHeroDeep],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'END OF DEMO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Placeholder',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 50,
                child: Placeholder(
                  color: Colors.white.withValues(alpha: 0.85),
                  strokeWidth: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 50,
                child: Placeholder(
                  color: Colors.white.withValues(alpha: 0.7),
                  strokeWidth: 2.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 50,
                child: Placeholder(
                  color: Colors.white.withValues(alpha: 0.55),
                  strokeWidth: 3.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 50,
                child: Placeholder(
                  color: Colors.white.withValues(alpha: 0.45),
                  strokeWidth: 4.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Placeholder is loud on purpose. Replace it before merging — '
          'and if a stray X ever ships to production, take it as a sign '
          'the wireframe never finished becoming a screen.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.86),
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'd4rt-ast deep visual demo · placeholder_test.dart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
