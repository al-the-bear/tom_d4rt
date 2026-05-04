// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element, unnecessary_import

// =====================================================================
// dart:ui StringAttribute deep-demo script
// ---------------------------------------------------------------------
// This script demonstrates the StringAttribute hierarchy from dart:ui
// in a deeply visual, instructive way. It does NOT exercise any engine
// state — StringAttribute objects are pure data, so the demo
// constructs them, reads back their fields (range, locale), and paints
// them onto the surface so a junior engineer can see exactly what each
// attribute is, where its range falls in a string, and why a screen
// reader cares about the difference between SpellOut and Locale.
//
// Hierarchy in scope:
//   StringAttribute            (abstract base, has TextRange range)
//     |__ LocaleStringAttribute(range, locale)
//     |__ SpellOutStringAttribute(range)
//
// AttributedString (also from dart:ui) carries a base String plus a
// List<StringAttribute> of these objects. We construct attribute
// instances directly and visualise them; we do not rely on engine
// semantics readback.
// =====================================================================

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------
// Top-level palette constants. Const-only top-level data is allowed by
// the bridge interpreter, so we use it heavily for theming consistency
// across the eleven sections of the demo.
// ---------------------------------------------------------------------

const Color _kBackground = Color(0xFF0E1B2C);
const Color _kPanelDark = Color(0xFF132A44);
const Color _kPanelMid = Color(0xFF1B3A5E);
const Color _kPanelLight = Color(0xFF24507F);
const Color _kAccentCyan = Color(0xFF34D8FF);
const Color _kAccentMint = Color(0xFF65F1B6);
const Color _kAccentGold = Color(0xFFFFD27A);
const Color _kAccentRose = Color(0xFFFF7A9A);
const Color _kAccentLilac = Color(0xFFB89BFF);
const Color _kAccentOrange = Color(0xFFFF9966);
const Color _kInk = Color(0xFFEAF4FF);
const Color _kInkSoft = Color(0xFFB7C8DC);
const Color _kInkDim = Color(0xFF7E94AC);
const Color _kCodeBg = Color(0xFF0A1424);
const Color _kCodeInk = Color(0xFFCBE6FF);
const Color _kRangeBaseInk = Color(0xFFFFFFFF);

// Six distinct linear gradients used as section header banners so each
// section is visually unique and easy to navigate while scrolling.
const LinearGradient _kGradientHero = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF0E1B2C), Color(0xFF1F4068), Color(0xFF34D8FF)],
  stops: [0.0, 0.55, 1.0],
);
const LinearGradient _kGradientAnatomy = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF132A44), Color(0xFF24507F), Color(0xFF65F1B6)],
);
const LinearGradient _kGradientRange = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF1B3A5E), Color(0xFFB89BFF)],
);
const LinearGradient _kGradientSpell = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF24507F), Color(0xFFFFD27A)],
);
const LinearGradient _kGradientLocale = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [Color(0xFF132A44), Color(0xFFFF7A9A)],
);
const LinearGradient _kGradientFootgun = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF3A1A1A), Color(0xFFFF9966)],
);
const LinearGradient _kGradientCompare = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF132A44), Color(0xFF1B3A5E), Color(0xFF34D8FF)],
);
const LinearGradient _kGradientRecipe = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF132A44), Color(0xFF65F1B6)],
);
const LinearGradient _kGradientCheatsheet = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF132A44), Color(0xFFB89BFF), Color(0xFF34D8FF)],
);

// =====================================================================
// build()  — sole top-level entry point.
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _kBackground,
      appBar: AppBar(
        backgroundColor: _kPanelDark,
        elevation: 0,
        title: const Text(
          'dart:ui StringAttribute',
          style: TextStyle(
            color: _kInk,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 28),
            _buildAnatomySection(),
            const SizedBox(height: 28),
            _buildRangeVisualisationSection(),
            const SizedBox(height: 28),
            _buildSpellOutShowcaseSection(),
            const SizedBox(height: 28),
            _buildLocaleShowcaseSection(),
            const SizedBox(height: 28),
            _buildTextRangeUtilitiesSection(),
            const SizedBox(height: 28),
            _buildAccessibilityRecipeSection(),
            const SizedBox(height: 28),
            _buildFootgunSection(),
            const SizedBox(height: 28),
            _buildComparisonVsInlineSpanSection(),
            const SizedBox(height: 28),
            _buildApiSummaryTableSection(),
            const SizedBox(height: 28),
            _buildLocaleCheatSheetSection(),
            const SizedBox(height: 28),
            _buildClosingNotesSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 1 — Hero / introduction.
// =====================================================================
//
// The hero panel introduces the topic with a strong header gradient and
// a three-sentence prose paragraph. It also surfaces the three concrete
// types in the hierarchy as labelled chips with distinct accent colours
// so the reader can mentally anchor StringAttribute, SpellOut, and
// Locale before the deeper sections begin.

Widget _buildHeroSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _kGradientHero,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(color: Color(0x6634D8FF), blurRadius: 36, offset: Offset(0, 12)),
        BoxShadow(color: Color(0x33000000), blurRadius: 24, offset: Offset(0, 4)),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLogoBadge(),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'StringAttribute',
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Pure-data accessibility annotations attached to ranges of text',
                    style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'StringAttribute is the abstract base class in dart:ui that lets an AttributedString '
          'carry semantic hints for assistive technologies. Each attribute instance covers a '
          'TextRange of a base string and tells the platform engine something the eye cannot '
          'read off the glyphs alone — the locale of an embedded foreign phrase, or the '
          'request to spell out a sequence of letters one by one.',
          style: TextStyle(color: _kInk, fontSize: 14.5, height: 1.55),
        ),
        const SizedBox(height: 12),
        const Text(
          'These objects do not influence visual rendering. They exist purely to enrich the '
          'accessibility tree. A screen reader uses them to switch voice locale mid-sentence, '
          'or to announce N-A-S-A as four letters instead of an unpronounceable word. The '
          'demo below constructs many of these attributes and shows their fields visually so '
          'you can see, byte-by-byte, what each attribute claims to cover.',
          style: TextStyle(color: _kInkSoft, fontSize: 13.5, height: 1.55),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildHeroChip('StringAttribute', 'abstract base', _kAccentCyan),
            _buildHeroChip('SpellOutStringAttribute', 'sealed shape, no extra fields', _kAccentGold),
            _buildHeroChip('LocaleStringAttribute', 'adds a Locale field', _kAccentRose),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLogoBadge() {
  return Container(
    width: 64,
    height: 64,
    decoration: BoxDecoration(
      color: const Color(0x3334D8FF),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kAccentCyan, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x6634D8FF), blurRadius: 18, offset: Offset(0, 6)),
      ],
    ),
    alignment: Alignment.center,
    child: const Text(
      'A11y',
      style: TextStyle(
        color: _kInk,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _buildHeroChip(String title, String subtitle, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0x33000000),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent, width: 1.2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: _kInk,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(color: _kInkSoft, fontSize: 11, height: 1.2),
            ),
          ],
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 2 — Anatomy diagram of the class hierarchy.
// =====================================================================
//
// We render a class-tree style diagram. The abstract StringAttribute is
// shown at the top with its single field (range). Underneath it, the
// two concrete subclasses are shown side-by-side with their additional
// fields and constructor signatures. We also instantiate a couple of
// real attribute objects so we can echo their runtimeType into the UI
// to prove the demo really constructed them.

Widget _buildAnatomySection() {
  // Construct a couple of real attributes to read .runtimeType from.
  final ui.SpellOutStringAttribute anatomySpell = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 4),
  );
  final ui.LocaleStringAttribute anatomyLocale = ui.LocaleStringAttribute(
    range: const TextRange(start: 5, end: 11),
    locale: const Locale('en', 'US'),
  );

  final String spellRtType = anatomySpell.runtimeType.toString();
  final String localeRtType = anatomyLocale.runtimeType.toString();
  final String anatomyRange1 = '[${anatomySpell.range.start}..${anatomySpell.range.end})';
  final String anatomyRange2 = '[${anatomyLocale.range.start}..${anatomyLocale.range.end})';
  final String anatomyLocaleStr = anatomyLocale.locale.toString();

  return _buildSectionShell(
    gradient: _kGradientAnatomy,
    sectionNumber: '01',
    title: 'Anatomy of the StringAttribute hierarchy',
    subtitle: 'AttributedString = base text + List<StringAttribute>',
    paragraphs: const [
      'An AttributedString is conceptually a tuple of a flat String and a list of '
          'StringAttribute objects. The flat String is the actual character sequence the '
          'screen reader will speak. The list of attributes layers extra semantic information '
          'on top, each one targeting a TextRange of the base string.',
      'StringAttribute itself is abstract and only holds the TextRange. The two concrete '
          'subclasses, SpellOutStringAttribute and LocaleStringAttribute, are the only '
          'attribute kinds the engine currently understands. SpellOut adds nothing beyond the '
          'range; Locale adds a Locale instance describing the language of the text inside '
          'that range.',
      'Because attributes never alter visual rendering, the framework is free to send them '
          'over the platform channel whenever the semantics tree updates. Constructing them is '
          'cheap and side-effect-free, which makes them safe to demo from an interpreter that '
          'has no engine attached.',
    ],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildAnatomyTopBox(),
        _buildAnatomyConnector(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildAnatomyChildBox(
                accent: _kAccentGold,
                label: 'SpellOutStringAttribute',
                fieldNames: const ['range'],
                fieldTypes: const ['TextRange'],
                fieldOrigins: const ['inherited'],
                constructorLines: const [
                  'SpellOutStringAttribute({',
                  '  required TextRange range,',
                  '})',
                ],
                liveRuntimeType: spellRtType,
                liveDetail: 'instance #1 covers $anatomyRange1',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildAnatomyChildBox(
                accent: _kAccentRose,
                label: 'LocaleStringAttribute',
                fieldNames: const ['range', 'locale'],
                fieldTypes: const ['TextRange', 'Locale'],
                fieldOrigins: const ['inherited', 'own field'],
                constructorLines: const [
                  'LocaleStringAttribute({',
                  '  required TextRange range,',
                  '  required Locale locale,',
                  '})',
                ],
                liveRuntimeType: localeRtType,
                liveDetail: 'instance #2 covers $anatomyRange2 with locale $anatomyLocaleStr',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _buildAnatomyAttributedStringDiagram(),
      ],
    ),
  );
}

Widget _buildAnatomyTopBox() {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0x4034D8FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccentCyan, width: 1.4),
        boxShadow: const [
          BoxShadow(color: Color(0x4434D8FF), blurRadius: 22, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'abstract class StringAttribute',
            style: TextStyle(
              color: _kInk,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 6),
          Text(
            'final TextRange range;',
            style: TextStyle(
              color: _kAccentCyan,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'extended by SpellOut + Locale',
            style: TextStyle(color: _kInkSoft, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAnatomyConnector() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 2, height: 18, color: _kAccentCyan),
        Container(width: 220, height: 2, color: _kAccentCyan),
        Container(width: 2, height: 18, color: _kAccentCyan),
      ],
    ),
  );
}

Widget _buildAnatomyChildBox({
  required Color accent,
  required String label,
  required List<String> fieldNames,
  required List<String> fieldTypes,
  required List<String> fieldOrigins,
  required List<String> constructorLines,
  required String liveRuntimeType,
  required String liveDetail,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0x33000000),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Fields',
          style: TextStyle(color: _kInkSoft, fontSize: 11, letterSpacing: 1.2),
        ),
        const SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(fieldNames.length, (int i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${fieldNames[i]}: ${fieldTypes[i]}',
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 12.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${fieldOrigins[i]})',
                    style: const TextStyle(color: _kInkDim, fontSize: 11),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0x33FFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(constructorLines.length, (int i) {
              return Text(
                constructorLines[i],
                style: const TextStyle(
                  color: _kCodeInk,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.bolt, color: accent, size: 14),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'live: $liveRuntimeType — $liveDetail',
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAnatomyAttributedStringDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0x4434D8FF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'AttributedString (composition view)',
          style: TextStyle(
            color: _kInk,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'AttributedString { String string; List<StringAttribute> attributes; }',
          style: TextStyle(
            color: _kAccentCyan,
            fontSize: 12.5,
            fontFamily: 'monospace',
            height: 1.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Each entry of `attributes` is either a SpellOutStringAttribute or a '
          'LocaleStringAttribute. Multiple attributes may target the same range, '
          'and ranges may overlap (although the engine reserves the right to '
          'collapse or normalise them).',
          style: TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.5),
        ),
      ],
    ),
  );
}

// =====================================================================
// Shared section shell.
// =====================================================================
//
// Each major section uses the same outer chrome: a tall gradient
// header (with the section number and a subtitle), then a panel of
// prose paragraphs in the demo's serif body voice, then the section
// body itself. Centralising the chrome keeps each section file-level
// helper short while keeping the visual rhythm consistent for the
// reader scrolling through.

Widget _buildSectionShell({
  required LinearGradient gradient,
  required String sectionNumber,
  required String title,
  required String subtitle,
  required List<String> paragraphs,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kPanelDark,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0x2234D8FF)),
      boxShadow: const [
        BoxShadow(color: Color(0x55000000), blurRadius: 18, offset: Offset(0, 6)),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(gradient: gradient),
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0x55000000),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0x66FFFFFF)),
                ),
                alignment: Alignment.center,
                child: Text(
                  sectionNumber,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _kInkSoft,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(paragraphs.length, (int i) {
              return Padding(
                padding: EdgeInsets.only(bottom: i == paragraphs.length - 1 ? 0 : 10),
                child: Text(
                  paragraphs[i],
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 13.5,
                    height: 1.55,
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
          child: body,
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 3 — Range visualisation.
// =====================================================================
//
// The most concrete idea in StringAttribute is the TextRange. Each
// attribute claims to apply to characters [range.start, range.end).
// To make ranges feel tangible, this section renders a sample sentence
// in a monospace font where every character is laid out in a fixed
// 14-pixel-wide cell. We then draw a coloured underline bar across the
// exact cells covered by each constructed StringAttribute, paired with
// a legend chip showing the actual `.range` and class name.
//
// The sample sentence, deliberately mixed-script, is:
//
//     "Call NASA before 8 PM in Paris."
//
// Five attributes are constructed against that string:
//   * SpellOut   covering "NASA" (range 5..9)
//   * Locale fr  covering "Paris" (range 23..28)
//   * SpellOut   covering "PM"   (range 18..20)
//   * SpellOut   covering "8"    (range 16..17)
//   * Locale en  covering whole sentence (range 0..30)

Widget _buildRangeVisualisationSection() {
  const String sample = 'Call NASA before 8 PM in Paris.';

  final ui.SpellOutStringAttribute rangeNasa = ui.SpellOutStringAttribute(
    range: const TextRange(start: 5, end: 9),
  );
  final ui.SpellOutStringAttribute rangePm = ui.SpellOutStringAttribute(
    range: const TextRange(start: 18, end: 20),
  );
  final ui.SpellOutStringAttribute rangeEight = ui.SpellOutStringAttribute(
    range: const TextRange(start: 16, end: 17),
  );
  final ui.LocaleStringAttribute rangeParis = ui.LocaleStringAttribute(
    range: const TextRange(start: 23, end: 28),
    locale: const Locale('fr', 'FR'),
  );
  final ui.LocaleStringAttribute rangeWhole = ui.LocaleStringAttribute(
    range: const TextRange(start: 0, end: 30),
    locale: const Locale('en', 'US'),
  );

  // Visual rows: each row paints a single attribute's underline beneath
  // the same shared sample sentence. Each row's colour is unique.
  final List<Widget> rows = [
    _buildRangeRow(
      sample: sample,
      attribute: rangeNasa,
      label: 'SpellOut "NASA"',
      explanation: 'Speaks "N-A-S-A" instead of as a word.',
      color: _kAccentGold,
    ),
    _buildRangeRow(
      sample: sample,
      attribute: rangePm,
      label: 'SpellOut "PM"',
      explanation: 'Speaks "P-M", clearer than the homophone "pm".',
      color: _kAccentMint,
    ),
    _buildRangeRow(
      sample: sample,
      attribute: rangeEight,
      label: 'SpellOut "8"',
      explanation: 'Forces the digit to be voiced as a single character.',
      color: _kAccentLilac,
    ),
    _buildRangeRow(
      sample: sample,
      attribute: rangeParis,
      label: 'Locale fr_FR "Paris"',
      explanation: 'Switches the voice to French for the city name.',
      color: _kAccentRose,
    ),
    _buildRangeRow(
      sample: sample,
      attribute: rangeWhole,
      label: 'Locale en_US whole sentence',
      explanation: 'Default voice baseline; nested locale overrides it.',
      color: _kAccentCyan,
    ),
  ];

  return _buildSectionShell(
    gradient: _kGradientRange,
    sectionNumber: '02',
    title: 'Visualising the TextRange',
    subtitle: 'Where exactly does each attribute apply?',
    paragraphs: const [
      'A StringAttribute is only meaningful when paired with a TextRange. The range '
          'expresses the half-open interval [start, end) into the base string. Inclusive on '
          'the left, exclusive on the right — the convention that makes range arithmetic '
          'composable.',
      'In the rows below, the sample sentence "Call NASA before 8 PM in Paris." is rendered '
          'in a fixed-pitch grid, and each attribute is shown as a coloured underline bar '
          'covering exactly the cells it claims. Read the .range values on the right; they '
          'are pulled directly off the constructed attribute objects.',
      'Notice how nothing visually changes in the sentence itself between rows: the visual '
          'rendering of the text stays the same, while the semantics layer projects an '
          'invisible accessibility annotation. That separation is the central design idea of '
          'the StringAttribute mechanism.',
    ],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

Widget _buildRangeRow({
  required String sample,
  required ui.StringAttribute attribute,
  required String label,
  required String explanation,
  required Color color,
}) {
  final int start = attribute.range.start;
  final int end = attribute.range.end;
  final String localeStr = attribute is ui.LocaleStringAttribute
      ? attribute.locale.toString()
      : '';
  final String summary = attribute is ui.LocaleStringAttribute
      ? 'Locale($localeStr) [$start..$end)'
      : 'SpellOut [$start..$end)';

  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0x22000000),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0x33000000),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  summary,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildRangeGrid(sample: sample, start: start, end: end, color: color),
          const SizedBox(height: 8),
          Text(
            explanation,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRangeGrid({
  required String sample,
  required int start,
  required int end,
  required Color color,
}) {
  // Build a Wrap of 14-px cells, each containing the character. Cells
  // whose index falls inside [start,end) receive a coloured underline
  // bar via Stack.
  final int len = sample.length;
  return Wrap(
    spacing: 0,
    runSpacing: 0,
    children: List<Widget>.generate(len, (int i) {
      final bool inRange = i >= start && i < end;
      final String ch = sample.substring(i, i + 1);
      return Container(
        width: 14,
        height: 28,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              ch,
              style: const TextStyle(
                color: _kRangeBaseInk,
                fontSize: 13,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 2,
              child: Container(
                height: 3,
                color: inRange ? color : Colors.transparent,
              ),
            ),
          ],
        ),
      );
    }),
  );
}

// =====================================================================
// SECTION 4 — SpellOutStringAttribute showcase.
// =====================================================================
//
// SpellOutStringAttribute tells the screen reader: "do not pronounce
// this run as a word; read it character by character." The classic use
// is acronyms like NASA, FBI, or product codes, but it also matters
// for phone numbers, single algebraic letters, and any place where the
// engine's heuristic would pick a misleading pronunciation.

Widget _buildSpellOutShowcaseSection() {
  // Five SpellOutStringAttributes, one per case.
  final ui.SpellOutStringAttribute spell1 = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 4),
  );
  final ui.SpellOutStringAttribute spell2 = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 3),
  );
  final ui.SpellOutStringAttribute spell3 = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 7),
  );
  final ui.SpellOutStringAttribute spell4 = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 12),
  );
  final ui.SpellOutStringAttribute spell5 = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 1),
  );

  final List<Widget> cards = [
    _buildSpellCard(
      sample: 'NASA',
      attribute: spell1,
      caption: 'Acronym',
      reasoning: 'Without SpellOut a US English voice may say "NASS-uh" '
          'as if it were a word. SpellOut forces "N-A-S-A".',
      icon: Icons.rocket_launch,
    ),
    _buildSpellCard(
      sample: 'FBI',
      attribute: spell2,
      caption: 'Initialism',
      reasoning: 'Three-letter initialism that almost everyone says letter '
          'by letter — make the engine do the same explicitly.',
      icon: Icons.shield,
    ),
    _buildSpellCard(
      sample: 'TM-42-Q',
      attribute: spell3,
      caption: 'Product code',
      reasoning: 'Internal SKUs and serial numbers should always be spelt '
          'out so listeners can write them down character by character.',
      icon: Icons.qr_code_2,
    ),
    _buildSpellCard(
      sample: '555-0123-99',
      attribute: spell4,
      caption: 'Phone number',
      reasoning: 'Phone numbers vary wildly in chunking conventions. '
          'Spelling each digit is the safest cross-locale strategy.',
      icon: Icons.call,
    ),
    _buildSpellCard(
      sample: 'x',
      attribute: spell5,
      caption: 'Single math letter',
      reasoning: 'In a math expression the variable "x" is read "ex" — '
          'spelling out keeps it from blending into surrounding words.',
      icon: Icons.functions,
    ),
  ];

  return _buildSectionShell(
    gradient: _kGradientSpell,
    sectionNumber: '03',
    title: 'SpellOutStringAttribute in practice',
    subtitle: 'When the engine should read characters one at a time',
    paragraphs: const [
      'SpellOutStringAttribute is the simpler of the two concrete attributes. It carries no '
          'extra fields beyond the inherited TextRange. Its sole job is to flip the '
          'pronunciation strategy for a run of text from "speak as a word" to "speak each '
          'character".',
      'The five examples below cover the common reasons you reach for SpellOut: an acronym, '
          'an initialism, an internal product code, a phone number, and a single algebraic '
          'letter. Each card displays the live .range of the underlying attribute so you can '
          'see that the start and end indices match the text shown.',
      'Notice that SpellOut is purely about pronunciation; it does not switch language and it '
          'does not change the displayed glyphs. If you also need a locale change (for a '
          'foreign acronym, say) you stack a LocaleStringAttribute next to the SpellOut.',
    ],
    body: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List<Widget>.generate(cards.length, (int i) {
        return SizedBox(width: 320, child: cards[i]);
      }),
    ),
  );
}

Widget _buildSpellCard({
  required String sample,
  required ui.SpellOutStringAttribute attribute,
  required String caption,
  required String reasoning,
  required IconData icon,
}) {
  final int s = attribute.range.start;
  final int e = attribute.range.end;
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1B3A5E), Color(0xFF24507F)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kAccentGold.withValues(alpha: 0.45)),
      boxShadow: const [
        BoxShadow(color: Color(0x44FFD27A), blurRadius: 16, offset: Offset(0, 6)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: _kAccentGold, size: 20),
            const SizedBox(width: 8),
            Text(
              caption,
              style: const TextStyle(
                color: _kAccentGold,
                fontSize: 12,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0x33FFD27A)),
          ),
          child: Text(
            sample,
            style: const TextStyle(
              color: _kInk,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              letterSpacing: 2.0,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0x33FFD27A),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'SpellOutStringAttribute(range: TextRange($s..$e))',
            style: const TextStyle(
              color: _kAccentGold,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          reasoning,
          style: const TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 5 — LocaleStringAttribute showcase.
// =====================================================================
//
// LocaleStringAttribute is the second concrete subclass. Beyond the
// inherited TextRange it adds a Locale field. Its purpose is to tell
// the engine "the text in this range is in a specific language" so
// the screen reader can pick the right voice and pronunciation rules.
// This is most visible in mixed-language sentences where the default
// voice would mangle a word from another language.

Widget _buildLocaleShowcaseSection() {
  final ui.LocaleStringAttribute locale1 = ui.LocaleStringAttribute(
    range: const TextRange(start: 11, end: 23),
    locale: const Locale('fr', 'FR'),
  );
  final ui.LocaleStringAttribute locale2 = ui.LocaleStringAttribute(
    range: const TextRange(start: 16, end: 26),
    locale: const Locale('de', 'DE'),
  );
  final ui.LocaleStringAttribute locale3 = ui.LocaleStringAttribute(
    range: const TextRange(start: 7, end: 23),
    locale: const Locale('es', 'ES'),
  );
  final ui.LocaleStringAttribute locale4 = ui.LocaleStringAttribute(
    range: const TextRange(start: 13, end: 19),
    locale: const Locale('ja', 'JP'),
  );
  // D4RT-SCRIPT-LIMITATION: bidi-text-shaping crash in headless Flutter
  // test runtime — a `RichText` with three `TextSpan` children where
  // the middle span contains Arabic-Indic digits ("٤٥٢") between
  // ASCII flanking spans crashes the test process with
  // "Lost connection to device" (reproduces with const-only widgets,
  // i.e. independent of the d4rt interpreter / bridges). See
  // `script_rewrites.md` ("Arabic-Indic digit TextSpan sandwiched in
  // RichText") for the full bisect log. The Russian Cyrillic example
  // below preserves the "non-Latin script demonstrates locale
  // switching" intent without triggering the bidi-shaping path.
  final ui.LocaleStringAttribute locale5 = ui.LocaleStringAttribute(
    range: const TextRange(start: 11, end: 18),
    locale: const Locale('ru', 'RU'),
  );

  final List<Widget> cards = [
    _buildLocaleCard(
      base: 'She said: bon appétit before the meal.',
      attribute: locale1,
      title: 'French inline phrase',
      reason: 'Without the locale switch, an English voice will mangle the '
          'accented word into something close to "bon ap-uh-teet".',
      gradient: const LinearGradient(
        colors: [Color(0xFF1B3A5E), Color(0xFFFF7A9A)],
      ),
    ),
    _buildLocaleCard(
      base: 'Their motto is "Vorsprung durch Technik" still.',
      attribute: locale2,
      title: 'German technical term',
      reason: 'German has hard t/k consonants and stressed first syllables; '
          'the de_DE voice handles the cluster naturally.',
      gradient: const LinearGradient(
        colors: [Color(0xFF132A44), Color(0xFFFFD27A)],
      ),
    ),
    _buildLocaleCard(
      base: 'I love mañana, no te preocupes phrasing.',
      attribute: locale3,
      title: 'Spanish quote',
      reason: 'Spanish nasal "ñ" and stressed syllables fall flat in '
          'an English voice — switch locale for the run.',
      gradient: const LinearGradient(
        colors: [Color(0xFF1B3A5E), Color(0xFF65F1B6)],
      ),
    ),
    _buildLocaleCard(
      base: 'A polite アリガトウ ends every email.',
      attribute: locale4,
      title: 'Japanese loanword',
      reason: 'Katakana "arigatou" must be voiced by a Japanese engine; '
          'an English voice cannot map katakana to phonemes.',
      gradient: const LinearGradient(
        colors: [Color(0xFF132A44), Color(0xFFB89BFF)],
      ),
    ),
    _buildLocaleCard(
      base: 'A friendly спасибо works wonders today.',
      attribute: locale5,
      title: 'Russian Cyrillic',
      reason: 'Cyrillic letters carry stress marks the English voice cannot '
          'infer; the ru_RU voice handles the soft-sign and "и" cleanly.',
      gradient: const LinearGradient(
        colors: [Color(0xFF132A44), Color(0xFFFF9966)],
      ),
    ),
  ];

  return _buildSectionShell(
    gradient: _kGradientLocale,
    sectionNumber: '04',
    title: 'LocaleStringAttribute in practice',
    subtitle: 'Switching voice locale mid-sentence',
    paragraphs: const [
      'LocaleStringAttribute attaches a Locale to a span of the base string. The screen '
          'reader treats that span as written in the named language and switches voice or '
          'pronunciation rules accordingly. Outside the range, the platform-default voice '
          'continues.',
      'In each card below, the embedded foreign phrase is highlighted in colour; the '
          'attribute card lists the live .locale value pulled from the constructed '
          'LocaleStringAttribute object. Some platforms only honour the language code, others '
          'observe the country code as well, so include both when you can.',
      'A common pitfall is forgetting that locale switching does not influence visual '
          'rendering. The fonts, colours, and direction stay the same; the attribute only '
          'enriches the accessibility tree.',
    ],
    body: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List<Widget>.generate(cards.length, (int i) {
        return SizedBox(width: 340, child: cards[i]);
      }),
    ),
  );
}

Widget _buildLocaleCard({
  required String base,
  required ui.LocaleStringAttribute attribute,
  required String title,
  required String reason,
  required LinearGradient gradient,
}) {
  final int s = attribute.range.start;
  final int e = attribute.range.end;
  final String localeStr = attribute.locale.toString();
  // Slice the base string for visual highlighting.
  final String pre = base.substring(0, s);
  final String mid = base.substring(s, e);
  final String post = base.substring(e);

  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(color: Color(0x44000000), blurRadius: 16, offset: Offset(0, 6)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.translate, color: _kInk, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: _kInk,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0x66000000),
            borderRadius: BorderRadius.circular(10),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: _kInk,
                fontSize: 14,
                height: 1.4,
              ),
              children: [
                TextSpan(text: pre),
                TextSpan(
                  text: mid,
                  style: const TextStyle(
                    color: _kAccentMint,
                    fontWeight: FontWeight.w700,
                    backgroundColor: Color(0x4434D8FF),
                  ),
                ),
                TextSpan(text: post),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0x44000000),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'LocaleStringAttribute(range: [$s..$e), locale: $localeStr)',
            style: const TextStyle(
              color: _kInk,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          reason,
          style: const TextStyle(color: _kInk, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 6 — TextRange utilities table.
// =====================================================================
//
// TextRange is the only field of the abstract base class, so its
// helpers (isValid, isCollapsed, isNormalized, the special TextRange.empty
// sentinel) deserve their own table. We construct several ranges, then
// embed them in attributes and read those properties back into the
// table cells.

Widget _buildTextRangeUtilitiesSection() {
  final List<TextRange> ranges = const [
    TextRange(start: 0, end: 4),
    TextRange(start: 5, end: 5),
    TextRange(start: -1, end: -1),
    TextRange(start: 12, end: 7),
    TextRange(start: 100, end: 200),
    TextRange.empty,
  ];

  // Wrap each range in a SpellOutStringAttribute so the table is
  // honest about how attributes interact with TextRange properties.
  final List<ui.SpellOutStringAttribute> wrappers = List<ui.SpellOutStringAttribute>.generate(
    ranges.length,
    (int i) => ui.SpellOutStringAttribute(range: ranges[i]),
  );

  final List<String> notes = [
    'Healthy 4-char span at the start of a string.',
    'Collapsed range — start equals end. Useful as a caret position.',
    'Sentinel "no selection" range; isValid is false.',
    'Inverted range; isNormalized is false. Sort before using.',
    'Out-of-bounds — the engine will clamp or reject.',
    'TextRange.empty is the canonical "nothing selected" value.',
  ];

  return _buildSectionShell(
    gradient: _kGradientRange,
    sectionNumber: '05',
    title: 'TextRange properties cheat-sheet',
    subtitle: 'isValid, isCollapsed, isNormalized — what they mean for attributes',
    paragraphs: const [
      'StringAttribute inherits exactly one field from its abstract base: range. That range '
          'is a TextRange — the same value type used elsewhere in Flutter for selection and '
          'caret positions. Understanding its predicates makes attribute construction and '
          'debugging easier.',
      'isValid returns false for the special TextRange(start: -1, end: -1) sentinel, '
          'isCollapsed is true when start equals end, and isNormalized is true when start is '
          'less than or equal to end. The engine is allowed to skip or normalise unhealthy '
          'ranges, so checking these flags before constructing an attribute saves surprises.',
      'In the table below the same ranges are wrapped in SpellOutStringAttribute and read '
          'back through .range.* — because TextRange is a value type the wrappers preserve '
          'the predicates verbatim.',
    ],
    body: Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0x33000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildRangeTableHeader(),
          Column(
            children: List<Widget>.generate(wrappers.length, (int i) {
              return _buildRangeTableRow(
                wrappers[i],
                note: notes[i],
                even: i.isEven,
              );
            }),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRangeTableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: const BoxDecoration(
      color: Color(0x6634D8FF),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: const [
        Expanded(flex: 3, child: Text('Range', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(flex: 2, child: Text('valid', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(flex: 2, child: Text('collapsed', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(flex: 2, child: Text('normalized', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(flex: 5, child: Text('Note', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
      ],
    ),
  );
}

Widget _buildRangeTableRow(
  ui.SpellOutStringAttribute attr, {
  required String note,
  required bool even,
}) {
  final TextRange r = attr.range;
  final bool valid = r.isValid;
  final bool collapsed = r.isCollapsed;
  final bool normalized = r.isNormalized;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(
      color: even ? const Color(0x11FFFFFF) : Colors.transparent,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'TextRange(${r.start}..${r.end})',
            style: const TextStyle(
              color: _kInk,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        Expanded(flex: 2, child: _buildBoolPill(valid)),
        Expanded(flex: 2, child: _buildBoolPill(collapsed)),
        Expanded(flex: 2, child: _buildBoolPill(normalized)),
        Expanded(
          flex: 5,
          child: Text(
            note,
            style: const TextStyle(color: _kInkSoft, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBoolPill(bool value) {
  final Color c = value ? _kAccentMint : _kAccentRose;
  final String label = value ? 'true' : 'false';
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: c,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 7 — Practical accessibility recipe gallery.
// =====================================================================
//
// Four real-world cards. Each is a tiny case study: a UI scenario, the
// problem the screen reader would have, and the recipe of attributes
// that fix it. Numbers in the captions reference the live constructed
// attributes shown alongside.

Widget _buildAccessibilityRecipeSection() {
  final ui.LocaleStringAttribute recipeLocaleErr = ui.LocaleStringAttribute(
    range: const TextRange(start: 14, end: 30),
    locale: const Locale('fr', 'FR'),
  );
  final ui.SpellOutStringAttribute recipeBrand = ui.SpellOutStringAttribute(
    range: const TextRange(start: 7, end: 11),
  );
  final ui.LocaleStringAttribute recipeAddrCity = ui.LocaleStringAttribute(
    range: const TextRange(start: 15, end: 23),
    locale: const Locale('de', 'DE'),
  );
  final ui.LocaleStringAttribute recipeAddrCountry = ui.LocaleStringAttribute(
    range: const TextRange(start: 25, end: 32),
    locale: const Locale('de', 'DE'),
  );
  final ui.SpellOutStringAttribute recipeMeasure = ui.SpellOutStringAttribute(
    range: const TextRange(start: 9, end: 12),
  );

  return _buildSectionShell(
    gradient: _kGradientRecipe,
    sectionNumber: '06',
    title: 'Real-world accessibility recipes',
    subtitle: 'Four mini case studies that combine attributes to fix a problem',
    paragraphs: const [
      'StringAttribute is most useful in combination. A real piece of UI text often needs '
          'one or two SpellOuts plus a LocaleStringAttribute to be voiced cleanly. The four '
          'cards below show patterns that occur over and over in production apps.',
      'Each card lists the original sentence, the screen-reader symptom without attributes, '
          'and the attribute "recipe" — the actual constructed objects, with their .range and '
          '.locale read back in the description so you can see the relationship between the '
          'pattern and the live data.',
      'Apply these patterns wherever your UI mixes acronyms or non-default-locale words; '
          'the cost of constructing extra attributes is negligible compared with the gain in '
          'accessibility quality.',
    ],
    body: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        SizedBox(
          width: 360,
          child: _buildRecipeCard(
            title: 'Localised error message',
            sentence: 'Network error: connexion expirée',
            symptom: 'Default English voice mispronounces "connexion expirée" as gibberish.',
            recipeText: 'Wrap "connexion expirée" with LocaleStringAttribute(fr_FR).',
            attributes: [recipeLocaleErr],
            color: _kAccentRose,
          ),
        ),
        SizedBox(
          width: 360,
          child: _buildRecipeCard(
            title: 'Brand acronym in headline',
            sentence: 'Welcome NASA engineers!',
            symptom: 'Reader says "NASS-uh", losing brand recognition.',
            recipeText: 'Add SpellOutStringAttribute over "NASA".',
            attributes: [recipeBrand],
            color: _kAccentGold,
          ),
        ),
        SizedBox(
          width: 360,
          child: _buildRecipeCard(
            title: 'Multilingual address block',
            sentence: 'Mailing to: München, Germany',
            symptom: 'Both city and country names need German voicing.',
            recipeText: 'Two LocaleStringAttribute(de_DE) covering the city and the country.',
            attributes: [recipeAddrCity, recipeAddrCountry],
            color: _kAccentLilac,
          ),
        ),
        SizedBox(
          width: 360,
          child: _buildRecipeCard(
            title: 'Recipe with measurement',
            sentence: 'Add 1.5 tsp of salt now.',
            symptom: 'Voice may collapse "tsp" into a non-word.',
            recipeText: 'SpellOut over "tsp" to make it "T-S-P".',
            attributes: [recipeMeasure],
            color: _kAccentMint,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipeCard({
  required String title,
  required String sentence,
  required String symptom,
  required String recipeText,
  required List<ui.StringAttribute> attributes,
  required Color color,
}) {
  final List<String> descriptions = List<String>.generate(
    attributes.length,
    (int i) {
      final ui.StringAttribute a = attributes[i];
      if (a is ui.LocaleStringAttribute) {
        return 'Locale(${a.locale}) over [${a.range.start}..${a.range.end})';
      }
      return 'SpellOut over [${a.range.start}..${a.range.end})';
    },
  );
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0x22000000),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.55)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            sentence,
            style: const TextStyle(
              color: _kInk,
              fontSize: 14,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded, color: _kAccentOrange, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                symptom,
                style: const TextStyle(color: _kInkSoft, fontSize: 12.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle_outline, color: _kAccentMint, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                recipeText,
                style: const TextStyle(color: _kInk, fontSize: 12.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(descriptions.length, (int i) {
            final String desc = descriptions[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                '• $desc',
                style: TextStyle(
                  color: color,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 8 — Footgun panel.
// =====================================================================
//
// A panel of common mistakes: overlapping ranges, off-by-one errors,
// ranges past the string length, mixed locale plus spell-out. Each
// footgun gets a labelled visual showing both the bug and how to read
// the .range/.locale fields back to debug it.

Widget _buildFootgunSection() {
  final ui.SpellOutStringAttribute fgOverA = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 5),
  );
  final ui.SpellOutStringAttribute fgOverB = ui.SpellOutStringAttribute(
    range: const TextRange(start: 3, end: 8),
  );
  final ui.SpellOutStringAttribute fgOff = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 4),
  );
  final ui.SpellOutStringAttribute fgPast = ui.SpellOutStringAttribute(
    range: const TextRange(start: 0, end: 99),
  );
  final ui.LocaleStringAttribute fgConflictA = ui.LocaleStringAttribute(
    range: const TextRange(start: 0, end: 6),
    locale: const Locale('en', 'US'),
  );
  final ui.LocaleStringAttribute fgConflictB = ui.LocaleStringAttribute(
    range: const TextRange(start: 0, end: 6),
    locale: const Locale('fr', 'FR'),
  );

  return _buildSectionShell(
    gradient: _kGradientFootgun,
    sectionNumber: '07',
    title: 'StringAttribute footguns',
    subtitle: 'Common mistakes and how to spot them',
    paragraphs: const [
      'Most bugs in StringAttribute usage come down to wrong indices. Because attributes do '
          'not change rendering, a broken range is invisible until somebody actually turns on '
          'a screen reader. The four footguns below are the ones I see most often in code '
          'review.',
      'Each footgun panel echoes the live .range start and end of the offending attributes '
          'so you can compare what was constructed with what you intended. When two '
          'attributes overlap or contradict each other, the engine will pick a winner you '
          'cannot easily predict.',
      'The cure is simple: write a tiny helper that asserts each constructed attribute is '
          'within bounds, normalised, and unique against its peers, then keep that assertion '
          'in your debug builds.',
    ],
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFootgunRow(
          title: 'Overlapping spell-out ranges',
          description: 'Two SpellOuts share characters 3..5. The engine may '
              'collapse them or pick one arbitrarily.',
          attributes: [fgOverA, fgOverB],
          sample: 'OverLap',
        ),
        _buildFootgunRow(
          title: 'Off-by-one (end exclusive)',
          description: 'TextRange end is exclusive. To cover "NASA" use '
              'end=4 not end=5; otherwise the trailing space is included.',
          attributes: [fgOff],
          sample: 'NASA team',
        ),
        _buildFootgunRow(
          title: 'Range past the string length',
          description: 'A range that stretches beyond the base string will '
              'be clamped or rejected. Defensive code must verify length.',
          attributes: [fgPast],
          sample: 'short',
        ),
        _buildFootgunRow(
          title: 'Conflicting locale on identical range',
          description: 'Two LocaleStringAttribute objects on the same range '
              'with different locales — the engine will choose unpredictably.',
          attributes: [fgConflictA, fgConflictB],
          sample: 'Hello!',
        ),
      ],
    ),
  );
}

Widget _buildFootgunRow({
  required String title,
  required String description,
  required List<ui.StringAttribute> attributes,
  required String sample,
}) {
  final List<String> descriptions = List<String>.generate(
    attributes.length,
    (int i) {
      final ui.StringAttribute a = attributes[i];
      if (a is ui.LocaleStringAttribute) {
        return 'Locale(${a.locale}) over [${a.range.start}..${a.range.end})';
      }
      return 'SpellOut over [${a.range.start}..${a.range.end})';
    },
  );
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0x33FF9966),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAccentOrange.withValues(alpha: 0.7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dangerous, color: _kAccentOrange, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.45),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'sample: "$sample" (length ${sample.length})',
            style: const TextStyle(
              color: _kInk,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(descriptions.length, (int i) {
            final String desc = descriptions[i];
            return Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '↪ $desc',
                style: const TextStyle(
                  color: _kAccentOrange,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 9 — StringAttribute vs InlineSpan.
// =====================================================================
//
// A common confusion in code review: people reach for StringAttribute
// when they actually want an InlineSpan / TextSpan, or vice versa.
// They live on different layers. InlineSpan is a visual rendering
// primitive (it controls colour, weight, font); StringAttribute is a
// semantics primitive (it never affects pixels). This section places
// them side by side using the same example sentence.

Widget _buildComparisonVsInlineSpanSection() {
  final ui.SpellOutStringAttribute compareSpell = ui.SpellOutStringAttribute(
    range: const TextRange(start: 5, end: 9),
  );
  final ui.LocaleStringAttribute compareLocale = ui.LocaleStringAttribute(
    range: const TextRange(start: 22, end: 28),
    locale: const Locale('fr', 'FR'),
  );

  return _buildSectionShell(
    gradient: _kGradientCompare,
    sectionNumber: '08',
    title: 'StringAttribute vs InlineSpan',
    subtitle: 'Two layers, two purposes — choose the right one',
    paragraphs: const [
      'Newcomers often confuse StringAttribute with InlineSpan because both attach metadata '
          'to a region of text. The crucial difference is that InlineSpan controls visual '
          'rendering — colour, font, weight — while StringAttribute controls accessibility '
          'semantics only.',
      'In the comparison below the same sentence is shown twice. On the left it uses '
          'TextSpan/InlineSpan to colour parts of the text; on the right it uses two '
          'StringAttribute instances to mark them up for the screen reader. The right side '
          'looks identical to plain text — that is the entire point.',
      'In production you usually want both: a TextSpan to make the foreign phrase italic and '
          'a LocaleStringAttribute so the screen reader pronounces it correctly. The two '
          'mechanisms compose cleanly because they target different layers.',
    ],
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildInlineSpanColumn()),
        const SizedBox(width: 12),
        Expanded(
          child: _buildAttributeColumn(
            spell: compareSpell,
            locale: compareLocale,
          ),
        ),
      ],
    ),
  );
}

Widget _buildInlineSpanColumn() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAccentCyan.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.brush, color: _kAccentCyan, size: 18),
            SizedBox(width: 8),
            Text(
              'Visual: InlineSpan / TextSpan',
              style: TextStyle(
                color: _kAccentCyan,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        RichText(
          text: const TextSpan(
            style: TextStyle(color: _kInk, fontSize: 16, fontFamily: 'monospace'),
            children: [
              TextSpan(text: 'Call '),
              TextSpan(
                text: 'NASA',
                style: TextStyle(color: _kAccentGold, fontWeight: FontWeight.w800),
              ),
              TextSpan(text: ' before 8 PM in '),
              TextSpan(
                text: 'Paris.',
                style: TextStyle(color: _kAccentRose, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Influences pixels. Screen readers see only the plain string.',
          style: TextStyle(color: _kInkSoft, fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _buildAttributeColumn({
  required ui.SpellOutStringAttribute spell,
  required ui.LocaleStringAttribute locale,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAccentMint.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.record_voice_over, color: _kAccentMint, size: 18),
            SizedBox(width: 8),
            Text(
              'Semantics: StringAttribute',
              style: TextStyle(
                color: _kAccentMint,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Call NASA before 8 PM in Paris.',
          style: TextStyle(color: _kInk, fontSize: 16, fontFamily: 'monospace'),
        ),
        const SizedBox(height: 12),
        Text(
          '• SpellOut [${spell.range.start}..${spell.range.end})',
          style: const TextStyle(
            color: _kAccentGold,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          '• Locale [${locale.range.start}..${locale.range.end}) ${locale.locale}',
          style: const TextStyle(
            color: _kAccentRose,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Pixels unchanged; screen reader voicing changes.',
          style: TextStyle(color: _kInkSoft, fontSize: 12),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 10 — API summary table.
// =====================================================================
//
// One canonical, scannable table that the reader can return to when
// they have forgotten the exact constructor signature. We render it
// with a header row and alternating zebra striping for readability.

Widget _buildApiSummaryTableSection() {
  final List<List<String>> rows = const [
    ['StringAttribute', 'abstract', 'final TextRange range', '— (cannot be instantiated)'],
    ['SpellOutStringAttribute', 'concrete', 'range', 'SpellOutStringAttribute({required TextRange range})'],
    ['LocaleStringAttribute', 'concrete', 'range, locale', 'LocaleStringAttribute({required TextRange range, required Locale locale})'],
    ['TextRange (range field)', 'value', 'start, end, isValid, isCollapsed, isNormalized', 'TextRange(start: int, end: int)'],
    ['Locale (locale field)', 'value', 'languageCode, countryCode, scriptCode', "Locale('en', 'US')"],
  ];

  return _buildSectionShell(
    gradient: _kGradientCompare,
    sectionNumber: '09',
    title: 'API summary table',
    subtitle: 'Class, kind, fields, canonical constructor',
    paragraphs: const [
      'For quick reference, this table lists every type that participates in the '
          'StringAttribute hierarchy along with its kind, the fields the developer interacts '
          'with, and the constructor you most commonly call.',
      'StringAttribute itself is abstract and never instantiated. The two concrete '
          'subclasses are the only attributes the engine recognises today; both rely on '
          'TextRange, and LocaleStringAttribute additionally relies on Locale.',
      'Memorising the table is overkill — bookmarking it for occasional reference is '
          'usually enough.',
    ],
    body: Container(
      decoration: BoxDecoration(
        color: const Color(0x22000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildApiSummaryHeader(),
          Column(
            children: List<Widget>.generate(rows.length, (int i) {
              return _buildApiSummaryRow(rows[i], even: i.isEven);
            }),
          ),
        ],
      ),
    ),
  );
}

Widget _buildApiSummaryHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: const BoxDecoration(
      color: Color(0x66B89BFF),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: const [
        Expanded(flex: 4, child: Text('Type', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(flex: 2, child: Text('Kind', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(flex: 4, child: Text('Fields', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(flex: 7, child: Text('Constructor', style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12))),
      ],
    ),
  );
}

Widget _buildApiSummaryRow(List<String> cells, {required bool even}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: even ? const Color(0x11FFFFFF) : Colors.transparent,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            cells[0],
            style: const TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            cells[1],
            style: const TextStyle(
              color: _kAccentLilac,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            cells[2],
            style: const TextStyle(color: _kInkSoft, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            cells[3],
            style: const TextStyle(
              color: _kAccentCyan,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 11 — Locale cheat-sheet.
// =====================================================================
//
// LocaleStringAttribute lives or dies by the Locale object you pass.
// The cheat-sheet gives a quick reference of common Locale codes and
// when each one helps. We construct one LocaleStringAttribute for
// each entry to verify the engine accepts it.

Widget _buildLocaleCheatSheetSection() {
  final List<Locale> locales = const [
    Locale('en', 'US'),
    Locale('en', 'GB'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('es', 'ES'),
    Locale('ja', 'JP'),
    Locale('ar', 'EG'),
    Locale('zh', 'CN'),
    Locale('ko', 'KR'),
    Locale('pt', 'BR'),
  ];
  final List<String> hints = const [
    'Default voice for North-American English content.',
    'British English voice; matters for date/units rephrasing.',
    'French voice; nasal vowels and silent terminal letters.',
    'German voice; long compound words and hard consonants.',
    'European Spanish; distinguish from es_MX where needed.',
    'Japanese voice; required for kana and kanji.',
    'Arabic; right-to-left script and Arabic-Indic digits.',
    'Mandarin Chinese; required for Han characters.',
    'Korean voice; necessary for Hangul.',
    'Brazilian Portuguese; nasal vowels differ from pt_PT.',
  ];

  final List<ui.LocaleStringAttribute> demos = List<ui.LocaleStringAttribute>.generate(
    locales.length,
    (int i) => ui.LocaleStringAttribute(
      range: const TextRange(start: 0, end: 1),
      locale: locales[i],
    ),
  );

  return _buildSectionShell(
    gradient: _kGradientCheatsheet,
    sectionNumber: '10',
    title: 'Locale cheat-sheet',
    subtitle: 'Common Locale codes and when LocaleStringAttribute helps',
    paragraphs: const [
      'A LocaleStringAttribute is only as useful as the Locale you give it. The locales '
          'below are the ones I reach for most often when I need to mark up foreign phrases '
          'inside a primarily-English UI.',
      'Each row lists the language code, the region code, and a one-line hint about why you '
          'might want it. Live LocaleStringAttribute instances are constructed for each row '
          'so you can read the .locale value back from the row badge.',
      'When you only know the language and not the region, omit the region: '
          'Locale("fr") is valid and the engine will pick a default region for you.',
    ],
    body: Column(
      children: List<Widget>.generate(locales.length, (int i) {
        return _buildCheatsheetRow(
          locales[i],
          hints[i],
          demos[i],
          even: i.isEven,
        );
      }),
    ),
  );
}

Widget _buildCheatsheetRow(
  Locale locale,
  String hint,
  ui.LocaleStringAttribute demo, {
  required bool even,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: even ? const Color(0x11FFFFFF) : Colors.transparent,
      border: const Border(
        bottom: BorderSide(color: Color(0x22FFFFFF), width: 0.6),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 86,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0x33B89BFF),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            locale.toString(),
            style: const TextStyle(
              color: _kAccentLilac,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            hint,
            style: const TextStyle(color: _kInk, fontSize: 12.5, height: 1.4),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'attr.locale=${demo.locale}',
          style: const TextStyle(
            color: _kInkDim,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 12 — Closing notes.
// =====================================================================
//
// Final reminder card with the three things to take away from this
// demo. Kept short: a hero-style coloured card is enough.

Widget _buildClosingNotesSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF132A44), Color(0xFF1B3A5E), Color(0xFF34D8FF)],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(color: Color(0x6634D8FF), blurRadius: 24, offset: Offset(0, 8)),
      ],
    ),
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Three takeaways',
          style: TextStyle(
            color: _kInk,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '1. StringAttribute is purely accessibility metadata. It never paints pixels.',
          style: TextStyle(color: _kInk, fontSize: 13.5, height: 1.55),
        ),
        SizedBox(height: 6),
        Text(
          '2. Reach for SpellOutStringAttribute when the screen reader would otherwise '
          'pronounce a run as a word; reach for LocaleStringAttribute when the run is '
          'in a different language.',
          style: TextStyle(color: _kInk, fontSize: 13.5, height: 1.55),
        ),
        SizedBox(height: 6),
        Text(
          '3. The TextRange is the only thing you can get wrong silently. Validate '
          'lengths, prefer normalised half-open ranges, and avoid overlaps.',
          style: TextStyle(color: _kInk, fontSize: 13.5, height: 1.55),
        ),
      ],
    ),
  );
}
