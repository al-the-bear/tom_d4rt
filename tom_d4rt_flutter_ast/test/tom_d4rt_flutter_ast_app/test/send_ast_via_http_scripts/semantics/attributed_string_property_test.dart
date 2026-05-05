// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
// AttributedStringProperty Deep Demo - "Inkwell Verbena" Edition
// ============================================================================
//
// This demo file is a hand-written, instruction-rich Flutter sample that
// explores the AttributedStringProperty class from the flutter/semantics
// library. It is designed as a long-form, narrative D4rt script that walks
// the reader through every nook and cranny of the AttributedStringProperty
// API while staying inside the constraints of the D4rt sandbox.
//
// Theme: "Inkwell Verbena". Verbena is a small purple flowering herb that
// grows in apothecary gardens. The palette intentionally mixes parchment
// off-whites with a curated set of verbena purples, stained-paper browns,
// muted ivys and the occasional dab of brass to evoke a hand-bound book of
// accessibility lore left open on a writing desk lit by an oil lamp.
//
// Why a property type deserves a 1500-line demo:
//   AttributedStringProperty is the bridge between the human side of Flutter
//   accessibility - labels, hints, values that a screen reader announces -
//   and the raw debug tooling that engineers use when those labels misbehave.
//   It surfaces AttributedString instances, including the SpellOut and
//   Locale string attributes attached to them, in a form that the Flutter
//   Inspector and the diagnostics tree can lay out cleanly.
//
//   Most Flutter teams meet AttributedStringProperty for the first time when
//   they are debugging a misannouncing screen reader. They open the widget
//   inspector, scroll down to the Semantics node, and see a property that
//   prints its attributes in a special format. Knowing exactly how this
//   property behaves saves hours of confused screen-reader testing.
//
// Hard rules baked into this file:
//   * build() is called exactly once. The widget tree returned is a snapshot.
//   * No StatefulWidget, no setState, no controllers, no live timers.
//   * No for-in over BridgedInstance values.
//   * Color alpha goes through .withValues(alpha: ...).
//   * Narrative print() lines walk the reader through what is happening.
//   * AttributedString and AttributedStringProperty are constructed for real
//     - this is not a doc-only demo; the runtime values feed the UI.
//
// Reading order if you only have ten minutes:
//   1. Skim the palette in section 1 to feel the theme.
//   2. Read section 4 (construction gallery) to see real properties.
//   3. Jump to section 9 (DO/AVOID) for the rules of the road.
//   4. Bookmark section 11 (glossary) for vocabulary.
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// ---------------------------------------------------------------------------
// Inkwell Verbena palette (>= 10 named colors)
// ---------------------------------------------------------------------------

const Color cParchment = Color(0xFFF5EFE2);
const Color cParchmentDeep = Color(0xFFEADFC4);
const Color cInkBrown = Color(0xFF3B2A1E);
const Color cInkSepia = Color(0xFF6B4F36);
const Color cVerbenaLight = Color(0xFFB7A4D8);
const Color cVerbena = Color(0xFF7C5BB0);
const Color cVerbenaDeep = Color(0xFF4B2E80);
const Color cIvy = Color(0xFF4F6B3E);
const Color cIvyMoss = Color(0xFF6E8C5A);
const Color cBrass = Color(0xFFB89455);
const Color cBrassDark = Color(0xFF7E6131);
const Color cWax = Color(0xFFD9B26A);
const Color cQuill = Color(0xFF1F1B17);
const Color cWhisperBlue = Color(0xFFC2D1D6);

dynamic build(BuildContext context) {
  print('============================================================');
  print('AttributedStringProperty deep demo - Inkwell Verbena edition');
  print('============================================================');
  print('Constructing AttributedString instances ...');

  // -------------------------------------------------------------------------
  // Real AttributedString instances. We will reuse these across sections.
  // Eight or more AttributedString objects, eight or more AttributedString
  // properties, plus locale and spell-out attributes.
  // -------------------------------------------------------------------------

  final attrPlain = AttributedString('Submit form');

  final attrSpellOutAcronym = AttributedString(
    'NASA mission report',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 0, end: 4)),
    ],
  );

  final attrSpellOutCode = AttributedString(
    'Code A1B2 confirmed',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 5, end: 9)),
    ],
  );

  final attrLocaleFrench = AttributedString(
    'Bonjour le monde',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 16),
        locale: Locale('fr', 'FR'),
      ),
    ],
  );

  final attrLocaleGerman = AttributedString(
    'Guten Morgen',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 12),
        locale: Locale('de', 'DE'),
      ),
    ],
  );

  final attrLocaleJapanese = AttributedString(
    'Tokyo station closed',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 5),
        locale: Locale('ja', 'JP'),
      ),
    ],
  );

  final attrMixed = AttributedString(
    'Order ID XYZ12 from Kyoto',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 9, end: 14)),
      LocaleStringAttribute(
        range: TextRange(start: 20, end: 25),
        locale: Locale('ja', 'JP'),
      ),
    ],
  );

  final attrLongHint = AttributedString(
    'Double tap to open the verbena drawer of the apothecary cabinet.',
  );

  final attrIncreased = AttributedString(
    'Brightness 80 percent',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 11, end: 13)),
    ],
  );

  final attrDecreased = AttributedString(
    'Brightness 60 percent',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 11, end: 13)),
    ],
  );

  print('Built ${9} AttributedString instances.');
  print('Now constructing AttributedStringProperty wrappers ...');

  // -------------------------------------------------------------------------
  // AttributedStringProperty wrappers (>= 8). These feed the gallery and the
  // diagnostics tree visualisation later on.
  // -------------------------------------------------------------------------

  final propLabel = AttributedStringProperty('label', attrPlain);
  final propAcronymLabel =
      AttributedStringProperty('label', attrSpellOutAcronym);
  final propConfirmationValue =
      AttributedStringProperty('value', attrSpellOutCode);
  final propFrenchLabel = AttributedStringProperty('label', attrLocaleFrench);
  final propGermanHint = AttributedStringProperty('hint', attrLocaleGerman);
  final propJapaneseHint = AttributedStringProperty('hint', attrLocaleJapanese);
  final propMixed = AttributedStringProperty('value', attrMixed);
  final propVerboseHint = AttributedStringProperty('hint', attrLongHint);
  final propIncreased =
      AttributedStringProperty('increasedValue', attrIncreased);
  final propDecreased =
      AttributedStringProperty('decreasedValue', attrDecreased);
  final propNullValue = AttributedStringProperty('label', null);
  final propWithDescription = AttributedStringProperty(
    'label',
    attrPlain,
    description: 'Primary submit button label',
  );

  print('Built 12 AttributedStringProperty instances.');
  print('Property names: label, value, hint, increasedValue, decreasedValue.');

  // Read .string back into the demo so that we exercise the runtime path.
  final readBackPlain = propLabel.value?.string ?? '<null>';
  final readBackMixed = propMixed.value?.string ?? '<null>';
  print('Plain label string: $readBackPlain');
  print('Mixed value string: $readBackMixed');

  // Build a scaffold-friendly title.
  final title = 'AttributedStringProperty - Inkwell Verbena';

  print('Assembling Scaffold body ...');

  // -------------------------------------------------------------------------
  // Section builders. Each helper returns a Widget that represents a single
  // section card. We keep helpers as plain top-level closures via local
  // functions so the file remains readable end-to-end.
  // -------------------------------------------------------------------------

  Widget section({
    required String number,
    required String title,
    required String subtitle,
    required Color accent,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cParchment,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cInkBrown.withValues(alpha: 0.10),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent, width: 1.2),
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: accent,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: cInkBrown,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: cInkSepia,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget bullet(String text, {Color color = cInkBrown}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13.5, color: cInkBrown, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget paragraph(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 13.5, color: cInkBrown, height: 1.4),
      ),
    );
  }

  Widget kvRow(String key, String value, {Color? accent}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              key,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: accent ?? cVerbenaDeep,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: cInkBrown, fontSize: 13.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget swatch(String name, Color color) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cInkBrown.withValues(alpha: 0.25)),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: cInkBrown),
            ),
          ),
        ],
      ),
    );
  }

  Widget propCard({
    required String heading,
    required String description,
    required AttributedStringProperty property,
    Color accent = cVerbena,
  }) {
    final v = property.value;
    final attrCount = v?.attributes.length ?? 0;
    final stringText = v?.string ?? '<null>';
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cParchmentDeep.withValues(alpha: 0.55),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: accent,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: cInkSepia,
              fontSize: 12.5,
            ),
          ),
          SizedBox(height: 8),
          kvRow('property name', property.name ?? '<unnamed>'),
          kvRow('value.string', stringText),
          kvRow('attribute count', '$attrCount'),
          kvRow('toString()', property.toString()),
        ],
      ),
    );
  }

  Widget codeBlock(String code, {Color accent = cVerbenaDeep}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cQuill,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          color: cParchment,
          fontSize: 12.5,
          height: 1.4,
        ),
      ),
    );
  }

  Widget twoColumnRow(
    String left,
    String right, {
    Color leftColor = cVerbenaDeep,
    Color rightColor = cIvy,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: leftColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                left,
                style: TextStyle(color: leftColor, fontSize: 12.5),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: rightColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                right,
                style: TextStyle(color: rightColor, fontSize: 12.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget calloutBox(String label, String body, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 4),
          Text(
            body,
            style: TextStyle(color: cInkBrown, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget glossaryRow(String term, String def) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              term,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: cVerbenaDeep,
              ),
            ),
          ),
          Expanded(
            child: Text(
              def,
              style: TextStyle(color: cInkBrown, fontSize: 13, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 1: TITLE BANNER + PALETTE SWATCHES
  // -------------------------------------------------------------------------

  print('Building section 1 - title banner and palette.');

  final titleBanner = Container(
    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          cVerbenaDeep,
          cVerbena,
          cVerbenaLight,
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cInkBrown.withValues(alpha: 0.25),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'AttributedStringProperty',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: cParchment,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Inkwell Verbena - a deep dive into semantics diagnostics',
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: cParchment.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Property type: DiagnosticsProperty<AttributedString>',
          style: TextStyle(color: cParchment, fontSize: 13),
        ),
        Text(
          'Used by: SemanticsConfiguration, SemanticsNode, debugFillProperties',
          style: TextStyle(color: cParchment, fontSize: 13),
        ),
        Text(
          'Companions: AttributedString, SpellOutStringAttribute, LocaleStringAttribute',
          style: TextStyle(color: cParchment, fontSize: 13),
        ),
        SizedBox(height: 16),
        Wrap(
          children: <Widget>[
            swatch('Parchment', cParchment),
            swatch('Parchment Deep', cParchmentDeep),
            swatch('Ink Brown', cInkBrown),
            swatch('Ink Sepia', cInkSepia),
            swatch('Verbena Light', cVerbenaLight),
            swatch('Verbena', cVerbena),
            swatch('Verbena Deep', cVerbenaDeep),
            swatch('Ivy', cIvy),
            swatch('Ivy Moss', cIvyMoss),
            swatch('Brass', cBrass),
            swatch('Brass Dark', cBrassDark),
            swatch('Wax', cWax),
            swatch('Quill', cQuill),
            swatch('Whisper Blue', cWhisperBlue),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2: PROSE ANATOMY
  // -------------------------------------------------------------------------

  print('Building section 2 - prose anatomy.');

  final section2 = section(
    number: '02',
    title: 'Prose anatomy of the property',
    subtitle: 'What it is, where it lives, who reads it.',
    accent: cVerbenaDeep,
    children: <Widget>[
      paragraph(
        'AttributedStringProperty is a DiagnosticsProperty subclass dedicated '
        'to AttributedString values. It exists so that the Flutter Inspector '
        'and the diagnostics tree can render an AttributedString in a way '
        'that preserves the metadata that screen readers care about.',
      ),
      paragraph(
        'When SemanticsConfiguration prepares its debug output, it reaches '
        'for AttributedStringProperty for label, value, hint, increasedValue '
        'and decreasedValue. Plain Strings would lose the spell-out and '
        'locale annotations attached to those fields.',
      ),
      paragraph(
        'In the accessibility tree the same property is what an engineer '
        'sees when they print the SemanticsNode. The runtime stores '
        'AttributedString instances, and AttributedStringProperty pulls them '
        'back out for display.',
      ),
      paragraph(
        'A useful mental model: AttributedString is the data, '
        'AttributedStringProperty is the lens that the tooling looks through.',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 3: PROPERTY ANATOMY
  // -------------------------------------------------------------------------

  print('Building section 3 - property anatomy.');

  final section3 = section(
    number: '03',
    title: 'Property anatomy',
    subtitle: 'name, value, description, level, defaultValue.',
    accent: cVerbena,
    children: <Widget>[
      paragraph(
        'Every DiagnosticsProperty has the same skeletal shape, and '
        'AttributedStringProperty is no exception. The fields below are the '
        'ones an engineer touches in everyday life.',
      ),
      kvRow('name', 'String label printed before the value, e.g. "label".'),
      kvRow('value', 'The wrapped AttributedString instance, possibly null.'),
      kvRow('description',
          'Optional human description used when value is missing.'),
      kvRow('level', 'DiagnosticLevel - usually .info; raise to .hidden to suppress.'),
      kvRow('defaultValue', 'When equal to value, the Inspector dims the row.'),
      kvRow('showName', 'Whether to print the name prefix at all.'),
      SizedBox(height: 8),
      paragraph(
        'The example label property used throughout this demo prints as '
        'roughly: label: "Submit form". When attributes are present, the '
        'AttributedString.toString() shows them after the string.',
      ),
      kvRow('current name', propLabel.name ?? '<none>'),
      kvRow('current value.string', propLabel.value?.string ?? '<null>'),
      kvRow('attribute count', '${propLabel.value?.attributes.length ?? 0}'),
      kvRow('description prop', propWithDescription.toString()),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 4: CONSTRUCTION GALLERY (>= 6 cards)
  // -------------------------------------------------------------------------

  print('Building section 4 - construction gallery.');

  final section4 = section(
    number: '04',
    title: 'Construction gallery',
    subtitle: 'Real properties paired with real attributed strings.',
    accent: cIvy,
    children: <Widget>[
      paragraph(
        'These cards show eight AttributedStringProperty instances. Each '
        'card prints the property name, the wrapped value.string, the count '
        'of attached StringAttribute objects, and the toString() rendering '
        'that the diagnostics tree would emit.',
      ),
      propCard(
        heading: 'Plain submit label',
        description: 'No attributes, just a localized button label.',
        property: propLabel,
        accent: cVerbena,
      ),
      propCard(
        heading: 'Acronym spelled out',
        description: 'NASA at range 0..4 spelled letter by letter.',
        property: propAcronymLabel,
        accent: cVerbenaDeep,
      ),
      propCard(
        heading: 'Confirmation code',
        description: 'A1B2 at range 5..9 spelled out for clarity.',
        property: propConfirmationValue,
        accent: cIvy,
      ),
      propCard(
        heading: 'French label',
        description: 'Locale fr-FR applied across the whole string.',
        property: propFrenchLabel,
        accent: cBrass,
      ),
      propCard(
        heading: 'German hint',
        description: 'Locale de-DE applied across the whole string.',
        property: propGermanHint,
        accent: cBrassDark,
      ),
      propCard(
        heading: 'Japanese hint slice',
        description: 'Tokyo (range 0..5) speaks ja-JP, the rest stays default.',
        property: propJapaneseHint,
        accent: cIvyMoss,
      ),
      propCard(
        heading: 'Mixed attributes',
        description: 'Order ID spelled out + Kyoto pronounced ja-JP.',
        property: propMixed,
        accent: cVerbena,
      ),
      propCard(
        heading: 'Verbose hint',
        description: 'Long instruction text, no attributes attached.',
        property: propVerboseHint,
        accent: cInkSepia,
      ),
      propCard(
        heading: 'Increased value',
        description: 'Used by Slider semantics to announce the new value.',
        property: propIncreased,
        accent: cIvy,
      ),
      propCard(
        heading: 'Decreased value',
        description: 'Used by Slider semantics to announce the prior value.',
        property: propDecreased,
        accent: cBrassDark,
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 5: SPELL OUT SHOWCASE (>= 6 instances)
  // -------------------------------------------------------------------------

  print('Building section 5 - spell out showcase.');

  // Build a series of SpellOutStringAttribute examples. We keep these as
  // local AttributedString objects to make the runtime path explicit.
  final spellSample1 = AttributedString(
    'IBM 360',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 0, end: 3)),
    ],
  );
  final spellSample2 = AttributedString(
    'PIN 1234 accepted',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 4, end: 8)),
    ],
  );
  final spellSample3 = AttributedString(
    'Flight QF11 boarding',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 7, end: 11)),
    ],
  );
  final spellSample4 = AttributedString(
    'License XK7Y2 valid',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 8, end: 13)),
    ],
  );
  final spellSample5 = AttributedString(
    'API key K8',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 8, end: 10)),
    ],
  );
  final spellSample6 = AttributedString(
    'Error E404 returned',
    attributes: <StringAttribute>[
      SpellOutStringAttribute(range: TextRange(start: 6, end: 10)),
    ],
  );

  Widget spellRow(String label, AttributedString attr) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cWax.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cBrass.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: cBrassDark,
              ),
            ),
            SizedBox(height: 4),
            kvRow('string', attr.string),
            kvRow('attribute count', '${attr.attributes.length}'),
            kvRow('toString', attr.toString()),
          ],
        ),
      ),
    );
  }

  final section5 = section(
    number: '05',
    title: 'SpellOutStringAttribute showcase',
    subtitle: 'Six AttributedStrings carrying spell-out attributes.',
    accent: cBrass,
    children: <Widget>[
      paragraph(
        'SpellOutStringAttribute tells the screen reader to read a substring '
        'letter by letter instead of as a word. Use it for acronyms, codes '
        'and identifiers where pronunciation would be confusing or ambiguous.',
      ),
      paragraph(
        'Each card below demonstrates a different range. The TextRange '
        'must be a valid substring of the AttributedString. If the range '
        'overflows, the framework will assert in debug mode.',
      ),
      spellRow('IBM acronym', spellSample1),
      spellRow('PIN digits', spellSample2),
      spellRow('Flight code', spellSample3),
      spellRow('License plate', spellSample4),
      spellRow('Short suffix', spellSample5),
      spellRow('Error code', spellSample6),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 6: LOCALE SHOWCASE (>= 6 locales)
  // -------------------------------------------------------------------------

  print('Building section 6 - locale showcase.');

  final localeEnUs = AttributedString(
    'Submit form',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 11),
        locale: Locale('en', 'US'),
      ),
    ],
  );
  final localeFrFr = AttributedString(
    'Envoyer le formulaire',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 21),
        locale: Locale('fr', 'FR'),
      ),
    ],
  );
  final localeDeDe = AttributedString(
    'Formular absenden',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 17),
        locale: Locale('de', 'DE'),
      ),
    ],
  );
  final localeJaJp = AttributedString(
    'Soshin suru',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 11),
        locale: Locale('ja', 'JP'),
      ),
    ],
  );
  final localeKoKr = AttributedString(
    'Jeson hagi',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 10),
        locale: Locale('ko', 'KR'),
      ),
    ],
  );
  final localeZhCn = AttributedString(
    'Tijiao biaodan',
    attributes: <StringAttribute>[
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 14),
        locale: Locale('zh', 'CN'),
      ),
    ],
  );

  Widget localeRow(String tag, String locale, AttributedString attr) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cWhisperBlue.withValues(alpha: 0.40),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cIvy.withValues(alpha: 0.45)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: cIvy.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    locale,
                    style: TextStyle(
                      color: cIvy,
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  tag,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cInkBrown,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            kvRow('string', attr.string),
            kvRow('attribute count', '${attr.attributes.length}'),
            kvRow('toString', attr.toString()),
          ],
        ),
      ),
    );
  }

  final section6 = section(
    number: '06',
    title: 'LocaleStringAttribute showcase',
    subtitle: 'Six locales, each pinning a substring to a language tag.',
    accent: cIvy,
    children: <Widget>[
      paragraph(
        'LocaleStringAttribute lets a screen reader switch voices and '
        'pronunciation rules across spans of text. It is the right tool '
        'for mixed-language UI, brand names, song titles and quoted phrases.',
      ),
      paragraph(
        'Each card shows the same intent (a submit-action label) translated '
        'into a different locale. In real applications you typically wrap '
        'localized values, not parallel translations.',
      ),
      localeRow('English', 'en-US', localeEnUs),
      localeRow('French', 'fr-FR', localeFrFr),
      localeRow('German', 'de-DE', localeDeDe),
      localeRow('Japanese', 'ja-JP', localeJaJp),
      localeRow('Korean', 'ko-KR', localeKoKr),
      localeRow('Chinese', 'zh-CN', localeZhCn),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 7: DIAGNOSTICS TREE VISUALIZATION
  // -------------------------------------------------------------------------

  print('Building section 7 - diagnostics tree visualisation.');

  Widget treeNode({
    required String header,
    required List<Widget> children,
    Color color = cVerbena,
    double indent = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: indent, top: 4, bottom: 4),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          border: Border(
            left: BorderSide(color: color, width: 3),
            top: BorderSide(color: color.withValues(alpha: 0.25), width: 0.6),
            right: BorderSide(color: color.withValues(alpha: 0.25), width: 0.6),
            bottom:
                BorderSide(color: color.withValues(alpha: 0.25), width: 0.6),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: color,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
            SizedBox(height: 4),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget treeProp(String prop, {Color color = cInkBrown}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Text(
        prop,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }

  final section7 = section(
    number: '07',
    title: 'Diagnostics tree visualization',
    subtitle: 'How a SemanticsNode prints its property bag.',
    accent: cVerbena,
    children: <Widget>[
      paragraph(
        'The diagnostics tree stacks DiagnosticsProperty rows. Below is a '
        'reconstructed snapshot of how SemanticsNode debug output looks '
        'when label, hint, value, increasedValue and decreasedValue are '
        'wrapped in AttributedStringProperty instances.',
      ),
      treeNode(
        header: 'SemanticsNode#42',
        color: cVerbenaDeep,
        children: <Widget>[
          treeProp('rect: Rect.fromLTRB(0.0, 0.0, 200.0, 48.0)'),
          treeProp('actions: [tap]'),
          treeProp('flags: [isButton]'),
          treeNode(
            header: 'AttributedStringProperty<label>',
            color: cVerbena,
            indent: 14,
            children: <Widget>[
              treeProp('value.string: "${propLabel.value?.string}"'),
              treeProp(
                  'attributes: ${propLabel.value?.attributes.length ?? 0}'),
              treeProp('toString: ${propLabel.toString()}'),
            ],
          ),
          treeNode(
            header: 'AttributedStringProperty<hint>',
            color: cIvy,
            indent: 14,
            children: <Widget>[
              treeProp('value.string: "${propVerboseHint.value?.string}"'),
              treeProp(
                  'attributes: ${propVerboseHint.value?.attributes.length ?? 0}'),
              treeProp('toString: ${propVerboseHint.toString()}'),
            ],
          ),
          treeNode(
            header: 'AttributedStringProperty<value>',
            color: cBrass,
            indent: 14,
            children: <Widget>[
              treeProp('value.string: "${propMixed.value?.string}"'),
              treeProp(
                  'attributes: ${propMixed.value?.attributes.length ?? 0}'),
              treeProp('toString: ${propMixed.toString()}'),
            ],
          ),
          treeNode(
            header: 'AttributedStringProperty<increasedValue>',
            color: cIvyMoss,
            indent: 14,
            children: <Widget>[
              treeProp('value.string: "${propIncreased.value?.string}"'),
              treeProp(
                  'attributes: ${propIncreased.value?.attributes.length ?? 0}'),
              treeProp('toString: ${propIncreased.toString()}'),
            ],
          ),
          treeNode(
            header: 'AttributedStringProperty<decreasedValue>',
            color: cBrassDark,
            indent: 14,
            children: <Widget>[
              treeProp('value.string: "${propDecreased.value?.string}"'),
              treeProp(
                  'attributes: ${propDecreased.value?.attributes.length ?? 0}'),
              treeProp('toString: ${propDecreased.toString()}'),
            ],
          ),
        ],
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 8: COMPARISON ATTRIBUTED VS PLAIN STRING PROPERTY
  // -------------------------------------------------------------------------

  print('Building section 8 - comparison.');

  final section8 = section(
    number: '08',
    title: 'AttributedStringProperty vs StringProperty',
    subtitle: 'Eight axes of difference between the two.',
    accent: cBrassDark,
    children: <Widget>[
      paragraph(
        'It is tempting to use the simpler StringProperty when wiring up a '
        'semantics widget. The table below explains why AttributedString '
        'and AttributedStringProperty are usually the right choice for '
        'accessibility-bearing values.',
      ),
      twoColumnRow(
        'StringProperty: takes a plain String value.',
        'AttributedStringProperty: takes an AttributedString value.',
      ),
      twoColumnRow(
        'StringProperty: cannot describe spell-out hints.',
        'AttributedStringProperty: carries SpellOutStringAttribute spans.',
      ),
      twoColumnRow(
        'StringProperty: cannot describe locale spans.',
        'AttributedStringProperty: carries LocaleStringAttribute spans.',
      ),
      twoColumnRow(
        'StringProperty: prints the raw string.',
        'AttributedStringProperty: prints the string plus attributes.',
      ),
      twoColumnRow(
        'StringProperty: used everywhere in widget debug output.',
        'AttributedStringProperty: used by SemanticsConfiguration.',
      ),
      twoColumnRow(
        'StringProperty: ideal for text content like errorText.',
        'AttributedStringProperty: ideal for label, hint, value, etc.',
      ),
      twoColumnRow(
        'StringProperty: rarely null, fallback empty string is fine.',
        'AttributedStringProperty: null is meaningful (no override).',
      ),
      twoColumnRow(
        'StringProperty: pure presentation use cases.',
        'AttributedStringProperty: accessibility-bearing use cases.',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 9: DO / AVOID CALLOUTS
  // -------------------------------------------------------------------------

  print('Building section 9 - do/avoid.');

  final section9 = section(
    number: '09',
    title: 'Do this. Avoid that.',
    subtitle: 'Six rules of thumb for working with AttributedStringProperty.',
    accent: cIvy,
    children: <Widget>[
      calloutBox(
        'DO',
        'Construct AttributedString once at semantics build time and pass it '
            'to AttributedStringProperty when overriding debugFillProperties.',
        cIvy,
      ),
      calloutBox(
        'AVOID',
        'Do not pass attributes whose TextRange exceeds the length of the '
            'underlying string. The framework asserts and the debug output '
            'becomes useless.',
        cBrassDark,
      ),
      calloutBox(
        'DO',
        'Use SpellOutStringAttribute for short codes, acronyms and '
            'identifiers that should be read letter by letter.',
        cIvy,
      ),
      calloutBox(
        'AVOID',
        'Avoid wrapping every word in a LocaleStringAttribute. Locale spans '
            'should be reserved for genuine language switches.',
        cBrassDark,
      ),
      calloutBox(
        'DO',
        'Reuse AttributedString instances when they are immutable and shared '
            'across rebuilds; SemanticsConfiguration will copy them safely.',
        cIvy,
      ),
      calloutBox(
        'AVOID',
        'Do not use AttributedStringProperty to display Strings that have '
            'no accessibility relevance. StringProperty is cheaper and clearer.',
        cBrassDark,
      ),
      calloutBox(
        'DO',
        'When debugging a screen reader regression, dump the SemanticsNode '
            'tree first; AttributedStringProperty rows will spotlight the '
            'misconfigured spans.',
        cIvy,
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 10: CODE-SNIPPET CARDS (5 recipes)
  // -------------------------------------------------------------------------

  print('Building section 10 - code recipes.');

  final section10 = section(
    number: '10',
    title: 'Code recipes',
    subtitle: 'Five end-to-end snippets for common semantics patterns.',
    accent: cVerbenaDeep,
    children: <Widget>[
      paragraph(
        'These recipes are written as if they were extracted from a '
        'RenderObject mixin or a semantics widget. They show the typical '
        'shape of a debugFillProperties override that uses '
        'AttributedStringProperty.',
      ),
      Text(
        'Recipe 1 - label',
        style: TextStyle(fontWeight: FontWeight.w700, color: cVerbenaDeep),
      ),
      codeBlock(
        '@override\n'
        'void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
        '  super.debugFillProperties(properties);\n'
        '  properties.add(AttributedStringProperty(\n'
        '    "label",\n'
        '    attributedLabel,\n'
        '  ));\n'
        '}\n',
      ),
      Text(
        'Recipe 2 - hint',
        style: TextStyle(fontWeight: FontWeight.w700, color: cVerbenaDeep),
      ),
      codeBlock(
        'properties.add(AttributedStringProperty(\n'
        '  "hint",\n'
        '  AttributedString("Double tap to confirm"),\n'
        '));\n',
      ),
      Text(
        'Recipe 3 - value with spelling',
        style: TextStyle(fontWeight: FontWeight.w700, color: cVerbenaDeep),
      ),
      codeBlock(
        'final attr = AttributedString(\n'
        '  "Code A1B2",\n'
        '  attributes: <StringAttribute>[\n'
        '    SpellOutStringAttribute(range: TextRange(start: 5, end: 9)),\n'
        '  ],\n'
        ');\n'
        'properties.add(AttributedStringProperty("value", attr));\n',
      ),
      Text(
        'Recipe 4 - locale switch',
        style: TextStyle(fontWeight: FontWeight.w700, color: cVerbenaDeep),
      ),
      codeBlock(
        'final attr = AttributedString(\n'
        '  "Bonjour",\n'
        '  attributes: <StringAttribute>[\n'
        '    LocaleStringAttribute(\n'
        '      range: TextRange(start: 0, end: 7),\n'
        '      locale: Locale("fr", "FR"),\n'
        '    ),\n'
        '  ],\n'
        ');\n'
        'properties.add(AttributedStringProperty("label", attr));\n',
      ),
      Text(
        'Recipe 5 - increased / decreased values',
        style: TextStyle(fontWeight: FontWeight.w700, color: cVerbenaDeep),
      ),
      codeBlock(
        'properties.add(AttributedStringProperty(\n'
        '  "increasedValue",\n'
        '  AttributedString("Brightness 80 percent"),\n'
        '));\n'
        'properties.add(AttributedStringProperty(\n'
        '  "decreasedValue",\n'
        '  AttributedString("Brightness 60 percent"),\n'
        '));\n',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 11: GLOSSARY (>= 12 terms)
  // -------------------------------------------------------------------------

  print('Building section 11 - glossary.');

  final section11 = section(
    number: '11',
    title: 'Glossary',
    subtitle: 'Twelve plus terms you will meet around this property.',
    accent: cBrass,
    children: <Widget>[
      glossaryRow('AttributedString',
          'A String paired with a list of StringAttribute spans.'),
      glossaryRow('AttributedStringProperty',
          'DiagnosticsProperty<AttributedString> for diagnostics output.'),
      glossaryRow('StringAttribute',
          'Abstract base for spans (SpellOut, Locale, ...).'),
      glossaryRow('SpellOutStringAttribute',
          'Tells screen readers to spell a span letter by letter.'),
      glossaryRow('LocaleStringAttribute',
          'Pins a span to a specific Locale for pronunciation.'),
      glossaryRow('TextRange',
          'Half-open [start, end) span of UTF-16 code units.'),
      glossaryRow('Locale',
          'Language and country tag like en-US, ja-JP, zh-CN.'),
      glossaryRow('SemanticsConfiguration',
          'Buffer of semantics fields built up by widgets.'),
      glossaryRow('SemanticsNode',
          'Live node in the accessibility tree at runtime.'),
      glossaryRow('DiagnosticsProperty',
          'Generic typed property carried by the diagnostics tree.'),
      glossaryRow('DiagnosticsNode',
          'Tree node printed in widget inspector dumps.'),
      glossaryRow('debugFillProperties',
          'Hook that contributes properties to the diagnostics tree.'),
      glossaryRow('Inspector',
          'Flutter DevTools panel that consumes diagnostics tree dumps.'),
      glossaryRow('DiagnosticLevel',
          'Visibility band: hidden, fine, info, warning, error, summary.'),
      glossaryRow('DefaultValue',
          'When property value matches default, the row is dimmed.'),
      glossaryRow('Verbena',
          'A purple flowering herb; here, the demo color theme.'),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 12: RECAP FOOTER
  // -------------------------------------------------------------------------

  print('Building section 12 - recap footer.');

  final section12 = section(
    number: '12',
    title: 'Recap',
    subtitle: 'Three sentences to take away.',
    accent: cVerbenaDeep,
    children: <Widget>[
      bullet(
        'AttributedStringProperty wraps an AttributedString for diagnostics, '
        'preserving spell-out and locale spans for the inspector.',
        color: cVerbena,
      ),
      bullet(
        'Use it inside debugFillProperties for any semantics-bearing '
        'String field on a RenderObject or widget.',
        color: cIvy,
      ),
      bullet(
        'Treat AttributedString as immutable data; treat the property '
        'as a transparent view onto that data.',
        color: cBrass,
      ),
      SizedBox(height: 8),
      paragraph(
        'Demo finished. Reload the script to refresh the snapshot. '
        '- Inkwell Verbena',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // Read-back panel: tiny diagnostic panel rendering live values from the
  // properties so the reader can see the runtime path was actually used.
  // -------------------------------------------------------------------------

  print('Building runtime read-back panel.');

  final readback = Container(
    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cQuill,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Runtime read-back',
          style: TextStyle(
            color: cWax,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Live values pulled from the property instances.',
          style: TextStyle(
            color: cParchment.withValues(alpha: 0.85),
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'propLabel.name = ${propLabel.name}',
          style: TextStyle(
            color: cParchment,
            fontFamily: 'monospace',
            fontSize: 12.5,
          ),
        ),
        Text(
          'propLabel.value.string = "${propLabel.value?.string}"',
          style: TextStyle(
            color: cParchment,
            fontFamily: 'monospace',
            fontSize: 12.5,
          ),
        ),
        Text(
          'propMixed.value.string = "${propMixed.value?.string}"',
          style: TextStyle(
            color: cParchment,
            fontFamily: 'monospace',
            fontSize: 12.5,
          ),
        ),
        Text(
          'propMixed attribute count = ${propMixed.value?.attributes.length ?? 0}',
          style: TextStyle(
            color: cParchment,
            fontFamily: 'monospace',
            fontSize: 12.5,
          ),
        ),
        Text(
          'propNullValue.value = ${propNullValue.value}',
          style: TextStyle(
            color: cParchment,
            fontFamily: 'monospace',
            fontSize: 12.5,
          ),
        ),
        Text(
          'propWithDescription.toString() = ${propWithDescription.toString()}',
          style: TextStyle(
            color: cParchment,
            fontFamily: 'monospace',
            fontSize: 12.5,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // Final scaffold assembly.
  // -------------------------------------------------------------------------

  print('Final assembly. Returning Scaffold.');
  print('Total sections: 12 plus banner and read-back.');
  print('Total AttributedString instances: 9 plus 12 spell/locale samples.');
  print('Total AttributedStringProperty instances: 12.');
  print('============================================================');

  return Scaffold(
    backgroundColor: cParchmentDeep,
    appBar: AppBar(
      backgroundColor: cVerbenaDeep,
      foregroundColor: cParchment,
      title: Text(title),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
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
          readback,
          SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ============================================================================
// END OF FILE - AttributedStringProperty Inkwell Verbena demo
// ============================================================================
//
// Appendix: extended notes (intentionally retained as comments to keep this
// file dense with reference material). These notes do not influence the
// runtime tree, but they help future maintainers and reviewers locate
// background information without leaving the file.
//
// A. Where AttributedStringProperty surfaces in the framework
//    The class lives in package:flutter/semantics.dart, alongside
//    SemanticsNode, SemanticsConfiguration, AttributedString and the
//    StringAttribute hierarchy. Its primary consumers are:
//
//      * SemanticsConfiguration.debugFillProperties - emits one
//        AttributedStringProperty for label, value, hint, increasedValue
//        and decreasedValue, plus a tooltip line for tooltips.
//      * SemanticsNode.debugFillProperties - same set of properties,
//        rendered as part of the semantics tree dump.
//      * Custom RenderObjects that override debugFillProperties to
//        contribute their own attributed semantics fields.
//
// B. Why a dedicated property type is necessary
//    A plain DiagnosticsProperty<AttributedString> would already render
//    the AttributedString.toString() output. The dedicated subtype:
//
//      * Provides a clearer semantic name in the inspector (it is "an
//        AttributedString property", not "a generic property of type
//        AttributedString").
//      * Allows the framework to centralise any future formatting
//        improvements without touching every call site.
//      * Mirrors the symmetry of StringProperty / AttributedStringProperty
//        in the diagnostics API.
//
// C. Range arithmetic gotchas
//    The TextRange used by SpellOutStringAttribute and LocaleStringAttribute
//    works in UTF-16 code units, exactly like Dart String indices. For
//    most Latin-script text this is one code unit per character, but
//    surrogate pairs (emoji, some CJK ideographs) take two. Always derive
//    ranges from substring searches on the same String you are wrapping,
//    not from external data.
//
// D. Equality semantics
//    AttributedString implements value-based equality. Two instances with
//    the same string and the same attributes are considered equal. This
//    matters for the diagnostics tree when comparing a property to its
//    defaultValue: equal values dim the row.
//
// E. Performance considerations
//    AttributedStringProperty is cheap to construct and read. The main
//    cost is in building the underlying AttributedString and its
//    attribute list. In production semantics paths, prefer building
//    these inside semantics callbacks rather than every frame in build().
//
// F. Testing strategy
//    A reasonable test for a custom widget that emits attributed semantics
//    is to:
//
//      1. Pump the widget into a TestWidgetsFlutterBinding.
//      2. Capture the SemanticsNode tree.
//      3. Read the AttributedStringProperty rows and assert on
//         value.string and value.attributes lengths.
//      4. Optionally compare against a golden semantics dump.
//
// G. Related accessibility concepts
//    AttributedStringProperty plays well with these other semantics
//    primitives: SemanticsAction, SemanticsFlag, TooltipProperty,
//    SemanticsHintOverrides, ImplicitScrollSemanticsHandle. The deeper
//    your widget integrates with assistive technology, the more often
//    these names will come up.
//
// H. Why Inkwell Verbena
//    The theme leans on the imagery of an apothecary writing book: ink
//    stains, parchment paper, ivy, brass tooling, wax seals. This file
//    has the personality of a long letter rather than a quick demo.
//
// I. Closing note
//    If you read this far, you now have a good intuition for how
//    AttributedStringProperty fits into Flutter accessibility. Carry it
//    with you the next time a semantics tree dump confuses you in the
//    inspector. Verbena season is short; legible diagnostics are forever.
//
// ============================================================================
