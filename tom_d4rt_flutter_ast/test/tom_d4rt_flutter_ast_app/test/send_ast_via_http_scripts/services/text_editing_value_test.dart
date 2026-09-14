// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for TextEditingValue,
// TextSelection, TextRange and the services text-input value model — a guided
// tour of how `package:flutter/services.dart` represents the moving parts of
// a text editor: the immutable value, the selection, the composing range,
// the formatters, the input type, the action button, and the keyboard
// appearance. All produced statelessly via copyWith and simple rendering.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// PALETTE — chosen to look pleasant on a dark canvas while clearly separating
// the conceptual zones: the immutable value, the selection geometry, the
// formatter pipeline and the platform configuration knobs.
// =============================================================================

const Color kCanvas = Color(0xFF0F1622);
const Color kPanel = Color(0xFF1A2333);
const Color kPanelAlt = Color(0xFF202C40);
const Color kPanelBorder = Color(0xFF2E3C55);
const Color kPanelBorderStrong = Color(0xFF425275);

const Color kAccentBlue = Color(0xFF4FB3FF);
const Color kAccentTeal = Color(0xFF26C6DA);
const Color kAccentGreen = Color(0xFF7CD992);
const Color kAccentAmber = Color(0xFFFFCB6B);
const Color kAccentPink = Color(0xFFFF7AA2);
const Color kAccentPurple = Color(0xFFB388FF);
const Color kAccentRed = Color(0xFFFF6B6B);
const Color kAccentLime = Color(0xFFCDDC39);

const Color kTextPrimary = Color(0xFFE4ECF7);
const Color kTextSecondary = Color(0xFFA8B6CB);
const Color kTextDim = Color(0xFF6F7E94);
const Color kTextFaint = Color(0xFF4F5C70);

const Color kSelectionFill = Color(0x554FB3FF);
const Color kCaretColor = Color(0xFFFFCB6B);
const Color kComposingUnderline = Color(0xFFB388FF);

// =============================================================================
// TYPOGRAPHY — keep an explicit, plain Material-compatible set of styles so
// the demo reads identically across platforms.
// =============================================================================

const TextStyle kHeroTitle = TextStyle(
  color: kTextPrimary,
  fontSize: 30,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.6,
);

const TextStyle kHeroSubtitle = TextStyle(
  color: kTextSecondary,
  fontSize: 15,
  height: 1.45,
);

const TextStyle kSectionTitle = TextStyle(
  color: kTextPrimary,
  fontSize: 22,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.4,
);

const TextStyle kSubsection = TextStyle(
  color: kTextPrimary,
  fontSize: 17,
  fontWeight: FontWeight.w700,
);

const TextStyle kCardTitle = TextStyle(
  color: kTextPrimary,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

const TextStyle kCardBody = TextStyle(
  color: kTextSecondary,
  fontSize: 13.5,
  height: 1.45,
);

const TextStyle kMono = TextStyle(
  color: kTextPrimary,
  fontSize: 13,
  fontFamily: 'monospace',
  height: 1.35,
);

const TextStyle kMonoDim = TextStyle(
  color: kTextDim,
  fontSize: 12,
  fontFamily: 'monospace',
  height: 1.35,
);

const TextStyle kLabel = TextStyle(
  color: kTextDim,
  fontSize: 11,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.2,
);

const TextStyle kPillStyle = TextStyle(
  color: kTextPrimary,
  fontSize: 11,
  fontWeight: FontWeight.w700,
);

// =============================================================================
// SMALL VISUAL BUILDING BLOCKS
// -----------------------------------------------------------------------------
// These helpers compose into the larger gallery — kept as plain top-level
// functions because the script is stateless and synchronous.
// =============================================================================

Widget kvLine(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key, style: kMonoDim),
        ),
        Expanded(
          child: Text(
            value,
            style: kMono.copyWith(color: valueColor ?? kTextPrimary),
          ),
        ),
      ],
    ),
  );
}

Widget pill(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      border: Border.all(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(label, style: kPillStyle.copyWith(color: color)),
  );
}

Widget panel({required Widget child, EdgeInsets? padding, Color? color}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color ?? kPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kPanelBorder, width: 1.0),
    ),
    child: child,
  );
}

Widget sectionHeader(String label, String title, Color accent) {
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 36,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: kLabel.copyWith(color: accent)),
            const SizedBox(height: 2),
            Text(title, style: kSectionTitle),
          ],
        ),
      ],
    ),
  );
}

Widget explanatoryCard({
  required String title,
  required String body,
  Color accent = kAccentBlue,
}) {
  return panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            Text(title, style: kSubsection),
          ],
        ),
        const SizedBox(height: 8),
        Text(body, style: kCardBody),
      ],
    ),
  );
}

// =============================================================================
// VISUAL RENDITION OF A TEXTEDITINGVALUE
// -----------------------------------------------------------------------------
// Renders one TextEditingValue as a coloured strip of glyphs, with the
// selection drawn as a fill, the caret drawn as a vertical bar, and the
// composing range drawn as a purple underline. This is not a real editor —
// it is a faithful static depiction of what an EditableText would show.
// =============================================================================

Widget renderTextValueStrip(TextEditingValue value) {
  final text = value.text;
  final sel = value.selection;
  final composing = value.composing;
  final hasValidSel = sel.isValid;
  final hasComposing = composing.isValid && !composing.isCollapsed;

  final glyphs = <Widget>[];
  // Caret-only rendering when text is empty — we still want a visible bar.
  if (text.isEmpty) {
    glyphs.add(
      Container(
        width: 2,
        height: 22,
        color: kCaretColor,
        margin: const EdgeInsets.symmetric(horizontal: 1),
      ),
    );
  }

  for (var i = 0; i < text.length; i++) {
    final ch = text[i];
    final inSelection = hasValidSel &&
        !sel.isCollapsed &&
        i >= sel.start &&
        i < sel.end;
    final inComposing =
        hasComposing && i >= composing.start && i < composing.end;
    final isCaretHere = hasValidSel && sel.isCollapsed && sel.baseOffset == i;

    final List<Widget> stacked = [];
    stacked.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
        color: inSelection ? kSelectionFill : Colors.transparent,
        child: Text(
          ch == ' ' ? '\u00B7' : ch,
          style: kMono.copyWith(
            color: ch == ' '
                ? kTextFaint
                : (inSelection ? kTextPrimary : kTextPrimary),
            fontSize: 16,
          ),
        ),
      ),
    );
    if (inComposing) {
      stacked.add(
        Positioned(
          left: 1,
          right: 1,
          bottom: 0,
          child: Container(height: 2, color: kComposingUnderline),
        ),
      );
    }

    if (isCaretHere) {
      glyphs.add(
        Container(
          width: 2,
          height: 22,
          color: kCaretColor,
          margin: const EdgeInsets.symmetric(horizontal: 1),
        ),
      );
    }

    glyphs.add(
      Stack(
        alignment: Alignment.bottomLeft,
        children: stacked,
      ),
    );
  }

  // Caret after the last glyph?
  if (hasValidSel && sel.isCollapsed && sel.baseOffset == text.length) {
    glyphs.add(
      Container(
        width: 2,
        height: 22,
        color: kCaretColor,
        margin: const EdgeInsets.symmetric(horizontal: 1),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kPanelBorderStrong, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: glyphs,
    ),
  );
}

Widget tevCard({
  required String title,
  required String description,
  required TextEditingValue value,
  required Color accent,
}) {
  final sel = value.selection;
  final composing = value.composing;
  return panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pill(title, accent),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                description,
                style: kCardBody.copyWith(fontSize: 12.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: renderTextValueStrip(value),
        ),
        const SizedBox(height: 10),
        kvLine('text', '"${value.text}"', valueColor: kAccentGreen),
        kvLine(
          'selection.base',
          '${sel.baseOffset}',
          valueColor: kAccentBlue,
        ),
        kvLine(
          'selection.extent',
          '${sel.extentOffset}',
          valueColor: kAccentBlue,
        ),
        kvLine(
          'selection.isCollapsed',
          '${sel.isCollapsed}',
          valueColor: sel.isCollapsed ? kAccentAmber : kAccentTeal,
        ),
        kvLine(
          'selection.affinity',
          '${sel.affinity}',
          valueColor: kAccentPurple,
        ),
        kvLine(
          'composing',
          composing.isValid
              ? '[${composing.start}, ${composing.end})'
              : 'TextRange.empty',
          valueColor:
              composing.isValid ? kAccentPink : kTextDim,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 — HERO INTRODUCTION
// -----------------------------------------------------------------------------
// A glossary header that explains the four central types: TextEditingValue,
// TextSelection, TextRange and TextPosition (with TextAffinity). It also
// previews the visual conventions used by every following section so the
// reader doesn't have to re-learn what colour means what.
// =============================================================================

Widget heroBanner() {
  return panel(
    color: kPanel,
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kAccentBlue.withOpacity(0.18),
                shape: BoxShape.circle,
                border: Border.all(color: kAccentBlue, width: 2),
              ),
              child: const Icon(
                Icons.text_fields,
                color: kAccentBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SERVICES · TEXT INPUT MODEL', style: kLabel),
                  const SizedBox(height: 2),
                  Text(
                    'TextEditingValue — the immutable heart of text editing',
                    style: kHeroTitle.copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Every Flutter text editor — TextField, CupertinoTextField, '
          'SelectableText, EditableText — ultimately produces a stream of '
          'TextEditingValue snapshots. Each snapshot wraps three things: the '
          'plain text the user has typed, the TextSelection describing where '
          'the caret or highlighted range lies, and the composing TextRange '
          'used for IME composition (e.g. while typing Japanese, Korean or '
          'Chinese). Together they form the canonical "what does this editor '
          'show right now?" payload.',
          style: kHeroSubtitle,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            pill('TextEditingValue', kAccentBlue),
            pill('TextSelection', kAccentTeal),
            pill('TextRange', kAccentAmber),
            pill('TextPosition', kAccentPink),
            pill('TextAffinity', kAccentPurple),
            pill('TextInputFormatter', kAccentGreen),
            pill('TextInputType', kAccentLime),
            pill('TextInputAction', kAccentRed),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kPanelAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPanelBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('VISUAL CONVENTIONS', style: kLabel),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(width: 14, height: 14, color: kSelectionFill),
                  const SizedBox(width: 8),
                  Text('selection fill', style: kMono),
                  const SizedBox(width: 18),
                  Container(width: 2, height: 14, color: kCaretColor),
                  const SizedBox(width: 8),
                  Text('caret', style: kMono),
                  const SizedBox(width: 18),
                  Container(width: 14, height: 2, color: kComposingUnderline),
                  const SizedBox(width: 8),
                  Text('composing underline', style: kMono),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — TEXTEDITINGVALUE CONSTRUCTION GALLERY
// -----------------------------------------------------------------------------
// Demonstrates: the default constructor, TextEditingValue.empty, copyWith
// (selection-only, text-only, composing-only changes), and `replaced(...)`.
// Each example renders as a card with the rendered text-strip plus the
// numeric fields of the value, so the reader can map abstract numbers onto
// where the caret and selection visibly are.
// =============================================================================

Widget tevConstructionGallery() {
  final tev1 = const TextEditingValue(
    text: 'Hello World',
    selection: TextSelection.collapsed(offset: 5),
  );

  final tevEmpty = TextEditingValue.empty;

  final tevWithSelection = const TextEditingValue(
    text: 'flutter loves dart',
    selection: TextSelection(baseOffset: 8, extentOffset: 13),
  );

  final tevComposing = const TextEditingValue(
    text: 'こんにちは',
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange(start: 0, end: 5),
  );

  final tevReversed = const TextEditingValue(
    text: 'Right-to-left selection',
    selection: TextSelection(
      baseOffset: 17,
      extentOffset: 6,
    ),
  );

  final tev1WithDart = tev1.copyWith(text: 'Hello Dart!');
  final tev1Replaced = tev1.replaced(
    const TextRange(start: 6, end: 11),
    'Flutter',
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'TextEditingValue is an immutable value',
        body:
            'You never mutate a TextEditingValue. Every change — even moving '
            'the caret by one character — produces a new instance, usually via '
            'copyWith. The constructor takes three fields: text (the buffer), '
            'selection (where the caret or range is), and composing (the IME '
            'staging area). Selection defaults to TextSelection.collapsed(offset: -1) '
            'meaning "no caret yet"; composing defaults to TextRange.empty.',
        accent: kAccentBlue,
      ),
      const SizedBox(height: 12),
      tevCard(
        title: 'CANONICAL',
        description:
            'TextEditingValue(text: "Hello World", selection: collapsed at 5).',
        value: tev1,
        accent: kAccentBlue,
      ),
      const SizedBox(height: 12),
      tevCard(
        title: 'EMPTY',
        description:
            'TextEditingValue.empty is a const sentinel: empty text, caret at '
            'offset -1 (i.e. invalid/uninitialised selection).',
        value: tevEmpty,
        accent: kTextDim,
      ),
      const SizedBox(height: 12),
      tevCard(
        title: 'RANGE',
        description:
            'A forward selection from offset 8 to 13 over "flutter loves dart" '
            'highlights the word "loves".',
        value: tevWithSelection,
        accent: kAccentTeal,
      ),
      const SizedBox(height: 12),
      tevCard(
        title: 'IME COMPOSING',
        description:
            'While the user is composing CJK input, the IME stages characters '
            'inside composing range. Rendered as a purple underline.',
        value: tevComposing,
        accent: kAccentPurple,
      ),
      const SizedBox(height: 12),
      tevCard(
        title: 'REVERSED',
        description:
            'baseOffset > extentOffset describes a backwards selection (the '
            'user dragged from right to left). start/end still normalise, but '
            'isDirectional flips to indicate this.',
        value: tevReversed,
        accent: kAccentPink,
      ),
      const SizedBox(height: 12),
      tevCard(
        title: 'copyWith(text:)',
        description:
            'Same selection geometry, different text — copyWith is the canonical '
            'way to derive a new value.',
        value: tev1WithDart,
        accent: kAccentAmber,
      ),
      const SizedBox(height: 12),
      tevCard(
        title: 'replaced(range, replacement)',
        description:
            'Replaces the substring inside the range with a replacement and '
            'returns a new TextEditingValue. Here, "World" → "Flutter".',
        value: tev1Replaced,
        accent: kAccentGreen,
      ),
    ],
  );
}

// =============================================================================
// SECTION 3 — TEXTSELECTION STATES
// -----------------------------------------------------------------------------
// Walks through every meaningful TextSelection configuration:
//   • TextSelection.collapsed
//   • TextSelection (forward range)
//   • TextSelection (reversed / right-to-left)
//   • TextSelection.fromPosition
//   • affinity downstream vs upstream
// For each, the demo prints isCollapsed, isDirectional, isNormalized, start,
// end, base, extent, and affinity. The same text body is reused so the only
// thing that differs is the selection.
// =============================================================================

Widget selectionStateRow({
  required String label,
  required String description,
  required TextSelection selection,
  required Color accent,
}) {
  const sampleText = 'Selection mechanics in Flutter';
  final tev = TextEditingValue(text: sampleText, selection: selection);
  return panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pill(label, accent),
            const SizedBox(width: 8),
            Expanded(
              child: Text(description, style: kCardBody),
            ),
          ],
        ),
        const SizedBox(height: 10),
        renderTextValueStrip(tev),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          runSpacing: 4,
          children: [
            Text('base=${selection.baseOffset}', style: kMonoDim),
            Text('extent=${selection.extentOffset}', style: kMonoDim),
            Text('start=${selection.start}', style: kMonoDim),
            Text('end=${selection.end}', style: kMonoDim),
            Text(
              'isCollapsed=${selection.isCollapsed}',
              style: kMonoDim,
            ),
            Text(
              'isDirectional=${selection.isDirectional}',
              style: kMonoDim,
            ),
            Text(
              'isNormalized=${selection.isNormalized}',
              style: kMonoDim,
            ),
            Text(
              'affinity=${selection.affinity}',
              style: kMonoDim,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget selectionStatesSection() {
  final selCollapsed = const TextSelection.collapsed(offset: 10);
  final selRange = const TextSelection(baseOffset: 10, extentOffset: 19);
  final selReversed = const TextSelection(baseOffset: 19, extentOffset: 10);
  final selFromPosition = TextSelection.fromPosition(
    const TextPosition(offset: 0),
  );
  final selFullExtent = const TextSelection(
    baseOffset: 0,
    extentOffset: 30,
  );
  final selAffinityDownstream = const TextSelection.collapsed(offset: 9);
  final selAffinityUpstream = const TextSelection.collapsed(
    offset: 9,
    affinity: TextAffinity.upstream,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'TextSelection extends TextRange',
        body:
            'Every TextSelection is also a TextRange. The selection adds two '
            'concepts on top: a directional pair (baseOffset/extentOffset where '
            'base is the anchor and extent moved with the user gesture), and an '
            'affinity that disambiguates the visual side when the caret sits at '
            'a line break. start/end always return the normalised pair.',
        accent: kAccentTeal,
      ),
      const SizedBox(height: 12),
      selectionStateRow(
        label: 'COLLAPSED',
        description:
            'A caret with no highlight. base == extent. isCollapsed=true.',
        selection: selCollapsed,
        accent: kAccentAmber,
      ),
      const SizedBox(height: 12),
      selectionStateRow(
        label: 'FORWARD RANGE',
        description:
            'Standard left-to-right drag selection. base < extent so '
            'isDirectional is false and isNormalized is true.',
        selection: selRange,
        accent: kAccentTeal,
      ),
      const SizedBox(height: 12),
      selectionStateRow(
        label: 'REVERSED RANGE',
        description:
            'User dragged backwards. base > extent therefore isDirectional=true. '
            'start/end still report the normalised pair.',
        selection: selReversed,
        accent: kAccentPink,
      ),
      const SizedBox(height: 12),
      selectionStateRow(
        label: 'FROM POSITION',
        description:
            'TextSelection.fromPosition(p) creates a collapsed selection at the '
            'given position. Used internally when the framework collapses on '
            'tap.',
        selection: selFromPosition,
        accent: kAccentBlue,
      ),
      const SizedBox(height: 12),
      selectionStateRow(
        label: 'SELECT-ALL',
        description:
            'A full-document selection: base=0, extent=text.length. This is '
            'the result of the Select All toolbar action.',
        selection: selFullExtent,
        accent: kAccentGreen,
      ),
      const SizedBox(height: 12),
      selectionStateRow(
        label: 'AFFINITY DOWNSTREAM',
        description:
            'A collapsed caret with TextAffinity.downstream — when at a soft '
            'line break, the caret is shown at the beginning of the next line.',
        selection: selAffinityDownstream,
        accent: kAccentPurple,
      ),
      const SizedBox(height: 12),
      selectionStateRow(
        label: 'AFFINITY UPSTREAM',
        description:
            'A collapsed caret with TextAffinity.upstream — at a soft line '
            'break the caret prefers the end of the previous line.',
        selection: selAffinityUpstream,
        accent: kAccentLime,
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 — TEXTRANGE TOUR
// -----------------------------------------------------------------------------
// TextRange is the simplest of the trio: just a start and an end into a
// string. Selection inherits from it; composing is also one. This section
// inspects every notable method:
//   • TextRange.empty / collapsed
//   • isValid / isCollapsed / isNormalized
//   • textBefore / textInside / textAfter
//   • equality
// =============================================================================

Widget rangeCallout({
  required String label,
  required TextRange range,
  required String sample,
  required Color accent,
  required String description,
}) {
  String safe(String s) => s.isEmpty ? '""' : '"$s"';
  return panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pill(label, accent),
            const SizedBox(width: 8),
            Expanded(child: Text(description, style: kCardBody)),
          ],
        ),
        const SizedBox(height: 8),
        kvLine('start', '${range.start}', valueColor: kAccentBlue),
        kvLine('end', '${range.end}', valueColor: kAccentBlue),
        kvLine('isValid', '${range.isValid}',
            valueColor: range.isValid ? kAccentGreen : kAccentRed),
        kvLine('isCollapsed', '${range.isCollapsed}',
            valueColor: kAccentAmber),
        kvLine('isNormalized', '${range.isNormalized}',
            valueColor: kAccentTeal),
        if (range.isValid) ...[
          kvLine(
            'textBefore',
            safe(range.textBefore(sample)),
            valueColor: kAccentPurple,
          ),
          kvLine(
            'textInside',
            safe(range.textInside(sample)),
            valueColor: kAccentPink,
          ),
          kvLine(
            'textAfter',
            safe(range.textAfter(sample)),
            valueColor: kAccentGreen,
          ),
        ],
      ],
    ),
  );
}

Widget textRangeTourSection() {
  const sample = 'The quick brown fox';
  final r1 = const TextRange(start: 4, end: 9); // "quick"
  final r2 = const TextRange(start: 10, end: 15); // "brown"
  final r3 = const TextRange.collapsed(7);
  final r4 = TextRange.empty;
  final r5 = const TextRange(start: 16, end: 19); // "fox"
  final r6 = const TextRange(start: 0, end: 19); // whole string
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'TextRange — the simplest piece of the model',
        body:
            'TextRange has two integer fields, start and end. A range is valid '
            'iff both are >= 0. It is collapsed iff start == end. It is '
            'normalized iff start <= end (selections may break this rule when '
            'reversed). TextRange has textBefore/textInside/textAfter helpers '
            'for slicing the underlying text.',
        accent: kAccentAmber,
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 320,
            child: rangeCallout(
              label: '[4, 9)',
              range: r1,
              sample: sample,
              accent: kAccentBlue,
              description: 'Selects "quick" inside "$sample".',
            ),
          ),
          SizedBox(
            width: 320,
            child: rangeCallout(
              label: '[10, 15)',
              range: r2,
              sample: sample,
              accent: kAccentTeal,
              description: 'Selects "brown" inside "$sample".',
            ),
          ),
          SizedBox(
            width: 320,
            child: rangeCallout(
              label: 'COLLAPSED(7)',
              range: r3,
              sample: sample,
              accent: kAccentPurple,
              description:
                  'A collapsed range — both ends equal. textInside is empty.',
            ),
          ),
          SizedBox(
            width: 320,
            child: rangeCallout(
              label: 'EMPTY',
              range: r4,
              sample: sample,
              accent: kAccentRed,
              description:
                  'TextRange.empty has start=-1 and end=-1 and is invalid.',
            ),
          ),
          SizedBox(
            width: 320,
            child: rangeCallout(
              label: '[16, 19)',
              range: r5,
              sample: sample,
              accent: kAccentAmber,
              description: 'Selects "fox" — the suffix of the string.',
            ),
          ),
          SizedBox(
            width: 320,
            child: rangeCallout(
              label: 'WHOLE',
              range: r6,
              sample: sample,
              accent: kAccentGreen,
              description:
                  'Spans the entire string — textBefore/textAfter both empty.',
            ),
          ),
        ],
      ),
    ],
  );
}

// =============================================================================
// SECTION 5 — TEXTAFFINITY AND TEXTPOSITION
// -----------------------------------------------------------------------------
// TextPosition is `offset + affinity`. The affinity matters at line boundaries
// in soft-wrapped text. We render two text positions in a soft-wrap example
// and explain why a single offset can correspond to two visual locations.
// =============================================================================

Widget affinityShowcase() {
  final pos1 = const TextPosition(offset: 0);
  final pos2 = const TextPosition(offset: 5, affinity: TextAffinity.upstream);
  final pos3 = const TextPosition(offset: 5);
  final pos4 = const TextPosition(offset: 11);

  Widget posLine(TextPosition p, String tag) {
    return panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              pill(tag, kAccentPurple),
              const SizedBox(width: 8),
              Text('TextPosition', style: kCardTitle),
            ],
          ),
          const SizedBox(height: 8),
          kvLine('offset', '${p.offset}', valueColor: kAccentBlue),
          kvLine('affinity', '${p.affinity}', valueColor: kAccentPurple),
          kvLine('hashCode', '${p.hashCode}', valueColor: kTextDim),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'TextPosition + TextAffinity = unambiguous caret location',
        body:
            'A character offset alone is ambiguous inside a soft-wrapped line: '
            'offset N could be the very end of visual line K, OR the very '
            'start of visual line K+1. TextAffinity.upstream means "attach to '
            'the preceding glyph" — keep the caret on line K. '
            'TextAffinity.downstream means "attach to the following glyph" — '
            'jump to line K+1. The default is downstream.',
        accent: kAccentPurple,
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(width: 240, child: posLine(pos1, 'START')),
          SizedBox(width: 240, child: posLine(pos2, 'UPSTREAM @5')),
          SizedBox(width: 240, child: posLine(pos3, 'DOWNSTREAM @5')),
          SizedBox(width: 240, child: posLine(pos4, 'END')),
        ],
      ),
      const SizedBox(height: 12),
      panel(
        color: kPanelAlt,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TextAffinity enum', style: kCardTitle),
            const SizedBox(height: 8),
            kvLine('values[0]', '${TextAffinity.values[0]}',
                valueColor: kAccentBlue),
            kvLine('values[1]', '${TextAffinity.values[1]}',
                valueColor: kAccentBlue),
            kvLine('upstream.index', '${TextAffinity.upstream.index}',
                valueColor: kAccentAmber),
            kvLine('downstream.index', '${TextAffinity.downstream.index}',
                valueColor: kAccentAmber),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 6 — TEXTINPUTFORMATTER SHOWCASE
// -----------------------------------------------------------------------------
// Renders every built-in formatter against the same input string and shows
// the resulting TextEditingValue.text. Each row is a static example: the
// input on the left, the formatter description in the middle, the result
// on the right. The TextField at the bottom of each row receives the same
// formatter set so a developer can see it apply in real life inside Material.
// =============================================================================

Widget formatterRow({
  required String label,
  required String description,
  required List<TextInputFormatter> formatters,
  required String input,
  required Color accent,
}) {
  final formatted = simulateFormat(formatters, input);
  return panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pill(label, accent),
            const SizedBox(width: 8),
            Expanded(
              child: Text(description, style: kCardBody),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('INPUT', style: kLabel),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kPanelAlt,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: kPanelBorder),
                    ),
                    child: Text(input, style: kMono),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.arrow_forward, color: accent, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('OUTPUT', style: kLabel),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: accent),
                    ),
                    child: Text(
                      formatted,
                      style: kMono.copyWith(color: accent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: formatted),
          inputFormatters: formatters,
          decoration: InputDecoration(
            isDense: true,
            labelText: label,
            labelStyle: const TextStyle(color: kTextDim, fontSize: 12),
            filled: true,
            fillColor: kPanelAlt,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPanelBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: accent),
            ),
          ),
          style: kMono,
        ),
      ],
    ),
  );
}

// Apply a list of formatters by manually invoking formatEditUpdate.
// Returns just the resulting text — this is what the editor would commit.
String simulateFormat(
  List<TextInputFormatter> formatters,
  String input,
) {
  var value = TextEditingValue(
    text: input,
    selection: TextSelection.collapsed(offset: input.length),
  );
  for (var i = 0; i < formatters.length; i++) {
    final formatter = formatters[i];
    value = formatter.formatEditUpdate(TextEditingValue.empty, value);
  }
  return value.text;
}

Widget formatterShowcase() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'TextInputFormatter — gatekeepers on every edit',
        body:
            'Formatters are pure functions of (oldValue, newValue) → '
            'TextEditingValue. The framework runs them in order on every edit '
            'before the new value reaches the controller. Two built-in '
            'formatters cover most cases: FilteringTextInputFormatter '
            '(allow/deny regexp) and LengthLimitingTextInputFormatter '
            '(maxLength + MaxLengthEnforcement strategy). Authoring custom '
            'formatters is also easy: override formatEditUpdate.',
        accent: kAccentGreen,
      ),
      const SizedBox(height: 12),
      formatterRow(
        label: 'DIGITS ONLY',
        description:
            'FilteringTextInputFormatter.digitsOnly — strips everything that '
            "isn't 0-9. Common for phone numbers, PINs, OTPs.",
        formatters: [FilteringTextInputFormatter.digitsOnly],
        input: 'phone 555-1234',
        accent: kAccentGreen,
      ),
      const SizedBox(height: 12),
      formatterRow(
        label: 'ALLOW LETTERS',
        description:
            'FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")) — keeps only '
            'ASCII letters.',
        formatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
        ],
        input: 'Hello123 World!',
        accent: kAccentBlue,
      ),
      const SizedBox(height: 12),
      formatterRow(
        label: 'DENY DIGITS',
        description:
            'FilteringTextInputFormatter.deny(RegExp("[0-9]")) — the dual of '
            'allow: anything matching the pattern is removed.',
        formatters: [
          FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
        ],
        input: 'abc 123 def 456',
        accent: kAccentPink,
      ),
      const SizedBox(height: 12),
      formatterRow(
        label: 'SINGLE LINE',
        description:
            'FilteringTextInputFormatter.singleLineFormatter — strips embedded '
            'newlines. Useful for text fields that must stay one line.',
        formatters: [FilteringTextInputFormatter.singleLineFormatter],
        input: 'line one\nline two\nline three',
        accent: kAccentTeal,
      ),
      const SizedBox(height: 12),
      formatterRow(
        label: 'LENGTH 8',
        description:
            'LengthLimitingTextInputFormatter(8) — truncates to 8 characters.',
        formatters: [LengthLimitingTextInputFormatter(8)],
        input: 'this is a long string',
        accent: kAccentAmber,
      ),
      const SizedBox(height: 12),
      formatterRow(
        label: 'LENGTH 8 + DIGITS',
        description:
            'Two stacked formatters: digits-only, THEN length-limit to 8. '
            'Order matters — the framework folds them left-to-right.',
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
        ],
        input: 'phone: +1-415-555-9876',
        accent: kAccentPurple,
      ),
      const SizedBox(height: 12),
      formatterRow(
        label: 'UPPERCASE (CUSTOM)',
        description:
            'A custom formatter built inline via TextInputFormatter.withFunction — '
            'uppercases every character before commit.',
        formatters: [
          TextInputFormatter.withFunction(
            (oldValue, newValue) => newValue.copyWith(
              text: newValue.text.toUpperCase(),
            ),
          ),
        ],
        input: 'shouting at the editor',
        accent: kAccentRed,
      ),
      const SizedBox(height: 12),
      panel(
        color: kPanelAlt,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MaxLengthEnforcement enum', style: kCardTitle),
            const SizedBox(height: 8),
            kvLine('values.length', '${MaxLengthEnforcement.values.length}',
                valueColor: kAccentBlue),
            kvLine(
              'none',
              '${MaxLengthEnforcement.none}',
              valueColor: kAccentGreen,
            ),
            kvLine(
              'enforced',
              '${MaxLengthEnforcement.enforced}',
              valueColor: kAccentTeal,
            ),
            kvLine(
              'truncateAfterCompositionEnds',
              '${MaxLengthEnforcement.truncateAfterCompositionEnds}',
              valueColor: kAccentAmber,
            ),
            const SizedBox(height: 8),
            Text(
              'Used by LengthLimitingTextInputFormatter to decide what to do '
              'with characters typed past the limit. enforced trims on every '
              'edit; truncateAfterCompositionEnds is necessary for IME so the '
              'staged composition is not cut mid-character.',
              style: kCardBody.copyWith(fontSize: 12.5),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 7 — TEXTINPUTTYPE / TEXTINPUTACTION REFERENCE CARD
// -----------------------------------------------------------------------------
// Two enums-ish classes used to configure how the OS keyboard appears.
//   • TextInputType decides the keyboard layout (text, number, phone, email…)
//   • TextInputAction decides the label on the return key (done, send, next…)
// We render a tabular reference card and a small fake-keyboard preview for
// the most common cases.
// =============================================================================

Widget typeAndActionReference() {
  final inputTypes = <_TypeRow>[
    _TypeRow(
      type: TextInputType.text,
      caption: 'Default alphanumeric keyboard. Layout is unspecified.',
      accent: kAccentBlue,
    ),
    _TypeRow(
      type: TextInputType.multiline,
      caption: 'Adds a return key for new lines.',
      accent: kAccentTeal,
    ),
    _TypeRow(
      type: TextInputType.number,
      caption: 'Number pad. Use options for signed/decimal.',
      accent: kAccentAmber,
    ),
    _TypeRow(
      type: const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      caption: 'Number with sign and decimal point.',
      accent: kAccentPurple,
    ),
    _TypeRow(
      type: TextInputType.phone,
      caption: 'Telephone keypad with +, *, # keys.',
      accent: kAccentPink,
    ),
    _TypeRow(
      type: TextInputType.emailAddress,
      caption: 'Optimised for email — @ and . are prominent.',
      accent: kAccentGreen,
    ),
    _TypeRow(
      type: TextInputType.url,
      caption: 'Optimised for URL entry — / and . are prominent.',
      accent: kAccentRed,
    ),
    _TypeRow(
      type: TextInputType.datetime,
      caption: 'Number-like keyboard for date-time entry.',
      accent: kAccentLime,
    ),
    _TypeRow(
      type: TextInputType.visiblePassword,
      caption: 'Like text but discourages auto-correct/dictionary.',
      accent: kAccentBlue,
    ),
    _TypeRow(
      type: TextInputType.name,
      caption: 'Hints "person name". Triggers capitalisation help on iOS.',
      accent: kAccentTeal,
    ),
    _TypeRow(
      type: TextInputType.streetAddress,
      caption: 'Hints "postal address" for auto-fill.',
      accent: kAccentAmber,
    ),
    _TypeRow(
      type: TextInputType.none,
      caption: 'Suppresses the on-screen keyboard entirely.',
      accent: kAccentPurple,
    ),
  ];

  final actions = <_ActionRow>[
    _ActionRow(
      action: TextInputAction.none,
      glyph: '·',
      caption: 'Use the platform default.',
      accent: kAccentBlue,
    ),
    _ActionRow(
      action: TextInputAction.done,
      glyph: '✓',
      caption: 'Closes the keyboard. Conceptually "finished".',
      accent: kAccentGreen,
    ),
    _ActionRow(
      action: TextInputAction.go,
      glyph: '→',
      caption: 'Submits and navigates.',
      accent: kAccentTeal,
    ),
    _ActionRow(
      action: TextInputAction.search,
      glyph: '⌕',
      caption: 'Triggers a search action.',
      accent: kAccentAmber,
    ),
    _ActionRow(
      action: TextInputAction.send,
      glyph: '➤',
      caption: 'Sends a message — e.g. chat compose box.',
      accent: kAccentPink,
    ),
    _ActionRow(
      action: TextInputAction.next,
      glyph: '⇥',
      caption: 'Advances focus to the next field.',
      accent: kAccentPurple,
    ),
    _ActionRow(
      action: TextInputAction.previous,
      glyph: '⇤',
      caption: 'Moves focus to the previous field.',
      accent: kAccentLime,
    ),
    _ActionRow(
      action: TextInputAction.continueAction,
      glyph: '»',
      caption: 'iOS-style "continue" button.',
      accent: kAccentBlue,
    ),
    _ActionRow(
      action: TextInputAction.join,
      glyph: '⏎',
      caption: 'Joins a network (Wi-Fi style).',
      accent: kAccentTeal,
    ),
    _ActionRow(
      action: TextInputAction.route,
      glyph: '↦',
      caption: 'iOS routing action.',
      accent: kAccentAmber,
    ),
    _ActionRow(
      action: TextInputAction.emergencyCall,
      glyph: '!',
      caption: 'iOS emergency call action.',
      accent: kAccentRed,
    ),
    _ActionRow(
      action: TextInputAction.newline,
      glyph: '↵',
      caption: 'Inserts a newline into the editor.',
      accent: kAccentGreen,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'TextInputType — what kind of keyboard?',
        body:
            'A TextInputType is a hint sent to the platform IME requesting a '
            'specific keyboard layout. It is not enforced by Flutter — a '
            'TextInputType.number field can still receive non-numeric text '
            'pasted from the clipboard. Use a FilteringTextInputFormatter for '
            'enforcement.',
        accent: kAccentBlue,
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (var i = 0; i < inputTypes.length; i++)
            SizedBox(width: 280, child: inputTypes[i].render())
        ],
      ),
      const SizedBox(height: 24),
      explanatoryCard(
        title: 'TextInputAction — the return key label',
        body:
            'TextInputAction controls the visible label of the keyboard\'s '
            'return key, and is delivered to your onSubmitted callback as a '
            'semantic intent. The actual rendering is platform-controlled.',
        accent: kAccentAmber,
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (var i = 0; i < actions.length; i++)
            SizedBox(width: 240, child: actions[i].render())
        ],
      ),
    ],
  );
}

class _TypeRow {
  _TypeRow({required this.type, required this.caption, required this.accent});

  final TextInputType type;
  final String caption;
  final Color accent;

  Widget render() {
    return panel(
      color: kPanelAlt,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill(type.toJson()['name'].toString(), accent),
          const SizedBox(height: 8),
          Text(caption, style: kCardBody.copyWith(fontSize: 12.5)),
          const SizedBox(height: 6),
          Text(
            'toString: ${type.toString()}',
            style: kMonoDim,
          ),
        ],
      ),
    );
  }
}

class _ActionRow {
  _ActionRow({
    required this.action,
    required this.glyph,
    required this.caption,
    required this.accent,
  });

  final TextInputAction action;
  final String glyph;
  final String caption;
  final Color accent;

  Widget render() {
    return panel(
      color: kPanelAlt,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent),
            ),
            child: Text(
              glyph,
              style: TextStyle(
                color: accent,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action.toString().split('.').last,
                  style: kCardTitle.copyWith(fontSize: 13.5),
                ),
                const SizedBox(height: 2),
                Text(caption, style: kCardBody.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — TEXTCAPITALIZATION + KEYBOARD BRIGHTNESS
// -----------------------------------------------------------------------------
// Two smaller knobs of TextInputConfiguration that still affect the UX:
//   • TextCapitalization (none / words / sentences / characters)
//   • Brightness (light / dark) — controls the keyboard's own appearance
// =============================================================================

Widget capitalizationAndBrightness() {
  String demoString(TextCapitalization c) {
    const sample = 'flutter is fun. dart is too.';
    switch (c) {
      case TextCapitalization.none:
        return sample;
      case TextCapitalization.words:
        final words = sample.split(' ');
        final out = <String>[];
        for (var i = 0; i < words.length; i++) {
          final w = words[i];
          if (w.isEmpty) {
            out.add(w);
          } else {
            out.add('${w[0].toUpperCase()}${w.substring(1)}');
          }
        }
        return out.join(' ');
      case TextCapitalization.sentences:
        final parts = sample.split('. ');
        final out = <String>[];
        for (var i = 0; i < parts.length; i++) {
          final p = parts[i];
          if (p.isEmpty) {
            out.add(p);
          } else {
            out.add('${p[0].toUpperCase()}${p.substring(1)}');
          }
        }
        return out.join('. ');
      case TextCapitalization.characters:
        return sample.toUpperCase();
    }
  }

  Widget capCard(TextCapitalization c, Color accent, String body) {
    final label = c.toString().split('.').last.toUpperCase();
    return panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              pill(label, accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(body, style: kCardBody.copyWith(fontSize: 12.5)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPanelAlt,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: kPanelBorder),
            ),
            child: Text(demoString(c), style: kMono),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: demoString(c)),
            textCapitalization: c,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: kPanelAlt,
              border: const OutlineInputBorder(),
              labelText: 'textCapitalization: $label',
              labelStyle: const TextStyle(color: kTextDim, fontSize: 12),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kPanelBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: accent),
              ),
            ),
            style: kMono,
          ),
        ],
      ),
    );
  }

  Widget brightnessCard(Brightness b, Color accent) {
    final isDark = b == Brightness.dark;
    return panel(
      color: isDark ? const Color(0xFF0A0F1A) : const Color(0xFFE9ECF1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              pill(b.toString().split('.').last.toUpperCase(), accent),
              const SizedBox(width: 8),
              Text(
                'keyboardAppearance',
                style: kCardTitle.copyWith(
                  color: isDark ? kTextPrimary : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isDark
                ? 'iOS shows a dark keyboard skin. The bar above is also dark.'
                : 'iOS shows a light keyboard skin. The bar above is also light.',
            style: kCardBody.copyWith(
              color: isDark ? kTextSecondary : Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          // A mocked keyboard preview (rows of dummy keys).
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF161A22)
                  : const Color(0xFFFBFCFE),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF273140)
                    : const Color(0xFFD0D5DD),
              ),
            ),
            child: Column(
              children: [
                _keyboardRow('qwertyuiop'.split(''), isDark),
                const SizedBox(height: 4),
                _keyboardRow('asdfghjkl'.split(''), isDark),
                const SizedBox(height: 4),
                _keyboardRow('zxcvbnm'.split(''), isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'TextCapitalization — auto-capitalisation hints',
        body:
            'TextCapitalization is a hint to the IME on how to capitalise '
            'characters as they are typed. The framework does NOT enforce it. '
            'The actual behaviour is OS-dependent (e.g. iOS auto-shift, '
            'Android predictive caps).',
        accent: kAccentTeal,
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 360,
            child: capCard(
              TextCapitalization.none,
              kAccentBlue,
              'No auto-capitalisation. Useful for usernames or passwords.',
            ),
          ),
          SizedBox(
            width: 360,
            child: capCard(
              TextCapitalization.words,
              kAccentTeal,
              'Capitalise the first character of each word.',
            ),
          ),
          SizedBox(
            width: 360,
            child: capCard(
              TextCapitalization.sentences,
              kAccentAmber,
              'Capitalise the first character of each sentence.',
            ),
          ),
          SizedBox(
            width: 360,
            child: capCard(
              TextCapitalization.characters,
              kAccentPink,
              'Capitalise every character (caps-lock style).',
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),
      explanatoryCard(
        title: 'Brightness — keyboard skin',
        body:
            'The keyboardAppearance property on TextField is a Brightness used '
            'to hint the OS keyboard to render in light or dark mode. It does '
            'NOT affect the field itself — only the keyboard popup above it. '
            'It is most visible on iOS.',
        accent: kAccentPurple,
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(child: brightnessCard(Brightness.light, kAccentAmber)),
          const SizedBox(width: 12),
          Expanded(child: brightnessCard(Brightness.dark, kAccentBlue)),
        ],
      ),
    ],
  );
}

Widget _keyboardRow(List<String> keys, bool isDark) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (var i = 0; i < keys.length; i++) ...[
        Container(
          width: 24,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF2A3346)
                : const Color(0xFFEDEFF3),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isDark
                  ? const Color(0xFF3B4660)
                  : const Color(0xFFCED3DA),
            ),
          ),
          child: Text(
            keys[i],
            style: TextStyle(
              color: isDark ? kTextPrimary : Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ],
  );
}

// =============================================================================
// SECTION 9 — FULL MOCKED EDITOR ANATOMY
// -----------------------------------------------------------------------------
// Final section assembles a realistic-looking text field with all the
// configuration we have shown: an explicit TextEditingValue, formatters,
// input type, action, capitalization and keyboard brightness — annotated by
// callouts. The field is for visual purposes only.
// =============================================================================

Widget mockedEditorAnatomy() {
  final value = const TextEditingValue(
    text: 'alice@flutter.dev',
    selection: TextSelection(baseOffset: 6, extentOffset: 13),
  );

  Widget calloutBox(String title, String detail, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.10),
        border: Border.all(color: accent.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kLabel.copyWith(color: accent)),
          const SizedBox(height: 4),
          Text(detail, style: kCardBody.copyWith(fontSize: 12.5)),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'Putting it all together',
        body:
            'A TextField is the convergence point of every type we have seen. '
            'The widget owns a TextEditingController which exposes the current '
            'TextEditingValue. The controller is passed to an EditableText, '
            'which negotiates with the TextInput service using a '
            'TextInputConfiguration carrying TextInputType, TextInputAction, '
            'TextCapitalization and keyboard Brightness. On every edit, the '
            'formatters run, the controller updates, the value flows out via '
            'onChanged.',
        accent: kAccentBlue,
      ),
      const SizedBox(height: 12),
      panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ANATOMY DIAGRAM', style: kLabel),
            const SizedBox(height: 12),
            renderTextValueStrip(value),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: value.text),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.send,
              textCapitalization: TextCapitalization.none,
              keyboardAppearance: Brightness.dark,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                LengthLimitingTextInputFormatter(64),
              ],
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'someone@example.com',
                helperText:
                    'keyboardType=email · action=send · cap=none · brightness=dark',
                helperStyle: const TextStyle(
                  color: kTextDim,
                  fontSize: 11,
                ),
                prefixIcon: const Icon(Icons.mail_outline, color: kAccentBlue),
                filled: true,
                fillColor: kPanelAlt,
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kPanelBorder),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kAccentBlue),
                ),
                labelStyle: const TextStyle(color: kTextDim),
              ),
              style: kMono,
            ),
            const SizedBox(height: 16),
            Text('FIELD CALLOUTS', style: kLabel),
            const SizedBox(height: 8),
            calloutBox(
              '1 — controller',
              'TextEditingController(text: "alice@flutter.dev"). The '
                  'TextField will keep this in sync with the OS\'s view of the '
                  'editor; what we pass here is its initial state.',
              kAccentBlue,
            ),
            calloutBox(
              '2 — selection [6, 13)',
              'baseOffset=6, extentOffset=13 — the substring "flutter" is '
                  'visually highlighted, demonstrating a forward selection.',
              kAccentTeal,
            ),
            calloutBox(
              '3 — keyboardType',
              'TextInputType.emailAddress — the OS keyboard places "@" and '
                  '"." prominently and omits the space bar (on iOS).',
              kAccentGreen,
            ),
            calloutBox(
              '4 — textInputAction',
              'TextInputAction.send — the return key is labelled "Send" and '
                  'the form expects to be submitted when pressed.',
              kAccentPink,
            ),
            calloutBox(
              '5 — textCapitalization',
              'TextCapitalization.none — email addresses are case-sensitive '
                  'in the local-part; auto-capitalisation would corrupt them.',
              kAccentAmber,
            ),
            calloutBox(
              '6 — keyboardAppearance',
              'Brightness.dark — the OS keyboard renders in a dark skin to '
                  'match this dark-themed form.',
              kAccentPurple,
            ),
            calloutBox(
              '7 — inputFormatters',
              'Two formatters: one denying whitespace, one capping at 64 '
                  'characters. They run in order on every edit.',
              kAccentRed,
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 10 — DELTA VS REPLACEMENT (BONUS)
// -----------------------------------------------------------------------------
// Compares TextEditingValue.replaced (high-level) with the lower-level "old
// value vs new value" diff that formatters see. This is the bridge between
// the value model and the formatter contract.
// =============================================================================

Widget deltaVsReplacementSection() {
  final original = const TextEditingValue(
    text: 'good morning',
    selection: TextSelection.collapsed(offset: 12),
  );
  final replaced = original.replaced(
    const TextRange(start: 5, end: 12),
    'evening',
  );
  final afterCustomFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) => newValue.copyWith(
      text: newValue.text.toUpperCase(),
    ),
  ).formatEditUpdate(original, replaced);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      explanatoryCard(
        title: 'Two ways to express change',
        body:
            'TextEditingValue.replaced(range, replacement) is the most direct '
            'expression of "swap a substring for this text". The formatter '
            'contract is more general: receive the previous TextEditingValue '
            'AND the proposed one, and return whatever value should be '
            'committed. Below we run them in series.',
        accent: kAccentLime,
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 320,
            child: tevCard(
              title: 'OLD VALUE',
              description:
                  'The starting value — "good morning", caret at the end.',
              value: original,
              accent: kAccentBlue,
            ),
          ),
          SizedBox(
            width: 320,
            child: tevCard(
              title: 'PROPOSED',
              description:
                  'After original.replaced([5,12), "evening") — "good evening".',
              value: replaced,
              accent: kAccentTeal,
            ),
          ),
          SizedBox(
            width: 320,
            child: tevCard(
              title: 'AFTER FORMATTER',
              description:
                  'A custom uppercase formatter takes (old, proposed) → '
                  '"GOOD EVENING".',
              value: afterCustomFormatter,
              accent: kAccentAmber,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      panel(
        color: kPanelAlt,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FORMATTER CONTRACT', style: kLabel),
            const SizedBox(height: 8),
            Text(
              'TextEditingValue formatEditUpdate(\n'
              '  TextEditingValue oldValue,\n'
              '  TextEditingValue newValue,\n'
              ') => newValue.copyWith(...);',
              style: kMono,
            ),
            const SizedBox(height: 8),
            Text(
              'Implementing this is enough to participate in the pipeline. '
              'The framework feeds the old value (what was committed last) and '
              'the new value (what the platform/text-buffer is proposing) and '
              'expects whatever should actually land in the controller. '
              'Returning the new value untouched is a no-op formatter.',
              style: kCardBody.copyWith(fontSize: 12.5),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// MAIN ENTRY — composes every section into a single ListView.
// -----------------------------------------------------------------------------
// Prints between sections so the test driver can attribute coverage. The
// final widget is wrapped in MaterialApp/Scaffold so it can be rendered by
// the d4rt test host.
// =============================================================================

dynamic build(BuildContext context) {
  print('TextEditingValue services demo — starting');

  print('SECTION 1: hero banner / glossary');
  final s1 = heroBanner();

  print('SECTION 2: TextEditingValue construction gallery');
  final s2 = tevConstructionGallery();

  print('SECTION 3: TextSelection states');
  final s3 = selectionStatesSection();

  print('SECTION 4: TextRange tour');
  final s4 = textRangeTourSection();

  print('SECTION 5: TextAffinity / TextPosition');
  final s5 = affinityShowcase();

  print('SECTION 6: TextInputFormatter showcase');
  final s6 = formatterShowcase();

  print('SECTION 7: TextInputType / TextInputAction reference');
  final s7 = typeAndActionReference();

  print('SECTION 8: TextCapitalization + keyboard Brightness');
  final s8 = capitalizationAndBrightness();

  print('SECTION 9: full mocked editor anatomy');
  final s9 = mockedEditorAnatomy();

  print('SECTION 10: delta vs replacement');
  final s10 = deltaVsReplacementSection();

  // ---- Sanity-check prints for the test harness ---------------------------
  final canonical = const TextEditingValue(
    text: 'Hello World',
    selection: TextSelection.collapsed(offset: 5),
  );
  print('Canonical TEV text: ${canonical.text}');
  print('Canonical TEV selection: ${canonical.selection}');
  print('Canonical TEV composing: ${canonical.composing}');

  final replacedTev = canonical.replaced(
    const TextRange(start: 6, end: 11),
    'Flutter',
  );
  print('TEV.replaced result: ${replacedTev.text}');

  final selRange = const TextSelection(baseOffset: 2, extentOffset: 7);
  print('TextSelection base=${selRange.baseOffset} extent=${selRange.extentOffset}');
  print('TextSelection isCollapsed=${selRange.isCollapsed}');
  print('TextSelection isDirectional=${selRange.isDirectional}');

  final rng = const TextRange(start: 2, end: 8);
  print('TextRange start=${rng.start} end=${rng.end}');
  print('TextRange isValid=${rng.isValid}');
  print('TextRange textInside=${rng.textInside('Hello World')}');

  print(
    'FilteringTextInputFormatter.digitsOnly = '
    '${FilteringTextInputFormatter.digitsOnly}',
  );
  print(
    'LengthLimitingTextInputFormatter(50).maxLength = '
    '${LengthLimitingTextInputFormatter(50).maxLength}',
  );

  print('TextInputType.emailAddress = ${TextInputType.emailAddress}');
  print('TextInputAction.send = ${TextInputAction.send}');
  print('TextCapitalization.sentences = ${TextCapitalization.sentences}');
  print('Brightness.dark = ${Brightness.dark}');

  print('All TextEditingValue demo sections constructed');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kCanvas,
      colorScheme: const ColorScheme.dark(
        primary: kAccentBlue,
        secondary: kAccentTeal,
        surface: kPanel,
      ),
    ),
    home: Scaffold(
      backgroundColor: kCanvas,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            s1,
            sectionHeader(
              'Section 2',
              'TextEditingValue construction gallery',
              kAccentBlue,
            ),
            s2,
            sectionHeader(
              'Section 3',
              'TextSelection — states & affinities',
              kAccentTeal,
            ),
            s3,
            sectionHeader(
              'Section 4',
              'TextRange — slicing the buffer',
              kAccentAmber,
            ),
            s4,
            sectionHeader(
              'Section 5',
              'TextAffinity & TextPosition',
              kAccentPurple,
            ),
            s5,
            sectionHeader(
              'Section 6',
              'TextInputFormatter showcase',
              kAccentGreen,
            ),
            s6,
            sectionHeader(
              'Section 7',
              'TextInputType & TextInputAction reference',
              kAccentLime,
            ),
            s7,
            sectionHeader(
              'Section 8',
              'TextCapitalization & keyboard Brightness',
              kAccentPink,
            ),
            s8,
            sectionHeader(
              'Section 9',
              'Mocked editor — full anatomy',
              kAccentRed,
            ),
            s9,
            sectionHeader(
              'Section 10',
              'Delta vs replacement (bonus)',
              kAccentLime,
            ),
            s10,
            const SizedBox(height: 32),
            Center(
              child: Text(
                'end of demo · TextEditingValue + services text-input model',
                style: kMonoDim,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
