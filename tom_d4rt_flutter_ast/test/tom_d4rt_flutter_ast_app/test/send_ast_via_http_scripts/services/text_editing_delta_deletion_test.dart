// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// Visual deep demo: TextEditingDeltaDeletion (package:flutter/services)
// =====================================================================
//
// `TextEditingDeltaDeletion` is one of four sealed-ish concrete subclasses
// of `TextEditingDelta` that the IME (input method editor) sends to a
// Flutter app whenever a `TextInputConfiguration(enableDeltaModel: true)`
// is in force.  The four siblings are:
//
//   * `TextEditingDeltaInsertion`     — characters inserted into oldText
//   * `TextEditingDeltaDeletion`      — characters removed from oldText
//   * `TextEditingDeltaReplacement`   — a range replaced with new text
//   * `TextEditingDeltaNonTextUpdate` — selection / composing changed
//                                       but the text itself did not
//
// A `TextEditingDeltaDeletion` carries:
//   * `oldText`       — the full text *before* this delta is applied
//   * `deletedRange`  — a `TextRange(start, end)` over `oldText` whose
//                       characters disappear in the new text
//   * `selection`     — the `TextSelection` after the deletion
//   * `composing`     — the `TextRange` of the IME's composing region
//                       after the deletion (often `TextRange.empty`)
//
// `delta.apply(TextEditingValue old)` is a *pure* function: given the
// previous `TextEditingValue`, it returns the next one.  That makes it
// safe to demo without any controllers, focus nodes, or live IME — we
// can simply feed in fixtures and inspect the output.
//
// This file is a hand-written, analyzer-clean visual demo that walks
// through every aspect of the deletion delta:
//   1. Hero card  — "scissors cutting text" graphic + tag-line.
//   2. Anatomy    — labelled diagram of the four named arguments.
//   3. Sibling gallery — one card per subclass.
//   4. Six worked examples — old text with deletedRange highlighted in
//      red, new text after `apply()` in green, JSON dump of the delta.
//   5. TextRange number line.
//   6. Selection-after-delete clamping diagram.
//   7. apply() worked example — old TextEditingValue + delta = new.
//   8. Recipe — how to subscribe via TextInputConfiguration.
//   9. Pitfalls — invalid ranges, null selections, etc.
//   10. Footer.
//
// Hard rules respected:
//   * single static `dynamic build(BuildContext)` entry,
//   * `_Private`-prefixed helpers,
//   * no `.withOpacity()` (uses `withValues(alpha: ...)`),
//   * no inline `// ignore:` directives,
//   * imports `package:flutter/material.dart` and
//     `package:flutter/services.dart`,
//   * wrapped in `MaterialApp(home: Scaffold(body: SingleChildScrollView))`.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------
// Palette (kept tiny and centralised so all the visual cards agree).
// ---------------------------------------------------------------------

const Color _kBgTop = Color(0xFF101524);
const Color _kBgBot = Color(0xFF1B2238);
const Color _kCard = Color(0xFF222B44);
const Color _kCardAlt = Color(0xFF2A3556);
const Color _kInk = Color(0xFFEDEFFA);
const Color _kInkDim = Color(0xFFB6BCD4);
const Color _kAccent = Color(0xFF7CC4FF);
const Color _kRed = Color(0xFFFF6B6B);
const Color _kGreen = Color(0xFF6CD78F);
const Color _kYellow = Color(0xFFFFD46B);
const Color _kPurple = Color(0xFFB892FF);
const Color _kOrange = Color(0xFFFFA75A);
const Color _kBorder = Color(0xFF3D4A6E);

// ---------------------------------------------------------------------
// _PrivateChip — small rounded label used all over the demo.
// ---------------------------------------------------------------------

Widget _privateChip(String text,
    {Color color = _kAccent, IconData? icon, double fontSize = 12}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      border: Border.all(color: color.withValues(alpha: 0.65), width: 1),
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
            fontSize: fontSize,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateSection — card scaffolding used by every section.
// ---------------------------------------------------------------------

Widget _privateSection({
  required String number,
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: _kCard,
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.2),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 14,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
            border: Border(
              bottom:
                  BorderSide(color: accent.withValues(alpha: 0.4), width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
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
                    fontWeight: FontWeight.w700,
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
                    Text(
                      title,
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _kInkDim,
                        fontSize: 12.5,
                        height: 1.25,
                      ),
                    ),
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
// _PrivateLabelValue — two-column label/value strip used in many cards.
// ---------------------------------------------------------------------

Widget _privateLabelValue(String label, String value,
    {Color valueColor = _kAccent}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              color: _kInkDim,
              fontFamily: 'monospace',
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateScissorsHero — the hero header. We draw a stylised "scissors
// cutting text" graphic using nested boxes (no CustomPaint, no fancy
// dependencies).
// ---------------------------------------------------------------------

Widget _privateScissorsHero() {
  return Container(
    margin: EdgeInsets.fromLTRB(16, 18, 16, 6),
    padding: EdgeInsets.fromLTRB(20, 22, 20, 22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _kAccent.withValues(alpha: 0.18),
          _kRed.withValues(alpha: 0.18),
          _kPurple.withValues(alpha: 0.18),
        ],
      ),
      border: Border.all(color: _kAccent.withValues(alpha: 0.55), width: 1.5),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('package:flutter/services.dart',
                color: _kAccent, icon: Icons.layers),
            SizedBox(width: 8),
            _privateChip('IME deltas', color: _kPurple, icon: Icons.bolt),
            SizedBox(width: 8),
            _privateChip('apply() is pure',
                color: _kGreen, icon: Icons.functions),
          ],
        ),
        SizedBox(height: 14),
        Text(
          'TextEditingDeltaDeletion',
          style: TextStyle(
            color: _kInk,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'A delta sent by the IME when characters disappear from the '
          'editable region. Pure data: oldText + deletedRange + selection '
          '+ composing. Reduce with apply(value) to obtain the next '
          'TextEditingValue.',
          style: TextStyle(color: _kInkDim, fontSize: 13.5, height: 1.45),
        ),
        SizedBox(height: 18),
        // The scissors-on-text strip --------------------------------------
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: _kBgTop.withValues(alpha: 0.6),
            border:
                Border.all(color: _kBorder.withValues(alpha: 0.7), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('oldText:',
                  style: TextStyle(
                      color: _kInkDim,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              SizedBox(height: 4),
              Row(
                children: [
                  _privateCharBox('H', _kInk),
                  _privateCharBox('e', _kInk),
                  _privateCharBox('l', _kInk),
                  _privateCharBox('l', _kInk),
                  _privateCharBox('o', _kInk),
                  _privateCharBox(' ', _kInk),
                  Icon(Icons.cut, color: _kRed, size: 22),
                  _privateCharBox('W', _kRed, strike: true),
                  _privateCharBox('o', _kRed, strike: true),
                  _privateCharBox('r', _kRed, strike: true),
                  _privateCharBox('l', _kRed, strike: true),
                  _privateCharBox('d', _kRed, strike: true),
                ],
              ),
              SizedBox(height: 10),
              Text('newText (after apply):',
                  style: TextStyle(
                      color: _kInkDim,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              SizedBox(height: 4),
              Row(
                children: [
                  _privateCharBox('H', _kGreen),
                  _privateCharBox('e', _kGreen),
                  _privateCharBox('l', _kGreen),
                  _privateCharBox('l', _kGreen),
                  _privateCharBox('o', _kGreen),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privateCharBox(String c, Color color, {bool strike = false}) {
  return Container(
    margin: EdgeInsets.only(right: 3),
    width: 22,
    height: 26,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      c.isEmpty ? ' ' : c,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: color,
        decorationThickness: 2,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateAnatomy — labelled four-field anatomy of TextEditingDeltaDeletion.
// ---------------------------------------------------------------------

Widget _privateAnatomy() {
  Widget field(String name, String type, String desc, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _privateChip(name, color: color, fontSize: 11),
              SizedBox(width: 6),
              _privateChip(type, color: _kInkDim, fontSize: 10.5),
            ],
          ),
          SizedBox(height: 6),
          Text(desc,
              style: TextStyle(color: _kInk, fontSize: 12.5, height: 1.4)),
        ],
      ),
    );
  }

  return _privateSection(
    number: '01',
    title: 'Anatomy of TextEditingDeltaDeletion',
    subtitle: 'Four named arguments — all required, all immutable.',
    accent: _kAccent,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        field(
          'oldText',
          'String',
          'The full text *before* the deletion. Always required so the '
              'delta is self-contained — receivers do not need to remember '
              'the previous TextEditingValue to interpret it.',
          _kAccent,
        ),
        field(
          'deletedRange',
          'TextRange',
          'A half-open range [start, end) over oldText. Characters inside '
              'the range disappear in the new text. Must satisfy '
              '0 <= start <= end <= oldText.length.',
          _kRed,
        ),
        field(
          'selection',
          'TextSelection',
          'The selection *after* the deletion. The IME tells you exactly '
              'where the caret should land — usually a collapsed selection '
              'at deletedRange.start, but it can be any valid selection.',
          _kPurple,
        ),
        field(
          'composing',
          'TextRange',
          'The composing region after the deletion. Often TextRange.empty '
              'because deleting typically commits or cancels composition.',
          _kYellow,
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kBgTop.withValues(alpha: 0.6),
            border: Border.all(color: _kBorder, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'TextEditingDeltaDeletion(\n'
            '  oldText:      \'Hello World\',\n'
            '  deletedRange: TextRange(start: 5, end: 11),\n'
            '  selection:    TextSelection.collapsed(offset: 5),\n'
            '  composing:    TextRange.empty,\n'
            ')',
            style: TextStyle(
              color: _kGreen,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateSiblingCard — one card per concrete TextEditingDelta subclass.
// ---------------------------------------------------------------------

Widget _privateSiblingCard({
  required String name,
  required String tag,
  required Color color,
  required IconData icon,
  required String summary,
  required String example,
}) {
  return Container(
    margin: EdgeInsets.all(6),
    padding: EdgeInsets.all(12),
    width: 320,
    decoration: BoxDecoration(
      color: _kCardAlt,
      border: Border.all(color: color.withValues(alpha: 0.65), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.22),
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            _privateChip(tag, color: color, fontSize: 10.5),
          ],
        ),
        SizedBox(height: 8),
        Text(summary,
            style: TextStyle(color: _kInk, fontSize: 12.5, height: 1.4)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kBgTop.withValues(alpha: 0.7),
            border:
                Border.all(color: _kBorder.withValues(alpha: 0.7), width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            example,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _privateSiblingGallery() {
  return _privateSection(
    number: '02',
    title: 'Sibling delta gallery',
    subtitle: 'All four concrete TextEditingDelta subclasses, side-by-side.',
    accent: _kPurple,
    body: Wrap(
      children: [
        _privateSiblingCard(
          name: 'TextEditingDeltaInsertion',
          tag: 'insert',
          color: _kGreen,
          icon: Icons.add_circle_outline,
          summary:
              'Characters appear in oldText at insertionOffset. apply() splices '
              'textInserted at insertionOffset.',
          example:
              'oldText:        "Hel"\n'
              'textInserted:   "lo"\n'
              'insertionOffset: 3\n'
              'newText:        "Hello"',
        ),
        _privateSiblingCard(
          name: 'TextEditingDeltaDeletion',
          tag: 'delete',
          color: _kRed,
          icon: Icons.remove_circle_outline,
          summary:
              'Characters disappear from oldText over deletedRange. apply() '
              'removes [start, end).',
          example:
              'oldText:      "Hello World"\n'
              'deletedRange: [5, 11)\n'
              'newText:      "Hello"',
        ),
        _privateSiblingCard(
          name: 'TextEditingDeltaReplacement',
          tag: 'replace',
          color: _kYellow,
          icon: Icons.swap_horiz,
          summary:
              'Range over oldText is replaced with replacementText. Equivalent '
              'to delete + insert as one atomic step.',
          example:
              'oldText:           "Hello World"\n'
              'replacedRange:    [6, 11)\n'
              'replacementText:   "Dart"\n'
              'newText:           "Hello Dart"',
        ),
        _privateSiblingCard(
          name: 'TextEditingDeltaNonTextUpdate',
          tag: 'meta',
          color: _kAccent,
          icon: Icons.adjust,
          summary:
              'Text did not change — only selection or composing did. apply() '
              'returns oldValue with new selection/composing.',
          example:
              'oldText:    "Hello"\n'
              'selection:  TextSelection.collapsed(offset: 2)\n'
              'composing:  TextRange.empty',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateExampleCard — worked example with old/new highlight rows
// and the JSON-ish dump of the delta.
// ---------------------------------------------------------------------

Widget _privateHighlightedRow({
  required String text,
  required int rangeStart,
  required int rangeEnd,
  required Color rangeColor,
  required Color baseColor,
  bool strike = false,
}) {
  final children = <Widget>[];
  for (var i = 0; i < text.length; i++) {
    final inRange = i >= rangeStart && i < rangeEnd;
    children.add(
      Container(
        margin: EdgeInsets.only(right: 2),
        width: 18,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: inRange
              ? rangeColor.withValues(alpha: 0.28)
              : baseColor.withValues(alpha: 0.10),
          border: Border.all(
            color: inRange
                ? rangeColor.withValues(alpha: 0.85)
                : baseColor.withValues(alpha: 0.45),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          text[i] == ' ' ? '·' : text[i],
          style: TextStyle(
            color: inRange ? rangeColor : baseColor,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            decoration: strike && inRange
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: rangeColor,
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }
  return Wrap(children: children);
}

Widget _privateIndexRuler(int len) {
  final cells = <Widget>[];
  for (var i = 0; i < len; i++) {
    cells.add(
      Container(
        margin: EdgeInsets.only(right: 2),
        width: 18,
        height: 14,
        alignment: Alignment.center,
        child: Text(
          '$i',
          style: TextStyle(
            color: _kInkDim,
            fontFamily: 'monospace',
            fontSize: 9,
          ),
        ),
      ),
    );
  }
  return Wrap(children: cells);
}

Widget _privateExampleCard({
  required String label,
  required String description,
  required TextEditingDeltaDeletion delta,
}) {
  final newValue = delta.apply(TextEditingValue(text: delta.oldText));
  final newText = newValue.text;

  String jsonDump() {
    final composing = delta.composing.isValid
        ? '[${delta.composing.start}, ${delta.composing.end})'
        : 'TextRange.empty';
    return '{\n'
        '  "type":         "TextEditingDeltaDeletion",\n'
        '  "oldText":      "${delta.oldText}",\n'
        '  "deletedRange": [${delta.deletedRange.start}, ${delta.deletedRange.end}),\n'
        '  "selection":    {base: ${delta.selection.baseOffset}, '
        'extent: ${delta.selection.extentOffset}},\n'
        '  "composing":    $composing\n'
        '}';
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kBgTop.withValues(alpha: 0.55),
      border: Border.all(color: _kBorder, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip(label, color: _kRed, icon: Icons.cut),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 12.5,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text('oldText:',
            style: TextStyle(
                color: _kInkDim, fontSize: 11, fontFamily: 'monospace')),
        SizedBox(height: 4),
        _privateIndexRuler(delta.oldText.length),
        _privateHighlightedRow(
          text: delta.oldText,
          rangeStart: delta.deletedRange.start,
          rangeEnd: delta.deletedRange.end,
          rangeColor: _kRed,
          baseColor: _kInk,
          strike: true,
        ),
        SizedBox(height: 10),
        Text('newText (after apply):',
            style: TextStyle(
                color: _kInkDim, fontSize: 11, fontFamily: 'monospace')),
        SizedBox(height: 4),
        _privateIndexRuler(newText.length == 0 ? 1 : newText.length),
        _privateHighlightedRow(
          text: newText.isEmpty ? ' ' : newText,
          rangeStart: -1,
          rangeEnd: -1,
          rangeColor: _kGreen,
          baseColor: _kGreen,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kBgBot.withValues(alpha: 0.7),
            border:
                Border.all(color: _kBorder.withValues(alpha: 0.7), width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            jsonDump(),
            style: TextStyle(
              color: _kAccent,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateExamples — six worked examples.
// ---------------------------------------------------------------------

Widget _privateExamples() {
  // Example 1: delete a single character ("backspace at end")
  final ex1 = TextEditingDeltaDeletion(
    oldText: 'flutter',
    deletedRange: TextRange(start: 6, end: 7),
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  // Example 2: delete a word
  final ex2 = TextEditingDeltaDeletion(
    oldText: 'Hello brave World',
    deletedRange: TextRange(start: 6, end: 12),
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  // Example 3: delete a line
  final ex3 = TextEditingDeltaDeletion(
    oldText: 'line one\nline two\nline three',
    deletedRange: TextRange(start: 9, end: 18),
    selection: TextSelection.collapsed(offset: 9),
    composing: TextRange.empty,
  );

  // Example 4: delete with selection moving (selection != collapsed)
  final ex4 = TextEditingDeltaDeletion(
    oldText: 'abcdefghij',
    deletedRange: TextRange(start: 2, end: 6),
    selection: TextSelection(baseOffset: 2, extentOffset: 4),
    composing: TextRange.empty,
  );

  // Example 5: delete with composing range affected
  final ex5 = TextEditingDeltaDeletion(
    oldText: 'こんにちは世界',
    deletedRange: TextRange(start: 5, end: 7),
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange(start: 0, end: 5),
  );

  // Example 6: backspace at end of text
  final ex6 = TextEditingDeltaDeletion(
    oldText: 'goodbye',
    deletedRange: TextRange(start: 6, end: 7),
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  return _privateSection(
    number: '03',
    title: 'Six worked examples',
    subtitle:
        'For each delta we show oldText (deletedRange in red), newText after '
        'apply() in green, and the JSON dump of the delta.',
    accent: _kRed,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _privateExampleCard(
          label: 'single char',
          description:
              'Delete a single character at the end of "flutter" → "flutte".',
          delta: ex1,
        ),
        _privateExampleCard(
          label: 'whole word',
          description:
              'Delete the word " brave" (with its leading space) inside a '
              'sentence.',
          delta: ex2,
        ),
        _privateExampleCard(
          label: 'whole line',
          description:
              'Delete an entire line including its trailing newline from a '
              'three-line buffer.',
          delta: ex3,
        ),
        _privateExampleCard(
          label: 'selection moves',
          description:
              'Delete characters and have the new selection be a non-collapsed '
              'TextSelection (base 2, extent 4).',
          delta: ex4,
        ),
        _privateExampleCard(
          label: 'composing affected',
          description:
              'Delete CJK characters while a composing range is still active.',
          delta: ex5,
        ),
        _privateExampleCard(
          label: 'backspace EOL',
          description:
              'Classic backspace at end-of-text removes the trailing "e".',
          delta: ex6,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateRangeNumberLine — visualisation of TextRange(start, end).
// ---------------------------------------------------------------------

Widget _privateRangeNumberLine() {
  const len = 12;
  final start = 5;
  final end = 11;
  final ticks = <Widget>[];
  for (var i = 0; i <= len; i++) {
    final inRange = i >= start && i <= end;
    ticks.add(
      SizedBox(
        width: 24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 2,
              height: 14,
              color: inRange ? _kRed : _kBorder,
            ),
            SizedBox(height: 2),
            Text(
              '$i',
              style: TextStyle(
                color: inRange ? _kRed : _kInkDim,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: inRange ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _privateSection(
    number: '04',
    title: 'TextRange(start, end) — number-line view',
    subtitle:
        'TextRange is half-open: [start, end). Indices count *between* '
        'characters, not over them.',
    accent: _kYellow,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kBgTop.withValues(alpha: 0.6),
            border: Border.all(color: _kBorder, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'For oldText = "Hello World" (length 11) with deletedRange '
                '[5, 11):',
                style: TextStyle(color: _kInkDim, fontSize: 12.5),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _privateCharSlot('H'),
                  _privateCharSlot('e'),
                  _privateCharSlot('l'),
                  _privateCharSlot('l'),
                  _privateCharSlot('o'),
                  _privateCharSlot(' '),
                  _privateCharSlot('W'),
                  _privateCharSlot('o'),
                  _privateCharSlot('r'),
                  _privateCharSlot('l'),
                  _privateCharSlot('d'),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: ticks,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _privateChip('start = 5', color: _kRed, fontSize: 11),
                  SizedBox(width: 6),
                  _privateChip('end = 11', color: _kRed, fontSize: 11),
                  SizedBox(width: 6),
                  _privateChip('chars deleted: 6',
                      color: _kInkDim, fontSize: 11),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        _privateLabelValue(
          'isCollapsed:',
          (start == end).toString(),
          valueColor: _kGreen,
        ),
        _privateLabelValue('isValid:',
            (start >= 0 && end >= start && end <= len).toString(),
            valueColor: _kGreen),
        _privateLabelValue('length:', '${end - start}', valueColor: _kAccent),
      ],
    ),
  );
}

Widget _privateCharSlot(String c) {
  return Container(
    width: 24,
    height: 26,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: _kCardAlt.withValues(alpha: 0.6),
      border: Border.all(color: _kBorder, width: 1),
    ),
    child: Text(
      c.isEmpty ? ' ' : c,
      style: TextStyle(
        color: _kInk,
        fontFamily: 'monospace',
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateSelectionClamp — diagram of how selection clamps after delete.
// ---------------------------------------------------------------------

Widget _privateSelectionClamp() {
  Widget row(String title, String oldSel, String newSel, String hint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kBgTop.withValues(alpha: 0.55),
        border: Border.all(color: _kBorder, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: _kPurple,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Row(
            children: [
              _privateChip('before: $oldSel', color: _kInkDim, fontSize: 10.5),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 14, color: _kInkDim),
              SizedBox(width: 6),
              _privateChip('after: $newSel', color: _kGreen, fontSize: 10.5),
            ],
          ),
          SizedBox(height: 6),
          Text(hint,
              style: TextStyle(color: _kInk, fontSize: 12, height: 1.35)),
        ],
      ),
    );
  }

  return _privateSection(
    number: '05',
    title: 'Selection clamping after deletion',
    subtitle:
        'When characters are removed, the IME also tells you the new selection. '
        'It is *not* derived from the old one — it is whatever the IME decided.',
    accent: _kPurple,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        row(
          'Caret was inside the deleted range',
          'collapsed @ 8',
          'collapsed @ 5',
          'Caret jumps to deletedRange.start when its previous offset would '
              'fall inside the deleted range.',
        ),
        row(
          'Caret was after the deleted range',
          'collapsed @ 11',
          'collapsed @ 5',
          'Caret offset is shifted left by (end - start). This is by far '
              'the most common case — typing then backspacing.',
        ),
        row(
          'Selection straddled the deleted range',
          'base 3 / extent 9',
          'base 3 / extent 5',
          'extentOffset is clamped to deletedRange.start; baseOffset is left '
              'alone because it sits before the cut.',
        ),
        row(
          'Caret was before the deleted range',
          'collapsed @ 2',
          'collapsed @ 2',
          'Untouched: indices before the cut never shift.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateApplyExample — calls delta.apply(TextEditingValue) and
// pretty-prints both values.
// ---------------------------------------------------------------------

Widget _privateApplyExample() {
  final oldValue = TextEditingValue(
    text: 'Hello brave World',
    selection: TextSelection.collapsed(offset: 12),
    composing: TextRange.empty,
  );
  final delta = TextEditingDeltaDeletion(
    oldText: 'Hello brave World',
    deletedRange: TextRange(start: 6, end: 12),
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );
  final newValue = delta.apply(oldValue);

  String dumpValue(TextEditingValue v) {
    return 'TextEditingValue(\n'
        '  text:      "${v.text}",\n'
        '  selection: TextSelection(base: ${v.selection.baseOffset}, '
        'extent: ${v.selection.extentOffset}),\n'
        '  composing: ${v.composing.isValid ? "[${v.composing.start}, ${v.composing.end})" : "TextRange.empty"},\n'
        ')';
  }

  Widget block(String title, String body, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: _kBgTop.withValues(alpha: 0.6),
        border: Border.all(color: color.withValues(alpha: 0.65), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _privateChip(title, color: color, fontSize: 11),
          SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  return _privateSection(
    number: '06',
    title: 'apply() — the pure reduction step',
    subtitle:
        'delta.apply(oldValue) returns the next TextEditingValue. No state, '
        'no side effects.',
    accent: _kGreen,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        block('oldValue', dumpValue(oldValue), _kAccent),
        block(
          'delta',
          'TextEditingDeltaDeletion(\n'
              '  oldText:      "${delta.oldText}",\n'
              '  deletedRange: [${delta.deletedRange.start}, ${delta.deletedRange.end}),\n'
              '  selection:    TextSelection.collapsed(offset: ${delta.selection.baseOffset}),\n'
              '  composing:    TextRange.empty,\n'
              ')',
          _kRed,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Icon(Icons.south, color: _kInkDim, size: 22),
          ),
        ),
        block('newValue (oldValue ⊕ delta)', dumpValue(newValue), _kGreen),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateRecipe — code-listing for hooking up enableDeltaModel.
// ---------------------------------------------------------------------

Widget _privateRecipe() {
  const code = '''
class MyClient implements DeltaTextInputClient {
  @override
  void updateEditingValueWithDeltas(List<TextEditingDelta> deltas) {
    var value = _value;
    for (final delta in deltas) {
      value = delta.apply(value);
      if (delta is TextEditingDeltaDeletion) {
        debugPrint('deleted [\${delta.deletedRange.start}, '
            '\${delta.deletedRange.end})');
      }
    }
    _value = value;
  }

  // ...
  TextInputConnection _open() {
    return TextInput.attach(
      this,
      TextInputConfiguration(
        enableDeltaModel: true, // <-- opt in
        inputType: TextInputType.text,
      ),
    );
  }
}
''';

  return _privateSection(
    number: '07',
    title: 'Recipe — opting into the delta model',
    subtitle:
        'Set enableDeltaModel: true on TextInputConfiguration and implement '
        'DeltaTextInputClient.updateEditingValueWithDeltas.',
    accent: _kAccent,
    body: Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kBgTop.withValues(alpha: 0.7),
        border: Border.all(color: _kBorder, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: TextStyle(
          color: _kInk,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivatePitfalls — common mistakes and how to avoid them.
// ---------------------------------------------------------------------

Widget _privatePitfalls() {
  Widget tile(String title, String body, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
                SizedBox(height: 4),
                Text(body,
                    style:
                        TextStyle(color: _kInk, fontSize: 12.5, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _privateSection(
    number: '08',
    title: 'Pitfalls — what can go wrong',
    subtitle: 'Constructor and apply() expectations you should not violate.',
    accent: _kOrange,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        tile(
          'deletedRange must be a valid range in oldText',
          'You must satisfy 0 <= start <= end <= oldText.length. Passing '
              'TextRange(start: 5, end: 100) for an oldText of length 11 will '
              'cause apply() to throw on substring out-of-range.',
          Icons.error_outline,
          _kRed,
        ),
        tile(
          'selection must be non-null and valid',
          'TextEditingDeltaDeletion requires a TextSelection. The contract is '
              'that base/extent are within the *new* text\'s bounds — the IME '
              'is responsible for that, but if you mint a delta yourself, you '
              'must obey the same rule.',
          Icons.warning_amber,
          _kYellow,
        ),
        tile(
          'composing is also relative to newText',
          'After a deletion, composing is interpreted in the new text. '
              'TextRange.empty is the safe default if you are unsure.',
          Icons.info_outline,
          _kAccent,
        ),
        tile(
          'apply() is pure but not idempotent',
          'Calling apply() twice on the same value will try to delete the '
              'range a second time — likely producing nonsense or throwing. '
              'Each delta corresponds to exactly one transition.',
          Icons.repeat,
          _kPurple,
        ),
        tile(
          'Do not confuse offset semantics',
          'TextRange and TextSelection use offsets *between* characters '
              '(0 to length, inclusive). Index 0 is before the first char, '
              'index length is after the last char.',
          Icons.straighten,
          _kGreen,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// _PrivateFooter
// ---------------------------------------------------------------------

Widget _privateFooter() {
  return Container(
    margin: EdgeInsets.fromLTRB(16, 12, 16, 24),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kBgTop.withValues(alpha: 0.55),
      border: Border.all(color: _kBorder, width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag_outlined, color: _kAccent, size: 16),
            SizedBox(width: 6),
            Text(
              'Footer',
              style: TextStyle(
                color: _kAccent,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'TextEditingDeltaDeletion is the cleanest of the four delta types: '
          'it removes a contiguous range from oldText and reports the new '
          'selection and composing region. apply() is a pure function, so '
          'every transition can be modelled, replayed, undone, or fed into '
          'a CRDT without any IDE or controller in the loop.',
          style: TextStyle(color: _kInk, fontSize: 12.5, height: 1.5),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _privateChip('pure data', color: _kGreen, fontSize: 11),
            _privateChip('immutable', color: _kAccent, fontSize: 11),
            _privateChip('replay-friendly', color: _kPurple, fontSize: 11),
            _privateChip('IME-emitted', color: _kYellow, fontSize: 11),
            _privateChip('apply()', color: _kOrange, fontSize: 11),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// build — the single entry point required by D4rt's analyzer-free
// interpreter test corpus.
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextEditingDeltaDeletion deep demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBgTop,
      fontFamily: 'monospace',
    ),
    home: Scaffold(
      backgroundColor: _kBgTop,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_kBgTop, _kBgBot],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _privateScissorsHero(),
              _privateAnatomy(),
              _privateSiblingGallery(),
              _privateExamples(),
              _privateRangeNumberLine(),
              _privateSelectionClamp(),
              _privateApplyExample(),
              _privateRecipe(),
              _privatePitfalls(),
              _privateFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
