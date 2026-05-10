// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// Visual deep demo: TextEditingDeltaReplacement
// =====================================================================
//
// `TextEditingDeltaReplacement` is one of the four concrete subclasses
// of `TextEditingDelta`, the granular IME-event records emitted by
// Flutter's text-input plugin when a `TextInputConfiguration` is
// configured with `enableDeltaModel: true`.  It captures the case where
// a contiguous slice of the previous text (the `replacedRange` of
// `oldText`) is swapped out for a brand-new string (`replacementText`).
// The most common platform sources of replacement deltas are:
//
//   * Autocorrect — typing "teh" then a space causes the IME to fire a
//     replacement of `(0,3)` with "the" (plus the trailing space as
//     either the same delta or a follow-up insertion).
//   * Suggestion bar tap — tapping a suggestion chip swaps the
//     currently composing word for the chosen suggestion.
//   * Spell-check accept — accepting a red-underlined word's correction
//     fires a replacement covering the misspelling's range.
//   * Drag-paste / drop / shortcut paste over a non-empty selection —
//     the selected range is the `replacedRange`, the clipboard payload
//     is the `replacementText`.
//   * IME composing commit — when typing a CJK / accented character,
//     the entire composing region is replaced by the committed glyphs.
//
// This file is a hand-authored, analyzer-clean visual deep dive.  It is
// rendered from a single static `dynamic build(BuildContext)` entry —
// no `runApp`, no state, no controllers, no async.  The demo is meant
// to be read top-to-bottom like a poster: hero -> anatomy -> field
// table -> IME journey -> range pillars -> apply() walkthrough ->
// comparison gallery -> composing callout -> pitfalls -> footer.
//
// Hard rules respected:
//   * Single import: `package:flutter/material.dart`.
//   * File-level analyzer ignores only; no inline `// ignore:` lines.
//   * Static layout — no `setState`, no controllers, no `Future`,
//     no `Stream`, no `Timer`, no `AnimationController`.
//   * Uses `Color.withValues(alpha: ...)` everywhere, never the
//     deprecated `Color.withOpacity()`.
//   * `dynamic build(BuildContext)` returns a `MaterialApp`.
//
// Important note about this demo: because we restrict ourselves to a
// single `package:flutter/material.dart` import, we cannot construct
// real `TextEditingDeltaReplacement` instances (those live in
// `package:flutter/services.dart`).  We instead use small private data
// holders (`_ReplacementSample`, `_FieldRow`, `_SiblingFact`) to
// describe the *shape* and *behaviour* of the real type.  Every code
// snippet rendered as monospace text inside the UI shows exactly what
// the real `TextEditingDeltaReplacement` API looks like at the source
// level.  The UI is the documentation; the data is the textbook.
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Palette — chosen specifically for "replacement" mood: a calm purple
// for the old slice, a warm tangerine for the new slice, with
// supporting blues and greens for selection / composing accents.  Kept
// centralised so every card stays visually coherent.
// ---------------------------------------------------------------------

const Color _kBgTop = Color(0xFF0F1320);
const Color _kBgBottom = Color(0xFF1A1F33);
const Color _kCard = Color(0xFF1F2540);
const Color _kCardAlt = Color(0xFF272F52);
const Color _kCardDeep = Color(0xFF161B30);
const Color _kInk = Color(0xFFEFF1FB);
const Color _kInkDim = Color(0xFFB8BED6);
const Color _kInkSoft = Color(0xFF8A91AD);
const Color _kBorder = Color(0xFF3B4670);
const Color _kBorderSoft = Color(0xFF2C355A);

const Color _kAccent = Color(0xFF7CC4FF); // primary blue accent
const Color _kOld = Color(0xFFB892FF); // lavender for old slice
const Color _kNew = Color(0xFFFFA75A); // tangerine for new slice
const Color _kSel = Color(0xFF6CD78F); // green for selection
const Color _kCmp = Color(0xFFFFD46B); // amber for composing
const Color _kWarn = Color(0xFFFF6B6B); // red for pitfalls
const Color _kCool = Color(0xFF66E1D8); // cyan for headings
const Color _kPink = Color(0xFFFF8FB1); // pink for callouts

// Precomputed translucent variants used in many places.  Computing them
// once keeps the build() body readable and avoids duplication.
const double _aFaint = 0.10;
const double _aSoft = 0.22;
const double _aMid = 0.40;
const double _aStrong = 0.65;

// ---------------------------------------------------------------------
// Typography tokens.
// ---------------------------------------------------------------------

const TextStyle _stHero = TextStyle(
  color: _kInk,
  fontSize: 32,
  fontWeight: FontWeight.w800,
  letterSpacing: -0.4,
  height: 1.05,
);

const TextStyle _stSection = TextStyle(
  color: _kInk,
  fontSize: 19,
  fontWeight: FontWeight.w700,
  letterSpacing: -0.2,
  height: 1.2,
);

const TextStyle _stSubtitle = TextStyle(
  color: _kInkDim,
  fontSize: 13,
  height: 1.45,
);

const TextStyle _stBody = TextStyle(
  color: _kInkDim,
  fontSize: 13,
  height: 1.55,
);

const TextStyle _stStrong = TextStyle(
  color: _kInk,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  height: 1.5,
);

const TextStyle _stMono = TextStyle(
  color: _kInk,
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.5,
);

const TextStyle _stMonoDim = TextStyle(
  color: _kInkDim,
  fontFamily: 'monospace',
  fontSize: 12,
  height: 1.45,
);

const TextStyle _stMonoSoft = TextStyle(
  color: _kInkSoft,
  fontFamily: 'monospace',
  fontSize: 11.5,
  height: 1.4,
);

const TextStyle _stChip = TextStyle(
  color: _kInk,
  fontFamily: 'monospace',
  fontSize: 11.5,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.3,
);

const TextStyle _stCaption = TextStyle(
  color: _kInkSoft,
  fontSize: 11.5,
  height: 1.4,
);

// ---------------------------------------------------------------------
// _ReplacementSample — pure-data record describing one IME journey we
// want to illustrate.  Each sample is rendered as a "before / arrow /
// after" strip with the replaced range highlighted in lavender and the
// inserted text highlighted in tangerine.
// ---------------------------------------------------------------------

class _ReplacementSample {
  const _ReplacementSample({
    required this.id,
    required this.title,
    required this.story,
    required this.oldText,
    required this.replacementText,
    required this.replacedStart,
    required this.replacedEnd,
    required this.selectionBase,
    required this.selectionExtent,
    required this.composingStart,
    required this.composingEnd,
    required this.icon,
  });

  final String id;
  final String title;
  final String story;
  final String oldText;
  final String replacementText;
  final int replacedStart;
  final int replacedEnd;
  final int selectionBase;
  final int selectionExtent;
  final int composingStart;
  final int composingEnd;
  final IconData icon;

  // Convenience: the slice of oldText that is being replaced.
  String get textReplaced => oldText.substring(replacedStart, replacedEnd);

  // Convenience: the new text after the replacement is applied.
  String get newText =>
      oldText.replaceRange(replacedStart, replacedEnd, replacementText);

  // Selection length (bound to the new text after applying).
  int get selectionLength => (selectionExtent - selectionBase).abs();

  // Whether the composing range is "empty" in the same sense as
  // `TextRange.empty` (i.e. start == end == -1).
  bool get composingIsEmpty => composingStart == -1 && composingEnd == -1;
}

// ---------------------------------------------------------------------
// _FieldRow — describes one row of the anatomy field table.
// ---------------------------------------------------------------------

class _FieldRow {
  const _FieldRow({
    required this.name,
    required this.type,
    required this.purpose,
    required this.example,
    required this.color,
  });

  final String name;
  final String type;
  final String purpose;
  final String example;
  final Color color;
}

// ---------------------------------------------------------------------
// _SiblingFact — one entry per sibling delta type for the gallery.
// ---------------------------------------------------------------------

class _SiblingFact {
  const _SiblingFact({
    required this.name,
    required this.tagline,
    required this.fields,
    required this.example,
    required this.icon,
    required this.color,
    required this.isThisOne,
  });

  final String name;
  final String tagline;
  final List<String> fields;
  final String example;
  final IconData icon;
  final Color color;
  final bool isThisOne;
}

// ---------------------------------------------------------------------
// Curated samples — six worked replacements covering the common IME
// scenarios that produce a `TextEditingDeltaReplacement`.
// ---------------------------------------------------------------------

const List<_ReplacementSample> _kSamples = <_ReplacementSample>[
  _ReplacementSample(
    id: 'autocorrect_teh_the',
    title: 'Autocorrect: "teh" -> "the"',
    story:
        'User types "teh" and then a space.  The IME has been tracking '
        '"teh" as a composing region; on space, autocorrect fires a '
        'replacement of (0,3) with "the".  The composing region clears '
        'because the word is now committed.',
    oldText: 'teh',
    replacementText: 'the',
    replacedStart: 0,
    replacedEnd: 3,
    selectionBase: 3,
    selectionExtent: 3,
    composingStart: -1,
    composingEnd: -1,
    icon: Icons.spellcheck,
  ),
  _ReplacementSample(
    id: 'suggestion_wld_world',
    title: 'Suggestion bar: "Hello, wld" -> "Hello, world"',
    story:
        'User has typed "Hello, wld" and the IME suggestion bar offers '
        '"world" as a correction.  Tapping the suggestion replaces the '
        'composing slice (7,10) with "world".  The cursor lands at the '
        'end of the replacement; composing clears.',
    oldText: 'Hello, wld',
    replacementText: 'world',
    replacedStart: 7,
    replacedEnd: 10,
    selectionBase: 12,
    selectionExtent: 12,
    composingStart: -1,
    composingEnd: -1,
    icon: Icons.auto_fix_high,
  ),
  _ReplacementSample(
    id: 'paste_over_selection',
    title: 'Paste over selection: "name=Alice" -> "name=Bob"',
    story:
        'User selects "Alice" (range (5,10)) and pastes "Bob".  The '
        'platform reports a replacement covering the selection; the '
        'cursor collapses to the end of the pasted text.  This is '
        'exactly how a deletion + insertion combo would behave, but '
        'the IME sends it as a single atomic replacement.',
    oldText: 'name=Alice',
    replacementText: 'Bob',
    replacedStart: 5,
    replacedEnd: 10,
    selectionBase: 8,
    selectionExtent: 8,
    composingStart: -1,
    composingEnd: -1,
    icon: Icons.content_paste,
  ),
  _ReplacementSample(
    id: 'spellcheck_helo_hello',
    title: 'Spell-check accept: "Helo" -> "Hello"',
    story:
        'User has "Helo there" with "Helo" underlined.  Long-pressing '
        'and tapping "Hello" in the spell-check menu sends a '
        'replacement of (0,4) with "Hello".  The cursor sits at the '
        'end of the corrected word.',
    oldText: 'Helo there',
    replacementText: 'Hello',
    replacedStart: 0,
    replacedEnd: 4,
    selectionBase: 5,
    selectionExtent: 5,
    composingStart: -1,
    composingEnd: -1,
    icon: Icons.fact_check,
  ),
  _ReplacementSample(
    id: 'cjk_compose_commit',
    title: 'IME compose-commit: "ni" -> "ni" (still composing)',
    story:
        'User typing pinyin "ni" sees the composing region (0,2) as '
        '"ni" with composing underline.  The IME may fire a '
        'replacement of (0,2) with "ni" purely to update the composing '
        'region or candidate list — the text content can be identical.',
    oldText: 'ni',
    replacementText: 'ni',
    replacedStart: 0,
    replacedEnd: 2,
    selectionBase: 2,
    selectionExtent: 2,
    composingStart: 0,
    composingEnd: 2,
    icon: Icons.translate,
  ),
  _ReplacementSample(
    id: 'shrink_replacement',
    title: 'Shrink: "thanksss" -> "thanks"',
    story:
        'User over-types "thanksss" then accepts the spell-check '
        'correction.  The replacement of (0,8) with "thanks" produces '
        'a strictly shorter text — replacementText.length < '
        '(replacedEnd - replacedStart).  Selection collapses at the '
        'end of the new word.',
    oldText: 'thanksss',
    replacementText: 'thanks',
    replacedStart: 0,
    replacedEnd: 8,
    selectionBase: 6,
    selectionExtent: 6,
    composingStart: -1,
    composingEnd: -1,
    icon: Icons.unfold_less,
  ),
];

// ---------------------------------------------------------------------
// Anatomy — every named field of `TextEditingDeltaReplacement`, plus
// inherited fields from `TextEditingDelta`.
// ---------------------------------------------------------------------

const List<_FieldRow> _kFields = <_FieldRow>[
  _FieldRow(
    name: 'oldText',
    type: 'String',
    purpose:
        'The full editable string before this delta is applied.  '
        'Inherited from TextEditingDelta.',
    example: '"Hello, wld"',
    color: _kInk,
  ),
  _FieldRow(
    name: 'replacementText',
    type: 'String',
    purpose:
        'The new text that takes the place of replacedRange.  May be '
        'shorter, longer, or even equal to the original slice.',
    example: '"world"',
    color: _kNew,
  ),
  _FieldRow(
    name: 'replacedRange',
    type: 'TextRange',
    purpose:
        'The slice of oldText that disappears.  start and end are '
        'UTF-16 code-unit offsets into oldText.',
    example: 'TextRange(start: 7, end: 10)',
    color: _kOld,
  ),
  _FieldRow(
    name: 'selection',
    type: 'TextSelection',
    purpose:
        'Where the cursor / selection should be in the new text after '
        'the replacement.  Inherited from TextEditingDelta.',
    example: 'TextSelection.collapsed(offset: 12)',
    color: _kSel,
  ),
  _FieldRow(
    name: 'composing',
    type: 'TextRange',
    purpose:
        'The IME composing region in the new text.  Often '
        'TextRange.empty after autocorrect / commit.',
    example: 'TextRange.empty',
    color: _kCmp,
  ),
  _FieldRow(
    name: 'textReplaced',
    type: 'String (getter)',
    purpose:
        'Convenience getter that returns the substring of oldText '
        'covered by replacedRange.',
    example: '"wld"',
    color: _kOld,
  ),
];

// ---------------------------------------------------------------------
// Sibling gallery data — four cards, one per delta subclass.
// ---------------------------------------------------------------------

const List<_SiblingFact> _kSiblings = <_SiblingFact>[
  _SiblingFact(
    name: 'TextEditingDeltaInsertion',
    tagline: 'Pure insertion at a single offset.',
    fields: <String>[
      'oldText',
      'textInserted',
      'insertionOffset',
      'selection',
      'composing',
    ],
    example: 'oldText:        "Hi"\n'
        'textInserted:   "!"\n'
        'insertionOffset: 2\n'
        'selection:       TextSelection.collapsed(offset: 3)',
    icon: Icons.add,
    color: _kSel,
    isThisOne: false,
  ),
  _SiblingFact(
    name: 'TextEditingDeltaDeletion',
    tagline: 'A slice of oldText disappears.',
    fields: <String>[
      'oldText',
      'deletedRange',
      'selection',
      'composing',
    ],
    example: 'oldText:      "Hello!"\n'
        'deletedRange: TextRange(start: 5, end: 6)\n'
        'selection:    TextSelection.collapsed(offset: 5)',
    icon: Icons.remove,
    color: _kWarn,
    isThisOne: false,
  ),
  _SiblingFact(
    name: 'TextEditingDeltaReplacement',
    tagline: 'A slice of oldText is swapped for new text.',
    fields: <String>[
      'oldText',
      'replacementText',
      'replacedRange',
      'selection',
      'composing',
    ],
    example: 'oldText:         "teh"\n'
        'replacementText: "the"\n'
        'replacedRange:   TextRange(start: 0, end: 3)\n'
        'selection:       TextSelection.collapsed(offset: 3)',
    icon: Icons.swap_horiz,
    color: _kNew,
    isThisOne: true,
  ),
  _SiblingFact(
    name: 'TextEditingDeltaNonTextUpdate',
    tagline: 'Selection and/or composing changed; text identical.',
    fields: <String>[
      'oldText',
      'selection',
      'composing',
    ],
    example: 'oldText:   "Hello"\n'
        'selection: TextSelection(baseOffset: 0, extentOffset: 5)\n'
        'composing: TextRange.empty',
    icon: Icons.swipe,
    color: _kCool,
    isThisOne: false,
  ),
];

// ---------------------------------------------------------------------
// _chip — small rounded label used as a section badge or header tag.
// ---------------------------------------------------------------------

Widget _chip(String text, {Color color = _kAccent, IconData? icon}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: _aFaint),
      border: Border.all(color: color.withValues(alpha: _aStrong), width: 1),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 13, color: color),
          SizedBox(width: 5),
        ],
        Text(
          text,
          style: TextStyle(
            color: color,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _pill — minimal coloured pill for inline labels (e.g. "OLD", "NEW").
// ---------------------------------------------------------------------

Widget _pill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: _aSoft),
      border: Border.all(color: color.withValues(alpha: _aStrong), width: 0.8),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// _section — wraps a body in a numbered titled card.  The accent colour
// drives the gradient header bar.
// ---------------------------------------------------------------------

Widget _section({
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
    decoration: BoxDecoration(
      color: _kCard,
      border: Border.all(color: accent.withValues(alpha: _aMid), width: 1.2),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 14,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
            border: Border(
              bottom: BorderSide(
                color: accent.withValues(alpha: _aMid),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.25),
                  border: Border.all(color: accent, width: 1),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: _stSection),
                    SizedBox(height: 2),
                    Text(subtitle, style: _stSubtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(16), child: body),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _hero — the top hero card.  Renders a stylised "OLD -> NEW" strip
// using two coloured boxes connected by a chevron.
// ---------------------------------------------------------------------

Widget _hero() {
  return Container(
    margin: EdgeInsets.fromLTRB(16, 18, 16, 8),
    padding: EdgeInsets.fromLTRB(22, 24, 22, 24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _kOld.withValues(alpha: 0.18),
          _kAccent.withValues(alpha: 0.12),
          _kNew.withValues(alpha: 0.18),
        ],
      ),
      border: Border.all(color: _kAccent.withValues(alpha: 0.45), width: 1.4),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _chip('package:flutter/services.dart',
                color: _kAccent, icon: Icons.layers),
            _chip('IME delta', color: _kOld, icon: Icons.bolt),
            _chip('apply() is pure', color: _kSel, icon: Icons.functions),
            _chip('opt-in: enableDeltaModel', color: _kCmp, icon: Icons.tune),
          ],
        ),
        SizedBox(height: 16),
        Text('TextEditingDeltaReplacement', style: _stHero),
        SizedBox(height: 8),
        Text(
          'A delta sent by the IME when a contiguous slice of the '
          'editable region is swapped for new text.  Pure data: '
          'oldText + replacementText + replacedRange + selection + '
          'composing.  Reduce with apply(value) to obtain the next '
          'TextEditingValue.',
          style: TextStyle(color: _kInkDim, fontSize: 13.5, height: 1.5),
        ),
        SizedBox(height: 18),
        // Visual: OLD slice -> arrow -> NEW slice ----------------------
        _heroSwapStrip(),
      ],
    ),
  );
}

Widget _heroSwapStrip() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      color: _kBgTop.withValues(alpha: 0.55),
      border: Border.all(color: _kBorder.withValues(alpha: 0.7), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          child: _heroSlice(
            label: 'OLD',
            text: 'teh',
            color: _kOld,
            sub: 'replacedRange = (0, 3)',
          ),
        ),
        SizedBox(width: 14),
        Icon(Icons.east, color: _kAccent, size: 26),
        SizedBox(width: 14),
        Expanded(
          child: _heroSlice(
            label: 'NEW',
            text: 'the',
            color: _kNew,
            sub: 'replacementText = "the"',
          ),
        ),
      ],
    ),
  );
}

Widget _heroSlice({
  required String label,
  required String text,
  required Color color,
  required String sub,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: _aFaint),
      border: Border.all(color: color.withValues(alpha: _aStrong), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pill(label, color),
        SizedBox(height: 8),
        Text(
          '"$text"',
          style: TextStyle(
            color: color,
            fontFamily: 'monospace',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(sub, style: _stMonoDim),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Anatomy section — field table.
// ---------------------------------------------------------------------

Widget _anatomyBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'TextEditingDeltaReplacement is a const class with five '
        'required constructor arguments (two of them inherited from '
        'TextEditingDelta) and one convenience getter.  Every field is '
        'final and the class itself extends Diagnosticable, which '
        'means delta.toString() prints a fully-labelled tree.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      _anatomyConstructor(),
      SizedBox(height: 16),
      _anatomyTable(),
      SizedBox(height: 16),
      _anatomyApplyBox(),
    ],
  );
}

Widget _anatomyConstructor() {
  return Container(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      color: _kCardDeep,
      border: Border.all(color: _kBorder, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _pill('SIGNATURE', _kAccent),
            SizedBox(width: 8),
            Text('lib/src/services/text_editing_delta.dart',
                style: _stMonoSoft),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'const TextEditingDeltaReplacement({\n'
          '  required String oldText,\n'
          '  required String replacementText,\n'
          '  required TextRange replacedRange,\n'
          '  required TextSelection selection,\n'
          '  required TextRange composing,\n'
          '});',
          style: _stMono,
        ),
        SizedBox(height: 8),
        Text(
          '// Inherited getter\n'
          'String get textReplaced =>\n'
          '    oldText.substring(replacedRange.start, replacedRange.end);',
          style: _stMonoDim,
        ),
      ],
    ),
  );
}

Widget _anatomyTable() {
  return Container(
    decoration: BoxDecoration(
      color: _kCardDeep,
      border: Border.all(color: _kBorder, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _anatomyHeaderRow(),
        for (int i = 0; i < _kFields.length; i++)
          _anatomyDataRow(_kFields[i], i.isOdd),
      ],
    ),
  );
}

Widget _anatomyHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kAccent.withValues(alpha: 0.12),
      border: Border(
        bottom: BorderSide(
          color: _kAccent.withValues(alpha: _aMid),
          width: 1,
        ),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(9),
        topRight: Radius.circular(9),
      ),
    ),
    child: Row(
      children: [
        SizedBox(width: 130, child: Text('field', style: _stStrong)),
        SizedBox(width: 120, child: Text('type', style: _stStrong)),
        Expanded(child: Text('purpose', style: _stStrong)),
        SizedBox(width: 200, child: Text('example', style: _stStrong)),
      ],
    ),
  );
}

Widget _anatomyDataRow(_FieldRow row, bool isAlt) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: isAlt ? _kCardAlt.withValues(alpha: 0.4) : Colors.transparent,
      border: Border(top: BorderSide(color: _kBorderSoft, width: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Row(
            children: [
              Container(
                width: 6,
                height: 18,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: row.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: Text(
                  row.name,
                  style: TextStyle(
                    color: row.color,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 120, child: Text(row.type, style: _stMonoDim)),
        Expanded(child: Text(row.purpose, style: _stBody)),
        SizedBox(width: 200, child: Text(row.example, style: _stMono)),
      ],
    ),
  );
}

Widget _anatomyApplyBox() {
  return Container(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      color: _kSel.withValues(alpha: _aFaint),
      border: Border.all(color: _kSel.withValues(alpha: _aMid), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _pill('apply()', _kSel),
            SizedBox(width: 8),
            Text(
              'TextEditingValue apply(TextEditingValue value)',
              style: TextStyle(
                color: _kSel,
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          '// Pseudo-source — the real implementation lives in\n'
          '// lib/src/services/text_editing_delta.dart.\n'
          'String newText = oldText.replaceRange(\n'
          '  replacedRange.start,\n'
          '  replacedRange.end,\n'
          '  replacementText,\n'
          ');\n'
          'return value.copyWith(\n'
          '  text:      newText,\n'
          '  selection: this.selection,\n'
          '  composing: this.composing,\n'
          ');',
          style: _stMono,
        ),
        SizedBox(height: 6),
        Text(
          'apply() is "last write wins": it ignores value.text and '
          'rebuilds the new text from oldText + replacementText + '
          'replacedRange.  This is intentional — IME deltas are '
          'authoritative, framework-side mutations between deltas are '
          'discarded.',
          style: _stCaption,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// IME journey section — six sample replacements.
// ---------------------------------------------------------------------

Widget _journeyBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'These six worked examples cover the canonical platform '
        'sources of a TextEditingDeltaReplacement.  Each card shows '
        'the oldText with the replaced slice highlighted in lavender, '
        'the replacementText in tangerine, and the resulting newText '
        'in green.  Below each strip is the JSON-shaped delta record.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      for (int i = 0; i < _kSamples.length; i++) ...[
        _sampleCard(_kSamples[i], i + 1),
        if (i < _kSamples.length - 1) SizedBox(height: 12),
      ],
    ],
  );
}

Widget _sampleCard(_ReplacementSample s, int index) {
  return Container(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    decoration: BoxDecoration(
      color: _kCardDeep,
      border: Border.all(color: _kBorder, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kNew.withValues(alpha: _aSoft),
                shape: BoxShape.circle,
                border: Border.all(
                    color: _kNew.withValues(alpha: _aStrong), width: 1),
              ),
              child: Icon(s.icon, size: 16, color: _kNew),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.title, style: _stStrong),
                  SizedBox(height: 2),
                  Text('id: ${s.id}', style: _stMonoSoft),
                ],
              ),
            ),
            _pill('#$index', _kAccent),
          ],
        ),
        SizedBox(height: 10),
        Text(s.story, style: _stBody),
        SizedBox(height: 12),
        _beforeAfterStrip(s),
        SizedBox(height: 12),
        _sampleJsonDump(s),
      ],
    ),
  );
}

Widget _beforeAfterStrip(_ReplacementSample s) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      color: _kBgTop.withValues(alpha: 0.55),
      border: Border.all(color: _kBorderSoft, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _pill('BEFORE', _kOld),
            SizedBox(width: 8),
            Text(
              'oldText (${s.oldText.length} code units)',
              style: _stMonoSoft,
            ),
          ],
        ),
        SizedBox(height: 6),
        _highlightedOldText(s),
        SizedBox(height: 14),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: _aFaint),
              border: Border.all(
                color: _kAccent.withValues(alpha: _aStrong),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.south, size: 14, color: _kAccent),
                SizedBox(width: 6),
                Text(
                  'apply()',
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            _pill('AFTER', _kSel),
            SizedBox(width: 8),
            Text(
              'newText (${s.newText.length} code units)',
              style: _stMonoSoft,
            ),
          ],
        ),
        SizedBox(height: 6),
        _highlightedNewText(s),
      ],
    ),
  );
}

Widget _highlightedOldText(_ReplacementSample s) {
  final String pre = s.oldText.substring(0, s.replacedStart);
  final String mid = s.oldText.substring(s.replacedStart, s.replacedEnd);
  final String post = s.oldText.substring(s.replacedEnd);
  return RichText(
    text: TextSpan(
      style: _stMono.copyWith(fontSize: 16),
      children: [
        TextSpan(text: pre),
        TextSpan(
          text: mid,
          style: TextStyle(
            color: _kOld,
            fontFamily: 'monospace',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            backgroundColor: _kOld.withValues(alpha: _aSoft),
          ),
        ),
        TextSpan(text: post),
      ],
    ),
  );
}

Widget _highlightedNewText(_ReplacementSample s) {
  final String pre = s.oldText.substring(0, s.replacedStart);
  final String post = s.oldText.substring(s.replacedEnd);
  return RichText(
    text: TextSpan(
      style: _stMono.copyWith(fontSize: 16),
      children: [
        TextSpan(text: pre),
        TextSpan(
          text: s.replacementText,
          style: TextStyle(
            color: _kNew,
            fontFamily: 'monospace',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            backgroundColor: _kNew.withValues(alpha: _aSoft),
          ),
        ),
        TextSpan(text: post),
      ],
    ),
  );
}

Widget _sampleJsonDump(_ReplacementSample s) {
  final String composingPart = s.composingIsEmpty
      ? '  composing:       TextRange.empty,'
      : '  composing:       TextRange(start: ${s.composingStart}, '
          'end: ${s.composingEnd}),';
  final String text = 'TextEditingDeltaReplacement(\n'
      '  oldText:         "${s.oldText}",\n'
      '  replacementText: "${s.replacementText}",\n'
      '  replacedRange:   TextRange(start: ${s.replacedStart}, '
      'end: ${s.replacedEnd}),\n'
      '  selection:       TextSelection.collapsed(offset: '
      '${s.selectionBase}),\n'
      '$composingPart\n'
      ')';
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kBgBottom.withValues(alpha: 0.6),
      border: Border.all(color: _kBorderSoft, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(text, style: _stMono),
  );
}

// ---------------------------------------------------------------------
// Range pillars section — visualises start and end as labelled
// columns over a number axis.
// ---------------------------------------------------------------------

Widget _rangeBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'A TextRange(start, end) is a half-open interval over UTF-16 '
        'code units of oldText: characters in [start, end) are the '
        'ones that disappear when the replacement is applied.  The '
        'figure below renders each sample\'s replacedRange as a '
        'lavender bar over a numbered code-unit axis.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      _rangeLegend(),
      SizedBox(height: 12),
      for (int i = 0; i < _kSamples.length; i++) ...[
        _rangePillarRow(_kSamples[i]),
        if (i < _kSamples.length - 1) SizedBox(height: 8),
      ],
      SizedBox(height: 12),
      _rangeAxisExplainer(),
    ],
  );
}

Widget _rangeLegend() {
  return Wrap(
    spacing: 12,
    runSpacing: 6,
    children: [
      _legendDot(_kOld, 'replacedRange'),
      _legendDot(_kSel, 'selection (collapsed)'),
      _legendDot(_kCmp, 'composing'),
    ],
  );
}

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color.withValues(alpha: _aSoft),
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(width: 6),
      Text(label, style: _stCaption),
    ],
  );
}

Widget _rangePillarRow(_ReplacementSample s) {
  // Build a discrete grid: one cell per code unit of oldText.
  final int n = s.oldText.length;
  final List<Widget> cells = [];
  for (int i = 0; i < n; i++) {
    final bool inRange = i >= s.replacedStart && i < s.replacedEnd;
    final bool atSel = i == s.selectionBase;
    final bool inComposing = !s.composingIsEmpty &&
        i >= s.composingStart &&
        i < s.composingEnd;
    Color bg;
    if (inRange && inComposing) {
      bg = Color.lerp(_kOld, _kCmp, 0.5)!.withValues(alpha: _aSoft);
    } else if (inRange) {
      bg = _kOld.withValues(alpha: _aSoft);
    } else if (inComposing) {
      bg = _kCmp.withValues(alpha: _aSoft);
    } else {
      bg = _kCardAlt.withValues(alpha: 0.35);
    }
    cells.add(
      Container(
        width: 22,
        height: 26,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: _kBorderSoft, width: 0.6),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          s.oldText[i],
          style: TextStyle(
            color: inRange ? _kOld : _kInk,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: inRange ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
    if (atSel) {
      cells.add(
        Container(
          width: 2,
          height: 26,
          margin: EdgeInsets.symmetric(horizontal: 1),
          color: _kSel,
        ),
      );
    }
  }
  // Code-unit indices row.
  final List<Widget> indices = [];
  for (int i = 0; i < n; i++) {
    indices.add(
      Container(
        width: 22,
        margin: EdgeInsets.symmetric(horizontal: 1),
        alignment: Alignment.center,
        child: Text('$i', style: _stMonoSoft.copyWith(fontSize: 9.5)),
      ),
    );
    if (i == s.selectionBase) {
      indices.add(SizedBox(width: 4));
    }
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
    decoration: BoxDecoration(
      color: _kCardDeep,
      border: Border.all(color: _kBorderSoft, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _pill('range', _kOld),
            Text(
              '(${s.replacedStart}, ${s.replacedEnd})',
              style: _stMono.copyWith(color: _kOld),
            ),
            _pill('caret', _kSel),
            Text(
              'offset = ${s.selectionBase}',
              style: _stMono.copyWith(color: _kSel),
            ),
            Text('"${s.oldText}"', style: _stMonoDim),
          ],
        ),
        SizedBox(height: 6),
        Wrap(children: cells),
        SizedBox(height: 2),
        Wrap(children: indices),
      ],
    ),
  );
}

Widget _rangeAxisExplainer() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kAccent.withValues(alpha: _aFaint),
      border: Border.all(color: _kAccent.withValues(alpha: _aMid), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          _pill('AXIS', _kAccent),
          SizedBox(width: 8),
          Text('How to read TextRange', style: _stStrong),
        ]),
        SizedBox(height: 6),
        Text(
          '  - start, end are UTF-16 code-unit offsets.\n'
          '  - The interval is half-open: characters at start..end-1 '
          'are replaced; the character at end is preserved.\n'
          '  - A collapsed range has start == end and replaces nothing '
          '(such a delta would be an Insertion, not a Replacement).\n'
          '  - TextRange.empty has start = end = -1 — used for the '
          'composing field when no IME composition is active.',
          style: _stMonoDim,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// apply() walkthrough — pick one canonical sample and show every
// intermediate step from oldText + delta to newText.
// ---------------------------------------------------------------------

Widget _applyBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'The apply(TextEditingValue) method is a pure function: feed '
        'it the current TextEditingValue, get the next one back.  The '
        'next four panels walk through one canonical replacement '
        'step-by-step.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      _applyStep(
        index: 1,
        title: 'Input — current TextEditingValue',
        body: 'TextEditingValue(\n'
            '  text:      "Hello, wld",\n'
            '  selection: TextSelection(\n'
            '    baseOffset:  10,\n'
            '    extentOffset: 10,\n'
            '  ),\n'
            '  composing: TextRange(start: 7, end: 10),\n'
            ')',
        accent: _kInk,
      ),
      SizedBox(height: 10),
      _applyStep(
        index: 2,
        title: 'Delta — TextEditingDeltaReplacement instance',
        body: 'TextEditingDeltaReplacement(\n'
            '  oldText:         "Hello, wld",\n'
            '  replacementText: "world",\n'
            '  replacedRange:   TextRange(start: 7, end: 10),\n'
            '  selection:       TextSelection.collapsed(offset: 12),\n'
            '  composing:       TextRange.empty,\n'
            ')',
        accent: _kNew,
      ),
      SizedBox(height: 10),
      _applyStep(
        index: 3,
        title: 'Compute — newText via String.replaceRange',
        body: 'String newText = oldText.replaceRange(\n'
            '  replacedRange.start,        // 7\n'
            '  replacedRange.end,          // 10\n'
            '  replacementText,            // "world"\n'
            ');\n'
            '// newText == "Hello, world"',
        accent: _kSel,
      ),
      SizedBox(height: 10),
      _applyStep(
        index: 4,
        title: 'Output — next TextEditingValue (via copyWith)',
        body: 'TextEditingValue(\n'
            '  text:      "Hello, world",\n'
            '  selection: TextSelection(\n'
            '    baseOffset:  12,\n'
            '    extentOffset: 12,\n'
            '  ),\n'
            '  composing: TextRange.empty,\n'
            ')',
        accent: _kCool,
      ),
      SizedBox(height: 14),
      _applyAssertions(),
    ],
  );
}

Widget _applyStep({
  required int index,
  required String title,
  required String body,
  required Color accent,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(14, 10, 14, 12),
    decoration: BoxDecoration(
      color: _kCardDeep,
      border: Border.all(color: accent.withValues(alpha: _aMid), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: _aSoft),
                shape: BoxShape.circle,
                border: Border.all(color: accent, width: 1),
              ),
              child: Text(
                '$index',
                style: TextStyle(
                  color: accent,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: _stStrong.copyWith(color: accent),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(body, style: _stMono),
      ],
    ),
  );
}

Widget _applyAssertions() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kCmp.withValues(alpha: _aFaint),
      border: Border.all(color: _kCmp.withValues(alpha: _aMid), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          _pill('asserts', _kCmp),
          SizedBox(width: 8),
          Expanded(
            child: Text('Debug-mode invariants checked by apply()',
                style: _stStrong),
          ),
        ]),
        SizedBox(height: 8),
        Text(
          '  - replacedRange must be valid against oldText (start/end '
          'within [0, oldText.length]).\n'
          '  - selection must be valid against the freshly computed '
          'newText.\n'
          '  - composing must be valid against newText (or be '
          'TextRange.empty).\n'
          '\n'
          'In release mode these assertions are stripped, but the '
          'underlying computation still produces undefined behaviour '
          'if you fabricate a delta with out-of-range offsets.',
          style: _stMonoDim,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Sibling gallery section — four cards comparing the four delta types.
// ---------------------------------------------------------------------

Widget _siblingsBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'TextEditingDeltaReplacement is one of four concrete subclasses '
        'of TextEditingDelta.  Their fields differ subtly; mixing them '
        'up is the most common bug when implementing a custom '
        'DeltaTextInputClient.  The four cards below show what each '
        'one actually carries.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      for (int i = 0; i < _kSiblings.length; i++) ...[
        _siblingCard(_kSiblings[i]),
        if (i < _kSiblings.length - 1) SizedBox(height: 10),
      ],
    ],
  );
}

Widget _siblingCard(_SiblingFact s) {
  final Color borderColor =
      s.isThisOne ? s.color : s.color.withValues(alpha: _aMid);
  return Container(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    decoration: BoxDecoration(
      color: s.isThisOne ? s.color.withValues(alpha: _aFaint) : _kCardDeep,
      border: Border.all(
        color: borderColor,
        width: s.isThisOne ? 1.6 : 1,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: s.color.withValues(alpha: _aSoft),
                shape: BoxShape.circle,
                border: Border.all(
                  color: s.color.withValues(alpha: _aStrong),
                  width: 1,
                ),
              ),
              child: Icon(s.icon, size: 16, color: s.color),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.name,
                    style: TextStyle(
                      color: s.color,
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(s.tagline, style: _stCaption),
                ],
              ),
            ),
            if (s.isThisOne) _pill('THIS', s.color),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final String f in s.fields) _chip(f, color: s.color),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _kBgBottom.withValues(alpha: 0.65),
            border: Border.all(color: _kBorderSoft, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(s.example, style: _stMono),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Composing callout — explains what the composing field actually means
// and how it interacts with replacement deltas.
// ---------------------------------------------------------------------

Widget _composingBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'The composing field of every TextEditingDelta is a TextRange '
        'over the *new* text describing the IME composing region.  For '
        'most replacement deltas (autocorrect, suggestion tap, '
        'paste-over-selection) it ends up as TextRange.empty because '
        'the act of replacing closes out the previous composition.  '
        'CJK / accented input is the exception: while the user is '
        'still composing a glyph, the IME may fire a replacement delta '
        'with a non-empty composing range to update the composing '
        'region itself.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _composingPanel(
              title: 'Composing.empty',
              hint: 'After autocorrect, suggestion tap, paste',
              codeBlock: 'composing == TextRange.empty\n'
                  'composing.isValid == false\n'
                  'composing.start  == -1\n'
                  'composing.end    == -1',
              color: _kSel,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _composingPanel(
              title: 'Composing live',
              hint: 'Mid-IME (e.g. typing "ni" in pinyin)',
              codeBlock: 'composing == TextRange(\n'
                  '  start: 0,\n'
                  '  end:   2,\n'
                  ')\n'
                  'composing.isValid == true',
              color: _kCmp,
            ),
          ),
        ],
      ),
      SizedBox(height: 14),
      _composingNote(),
    ],
  );
}

Widget _composingPanel({
  required String title,
  required String hint,
  required String codeBlock,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(12, 10, 12, 12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: _aFaint),
      border: Border.all(color: color.withValues(alpha: _aMid), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          _pill(title, color),
          SizedBox(width: 6),
          Expanded(child: Text(hint, style: _stCaption)),
        ]),
        SizedBox(height: 8),
        Text(codeBlock, style: _stMono),
      ],
    ),
  );
}

Widget _composingNote() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kPink.withValues(alpha: _aFaint),
      border: Border.all(color: _kPink.withValues(alpha: _aMid), width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          _pill('NOTE', _kPink),
          SizedBox(width: 8),
          Expanded(
            child: Text('Don\'t draw composing-underlines from the delta',
                style: _stStrong.copyWith(color: _kPink)),
          ),
        ]),
        SizedBox(height: 6),
        Text(
          'Treat the composing field as authoritative state — the '
          'rendered composing-underline lives on the next '
          'TextEditingValue, not on the delta object.  Render it from '
          'value.composing after apply(); do not cache the delta.',
          style: _stBody,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Pitfalls section — common bugs when handling replacement deltas.
// ---------------------------------------------------------------------

Widget _pitfallsBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'Six classic pitfalls observed in custom DeltaTextInputClient '
        'implementations.  Each one is preventable by leaning on the '
        'delta\'s pure apply() method instead of hand-rolling string '
        'edits.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      _pitfall(
        n: 1,
        title: 'Using value.text instead of delta.oldText',
        body: 'apply() rebuilds the new text from delta.oldText, not '
            'from value.text.  If you imitate apply() but pull text '
            'from your local TextEditingController, you will lose any '
            'IME-side edits made between deltas.',
      ),
      SizedBox(height: 8),
      _pitfall(
        n: 2,
        title: 'Treating Replacement as Insertion + Deletion',
        body: 'A replacement is atomic.  Splitting it into a deletion '
            'followed by an insertion can produce intermediate '
            'invalid TextEditingValues with broken selection or '
            'composing offsets.',
      ),
      SizedBox(height: 8),
      _pitfall(
        n: 3,
        title: 'Off-by-one on replacedRange.end',
        body: 'replacedRange is half-open.  oldText.substring('
            'replacedRange.start, replacedRange.end) is correct; '
            'replacedRange.end + 1 is not.  textReplaced is the safest '
            'getter to use.',
      ),
      SizedBox(height: 8),
      _pitfall(
        n: 4,
        title: 'Forgetting to copyWith composing',
        body: 'apply() returns value.copyWith(text, selection, '
            'composing).  If your custom reducer omits composing, '
            'IME state will diverge from the platform and you will '
            'see ghost composing underlines.',
      ),
      SizedBox(height: 8),
      _pitfall(
        n: 5,
        title: 'Mutating shared TextEditingValue objects',
        body: 'TextEditingValue is immutable.  apply() returns a new '
            'instance; never reach into the existing one.  The '
            'framework relies on identity-or-equality comparisons.',
      ),
      SizedBox(height: 8),
      _pitfall(
        n: 6,
        title: 'Skipping enableDeltaModel = true',
        body: 'Replacement deltas are only sent when '
            'TextInputConfiguration.enableDeltaModel is true.  '
            'Otherwise the platform sends opaque updateEditingValue '
            'calls instead, and you will never see a TextEditingDelta '
            'of any flavour.',
      ),
    ],
  );
}

Widget _pitfall({
  required int n,
  required String title,
  required String body,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(14, 10, 14, 12),
    decoration: BoxDecoration(
      color: _kWarn.withValues(alpha: _aFaint),
      border: Border.all(color: _kWarn.withValues(alpha: _aMid), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kWarn.withValues(alpha: _aSoft),
            shape: BoxShape.circle,
            border: Border.all(color: _kWarn, width: 1),
          ),
          child: Text(
            '$n',
            style: TextStyle(
              color: _kWarn,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _stStrong.copyWith(color: _kWarn)),
              SizedBox(height: 4),
              Text(body, style: _stBody),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Recipe section — show how to actually receive replacement deltas in
// a custom DeltaTextInputClient.  Illustrative source only; rendered
// as text.
// ---------------------------------------------------------------------

Widget _recipeBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'To receive replacement deltas, attach a DeltaTextInputClient '
        'to a TextInput connection with enableDeltaModel: true.  The '
        'platform will then forward every IME-side mutation as a list '
        'of TextEditingDeltas — each of which can be Insertion, '
        'Deletion, Replacement, or NonTextUpdate.',
        style: _stBody,
      ),
      SizedBox(height: 14),
      _recipeBlock(
        title: '1. Configure the input connection',
        code: 'final TextInputConnection connection = TextInput.attach(\n'
            '  myDeltaClient,\n'
            '  TextInputConfiguration(\n'
            '    inputType:         TextInputType.text,\n'
            '    enableDeltaModel:  true,   // <-- the magic switch\n'
            '    autocorrect:       true,\n'
            '    smartDashesType:   SmartDashesType.enabled,\n'
            '    smartQuotesType:   SmartQuotesType.enabled,\n'
            '  ),\n'
            ');\n'
            'connection.show();',
      ),
      SizedBox(height: 10),
      _recipeBlock(
        title: '2. Implement updateEditingValueWithDeltas',
        code: 'class _MyDeltaClient implements DeltaTextInputClient {\n'
            '  TextEditingValue _value =\n'
            '      const TextEditingValue();\n'
            '\n'
            '  @override\n'
            '  void updateEditingValueWithDeltas(\n'
            '    List<TextEditingDelta> deltas,\n'
            '  ) {\n'
            '    TextEditingValue v = _value;\n'
            '    for (final TextEditingDelta d in deltas) {\n'
            '      v = d.apply(v);\n'
            '    }\n'
            '    _value = v;\n'
            '  }\n'
            '}',
      ),
      SizedBox(height: 10),
      _recipeBlock(
        title: '3. Pattern-match on Replacement',
        code: 'for (final TextEditingDelta d in deltas) {\n'
            '  if (d is TextEditingDeltaReplacement) {\n'
            '    debugPrint(\n'
            '      "replaced \\"\${d.textReplaced}\\" "\n'
            '      "with \\"\${d.replacementText}\\" at "\n'
            '      "\${d.replacedRange}",\n'
            '    );\n'
            '  }\n'
            '  v = d.apply(v);\n'
            '}',
      ),
    ],
  );
}

Widget _recipeBlock({required String title, required String code}) {
  return Container(
    padding: EdgeInsets.fromLTRB(14, 10, 14, 12),
    decoration: BoxDecoration(
      color: _kCardDeep,
      border: Border.all(color: _kBorder, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          _pill('STEP', _kAccent),
          SizedBox(width: 8),
          Expanded(child: Text(title, style: _stStrong)),
        ]),
        SizedBox(height: 8),
        Text(code, style: _stMono),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Footer.
// ---------------------------------------------------------------------

Widget _footer() {
  return Container(
    margin: EdgeInsets.fromLTRB(16, 14, 16, 24),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: _kBgBottom,
      border: Border.all(color: _kBorderSoft, width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(Icons.bookmark_border, color: _kAccent, size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextEditingDeltaReplacement — visual deep demo',
                style: _stStrong,
              ),
              SizedBox(height: 2),
              Text(
                'See also: TextEditingDeltaInsertion, '
                'TextEditingDeltaDeletion, '
                'TextEditingDeltaNonTextUpdate, '
                'DeltaTextInputClient, TextInputConfiguration.',
                style: _stCaption,
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        _chip('end', color: _kAccent, icon: Icons.flag),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Body composer — stitches every section together inside a scroll view.
// ---------------------------------------------------------------------

Widget _body() {
  return DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_kBgTop, _kBgBottom],
      ),
    ),
    child: SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _hero(),
          _section(
            number: '1',
            title: 'Anatomy',
            subtitle:
                'Constructor, fields, types, examples, and the apply() '
                'method.',
            accent: _kAccent,
            body: _anatomyBody(),
          ),
          _section(
            number: '2',
            title: 'IME journey',
            subtitle: 'Six worked replacements — autocorrect, suggestions, '
                'paste, spell-check, IME compose, shrink.',
            accent: _kNew,
            body: _journeyBody(),
          ),
          _section(
            number: '3',
            title: 'TextRange pillars',
            subtitle: 'Every replacedRange visualised over a code-unit '
                'axis with caret markers and composing overlay.',
            accent: _kOld,
            body: _rangeBody(),
          ),
          _section(
            number: '4',
            title: 'apply() walkthrough',
            subtitle: 'Four-step reduction from TextEditingValue + delta '
                'to the next TextEditingValue.',
            accent: _kSel,
            body: _applyBody(),
          ),
          _section(
            number: '5',
            title: 'Sibling delta gallery',
            subtitle: 'How Replacement compares to Insertion, Deletion, '
                'and NonTextUpdate.',
            accent: _kCool,
            body: _siblingsBody(),
          ),
          _section(
            number: '6',
            title: 'Composing callout',
            subtitle: 'When composing is empty, when it is live, and how '
                'replacement deltas interact with it.',
            accent: _kCmp,
            body: _composingBody(),
          ),
          _section(
            number: '7',
            title: 'Pitfalls',
            subtitle: 'Six recurring bugs in custom DeltaTextInputClient '
                'implementations.',
            accent: _kWarn,
            body: _pitfallsBody(),
          ),
          _section(
            number: '8',
            title: 'Recipe — receiving deltas',
            subtitle: 'TextInputConfiguration, DeltaTextInputClient, and '
                'pattern-matching on TextEditingDeltaReplacement.',
            accent: _kPink,
            body: _recipeBody(),
          ),
          _footer(),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Entry — mandatory `dynamic build(BuildContext)` returning a
// MaterialApp.  No state, no controllers, no async.
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextEditingDeltaReplacement — visual deep demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBgTop,
      colorScheme: ColorScheme.dark(
        primary: _kAccent,
        secondary: _kNew,
        surface: _kCard,
      ),
      textTheme: TextTheme(
        bodyMedium: _stBody,
        bodyLarge: _stStrong,
        titleLarge: _stSection,
      ),
    ),
    home: Scaffold(
      backgroundColor: _kBgTop,
      body: SafeArea(child: _body()),
    ),
  );
}
