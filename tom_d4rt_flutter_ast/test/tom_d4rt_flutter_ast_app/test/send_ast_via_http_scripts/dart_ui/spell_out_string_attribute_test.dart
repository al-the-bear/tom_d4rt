// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: SpellOutStringAttribute from dart:ui
//
// Theme: "Phoneme Sand" - a warm, parchment palette built around the idea of
// letter-by-letter pronunciation. SpellOutStringAttribute tells screen readers
// (TalkBack, VoiceOver, NVDA) to enunciate each individual character of a
// substring rather than pronouncing it as a whole word. This is essential for
// acronyms (NASA, FBI, IBM), brand initialisms (BBC, CNN, NPR), license plates
// ("7-K-Q-9-Z-3"), serial numbers, masked passwords and any short string where
// the literal letters carry the meaning.
//
// The attribute carries a single property:
//
//   range : TextRange    The half-open [start, end) span over the parent
//                        AttributedString to which spell-out behaviour applies.
//
// Constructing a SpellOutStringAttribute is cheap and immutable; the engine
// uses it only as accessibility metadata, not as visual styling. This file
// hand-authors a deep visual catalogue around that single property: a hero
// card, an API table, a sibling-attribute catalogue, scenario panels for
// acronyms, codes, brands and license plates, an example table comparing
// spoken output, prose on TalkBack/VoiceOver behaviour, ASCII diagrams of
// TextRange spans, palette swatches, a glossary, and pitfall notes about
// over-spelling regular words.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ----------------------------------------------------------------------
  // Console preamble.
  // ----------------------------------------------------------------------
  print('SpellOutStringAttribute :: Phoneme Sand visual demo');
  print('=' * 64);
  print('Theme   : Phoneme Sand / Letterpress Indigo / Diacritic Saffron');
  print('Subject : ui.SpellOutStringAttribute');
  print('Purpose : Force screen readers to spell each character');
  print('Carries : range (TextRange)');
  print('=' * 64);

  // ----------------------------------------------------------------------
  // Palette - Phoneme Sand.
  // ----------------------------------------------------------------------
  const Color sandParchment = Color(0xFFF6EFE2);
  const Color sandLinen = Color(0xFFEFE4CE);
  const Color sandWheat = Color(0xFFE6D3A8);
  const Color sandToast = Color(0xFFC8A864);
  const Color sandClay = Color(0xFF8C6B33);
  const Color inkIndigo = Color(0xFF2A2F5A);
  const Color inkMidnight = Color(0xFF1A1F44);
  const Color inkDeep = Color(0xFF0F1230);
  const Color saffron = Color(0xFFE89A2C);
  const Color saffronDeep = Color(0xFFB8741C);
  const Color cinnabar = Color(0xFFC0492E);
  const Color cinnabarSoft = Color(0xFFE07458);
  const Color teal = Color(0xFF2C7A7B);
  const Color tealDeep = Color(0xFF1F5859);
  const Color olive = Color(0xFF6B7A2C);
  const Color rose = Color(0xFFB85470);
  const Color slate = Color(0xFF4A4F66);
  const Color slateLight = Color(0xFF6F7488);
  const Color cream = Color(0xFFFFF8EA);

  // ----------------------------------------------------------------------
  // Build SpellOutStringAttribute instances under try/catch as required.
  // Each instance demonstrates a different acronym/code with its own range.
  // ----------------------------------------------------------------------
  ui.SpellOutStringAttribute? attrFbi;
  ui.SpellOutStringAttribute? attrNasa;
  ui.SpellOutStringAttribute? attrIbm;
  ui.SpellOutStringAttribute? attrBbc;
  ui.SpellOutStringAttribute? attrPlate;
  ui.SpellOutStringAttribute? attrZip;
  ui.SpellOutStringAttribute? attrEta;
  ui.SpellOutStringAttribute? attrFyi;
  ui.SpellOutStringAttribute? attrKbe;
  ui.SpellOutStringAttribute? attrSerial;
  ui.SpellOutStringAttribute? attrPin;

  TextRange? rangeFbi;
  TextRange? rangeNasa;
  TextRange? rangeIbm;
  TextRange? rangeBbc;
  TextRange? rangePlate;
  TextRange? rangeZip;
  TextRange? rangeEta;
  TextRange? rangeFyi;
  TextRange? rangeKbe;
  TextRange? rangeSerial;
  TextRange? rangePin;

  ui.LocaleStringAttribute? localeAttrEn;
  ui.LocaleStringAttribute? localeAttrFr;
  ui.LocaleStringAttribute? localeAttrDe;

  try {
    rangeFbi = const TextRange(start: 0, end: 3);
  } catch (e) {
    print('TextRange FBI failed: $e');
  }
  try {
    rangeNasa = const TextRange(start: 4, end: 8);
  } catch (e) {
    print('TextRange NASA failed: $e');
  }
  try {
    rangeIbm = const TextRange(start: 0, end: 3);
  } catch (e) {
    print('TextRange IBM failed: $e');
  }
  try {
    rangeBbc = const TextRange(start: 0, end: 3);
  } catch (e) {
    print('TextRange BBC failed: $e');
  }
  try {
    rangePlate = const TextRange(start: 6, end: 13);
  } catch (e) {
    print('TextRange plate failed: $e');
  }
  try {
    rangeZip = const TextRange(start: 9, end: 14);
  } catch (e) {
    print('TextRange ZIP failed: $e');
  }
  try {
    rangeEta = const TextRange(start: 0, end: 3);
  } catch (e) {
    print('TextRange ETA failed: $e');
  }
  try {
    rangeFyi = const TextRange(start: 0, end: 3);
  } catch (e) {
    print('TextRange FYI failed: $e');
  }
  try {
    rangeKbe = const TextRange(start: 0, end: 3);
  } catch (e) {
    print('TextRange KBE failed: $e');
  }
  try {
    rangeSerial = const TextRange(start: 8, end: 20);
  } catch (e) {
    print('TextRange serial failed: $e');
  }
  try {
    rangePin = const TextRange(start: 5, end: 9);
  } catch (e) {
    print('TextRange PIN failed: $e');
  }

  try {
    attrFbi = ui.SpellOutStringAttribute(
      range: rangeFbi ?? const TextRange(start: 0, end: 3),
    );
  } catch (e) {
    print('SpellOutStringAttribute FBI failed: $e');
  }
  try {
    attrNasa = ui.SpellOutStringAttribute(
      range: rangeNasa ?? const TextRange(start: 4, end: 8),
    );
  } catch (e) {
    print('SpellOutStringAttribute NASA failed: $e');
  }
  try {
    attrIbm = ui.SpellOutStringAttribute(
      range: rangeIbm ?? const TextRange(start: 0, end: 3),
    );
  } catch (e) {
    print('SpellOutStringAttribute IBM failed: $e');
  }
  try {
    attrBbc = ui.SpellOutStringAttribute(
      range: rangeBbc ?? const TextRange(start: 0, end: 3),
    );
  } catch (e) {
    print('SpellOutStringAttribute BBC failed: $e');
  }
  try {
    attrPlate = ui.SpellOutStringAttribute(
      range: rangePlate ?? const TextRange(start: 6, end: 13),
    );
  } catch (e) {
    print('SpellOutStringAttribute plate failed: $e');
  }
  try {
    attrZip = ui.SpellOutStringAttribute(
      range: rangeZip ?? const TextRange(start: 9, end: 14),
    );
  } catch (e) {
    print('SpellOutStringAttribute ZIP failed: $e');
  }
  try {
    attrEta = ui.SpellOutStringAttribute(
      range: rangeEta ?? const TextRange(start: 0, end: 3),
    );
  } catch (e) {
    print('SpellOutStringAttribute ETA failed: $e');
  }
  try {
    attrFyi = ui.SpellOutStringAttribute(
      range: rangeFyi ?? const TextRange(start: 0, end: 3),
    );
  } catch (e) {
    print('SpellOutStringAttribute FYI failed: $e');
  }
  try {
    attrKbe = ui.SpellOutStringAttribute(
      range: rangeKbe ?? const TextRange(start: 0, end: 3),
    );
  } catch (e) {
    print('SpellOutStringAttribute KBE failed: $e');
  }
  try {
    attrSerial = ui.SpellOutStringAttribute(
      range: rangeSerial ?? const TextRange(start: 8, end: 20),
    );
  } catch (e) {
    print('SpellOutStringAttribute serial failed: $e');
  }
  try {
    attrPin = ui.SpellOutStringAttribute(
      range: rangePin ?? const TextRange(start: 5, end: 9),
    );
  } catch (e) {
    print('SpellOutStringAttribute PIN failed: $e');
  }

  try {
    localeAttrEn = ui.LocaleStringAttribute(
      range: const TextRange(start: 0, end: 5),
      locale: const Locale('en', 'US'),
    );
  } catch (e) {
    print('LocaleStringAttribute en-US failed: $e');
  }
  try {
    localeAttrFr = ui.LocaleStringAttribute(
      range: const TextRange(start: 0, end: 5),
      locale: const Locale('fr', 'FR'),
    );
  } catch (e) {
    print('LocaleStringAttribute fr-FR failed: $e');
  }
  try {
    localeAttrDe = ui.LocaleStringAttribute(
      range: const TextRange(start: 0, end: 5),
      locale: const Locale('de', 'DE'),
    );
  } catch (e) {
    print('LocaleStringAttribute de-DE failed: $e');
  }

  print('FBI    range: ${attrFbi?.range}');
  print('NASA   range: ${attrNasa?.range}');
  print('IBM    range: ${attrIbm?.range}');
  print('BBC    range: ${attrBbc?.range}');
  print('plate  range: ${attrPlate?.range}');
  print('ZIP    range: ${attrZip?.range}');
  print('ETA    range: ${attrEta?.range}');
  print('FYI    range: ${attrFyi?.range}');
  print('KBE    range: ${attrKbe?.range}');
  print('serial range: ${attrSerial?.range}');
  print('PIN    range: ${attrPin?.range}');

  // ----------------------------------------------------------------------
  // Section header builder (closure - allowed; we are inside build()).
  // ----------------------------------------------------------------------
  Widget sectionTitle(String label, String subtitle, IconData icon,
      Color background, Color foreground) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            background,
            Color.lerp(background, inkDeep, 0.35) ?? background,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: foreground.withValues(alpha: 0.22), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: foreground, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: foreground.withValues(alpha: 0.78),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardShell(Widget child, Color border, Color fill) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border.withValues(alpha: 0.4), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: inkDeep.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget kvLine(String key, String value, Color keyColor, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 132,
            child: Text(
              key,
              style: TextStyle(
                color: keyColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================================
  // HERO CARD - "B - B - C" letter-by-letter visualization.
  // ======================================================================
  final List<String> heroLetters = <String>['B', 'B', 'C'];
  final List<Widget> heroLetterTiles = <Widget>[];
  for (int i = 0; i < heroLetters.length; i = i + 1) {
    heroLetterTiles.add(
      Container(
        width: 64,
        height: 76,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[saffron, saffronDeep],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: inkMidnight, width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: inkDeep.withValues(alpha: 0.22),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              heroLetters[i],
              style: const TextStyle(
                color: cream,
                fontWeight: FontWeight.bold,
                fontSize: 36,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '#${i + 1}',
              style: TextStyle(
                color: cream.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
    if (i < heroLetters.length - 1) {
      heroLetterTiles.add(
        Container(
          width: 22,
          alignment: Alignment.center,
          child: Text(
            '\u00B7',
            style: TextStyle(
              color: inkMidnight.withValues(alpha: 0.55),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  final Widget heroCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[sandLinen, sandWheat, sandToast],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: sandClay, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: inkDeep.withValues(alpha: 0.18),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: inkIndigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'dart:ui',
                style: TextStyle(
                  color: cream,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.5,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: cinnabar,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'a11y',
                style: TextStyle(
                  color: cream,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.5,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'phoneme sand',
                style: TextStyle(
                  color: cream,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.5,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'SpellOutStringAttribute',
          style: TextStyle(
            color: inkDeep,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Spell each character. "BBC" becomes B - B - C.',
          style: TextStyle(
            color: inkIndigo.withValues(alpha: 0.85),
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: heroLetterTiles,
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cream.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: sandClay.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Reader-rendered output',
                style: TextStyle(
                  color: sandClay,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '"bee, bee, see"',
                style: TextStyle(
                  color: inkDeep,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'TalkBack and VoiceOver enunciate each glyph in the spell-out '
                'range, leaving the rest of the string to normal pronunciation '
                'rules so the announcement still flows naturally.',
                style: TextStyle(
                  color: inkIndigo.withValues(alpha: 0.78),
                  fontSize: 11.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: inkMidnight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'range = ${attrBbc?.range ?? rangeBbc}',
                style: const TextStyle(
                  color: cream,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: olive,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'extends StringAttribute',
                style: TextStyle(
                  color: cream,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: rose,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'immutable accessibility metadata',
                style: TextStyle(
                  color: cream,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ======================================================================
  // API SURFACE TABLE.
  // ======================================================================
  final List<List<String>> apiRows = <List<String>>[
    <String>['Member', 'Kind', 'Type', 'Notes'],
    <String>[
      'SpellOutStringAttribute',
      'class',
      'extends StringAttribute',
      'Annotation telling readers to spell each char',
    ],
    <String>[
      'SpellOutStringAttribute(...)',
      'constructor',
      '({required TextRange range})',
      'Cheap, immutable, no validation cost',
    ],
    <String>[
      'range',
      'final field',
      'TextRange',
      'Half-open span [start, end)',
    ],
    <String>[
      'runtimeType',
      'getter (Object)',
      'Type',
      'Reflects concrete subclass',
    ],
    <String>[
      'toString()',
      'method (Object)',
      'String',
      'Engine-defined debug repr',
    ],
    <String>[
      'hashCode / ==',
      'inherited',
      'int / bool',
      'Identity semantics from base',
    ],
    <String>[
      'StringAttribute',
      'sealed base',
      'abstract',
      'Parent of SpellOut + Locale variants',
    ],
    <String>[
      'AttributedString',
      'consumer',
      'class',
      'Carries a list of StringAttribute',
    ],
    <String>[
      'TextRange',
      'collaborator',
      'class',
      'start (incl), end (excl), guards',
    ],
    <String>[
      'SemanticsConfiguration',
      'consumer',
      'class',
      'attributedLabel / attributedValue',
    ],
  ];

  final List<TableRow> apiTableRows = <TableRow>[];
  for (int i = 0; i < apiRows.length; i = i + 1) {
    final List<String> row = apiRows[i];
    final bool header = i == 0;
    final Color rowFill = header
        ? inkMidnight
        : (i.isOdd ? sandParchment : cream);
    final Color rowText = header ? cream : inkDeep;
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < row.length; c = c + 1) {
      cells.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Text(
            row[c],
            style: TextStyle(
              color: rowText,
              fontWeight: header ? FontWeight.bold : FontWeight.w500,
              fontSize: header ? 12 : 11.5,
              fontFamily: c == 0 || c == 2 ? 'monospace' : null,
            ),
          ),
        ),
      );
    }
    apiTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowFill),
        children: cells,
      ),
    );
  }

  final Widget apiTable = Table(
    border: TableBorder.all(
      color: sandClay.withValues(alpha: 0.45),
      width: 0.7,
    ),
    columnWidths: const <int, TableColumnWidth>{
      0: FlexColumnWidth(2.4),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(2.6),
      3: FlexColumnWidth(3.0),
    },
    children: apiTableRows,
  );

  // ======================================================================
  // RELATED ATTRIBUTE CATALOG.
  // ======================================================================
  final List<List<String>> attrCatalogRows = <List<String>>[
    <String>['Attribute', 'Constructor', 'Effect', 'Use case'],
    <String>[
      'SpellOutStringAttribute',
      '({range})',
      'Read each character',
      'Acronyms, codes, license plates',
    ],
    <String>[
      'LocaleStringAttribute',
      '({range, locale})',
      'Switch reader voice/locale for span',
      'Mixed-language strings, foreign names',
    ],
    <String>[
      'StringAttribute (base)',
      'abstract',
      'Tag a TextRange with a11y semantics',
      'Polymorphic carrier',
    ],
    <String>[
      'AttributedString',
      '(string, attributes: [...])',
      'Bundle string with attribute list',
      'Provide to SemanticsConfiguration',
    ],
    <String>[
      'TextRange',
      '({start, end})',
      'Span definition',
      'Must satisfy 0 <= start <= end',
    ],
    <String>[
      'SemanticsConfiguration',
      '.attributedLabel = ...',
      'Forward attributes to platform',
      'Custom semantic widgets',
    ],
  ];

  final List<TableRow> attrCatalogTableRows = <TableRow>[];
  for (int i = 0; i < attrCatalogRows.length; i = i + 1) {
    final List<String> row = attrCatalogRows[i];
    final bool header = i == 0;
    final Color rowFill = header
        ? tealDeep
        : (i.isOdd ? cream : sandParchment);
    final Color rowText = header ? cream : inkDeep;
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < row.length; c = c + 1) {
      cells.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            row[c],
            style: TextStyle(
              color: rowText,
              fontWeight: header ? FontWeight.bold : FontWeight.w500,
              fontSize: header ? 11.5 : 11,
              fontFamily: c == 0 || c == 1 ? 'monospace' : null,
            ),
          ),
        ),
      );
    }
    attrCatalogTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowFill),
        children: cells,
      ),
    );
  }

  final Widget attrCatalog = Table(
    border: TableBorder.all(
      color: teal.withValues(alpha: 0.4),
      width: 0.7,
    ),
    columnWidths: const <int, TableColumnWidth>{
      0: FlexColumnWidth(2.3),
      1: FlexColumnWidth(2.0),
      2: FlexColumnWidth(2.6),
      3: FlexColumnWidth(2.6),
    },
    children: attrCatalogTableRows,
  );

  // ======================================================================
  // TEXT vs READER-RENDERED TABLE.
  // ======================================================================
  final List<List<String>> readerRows = <List<String>>[
    <String>['Original text', 'Spell-out range', 'Default reading',
      'Spell-out reading'],
    <String>[
      'FBI agent',
      '[0, 3)',
      '"fbi agent"',
      '"F, B, I agent"',
    ],
    <String>[
      'NASA mission',
      '[0, 4)',
      '"nasa mission"',
      '"N, A, S, A mission"',
    ],
    <String>[
      'IBM ThinkPad',
      '[0, 3)',
      '"ibm thinkpad"',
      '"I, B, M ThinkPad"',
    ],
    <String>[
      'BBC News',
      '[0, 3)',
      '"bbc news"',
      '"B, B, C news"',
    ],
    <String>[
      'Plate 7KQ9Z3',
      '[6, 12)',
      '"plate 7kq9z3"',
      '"plate 7, K, Q, 9, Z, 3"',
    ],
    <String>[
      'ZIP 90210',
      '[4, 9)',
      '"zip ninety-thousand"',
      '"zip 9, 0, 2, 1, 0"',
    ],
    <String>[
      'PIN 4815',
      '[4, 8)',
      '"pin four-thousand"',
      '"pin 4, 8, 1, 5"',
    ],
    <String>[
      'KBE-class',
      '[0, 3)',
      '"kbe-class"',
      '"K, B, E class"',
    ],
    <String>[
      'ETA 19:30',
      '[0, 3)',
      '"eta nineteen-thirty"',
      '"E, T, A nineteen-thirty"',
    ],
  ];

  final List<TableRow> readerTableRows = <TableRow>[];
  for (int i = 0; i < readerRows.length; i = i + 1) {
    final List<String> row = readerRows[i];
    final bool header = i == 0;
    final Color rowFill = header
        ? saffronDeep
        : (i.isOdd ? sandLinen : cream);
    final Color rowText = header ? cream : inkDeep;
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < row.length; c = c + 1) {
      cells.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          child: Text(
            row[c],
            style: TextStyle(
              color: rowText,
              fontWeight: header
                  ? FontWeight.bold
                  : (c == 0 ? FontWeight.w700 : FontWeight.w500),
              fontSize: header ? 11.5 : 11,
              fontFamily: c == 1 || c == 2 || c == 3 ? 'monospace' : null,
            ),
          ),
        ),
      );
    }
    readerTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowFill),
        children: cells,
      ),
    );
  }

  final Widget readerTable = Table(
    border: TableBorder.all(
      color: saffronDeep.withValues(alpha: 0.4),
      width: 0.7,
    ),
    columnWidths: const <int, TableColumnWidth>{
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(1.4),
      2: FlexColumnWidth(2.6),
      3: FlexColumnWidth(2.8),
    },
    children: readerTableRows,
  );

  // ======================================================================
  // EXAMPLES TABLE - NASA, IBM, ETA, FYI, KBE, ZIP.
  // ======================================================================
  final List<List<String>> examplesRows = <List<String>>[
    <String>['Acronym', 'Meaning', 'Spell-out reading', 'Why spell out'],
    <String>[
      'NASA',
      'National Aeronautics and Space Administration',
      'N, A, S, A',
      'Brand identity is the letters',
    ],
    <String>[
      'IBM',
      'International Business Machines',
      'I, B, M',
      'Reader would otherwise say "ibm"',
    ],
    <String>[
      'ETA',
      'Estimated Time of Arrival',
      'E, T, A',
      'Avoid "eta" as a Greek letter',
    ],
    <String>[
      'FYI',
      'For Your Information',
      'F, Y, I',
      'Casual initialism, not a word',
    ],
    <String>[
      'KBE',
      'Knight Commander of the British Empire',
      'K, B, E',
      'Honorific abbreviation',
    ],
    <String>[
      'ZIP',
      'Zone Improvement Plan code',
      'Z, I, P',
      'Disambiguate from "zip" verb',
    ],
    <String>[
      'BBC',
      'British Broadcasting Corporation',
      'B, B, C',
      'Brand is the letters',
    ],
    <String>[
      'CNN',
      'Cable News Network',
      'C, N, N',
      'Avoid the "kahn" pronunciation',
    ],
    <String>[
      'NPR',
      'National Public Radio',
      'N, P, R',
      'Letter-only brand identity',
    ],
  ];

  final List<TableRow> examplesTableRows = <TableRow>[];
  for (int i = 0; i < examplesRows.length; i = i + 1) {
    final List<String> row = examplesRows[i];
    final bool header = i == 0;
    final Color rowFill = header
        ? cinnabar
        : (i.isOdd ? cream : sandLinen);
    final Color rowText = header ? cream : inkDeep;
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < row.length; c = c + 1) {
      cells.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          child: Text(
            row[c],
            style: TextStyle(
              color: rowText,
              fontWeight: header
                  ? FontWeight.bold
                  : (c == 0 ? FontWeight.w800 : FontWeight.w500),
              fontSize: header ? 11.5 : 11,
              fontFamily: c == 0 || c == 2 ? 'monospace' : null,
            ),
          ),
        ),
      );
    }
    examplesTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowFill),
        children: cells,
      ),
    );
  }

  final Widget examplesTable = Table(
    border: TableBorder.all(
      color: cinnabar.withValues(alpha: 0.4),
      width: 0.7,
    ),
    columnWidths: const <int, TableColumnWidth>{
      0: FlexColumnWidth(1.2),
      1: FlexColumnWidth(2.6),
      2: FlexColumnWidth(1.6),
      3: FlexColumnWidth(2.4),
    },
    children: examplesTableRows,
  );

  // ======================================================================
  // SCENARIO PANELS.
  // ======================================================================
  Widget scenarioPanel(
    String tag,
    String title,
    String exampleText,
    String spellRange,
    String reads,
    String body,
    Color accent,
  ) {
    return cardShell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: cream,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.5,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: inkDeep,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent.withValues(alpha: 0.35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Source string:',
                  style: TextStyle(
                    color: slate,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.5,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  exampleText,
                  style: TextStyle(
                    color: inkDeep,
                    fontSize: 14,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Spell-out range: $spellRange',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Reader: $reads',
                  style: TextStyle(
                    color: inkIndigo,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              color: inkIndigo.withValues(alpha: 0.85),
              fontSize: 11.8,
              height: 1.4,
            ),
          ),
        ],
      ),
      accent,
      sandParchment,
    );
  }

  final Widget scenarioAcronyms = scenarioPanel(
    'ACRONYM',
    'Pronouncing initialisms letter-by-letter',
    'NASA mission to FBI HQ',
    '[0,4) and [16,19)',
    '"N, A, S, A mission to F, B, I HQ"',
    'Without the SpellOutStringAttribute, TalkBack would attempt to pronounce '
        '"NASA" as "nasa" (which is fine in English) and "FBI" as the syllable '
        '"fbi" (which is awkward). Marking each acronym with its own range '
        'makes both renderings consistent and unambiguous, regardless of the '
        'voice engine the user has installed.',
    saffron,
  );

  final Widget scenarioCodes = scenarioPanel(
    'CODE',
    'Numeric identifiers and PINs',
    'Order code 4815-1623-4242',
    '[11, 25)',
    '"Order code 4, 8, 1, 5 ... 1, 6, 2, 3 ... 4, 2, 4, 2"',
    'Long digit sequences are far easier to verify when each digit is '
        'announced individually. A reader saying "four billion eight hundred '
        'fifteen million" is impossible to compare against printed text. The '
        'spell-out range across the entire code keeps each digit in line with '
        'the visible glyphs and lets the listener reproduce or transcribe the '
        'value confidently.',
    teal,
  );

  final Widget scenarioBrands = scenarioPanel(
    'BRAND',
    'Letter-style brand names',
    'BBC News special',
    '[0, 3)',
    '"B, B, C news special"',
    'Many brand identities ARE the letters: BBC, CNN, NPR, IBM, ICQ. Reading '
        '"bbc" as a single syllable strips away the brand recognition. The '
        'spell-out attribute restores the intended announcement across iOS, '
        'Android and desktop screen readers without forcing visual changes '
        'or capitalisation tricks in the source string.',
    cinnabar,
  );

  final Widget scenarioPlates = scenarioPanel(
    'PLATE',
    'License plates and serial numbers',
    'Plate 7KQ9Z3 issued',
    '[6, 12)',
    '"Plate 7, K, Q, 9, Z, 3 issued"',
    'License plates intermix letters and digits in a way that defeats every '
        'natural-language heuristic. "7KQ9Z3" might be read as "seven thousand '
        'kew nine zee three" or fall apart entirely. Spell-out restores the '
        'one-glyph-at-a-time cadence drivers and dispatchers actually need '
        'when relaying registrations or serial numbers over voice.',
    rose,
  );

  // ======================================================================
  // RANGE DIAGRAMS - ASCII visualisations of TextRange spans.
  // ======================================================================
  Widget asciiBlock(String title, String code, Color accent) {
    return cardShell(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: inkDeep,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              code,
              style: TextStyle(
                color: cream,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
      accent,
      cream,
    );
  }

  final Widget rangeDiagram1 = asciiBlock(
    'TEXT RANGE: "FBI agent"',
    'index : 0 1 2 3 4 5 6 7 8\n'
        'char  : F B I _ a g e n t\n'
        'span  : [---)\n'
        '        start=0  end=3\n'
        '\n'
        '   spell-out applies to "FBI"\n'
        '   "agent" reads naturally',
    saffron,
  );

  final Widget rangeDiagram2 = asciiBlock(
    'TEXT RANGE: "see NASA launch"',
    'index : 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14\n'
        'char  : s e e _ N A S A _ l  a  u  n  c  h\n'
        'span  :         [-------)\n'
        '                start=4  end=8\n'
        '\n'
        '   "see" -> normal voice\n'
        '   "NASA" -> N, A, S, A\n'
        '   "launch" -> normal voice',
    teal,
  );

  final Widget rangeDiagram3 = asciiBlock(
    'TEXT RANGE: "Plate 7KQ9Z3 OK"',
    'index : 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14\n'
        'char  : P l a t e _ 7 K Q 9 Z  3  _  O  K\n'
        'span  :             [-----------)\n'
        '                    start=6 end=12\n'
        '\n'
        '   "Plate" -> normal voice\n'
        '   "7KQ9Z3" -> 7, K, Q, 9, Z, 3\n'
        '   "OK" -> normal voice (or "okay")',
    cinnabar,
  );

  final Widget rangeDiagram4 = asciiBlock(
    'TEXT RANGE: "PIN 4815 entered"',
    'index : 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14\n'
        'char  : P I N _ 4 8 1 5 _ e n  t  e  r  e  d\n'
        'span1 : [-)         (PIN itself)\n'
        '         start=0 end=3\n'
        'span2 :         [-----)\n'
        '                start=4 end=8\n'
        '\n'
        '   Two SpellOutStringAttributes\n'
        '   may coexist on one string.',
    rose,
  );

  // ======================================================================
  // PROSE: TalkBack and VoiceOver behaviour.
  // ======================================================================
  final Widget proseBlock = cardShell(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'How TalkBack and VoiceOver realise spell-out attributes',
          style: TextStyle(
            color: inkDeep,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'When a Flutter widget exposes an attributedLabel or attributedValue '
          'on its SemanticsConfiguration, the framework forwards the wrapped '
          'AttributedString to the platform a11y bridge. That bridge translates '
          'each StringAttribute into the platform-equivalent annotation:',
          style: TextStyle(
            color: inkIndigo.withValues(alpha: 0.85),
            fontSize: 12,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 8),
        kvLine('iOS / VoiceOver',
            'NSAttributedString + UIAccessibilitySpeechAttributeSpellOut',
            saffronDeep, inkDeep),
        kvLine('Android / TalkBack',
            'SpannableString + TtsSpan.TYPE_VERBATIM',
            saffronDeep, inkDeep),
        kvLine('Web / ARIA',
            'aria-label rewritten with U+2009 thin spaces between glyphs',
            saffronDeep, inkDeep),
        kvLine('Desktop / NVDA',
            'character-by-character speech mode for the span',
            saffronDeep, inkDeep),
        const SizedBox(height: 8),
        Text(
          'Importantly, SpellOutStringAttribute is metadata only. It does not '
          'alter the visible glyphs, the layout, the cursor positions, the '
          'caret hit-testing, the selection logic, or the input-method '
          'composition. The same Text widget renders identically whether or '
          'not it carries this attribute - the only consumers are the '
          'accessibility services. A user who has both vision and a screen '
          'reader running will see "BBC" and hear "B, B, C" simultaneously.',
          style: TextStyle(
            color: inkIndigo.withValues(alpha: 0.85),
            fontSize: 12,
            height: 1.45,
          ),
        ),
      ],
    ),
    inkIndigo,
    sandParchment,
  );

  // ======================================================================
  // COMPARISON: SpellOut vs Locale.
  // ======================================================================
  final List<List<String>> comparisonRows = <List<String>>[
    <String>['Aspect', 'SpellOutStringAttribute', 'LocaleStringAttribute'],
    <String>[
      'Constructor',
      '({TextRange range})',
      '({TextRange range, Locale locale})',
    ],
    <String>[
      'Behaviour',
      'Spell each glyph in range',
      'Use locale\'s voice for range',
    ],
    <String>[
      'Affects pronunciation',
      'Yes (one glyph at a time)',
      'Yes (whole-word, locale rules)',
    ],
    <String>[
      'Affects rendering',
      'No',
      'No',
    ],
    <String>[
      'Typical input',
      'Acronyms, codes',
      'Foreign names, mixed-language',
    ],
    <String>[
      'Stackable',
      'Yes (multiple ranges allowed)',
      'Yes (per-range locale)',
    ],
    <String>[
      'Conflict with each other',
      'May coexist - both apply',
      'Locale wins on conflicting span',
    ],
    <String>[
      'Falls back to',
      'Default reader pronunciation',
      'System locale',
    ],
    <String>[
      'Best for',
      'Letter identity matters',
      'Word identity matters',
    ],
  ];

  final List<TableRow> comparisonTableRows = <TableRow>[];
  for (int i = 0; i < comparisonRows.length; i = i + 1) {
    final List<String> row = comparisonRows[i];
    final bool header = i == 0;
    final Color rowFill = header
        ? olive
        : (i.isOdd ? sandLinen : cream);
    final Color rowText = header ? cream : inkDeep;
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < row.length; c = c + 1) {
      cells.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
          child: Text(
            row[c],
            style: TextStyle(
              color: rowText,
              fontWeight: header
                  ? FontWeight.bold
                  : (c == 0 ? FontWeight.w700 : FontWeight.w500),
              fontSize: header ? 11.5 : 11,
              fontFamily: c == 1 || c == 2 ? 'monospace' : null,
            ),
          ),
        ),
      );
    }
    comparisonTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowFill),
        children: cells,
      ),
    );
  }

  final Widget comparisonTable = Table(
    border: TableBorder.all(
      color: olive.withValues(alpha: 0.4),
      width: 0.7,
    ),
    columnWidths: const <int, TableColumnWidth>{
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(2.8),
      2: FlexColumnWidth(2.8),
    },
    children: comparisonTableRows,
  );

  // ======================================================================
  // PITFALLS.
  // ======================================================================
  Widget pitfall(
    String label,
    String title,
    String body,
    Color border,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: border,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                color: cream,
                fontWeight: FontWeight.bold,
                fontSize: 10.5,
                letterSpacing: 1.5,
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
                  style: TextStyle(
                    color: inkDeep,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    color: inkIndigo.withValues(alpha: 0.85),
                    fontSize: 11.8,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfallsBlock = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      pitfall(
        'OVER',
        'Do not spell out regular words',
        'Marking the entire visible label with a SpellOutStringAttribute will '
            'turn "Welcome to settings" into "W, e, l, c, o, m, e ...". This '
            'is exhausting and condescending for users. Spell-out is for spans '
            'where the letters themselves carry meaning, not generic prose.',
        cinnabar,
      ),
      pitfall(
        'RANGE',
        'Stay within string bounds',
        'TextRange uses half-open semantics: end is the index AFTER the last '
            'covered glyph. A 3-character acronym at the start of the string '
            'is range(0, 3), not range(0, 2). Off-by-one errors silently '
            'misalign the spell-out span and produce a garbled announcement.',
        saffronDeep,
      ),
      pitfall(
        'LANG',
        'Combine with LocaleStringAttribute carefully',
        'If you set a French locale on the same span, the reader may try to '
            'announce each letter using French letter names ("ah, beh, seh"). '
            'That is the correct behaviour - the locale wins over default '
            'reader voice, and SpellOut just changes granularity. Pick the '
            'locale deliberately for the audience.',
        teal,
      ),
      pitfall(
        'PUNC',
        'Punctuation inside the range',
        'A range like "Mr. Smith" with spell-out covering the dot will cause '
            'the reader to enunciate "M, r, period, S, m, i, t, h". That is '
            'rarely useful. Trim trailing or interior punctuation out of the '
            'range so only meaningful glyphs are spelled.',
        rose,
      ),
      pitfall(
        'STACK',
        'Do not contradict yourself',
        'Adding both a SpellOutStringAttribute and a LocaleStringAttribute to '
            'the same span is allowed, but make sure the locale supports '
            'letter-name pronunciation (most do). Adding two SpellOut spans '
            'over the same indices is redundant - simplify to one.',
        olive,
      ),
      pitfall(
        'TEST',
        'Verify with a real screen reader',
        'Visual code review cannot verify accessibility metadata. Run the app '
            'with TalkBack and VoiceOver enabled, navigate to your widget, '
            'and listen to the announcement. Synthetic-voice subtleties (pace, '
            'pitch, pause length around the range) are only audible in situ.',
        slate,
      ),
    ],
  );

  // ======================================================================
  // GLOSSARY.
  // ======================================================================
  final List<List<String>> glossaryRows = <List<String>>[
    <String>['Term', 'Definition'],
    <String>[
      'AttributedString',
      'A String with a list of StringAttribute spans for accessibility',
    ],
    <String>[
      'StringAttribute',
      'Sealed base class; either SpellOut or Locale variant',
    ],
    <String>[
      'SpellOutStringAttribute',
      'Tells screen readers to spell each character of the range',
    ],
    <String>[
      'LocaleStringAttribute',
      'Switches the screen-reader voice/locale for the range',
    ],
    <String>[
      'TextRange',
      'Half-open span [start, end) into the parent string',
    ],
    <String>[
      'TalkBack',
      'Android system screen reader',
    ],
    <String>[
      'VoiceOver',
      'iOS / macOS system screen reader',
    ],
    <String>[
      'NVDA',
      'NonVisual Desktop Access; popular Windows screen reader',
    ],
    <String>[
      'Initialism',
      'Acronym pronounced letter-by-letter (FBI), as opposed to NATO-style',
    ],
    <String>[
      'TTS',
      'Text-to-speech; the synthesised voice engine doing the reading',
    ],
    <String>[
      'TtsSpan',
      'Android annotation type carrying speech hints inside Spannable',
    ],
    <String>[
      'NSAttributedString',
      'Apple-platform string with attributed regions',
    ],
    <String>[
      'SemanticsConfiguration',
      'Flutter object describing a node\'s a11y properties to the platform',
    ],
  ];

  final List<TableRow> glossaryTableRows = <TableRow>[];
  for (int i = 0; i < glossaryRows.length; i = i + 1) {
    final List<String> row = glossaryRows[i];
    final bool header = i == 0;
    final Color rowFill = header
        ? slate
        : (i.isOdd ? cream : sandParchment);
    final Color rowText = header ? cream : inkDeep;
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < row.length; c = c + 1) {
      cells.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Text(
            row[c],
            style: TextStyle(
              color: rowText,
              fontWeight: header
                  ? FontWeight.bold
                  : (c == 0 ? FontWeight.w700 : FontWeight.w500),
              fontSize: header ? 11.5 : 11,
              fontFamily: c == 0 ? 'monospace' : null,
            ),
          ),
        ),
      );
    }
    glossaryTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: rowFill),
        children: cells,
      ),
    );
  }

  final Widget glossaryTable = Table(
    border: TableBorder.all(
      color: slateLight.withValues(alpha: 0.45),
      width: 0.7,
    ),
    columnWidths: const <int, TableColumnWidth>{
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(5.0),
    },
    children: glossaryTableRows,
  );

  // ======================================================================
  // PALETTE SWATCHES.
  // ======================================================================
  final List<Map<String, dynamic>> swatches = <Map<String, dynamic>>[
    <String, dynamic>{'name': 'Sand Parchment', 'hex': '#F6EFE2', 'c': sandParchment},
    <String, dynamic>{'name': 'Sand Linen', 'hex': '#EFE4CE', 'c': sandLinen},
    <String, dynamic>{'name': 'Sand Wheat', 'hex': '#E6D3A8', 'c': sandWheat},
    <String, dynamic>{'name': 'Sand Toast', 'hex': '#C8A864', 'c': sandToast},
    <String, dynamic>{'name': 'Sand Clay', 'hex': '#8C6B33', 'c': sandClay},
    <String, dynamic>{'name': 'Letterpress Indigo', 'hex': '#2A2F5A', 'c': inkIndigo},
    <String, dynamic>{'name': 'Ink Midnight', 'hex': '#1A1F44', 'c': inkMidnight},
    <String, dynamic>{'name': 'Ink Deep', 'hex': '#0F1230', 'c': inkDeep},
    <String, dynamic>{'name': 'Diacritic Saffron', 'hex': '#E89A2C', 'c': saffron},
    <String, dynamic>{'name': 'Saffron Deep', 'hex': '#B8741C', 'c': saffronDeep},
    <String, dynamic>{'name': 'Cinnabar', 'hex': '#C0492E', 'c': cinnabar},
    <String, dynamic>{'name': 'Cinnabar Soft', 'hex': '#E07458', 'c': cinnabarSoft},
    <String, dynamic>{'name': 'Phoneme Teal', 'hex': '#2C7A7B', 'c': teal},
    <String, dynamic>{'name': 'Teal Deep', 'hex': '#1F5859', 'c': tealDeep},
    <String, dynamic>{'name': 'Manuscript Olive', 'hex': '#6B7A2C', 'c': olive},
    <String, dynamic>{'name': 'Voiceover Rose', 'hex': '#B85470', 'c': rose},
    <String, dynamic>{'name': 'Slate Quote', 'hex': '#4A4F66', 'c': slate},
    <String, dynamic>{'name': 'Slate Light', 'hex': '#6F7488', 'c': slateLight},
    <String, dynamic>{'name': 'Cream', 'hex': '#FFF8EA', 'c': cream},
  ];

  final List<Widget> swatchTiles = <Widget>[];
  for (int i = 0; i < swatches.length; i = i + 1) {
    final Map<String, dynamic> sw = swatches[i];
    final Color c = sw['c'] as Color;
    final String name = sw['name'] as String;
    final String hex = sw['hex'] as String;
    swatchTiles.add(
      Container(
        width: 150,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: sandClay.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: inkDeep.withValues(alpha: 0.18)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: inkDeep,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.5,
                    ),
                  ),
                  Text(
                    hex,
                    style: TextStyle(
                      color: slateLight,
                      fontSize: 9.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================================
  // CODE EXAMPLE SNIPPET.
  // ======================================================================
  const String codeExample =
      '// Marking an acronym for letter-by-letter pronunciation\n'
      'final attr = SpellOutStringAttribute(\n'
      '  range: TextRange(start: 0, end: 3),\n'
      ');\n'
      '\n'
      'final aStr = AttributedString(\n'
      '  "FBI agent on the line",\n'
      '  attributes: <StringAttribute>[attr],\n'
      ');\n'
      '\n'
      '// Forward to the platform via SemanticsConfiguration\n'
      'config.attributedLabel = aStr;\n'
      '\n'
      '// Multiple ranges:\n'
      'AttributedString(\n'
      '  "see NASA before BBC airs",\n'
      '  attributes: <StringAttribute>[\n'
      '    SpellOutStringAttribute(\n'
      '      range: TextRange(start: 4, end: 8),\n'
      '    ),\n'
      '    SpellOutStringAttribute(\n'
      '      range: TextRange(start: 16, end: 19),\n'
      '    ),\n'
      '  ],\n'
      ');';

  final Widget codeBlock = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: inkDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: saffron.withValues(alpha: 0.45), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: cinnabarSoft,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: saffron,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: olive,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'spell_out_attribute.dart',
              style: TextStyle(
                color: cream.withValues(alpha: 0.7),
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          codeExample,
          style: TextStyle(
            color: cream,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ======================================================================
  // RUNTIME PROBE PANEL.
  // ======================================================================
  final Widget runtimeProbe = cardShell(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Runtime probe',
          style: TextStyle(
            color: inkDeep,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        kvLine('FBI range', '${attrFbi?.range}', saffronDeep, inkDeep),
        kvLine('NASA range', '${attrNasa?.range}', saffronDeep, inkDeep),
        kvLine('IBM range', '${attrIbm?.range}', saffronDeep, inkDeep),
        kvLine('BBC range', '${attrBbc?.range}', saffronDeep, inkDeep),
        kvLine('Plate range', '${attrPlate?.range}', saffronDeep, inkDeep),
        kvLine('ZIP range', '${attrZip?.range}', saffronDeep, inkDeep),
        kvLine('ETA range', '${attrEta?.range}', saffronDeep, inkDeep),
        kvLine('FYI range', '${attrFyi?.range}', saffronDeep, inkDeep),
        kvLine('KBE range', '${attrKbe?.range}', saffronDeep, inkDeep),
        kvLine('Serial range', '${attrSerial?.range}', saffronDeep, inkDeep),
        kvLine('PIN range', '${attrPin?.range}', saffronDeep, inkDeep),
        const SizedBox(height: 6),
        kvLine('runtimeType', '${attrFbi?.runtimeType}', cinnabar, inkDeep),
        kvLine('Locale en-US', '${localeAttrEn?.locale}', teal, inkDeep),
        kvLine('Locale fr-FR', '${localeAttrFr?.locale}', teal, inkDeep),
        kvLine('Locale de-DE', '${localeAttrDe?.locale}', teal, inkDeep),
      ],
    ),
    inkIndigo,
    cream,
  );

  // ======================================================================
  // FOOTER.
  // ======================================================================
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: inkDeep,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phoneme Sand / Letterpress Indigo / Diacritic Saffron',
          style: TextStyle(
            color: saffron,
            fontWeight: FontWeight.bold,
            fontSize: 11.5,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'SpellOutStringAttribute carries one property - a TextRange - and one '
          'promise: the platform screen reader will enunciate each character of '
          'that span individually. Use it for acronyms, codes, brands, plates '
          'and serial numbers; do not use it for ordinary prose. Pair with '
          'LocaleStringAttribute when the audience\'s expected letter names '
          'differ from the system default. Verify with a real screen reader, '
          'not a code review.',
          style: TextStyle(
            color: cream.withValues(alpha: 0.85),
            fontSize: 11.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: 0.96,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: 0.96,
            child: const Text(
              'attributedLabel - attributedValue - attributedHint',
              style: TextStyle(
                color: cream,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ======================================================================
  // FADE WRAPPER (uses AlwaysStoppedAnimation only).
  // ======================================================================
  Widget faded(Widget child, double t) {
    return FadeTransition(
      opacity: AlwaysStoppedAnimation<double>(t),
      child: child,
    );
  }

  // ======================================================================
  // FINAL ASSEMBLY.
  // ======================================================================
  print('Assembling Phoneme Sand canvas');
  print('Sections: hero, api, catalog, reader, examples, scenarios, ranges,');
  print('          prose, comparison, pitfalls, glossary, palette, code,');
  print('          runtime probe, footer.');
  print('=' * 64);

  return Scaffold(
    backgroundColor: sandParchment,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top banner.
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[inkDeep, inkIndigo, saffronDeep],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: cream.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.record_voice_over,
                      color: cream,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'dart:ui :: SpellOutStringAttribute',
                          style: TextStyle(
                            color: cream,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'phoneme sand visual demo',
                          style: TextStyle(
                            color: cream.withValues(alpha: 0.78),
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: saffron,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'a11y',
                      style: TextStyle(
                        color: inkDeep,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.5,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Hero card.
            faded(heroCard, 1.0),
            const SizedBox(height: 18),

            // API surface.
            sectionTitle(
              'API SURFACE',
              'Members, types, and notes for SpellOutStringAttribute',
              Icons.api,
              inkIndigo,
              cream,
            ),
            const SizedBox(height: 8),
            cardShell(apiTable, inkIndigo, cream),
            const SizedBox(height: 14),

            // Related attributes.
            sectionTitle(
              'RELATED ATTRIBUTE CATALOG',
              'Sibling types in the StringAttribute hierarchy',
              Icons.library_books_outlined,
              tealDeep,
              cream,
            ),
            const SizedBox(height: 8),
            cardShell(attrCatalog, tealDeep, cream),
            const SizedBox(height: 14),

            // Reader rendering.
            sectionTitle(
              'READER RENDERING',
              'Original text vs. screen-reader output',
              Icons.hearing,
              saffronDeep,
              cream,
            ),
            const SizedBox(height: 8),
            cardShell(readerTable, saffronDeep, cream),
            const SizedBox(height: 14),

            // Examples table.
            sectionTitle(
              'EXAMPLES',
              'NASA, IBM, ETA, FYI, KBE, ZIP, BBC, CNN, NPR',
              Icons.science_outlined,
              cinnabar,
              cream,
            ),
            const SizedBox(height: 8),
            cardShell(examplesTable, cinnabar, cream),
            const SizedBox(height: 14),

            // Scenarios.
            sectionTitle(
              'SCENARIO PANELS',
              'Acronyms, codes, brand names, license plates',
              Icons.dashboard_customize_outlined,
              olive,
              cream,
            ),
            const SizedBox(height: 8),
            scenarioAcronyms,
            scenarioCodes,
            scenarioBrands,
            scenarioPlates,
            const SizedBox(height: 14),

            // Range diagrams.
            sectionTitle(
              'TEXTRANGE DIAGRAMS',
              'ASCII visualisation of [start, end) spans',
              Icons.format_align_left,
              rose,
              cream,
            ),
            const SizedBox(height: 8),
            rangeDiagram1,
            rangeDiagram2,
            rangeDiagram3,
            rangeDiagram4,
            const SizedBox(height: 14),

            // Prose.
            sectionTitle(
              'PLATFORM BEHAVIOUR',
              'TalkBack, VoiceOver, NVDA realisations',
              Icons.menu_book_outlined,
              inkMidnight,
              cream,
            ),
            const SizedBox(height: 8),
            proseBlock,
            const SizedBox(height: 14),

            // Comparison.
            sectionTitle(
              'COMPARISON: SPELLOUT vs LOCALE',
              'Both inherit from StringAttribute',
              Icons.compare_arrows,
              olive,
              cream,
            ),
            const SizedBox(height: 8),
            cardShell(comparisonTable, olive, cream),
            const SizedBox(height: 14),

            // Code example.
            sectionTitle(
              'CODE EXAMPLE',
              'Constructing and applying SpellOutStringAttribute',
              Icons.code,
              inkDeep,
              cream,
            ),
            const SizedBox(height: 8),
            codeBlock,
            const SizedBox(height: 14),

            // Pitfalls.
            sectionTitle(
              'PITFALLS',
              'Mistakes to avoid when applying spell-out',
              Icons.warning_amber_rounded,
              cinnabar,
              cream,
            ),
            const SizedBox(height: 8),
            pitfallsBlock,
            const SizedBox(height: 14),

            // Glossary.
            sectionTitle(
              'GLOSSARY',
              'Vocabulary used by accessibility plumbing',
              Icons.menu_book,
              slate,
              cream,
            ),
            const SizedBox(height: 8),
            cardShell(glossaryTable, slate, cream),
            const SizedBox(height: 14),

            // Palette.
            sectionTitle(
              'PALETTE - PHONEME SAND',
              '19-step parchment / indigo / saffron family',
              Icons.palette_outlined,
              sandClay,
              cream,
            ),
            const SizedBox(height: 8),
            cardShell(
              Wrap(
                children: swatchTiles,
              ),
              sandClay,
              cream,
            ),
            const SizedBox(height: 14),

            // Runtime probe.
            sectionTitle(
              'RUNTIME PROBE',
              'Live values harvested from constructed attributes',
              Icons.bug_report_outlined,
              inkIndigo,
              cream,
            ),
            const SizedBox(height: 8),
            runtimeProbe,
            const SizedBox(height: 14),

            // Footer.
            footer,
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
