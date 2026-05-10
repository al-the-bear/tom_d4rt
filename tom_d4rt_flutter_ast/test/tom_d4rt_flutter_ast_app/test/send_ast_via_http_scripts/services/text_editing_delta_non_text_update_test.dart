// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// ============================================================================
// Visual deep demo: TextEditingDeltaNonTextUpdate
// ----------------------------------------------------------------------------
// `TextEditingDeltaNonTextUpdate` is the `TextEditingDelta` subclass for
// changes that DO NOT modify the text content but DO change the selection or
// composing range. Examples include:
//   * arrow-key cursor moves
//   * long-press cursor jumps
//   * double-tap word selection
//   * drag-extending selection
//   * IME composing-range narrowing/expanding
//
// This file is a hand-authored, analyzer-clean demonstration. It is rendered
// from a single static `dynamic build(BuildContext)` entry, with no runApp,
// state, controllers, or async work.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Theme tokens
// ---------------------------------------------------------------------------

const Color _bgPage = Color(0xFF0E1116);
const Color _bgCard = Color(0xFF161B22);
const Color _bgInner = Color(0xFF1F242C);
const Color _bgChip = Color(0xFF2A313B);
const Color _accent = Color(0xFF61AFEF);
const Color _accentWarm = Color(0xFFE5C07B);
const Color _accentGreen = Color(0xFF98C379);
const Color _accentRed = Color(0xFFE06C75);
const Color _accentMagenta = Color(0xFFC678DD);
const Color _accentCyan = Color(0xFF56B6C2);
const Color _textPrimary = Color(0xFFE6EDF3);
const Color _textSecondary = Color(0xFFB1BAC4);
const Color _textMuted = Color(0xFF8B949E);
const Color _border = Color(0xFF30363D);

const double _gapXS = 4;
const double _gapS = 8;
const double _gapM = 12;
const double _gapL = 18;
const double _gapXL = 26;
const double _gapXXL = 36;

const TextStyle _stTitle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w700,
  color: _textPrimary,
  height: 1.2,
);

const TextStyle _stSubtitle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: _textPrimary,
  height: 1.3,
);

const TextStyle _stSection = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: _accent,
  letterSpacing: 0.4,
);

const TextStyle _stBody = TextStyle(
  fontSize: 14,
  color: _textSecondary,
  height: 1.55,
);

const TextStyle _stBodyStrong = TextStyle(
  fontSize: 14,
  color: _textPrimary,
  fontWeight: FontWeight.w600,
  height: 1.55,
);

const TextStyle _stMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 13,
  color: _textPrimary,
  height: 1.55,
);

const TextStyle _stMonoMuted = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: _textMuted,
  height: 1.5,
);

const TextStyle _stChip = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: _textPrimary,
  letterSpacing: 0.6,
);

const TextStyle _stCaption = TextStyle(
  fontSize: 12,
  color: _textMuted,
  height: 1.4,
);

// ---------------------------------------------------------------------------
// Reusable widget pieces (private, lowerCamelCase functions returning Widgets)
// ---------------------------------------------------------------------------

Widget _sectionShell({
  required String label,
  required String title,
  required String summary,
  required List<Widget> children,
  Color accent = _accent,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: _gapXXL),
    padding: const EdgeInsets.all(_gapXL),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pillChip(label, accent),
            const SizedBox(width: _gapM),
            Expanded(
              child: Text(title, style: _stSection.copyWith(color: accent)),
            ),
          ],
        ),
        const SizedBox(height: _gapM),
        Text(summary, style: _stBody),
        const SizedBox(height: _gapL),
        ...children,
      ],
    ),
  );
}

Widget _pillChip(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: _gapM, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: color.withValues(alpha: 0.55)),
    ),
    child: Text(text, style: _stChip.copyWith(color: color)),
  );
}

Widget _miniBadge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.45)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _innerPanel({
  required String heading,
  required List<Widget> children,
  Color? headingColor,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: _gapL),
    padding: const EdgeInsets.all(_gapL),
    decoration: BoxDecoration(
      color: _bgInner,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          heading,
          style: _stSubtitle.copyWith(color: headingColor ?? _textPrimary),
        ),
        const SizedBox(height: _gapM),
        ...children,
      ],
    ),
  );
}

Widget _bullet(String text, {Color color = _accent}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 7, right: _gapS),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
        Expanded(child: Text(text, style: _stBody)),
      ],
    ),
  );
}

Widget _kv(String key, String value, {Color valueColor = _accentGreen}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(key, style: _stMonoMuted),
        ),
        Expanded(
          child: Text(value, style: _stMono.copyWith(color: valueColor)),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, {Color border = _border}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: _gapS),
    padding: const EdgeInsets.all(_gapM),
    decoration: BoxDecoration(
      color: const Color(0xFF0B0E12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: border),
    ),
    child: Text(code, style: _stMono),
  );
}

Widget _calloutNote(
  String title,
  String body, {
  Color color = _accentWarm,
  IconData icon = Icons.lightbulb_outline,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: _gapS),
    padding: const EdgeInsets.all(_gapM),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.45)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 18),
        const SizedBox(width: _gapM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _stBodyStrong.copyWith(color: color)),
              const SizedBox(height: 4),
              Text(body, style: _stBody),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// "Frozen frame" cursor visualizer
//
// Renders a snapshot of the text with optional selection range highlighted
// and a vertical cursor bar drawn at the caret offset. This lets us show
// "the text didn't change but the cursor moved" without any animation.
// ---------------------------------------------------------------------------

Widget _frozenFrame({
  required String label,
  required String text,
  required int caret,
  int? selectionStart,
  int? selectionEnd,
  TextRange? composing,
  Color frameColor = _accent,
}) {
  final List<InlineSpan> spans = <InlineSpan>[];

  for (int i = 0; i < text.length; i++) {
    final String ch = text[i];
    final bool inSelection =
        selectionStart != null &&
            selectionEnd != null &&
            i >= selectionStart &&
            i < selectionEnd;
    final bool inComposing = composing != null &&
        composing.isValid &&
        !composing.isCollapsed &&
        i >= composing.start &&
        i < composing.end;

    Color? bg;
    Color fg = _textPrimary;
    TextDecoration deco = TextDecoration.none;

    if (inSelection) {
      bg = _accent.withValues(alpha: 0.32);
      fg = Colors.white;
    }
    if (inComposing) {
      deco = TextDecoration.underline;
      fg = _accentMagenta;
    }

    spans.add(
      TextSpan(
        text: ch,
        style: TextStyle(
          color: fg,
          backgroundColor: bg,
          decoration: deco,
          decorationColor: _accentMagenta,
          decorationStyle: TextDecorationStyle.dashed,
        ),
      ),
    );
  }

  // Inject a thin caret marker at the right offset.
  final List<InlineSpan> withCaret = <InlineSpan>[];
  for (int i = 0; i <= text.length; i++) {
    if (i == caret) {
      withCaret.add(
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: _CaretBar(),
        ),
      );
    }
    if (i < text.length) {
      withCaret.add(spans[i]);
    }
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: _gapXS),
    padding: const EdgeInsets.all(_gapM),
    decoration: BoxDecoration(
      color: const Color(0xFF0B0E12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: frameColor.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _miniBadge(label, frameColor),
            const SizedBox(width: _gapS),
            Text(
              'caret @ $caret '
              '${selectionStart != null ? "| sel [$selectionStart..${selectionEnd ?? selectionStart}]" : ""}',
              style: _stCaption,
            ),
          ],
        ),
        const SizedBox(height: _gapS),
        RichText(
          text: TextSpan(
            style: _stMono,
            children: withCaret,
          ),
        ),
      ],
    ),
  );
}

class _CaretBar extends StatelessWidget {
  const _CaretBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 16,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      color: _accentWarm,
    );
  }
}

// ---------------------------------------------------------------------------
// Section: Hero
// ---------------------------------------------------------------------------

Widget _heroSection() {
  const String demoText = 'Hello, NonText!';
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: _gapXXL),
    padding: const EdgeInsets.all(_gapXL),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1B2433), Color(0xFF0F1620)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _accent.withValues(alpha: 0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pillChip('FLUTTER / SERVICES', _accent),
            const SizedBox(width: _gapS),
            _pillChip('TextEditingDelta', _accentMagenta),
            const SizedBox(width: _gapS),
            _pillChip('NON-TEXT', _accentGreen),
          ],
        ),
        const SizedBox(height: _gapL),
        const Text('TextEditingDeltaNonTextUpdate', style: _stTitle),
        const SizedBox(height: _gapS),
        Text(
          'When the cursor moves but the text does not: the delta that '
          'reports selection and composing-range changes without ever '
          'rewriting the document.',
          style: _stBody.copyWith(fontSize: 15),
        ),
        const SizedBox(height: _gapL),
        const Text(
          'Three frozen frames: same text, three different selections.',
          style: _stBodyStrong,
        ),
        const SizedBox(height: _gapM),
        _frozenFrame(
          label: 'FRAME 1',
          text: demoText,
          caret: 0,
          frameColor: _accentCyan,
        ),
        _frozenFrame(
          label: 'FRAME 2',
          text: demoText,
          caret: 7,
          selectionStart: 0,
          selectionEnd: 7,
          frameColor: _accent,
        ),
        _frozenFrame(
          label: 'FRAME 3',
          text: demoText,
          caret: 14,
          selectionStart: 7,
          selectionEnd: 14,
          frameColor: _accentMagenta,
        ),
        const SizedBox(height: _gapM),
        const Text(
          'Notice: the underlying string "Hello, NonText!" is byte-identical '
          'in all three frames. Only `selection` (and possibly `composing`) '
          'changes.',
          style: _stBody,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: Anatomy
// ---------------------------------------------------------------------------

Widget _anatomySection() {
  final TextEditingDeltaNonTextUpdate sample = TextEditingDeltaNonTextUpdate(
    oldText: 'Hello World',
    selection: const TextSelection(baseOffset: 0, extentOffset: 5),
    composing: TextRange.empty,
  );

  return _sectionShell(
    label: 'ANATOMY',
    title: '1. Constructor and field anatomy',
    summary:
        'Unlike Insertion / Deletion / Replacement, NonTextUpdate carries no '
        '`replacementText` and no `replacedRange`. It only carries selection '
        'and composing changes against the unchanged text.',
    accent: _accentMagenta,
    children: <Widget>[
      _innerPanel(
        heading: 'Constructor signature',
        children: <Widget>[
          _codeBlock(
            'TextEditingDeltaNonTextUpdate({\n'
            '  required String     oldText,\n'
            '  required TextSelection selection,\n'
            '  required TextRange  composing,\n'
            '})',
          ),
          _bullet('oldText  — the text BEFORE the delta (unchanged after).'),
          _bullet('selection — the new selection range to apply.'),
          _bullet('composing — the new IME composing range to apply.'),
        ],
      ),
      _innerPanel(
        heading: 'Sample instance',
        children: <Widget>[
          _kv('runtimeType', '${sample.runtimeType}', valueColor: _accentCyan),
          _kv('oldText', '"${sample.oldText}"'),
          _kv('selection', '${sample.selection}'),
          _kv('composing', '${sample.composing}'),
          _kv(
            'isCollapsed?',
            '${sample.selection.isCollapsed}',
            valueColor: _accentWarm,
          ),
        ],
      ),
      _calloutNote(
        'Key invariant',
        'After applying a NonTextUpdate, the resulting `TextEditingValue.text` '
            'is identical to `oldText`. Only `selection` and `composing` '
            'change.',
        color: _accentGreen,
        icon: Icons.verified_outlined,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: Sibling delta gallery
// ---------------------------------------------------------------------------

Widget _siblingGallerySection() {
  // Each sibling is constructed once so we can show its actual runtimeType.
  final TextEditingDeltaInsertion ins = TextEditingDeltaInsertion(
    oldText: 'Hi',
    textInserted: '!',
    insertionOffset: 2,
    selection: const TextSelection.collapsed(offset: 3),
    composing: TextRange.empty,
  );
  final TextEditingDeltaDeletion del = TextEditingDeltaDeletion(
    oldText: 'Hi!',
    deletedRange: const TextRange(start: 2, end: 3),
    selection: const TextSelection.collapsed(offset: 2),
    composing: TextRange.empty,
  );
  final TextEditingDeltaReplacement rep = TextEditingDeltaReplacement(
    oldText: 'cat',
    replacementText: 'dog',
    replacedRange: const TextRange(start: 0, end: 3),
    selection: const TextSelection.collapsed(offset: 3),
    composing: TextRange.empty,
  );
  final TextEditingDeltaNonTextUpdate nontext = TextEditingDeltaNonTextUpdate(
    oldText: 'cat',
    selection: const TextSelection(baseOffset: 0, extentOffset: 3),
    composing: TextRange.empty,
  );

  Widget tile({
    required String name,
    required String desc,
    required String fields,
    required Color color,
    required String runtimeTypeStr,
    required bool emphasized,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: _gapM),
      padding: const EdgeInsets.all(_gapM),
      decoration: BoxDecoration(
        color: emphasized
            ? color.withValues(alpha: 0.14)
            : _bgInner,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: emphasized
              ? color.withValues(alpha: 0.7)
              : _border,
          width: emphasized ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _miniBadge(emphasized ? 'FOCUS' : 'SIBLING', color),
              const SizedBox(width: _gapS),
              Text(name, style: _stBodyStrong.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: 6),
          Text(desc, style: _stBody),
          const SizedBox(height: 6),
          Text(fields, style: _stMonoMuted),
          const SizedBox(height: 4),
          Text('runtimeType: $runtimeTypeStr', style: _stCaption),
        ],
      ),
    );
  }

  return _sectionShell(
    label: 'GALLERY',
    title: '2. Sibling-delta gallery',
    summary:
        'All four `TextEditingDelta` subclasses live side-by-side. Insertion, '
        'Deletion, and Replacement all change `text`. NonTextUpdate alone does '
        'not.',
    accent: _accentCyan,
    children: <Widget>[
      tile(
        name: 'TextEditingDeltaInsertion',
        desc: 'Pure insertion at a specific offset. Increases text length.',
        fields: 'oldText, textInserted, insertionOffset, selection, composing',
        color: _accentGreen,
        runtimeTypeStr: '${ins.runtimeType}',
        emphasized: false,
      ),
      tile(
        name: 'TextEditingDeltaDeletion',
        desc: 'Pure deletion of a range. Decreases text length.',
        fields: 'oldText, deletedRange, selection, composing',
        color: _accentRed,
        runtimeTypeStr: '${del.runtimeType}',
        emphasized: false,
      ),
      tile(
        name: 'TextEditingDeltaReplacement',
        desc: 'Replace a range with new text. Length may change.',
        fields:
            'oldText, replacementText, replacedRange, selection, composing',
        color: _accentWarm,
        runtimeTypeStr: '${rep.runtimeType}',
        emphasized: false,
      ),
      tile(
        name: 'TextEditingDeltaNonTextUpdate',
        desc:
            'No text change. Only `selection` and `composing` move. The only '
            'delta that preserves `oldText` byte-for-byte.',
        fields: 'oldText, selection, composing',
        color: _accentMagenta,
        runtimeTypeStr: '${nontext.runtimeType}',
        emphasized: true,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: Six worked examples
// ---------------------------------------------------------------------------

class _WorkedExample {
  const _WorkedExample({
    required this.title,
    required this.story,
    required this.text,
    required this.beforeCaret,
    required this.beforeSelStart,
    required this.beforeSelEnd,
    required this.beforeComposing,
    required this.afterCaret,
    required this.afterSelStart,
    required this.afterSelEnd,
    required this.afterComposing,
    required this.color,
  });

  final String title;
  final String story;
  final String text;
  final int beforeCaret;
  final int? beforeSelStart;
  final int? beforeSelEnd;
  final TextRange beforeComposing;
  final int afterCaret;
  final int? afterSelStart;
  final int? afterSelEnd;
  final TextRange afterComposing;
  final Color color;
}

List<_WorkedExample> _buildWorkedExamples() {
  const String poem = 'The quick brown fox';
  const String greet = 'こんにちは';
  return <_WorkedExample>[
    const _WorkedExample(
      title: 'a) Cursor move via right-arrow',
      story:
          'User presses → once. The character at offset 4 ("q") is unchanged; '
          'caret moves from 4 to 5.',
      text: poem,
      beforeCaret: 4,
      beforeSelStart: null,
      beforeSelEnd: null,
      beforeComposing: TextRange.empty,
      afterCaret: 5,
      afterSelStart: null,
      afterSelEnd: null,
      afterComposing: TextRange.empty,
      color: _accentCyan,
    ),
    const _WorkedExample(
      title: 'b) Long-press cursor jump',
      story:
          'User long-presses on the word "fox". The selection collapses at the '
          'pressed offset. Note: this is collapsed, not extended.',
      text: poem,
      beforeCaret: 0,
      beforeSelStart: null,
      beforeSelEnd: null,
      beforeComposing: TextRange.empty,
      afterCaret: 17,
      afterSelStart: null,
      afterSelEnd: null,
      afterComposing: TextRange.empty,
      color: _accentWarm,
    ),
    const _WorkedExample(
      title: 'c) Double-tap word selection',
      story:
          'A double-tap on "brown" expands the selection to the word boundary. '
          'Selection becomes [10..15], text unchanged.',
      text: poem,
      beforeCaret: 12,
      beforeSelStart: null,
      beforeSelEnd: null,
      beforeComposing: TextRange.empty,
      afterCaret: 15,
      afterSelStart: 10,
      afterSelEnd: 15,
      afterComposing: TextRange.empty,
      color: _accent,
    ),
    const _WorkedExample(
      title: 'd) Drag-extending selection',
      story:
          'User drags from caret-13 outward. The extentOffset moves from 13 to '
          '19, baseOffset stays anchored.',
      text: poem,
      beforeCaret: 13,
      beforeSelStart: 13,
      beforeSelEnd: 13,
      beforeComposing: TextRange.empty,
      afterCaret: 19,
      afterSelStart: 13,
      afterSelEnd: 19,
      afterComposing: TextRange.empty,
      color: _accentGreen,
    ),
    const _WorkedExample(
      title: 'e) Composing-range shrinking',
      story:
          'IME initially composes "こんにちは" (5 chars). User commits the first '
          '2 chars; remaining composition shrinks to [2..5].',
      text: greet,
      beforeCaret: 5,
      beforeSelStart: null,
      beforeSelEnd: null,
      beforeComposing: TextRange(start: 0, end: 5),
      afterCaret: 5,
      afterSelStart: null,
      afterSelEnd: null,
      afterComposing: TextRange(start: 2, end: 5),
      color: _accentMagenta,
    ),
    const _WorkedExample(
      title: 'f) IME backspace inside composing',
      story:
          'NOTE: a true backspace would be a Deletion delta. But some IMEs '
          'send a NonTextUpdate to first relocate the caret inside the '
          'composing region — this example shows that prelude.',
      text: greet,
      beforeCaret: 5,
      beforeSelStart: null,
      beforeSelEnd: null,
      beforeComposing: TextRange(start: 0, end: 5),
      afterCaret: 4,
      afterSelStart: null,
      afterSelEnd: null,
      afterComposing: TextRange(start: 0, end: 5),
      color: _accentRed,
    ),
  ];
}

Widget _examplesSection() {
  final List<_WorkedExample> examples = _buildWorkedExamples();
  return _sectionShell(
    label: 'EXAMPLES',
    title: '3. Six worked NonText examples',
    summary:
        'Six realistic scenarios that produce a `TextEditingDeltaNonTextUpdate` '
        'and no other delta. Each card shows the BEFORE state, the AFTER '
        'state, and the constructed delta.',
    accent: _accentGreen,
    children: examples.map(_renderExampleCard).toList(),
  );
}

Widget _renderExampleCard(_WorkedExample ex) {
  final TextEditingDeltaNonTextUpdate delta = TextEditingDeltaNonTextUpdate(
    oldText: ex.text,
    selection: ex.afterSelStart != null && ex.afterSelEnd != null
        ? TextSelection(
            baseOffset: ex.afterSelStart!,
            extentOffset: ex.afterSelEnd!,
          )
        : TextSelection.collapsed(offset: ex.afterCaret),
    composing: ex.afterComposing,
  );

  return Container(
    margin: const EdgeInsets.only(bottom: _gapM),
    padding: const EdgeInsets.all(_gapM),
    decoration: BoxDecoration(
      color: _bgInner,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ex.color.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _miniBadge('CASE', ex.color),
            const SizedBox(width: _gapS),
            Expanded(
              child: Text(
                ex.title,
                style: _stBodyStrong.copyWith(color: ex.color),
              ),
            ),
          ],
        ),
        const SizedBox(height: _gapS),
        Text(ex.story, style: _stBody),
        const SizedBox(height: _gapS),
        _frozenFrame(
          label: 'BEFORE',
          text: ex.text,
          caret: ex.beforeCaret,
          selectionStart: ex.beforeSelStart,
          selectionEnd: ex.beforeSelEnd,
          composing: ex.beforeComposing,
          frameColor: _textMuted,
        ),
        _frozenFrame(
          label: 'AFTER',
          text: ex.text,
          caret: ex.afterCaret,
          selectionStart: ex.afterSelStart,
          selectionEnd: ex.afterSelEnd,
          composing: ex.afterComposing,
          frameColor: ex.color,
        ),
        _kv('selection', '${delta.selection}'),
        _kv('composing', '${delta.composing}'),
        _kv(
          'text changed?',
          '${ex.text != delta.oldText}',
          valueColor: _accentRed,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: TextSelection deconstruction
// ---------------------------------------------------------------------------

Widget _selectionDeconstructionSection() {
  const TextSelection collapsed = TextSelection.collapsed(offset: 7);
  const TextSelection forward = TextSelection(baseOffset: 2, extentOffset: 9);
  const TextSelection backward = TextSelection(baseOffset: 9, extentOffset: 2);
  const TextSelection withAffinity = TextSelection(
    baseOffset: 4,
    extentOffset: 4,
    affinity: TextAffinity.upstream,
  );

  Widget rowFor(String name, TextSelection s) {
    return Container(
      margin: const EdgeInsets.only(bottom: _gapS),
      padding: const EdgeInsets.all(_gapS),
      decoration: BoxDecoration(
        color: _bgInner,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: _stBodyStrong),
          const SizedBox(height: 4),
          _kv('baseOffset', '${s.baseOffset}'),
          _kv('extentOffset', '${s.extentOffset}'),
          _kv('isCollapsed', '${s.isCollapsed}', valueColor: _accentCyan),
          _kv('affinity', '${s.affinity}', valueColor: _accentMagenta),
          _kv(
            'normalized [start..end]',
            '[${s.start}..${s.end}]',
            valueColor: _accentWarm,
          ),
        ],
      ),
    );
  }

  return _sectionShell(
    label: 'SELECTION',
    title: '4. TextSelection deconstruction',
    summary:
        '`TextSelection` is more than `[start, end]`. It carries direction '
        '(via baseOffset / extentOffset) and `affinity`. Both matter when '
        'the engine reports a NonTextUpdate.',
    accent: _accentWarm,
    children: <Widget>[
      _innerPanel(
        heading: 'Four representative selections',
        children: <Widget>[
          rowFor('Collapsed at offset 7', collapsed),
          rowFor('Forward [2..9] (drag right)', forward),
          rowFor('Backward [9..2] (drag left)', backward),
          rowFor('Collapsed at 4 with upstream affinity', withAffinity),
        ],
      ),
      _calloutNote(
        'Affinity gotcha',
        '`affinity` only matters at line-wrap boundaries. For `NonTextUpdate` '
            'most of the time you can ignore it, but DON\'T strip it when '
            'reconstructing values — it affects caret rendering.',
        color: _accentWarm,
        icon: Icons.info_outline,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: TextRange for composing
// ---------------------------------------------------------------------------

Widget _composingRangeSection() {
  const TextRange empty = TextRange.empty;
  const TextRange collapsed = TextRange.collapsed(3);
  const TextRange real = TextRange(start: 2, end: 7);

  Widget row(String name, TextRange r) {
    return Container(
      margin: const EdgeInsets.only(bottom: _gapS),
      padding: const EdgeInsets.all(_gapS),
      decoration: BoxDecoration(
        color: _bgInner,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name, style: _stBodyStrong),
          const SizedBox(height: 4),
          _kv('start', '${r.start}'),
          _kv('end', '${r.end}'),
          _kv('isValid', '${r.isValid}'),
          _kv('isCollapsed', '${r.isCollapsed}'),
          _kv('isNormalized', '${r.isNormalized}'),
        ],
      ),
    );
  }

  return _sectionShell(
    label: 'COMPOSING',
    title: '5. TextRange — the composing region',
    summary:
        'Composing range tracks the IME\'s in-flight composition. '
        '`TextRange.empty` (start=-1, end=-1) means "no composition active". '
        'A NonTextUpdate may toggle this region without inserting characters.',
    accent: _accentMagenta,
    children: <Widget>[
      _innerPanel(
        heading: 'Three composing-range states',
        children: <Widget>[
          row('TextRange.empty', empty),
          row('TextRange.collapsed(3)', collapsed),
          row('TextRange(start: 2, end: 7)', real),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: apply() worked example
// ---------------------------------------------------------------------------

Widget _applySection() {
  const String src = 'apply preserves text';
  final TextEditingValue before = const TextEditingValue(
    text: src,
    selection: TextSelection.collapsed(offset: 0),
    composing: TextRange.empty,
  );
  final TextEditingDeltaNonTextUpdate delta = TextEditingDeltaNonTextUpdate(
    oldText: src,
    selection: const TextSelection(baseOffset: 6, extentOffset: 14),
    composing: TextRange.empty,
  );
  final TextEditingValue after = delta.apply(before);

  return _sectionShell(
    label: 'APPLY',
    title: '6. delta.apply(value) — text preserved, selection swapped',
    summary:
        '`apply()` is pure: it returns a NEW `TextEditingValue` with the '
        'same text, but the selection and composing fields replaced from the '
        'delta.',
    accent: _accentCyan,
    children: <Widget>[
      _innerPanel(
        heading: 'Inputs',
        children: <Widget>[
          _kv('value.text', '"${before.text}"'),
          _kv('value.selection', '${before.selection}'),
          _kv('value.composing', '${before.composing}'),
          const SizedBox(height: _gapS),
          _kv('delta.oldText', '"${delta.oldText}"'),
          _kv('delta.selection', '${delta.selection}'),
          _kv('delta.composing', '${delta.composing}'),
        ],
      ),
      _innerPanel(
        heading: 'Result of delta.apply(before)',
        headingColor: _accentGreen,
        children: <Widget>[
          _kv('after.text', '"${after.text}"', valueColor: _accentGreen),
          _kv(
            'after.text == before.text',
            '${after.text == before.text}',
            valueColor: _accentGreen,
          ),
          _kv('after.selection', '${after.selection}'),
          _kv('after.composing', '${after.composing}'),
        ],
      ),
      _frozenFrame(
        label: 'BEFORE',
        text: before.text,
        caret: before.selection.extentOffset,
        frameColor: _textMuted,
      ),
      _frozenFrame(
        label: 'AFTER',
        text: after.text,
        caret: after.selection.extentOffset,
        selectionStart: after.selection.start,
        selectionEnd: after.selection.end,
        frameColor: _accentCyan,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: Recipe — handling updateEditingValueWithDeltas
// ---------------------------------------------------------------------------

Widget _recipeSection() {
  const String code = '''
// In a DeltaTextInputClient implementation:

@override
void updateEditingValueWithDeltas(List<TextEditingDelta> deltas) {
  TextEditingValue v = currentValue;
  for (final TextEditingDelta d in deltas) {
    if (d is TextEditingDeltaInsertion) {
      // text grew
    } else if (d is TextEditingDeltaDeletion) {
      // text shrank
    } else if (d is TextEditingDeltaReplacement) {
      // text length may have changed
    } else if (d is TextEditingDeltaNonTextUpdate) {
      // text is identical; selection / composing changed
      // safe to skip "did the text change?" listeners
    }
    v = d.apply(v);
  }
  currentValue = v;
}''';

  return _sectionShell(
    label: 'RECIPE',
    title: '7. Recipe — branching on the four delta types',
    summary:
        'When implementing a `DeltaTextInputClient`, the type-switch below '
        'is the canonical pattern. NonTextUpdate is the cheap path: no '
        'spell-check rerun, no autocomplete reset, no diff.',
    accent: _accent,
    children: <Widget>[
      _codeBlock(code),
      _bullet(
        'Insertion / Deletion / Replacement → re-run spell-check, autocomplete.',
        color: _accentWarm,
      ),
      _bullet(
        'NonTextUpdate → only update caret/selection visuals.',
        color: _accentGreen,
      ),
      _bullet(
        'Always finish by calling delta.apply() to fold the change in.',
        color: _accentCyan,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: Pitfalls
// ---------------------------------------------------------------------------

Widget _pitfallsSection() {
  return _sectionShell(
    label: 'PITFALLS',
    title: '8. Pitfalls and crash modes',
    summary:
        'NonTextUpdate looks innocuous, but its `selection` and `composing` '
        'must be valid against `oldText`. Easy to violate.',
    accent: _accentRed,
    children: <Widget>[
      _innerPanel(
        heading: 'Out-of-range selection',
        children: <Widget>[
          const Text(
            'A TextSelection whose offsets exceed `oldText.length` will be '
            'rejected (or silently clamped) by Flutter. Passing such a '
            'selection from a custom IME bridge corrupts caret rendering.',
            style: _stBody,
          ),
          _codeBlock(
            '// BAD\n'
            'TextEditingDeltaNonTextUpdate(\n'
            '  oldText: "abc",                 // length 3\n'
            '  selection: TextSelection.collapsed(offset: 99), // !!\n'
            '  composing: TextRange.empty,\n'
            ');',
          ),
        ],
      ),
      _innerPanel(
        heading: 'Composing range outside text',
        children: <Widget>[
          const Text(
            '`composing.end` must satisfy `composing.end <= oldText.length`. '
            'Otherwise downstream painters that render the composing underline '
            'will fail to lay out.',
            style: _stBody,
          ),
          _codeBlock(
            '// BAD\n'
            'TextEditingDeltaNonTextUpdate(\n'
            '  oldText: "hi",                  // length 2\n'
            '  selection: TextSelection.collapsed(offset: 0),\n'
            '  composing: TextRange(start: 1, end: 5), // !!\n'
            ');',
          ),
        ],
      ),
      _innerPanel(
        heading: 'Mistaking a Replacement for a NonTextUpdate',
        children: <Widget>[
          const Text(
            'If your platform plumbing reports "selection moved" but the text '
            'has actually changed, you must emit Replacement (or Insertion / '
            'Deletion) — not NonTextUpdate. Otherwise listeners that gate on '
            'text change will miss the event.',
            style: _stBody,
          ),
        ],
      ),
      _calloutNote(
        'Defensive idiom',
        'Before constructing a NonTextUpdate, assert that the new text is '
            'identical to oldText: `assert(newPlatformText == oldText)`.',
        color: _accentRed,
        icon: Icons.warning_amber_outlined,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: Comparison with the older value-based update model
// ---------------------------------------------------------------------------

Widget _comparisonSection() {
  Widget col({
    required String title,
    required List<String> bullets,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _gapXS),
        padding: const EdgeInsets.all(_gapM),
        decoration: BoxDecoration(
          color: _bgInner,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: _stBodyStrong.copyWith(color: color)),
            const SizedBox(height: _gapS),
            ...bullets.map((String b) => _bullet(b, color: color)),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    label: 'COMPARE',
    title: '9. Old `TextEditingValue` updates vs. delta updates',
    summary:
        'Before deltas, IMEs sent whole-value snapshots via '
        '`updateEditingValue(TextEditingValue)`. The delta model is finer '
        'grained — and NonTextUpdate is the part that was implicit in the '
        'old model.',
    accent: _accent,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          col(
            title: 'Old: TextEditingValue snapshot',
            color: _textMuted,
            bullets: <String>[
              'Whole value sent every change.',
              'Listeners must diff text vs. previous to detect change.',
              'Selection-only updates indistinguishable from text-only.',
              'Implementations re-run spell check on every event.',
            ],
          ),
          col(
            title: 'New: TextEditingDelta',
            color: _accentGreen,
            bullets: <String>[
              'Each event is typed: Insert/Delete/Replace/NonText.',
              'NonTextUpdate is explicitly "no text change".',
              'Listeners can branch by `is TextEditingDeltaXxx`.',
              'Cheaper: skip work on NonTextUpdate.',
            ],
          ),
        ],
      ),
      _calloutNote(
        'Adoption note',
        'A widget opts into deltas by implementing `DeltaTextInputClient` and '
            'connecting to `TextInput` with `enableDeltaModel: true` on the '
            'configuration. Without that flag, the engine still calls '
            '`updateEditingValue(value)` instead.',
        color: _accent,
        icon: Icons.bookmark_border,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

Widget _footerSection() {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: _gapL),
    padding: const EdgeInsets.all(_gapL),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.bookmark_outline, color: _accent, size: 18),
            const SizedBox(width: _gapS),
            Text('References', style: _stSubtitle.copyWith(color: _accent)),
          ],
        ),
        const SizedBox(height: _gapS),
        const Text(
          'package:flutter/services.dart\n'
          '  • TextEditingDelta            (abstract base)\n'
          '  • TextEditingDeltaInsertion\n'
          '  • TextEditingDeltaDeletion\n'
          '  • TextEditingDeltaReplacement\n'
          '  • TextEditingDeltaNonTextUpdate   ← this demo\n'
          '  • TextSelection, TextRange, TextEditingValue\n'
          '  • DeltaTextInputClient',
          style: _stMonoMuted,
        ),
        const SizedBox(height: _gapM),
        const Text(
          'This demo was authored as an analyzer-clean visual reference for '
          'the D4rt interpreter\'s Flutter AST test corpus. It is rendered '
          'from a single static `dynamic build(BuildContext)` entry with no '
          'state, no controllers, and no async work.',
          style: _stCaption,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Diagnostic side-channel: also print a textual summary, exactly like the
// original test fixture used to. This keeps any prior test assertions that
// inspected stdout intact.
// ---------------------------------------------------------------------------

void _printDiagnostics() {
  print('TextEditingDeltaNonTextUpdate test executing');
  print('=' * 50);

  final TextEditingDeltaNonTextUpdate nonTextUpdate =
      TextEditingDeltaNonTextUpdate(
    oldText: 'Hello World',
    selection: const TextSelection(baseOffset: 0, extentOffset: 5),
    composing: TextRange.empty,
  );
  print('\nTextEditingDeltaNonTextUpdate created:');
  print('runtimeType: ${nonTextUpdate.runtimeType}');

  print('\nNon-text update delta properties:');
  print('oldText: "${nonTextUpdate.oldText}"');
  print('selection: ${nonTextUpdate.selection}');
  print('composing: ${nonTextUpdate.composing}');

  print('\nApplying non-text update:');
  final TextEditingValue oldValue = const TextEditingValue(
    text: 'Hello World',
    selection: TextSelection.collapsed(offset: 0),
  );
  print('Before selection: ${oldValue.selection}');
  final TextEditingValue newValue = nonTextUpdate.apply(oldValue);
  print('After selection: ${newValue.selection}');
  print('Text unchanged: ${oldValue.text == newValue.text}');

  print('\nSelection change example:');
  final TextEditingDeltaNonTextUpdate selectionChange =
      TextEditingDeltaNonTextUpdate(
    oldText: 'Example text',
    selection: const TextSelection(baseOffset: 8, extentOffset: 12),
    composing: TextRange.empty,
  );
  print('New selection: ${selectionChange.selection}');
  print('Selected text would be: "text"');

  print('\nComposing region change:');
  final TextEditingDeltaNonTextUpdate composingChange =
      TextEditingDeltaNonTextUpdate(
    oldText: 'Hello',
    selection: const TextSelection.collapsed(offset: 5),
    composing: const TextRange(start: 0, end: 5),
  );
  print('composing: ${composingChange.composing}');
  print('Shows IME composition region');

  print('\nWhen non-text update occurs:');
  print('- Selection changed by tap');
  print('- Selection changed by keyboard');
  print('- Composing region updated');
  print('- Cursor position moved');
  print('- No actual text modification');

  print('\nType hierarchy:');
  print('TextEditingDelta (abstract base)');
  print('  \u251c\u2500 TextEditingDeltaInsertion');
  print('  \u251c\u2500 TextEditingDeltaDeletion');
  print('  \u251c\u2500 TextEditingDeltaReplacement');
  print('  \u2514\u2500 TextEditingDeltaNonTextUpdate');

  print('\nTextEditingDeltaNonTextUpdate purpose:');
  print('- Represents non-text changes');
  print('- Selection or composing updates only');
  print('- Text content remains unchanged');
  print('- Used with DeltaTextInputClient');
  print('- Tracks selection/cursor changes');

  print('\n${'=' * 50}');
  print('TextEditingDeltaNonTextUpdate test completed');
}

// ---------------------------------------------------------------------------
// build() — single entry point per the test-script contract
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  _printDiagnostics();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextEditingDeltaNonTextUpdate Deep Demo',
    home: Scaffold(
      backgroundColor: _bgPage,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(_gapXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _heroSection(),
            _anatomySection(),
            _siblingGallerySection(),
            _examplesSection(),
            _selectionDeconstructionSection(),
            _composingRangeSection(),
            _applySection(),
            _recipeSection(),
            _pitfallsSection(),
            _comparisonSection(),
            _footerSection(),
          ],
        ),
      ),
    ),
  );
}
