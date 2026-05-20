// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
// =============================================================================
// VISUAL DEEP DEMO: TextSelection (package:flutter/services.dart)
// -----------------------------------------------------------------------------
// TextSelection extends TextRange and is the model that Flutter uses to
// represent both cursor positions and ranges of selected text inside text
// editing widgets such as EditableText, TextField, and SelectableText.
//
// This visual demo enumerates every notable field, every constructor, and
// shows the relationship between TextSelection, TextRange and TextAffinity
// in a fully painted Material gallery. No state, no controllers, no async,
// no runApp — only a pure `build` returning widgets.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// -----------------------------------------------------------------------------
// THEME COLOR PALETTE
// -----------------------------------------------------------------------------

const Color kBackgroundColor = Color(0xFF101822);
const Color kPanelColor = Color(0xFF1B2735);
const Color kPanelBorderColor = Color(0xFF2C3E55);
const Color kAccentBlue = Color(0xFF4FB3FF);
const Color kAccentTeal = Color(0xFF26C6DA);
const Color kAccentGreen = Color(0xFF7CD992);
const Color kAccentAmber = Color(0xFFFFCB6B);
const Color kAccentPink = Color(0xFFFF7AA2);
const Color kAccentPurple = Color(0xFFB388FF);
const Color kTextPrimary = Color(0xFFE4ECF7);
const Color kTextSecondary = Color(0xFFA8B6CB);
const Color kTextDim = Color(0xFF6F7E94);
const Color kHighlightBefore = Color(0xFF334155);
const Color kHighlightInside = Color(0xFFFFCB6B);
const Color kHighlightAfter = Color(0xFF334155);

// -----------------------------------------------------------------------------
// TEXT STYLE HELPERS
// -----------------------------------------------------------------------------

const TextStyle kHeroTitleStyle = TextStyle(
  color: kTextPrimary,
  fontSize: 30,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.6,
);

const TextStyle kHeroSubtitleStyle = TextStyle(
  color: kTextSecondary,
  fontSize: 15,
  height: 1.45,
);

const TextStyle kSectionTitleStyle = TextStyle(
  color: kTextPrimary,
  fontSize: 22,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.4,
);

const TextStyle kCardTitleStyle = TextStyle(
  color: kTextPrimary,
  fontSize: 17,
  fontWeight: FontWeight.w700,
);

const TextStyle kCardBodyStyle = TextStyle(
  color: kTextSecondary,
  fontSize: 13.5,
  height: 1.45,
);

const TextStyle kMonoStyle = TextStyle(
  color: kTextPrimary,
  fontSize: 13,
  fontFamily: 'monospace',
  height: 1.35,
);

const TextStyle kMonoDimStyle = TextStyle(
  color: kTextDim,
  fontSize: 12,
  fontFamily: 'monospace',
  height: 1.35,
);

const TextStyle kLabelStyle = TextStyle(
  color: kTextDim,
  fontSize: 11,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.2,
);

// -----------------------------------------------------------------------------
// SHARED LITTLE WIDGETS
// -----------------------------------------------------------------------------

Widget panelContainer({
  required Widget child,
  Color? color,
  Color? borderColor,
  EdgeInsets? padding,
}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: color ?? kPanelColor,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: borderColor ?? kPanelBorderColor, width: 1),
    ),
    child: child,
  );
}

Widget pillBadge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    ),
  );
}

Widget keyValueRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            key,
            style: const TextStyle(
              color: kTextDim,
              fontFamily: 'monospace',
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 12.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget sectionTitle(String number, String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 12),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kAccentBlue.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kAccentBlue.withValues(alpha: 0.6)),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: kAccentBlue,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: kSectionTitleStyle)),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// HIGHLIGHTED TEXT RENDER (textBefore / textInside / textAfter)
// -----------------------------------------------------------------------------
//
// Given a source string and a TextSelection, paint each region with a
// distinct background color so the user visually understands the regions:
//   textBefore  -> slate
//   textInside  -> amber
//   textAfter   -> slate
// For collapsed selections we draw a vertical caret at the offset position.
// For invalid selections (offset == -1) we render the source dimmed and
// note that no selection exists.

Widget highlightedSelectionText(String source, TextSelection sel) {
  if (!sel.isValid) {
    return Text(
      source,
      style: const TextStyle(
        color: kTextDim,
        fontFamily: 'monospace',
        fontSize: 13,
        decoration: TextDecoration.lineThrough,
      ),
    );
  }
  if (sel.isCollapsed) {
    final int offset = sel.baseOffset.clamp(0, source.length);
    final String left = source.substring(0, offset);
    final String right = source.substring(offset);
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: kTextPrimary,
          fontFamily: 'monospace',
          fontSize: 13,
        ),
        children: [
          TextSpan(text: left),
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: _CaretIndicator(),
          ),
          TextSpan(text: right),
        ],
      ),
    );
  }
  final TextSelection norm = sel.isNormalized
      ? sel
      : TextSelection(baseOffset: sel.extentOffset, extentOffset: sel.baseOffset);
  final String before = norm.textBefore(source);
  final String inside = norm.textInside(source);
  final String after = norm.textAfter(source);
  return RichText(
    text: TextSpan(
      style: const TextStyle(
        color: kTextPrimary,
        fontFamily: 'monospace',
        fontSize: 13,
      ),
      children: [
        TextSpan(
          text: before,
          style: const TextStyle(backgroundColor: kHighlightBefore),
        ),
        TextSpan(
          text: inside,
          style: TextStyle(
            backgroundColor: kHighlightInside,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: after,
          style: const TextStyle(backgroundColor: kHighlightAfter),
        ),
      ],
    ),
  );
}

class _CaretIndicator extends StatelessWidget {
  const _CaretIndicator();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 16,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      color: kAccentPink,
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION 1 — HERO CARD
// -----------------------------------------------------------------------------

Widget buildHeroSection() {
  const String demoText = 'Flutter selection model';
  const TextSelection demoSel =
      TextSelection(baseOffset: 8, extentOffset: 17);
  return panelContainer(
    padding: const EdgeInsets.all(24),
    color: const Color(0xFF18243A),
    borderColor: kAccentBlue.withValues(alpha: 0.45),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pillBadge('FLUTTER · SERVICES', kAccentBlue),
            const SizedBox(width: 8),
            pillBadge('TextSelection', kAccentTeal),
            const SizedBox(width: 8),
            pillBadge('extends TextRange', kAccentPurple),
          ],
        ),
        const SizedBox(height: 18),
        const Text('TextSelection — A Visual Field Guide',
            style: kHeroTitleStyle),
        const SizedBox(height: 10),
        const Text(
          'TextSelection is the canonical model for cursors and selections '
          'in Flutter. It carries baseOffset, extentOffset, affinity, and '
          'isDirectional, and inherits start/end/isCollapsed/isValid '
          'semantics from TextRange. The renderer paints, the framework '
          'navigates, and your widget tree responds — all driven by this '
          'tiny immutable value object.',
          style: kHeroSubtitleStyle,
        ),
        const SizedBox(height: 22),
        panelContainer(
          color: const Color(0xFF0E1726),
          borderColor: kAccentTeal.withValues(alpha: 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('SAMPLE STRING', style: kLabelStyle),
              const SizedBox(height: 8),
              highlightedSelectionText(demoText, demoSel),
              const SizedBox(height: 14),
              const Text('SELECTION VALUE', style: kLabelStyle),
              const SizedBox(height: 6),
              const Text(
                "TextSelection(baseOffset: 8, extentOffset: 17)",
                style: kMonoStyle,
              ),
              const SizedBox(height: 10),
              keyValueRow('start', '${demoSel.start}',
                  valueColor: kAccentGreen),
              keyValueRow('end', '${demoSel.end}', valueColor: kAccentGreen),
              keyValueRow('isCollapsed', '${demoSel.isCollapsed}'),
              keyValueRow('isDirectional', '${demoSel.isDirectional}'),
              keyValueRow('affinity', '${demoSel.affinity}'),
            ],
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 2 — ANATOMY DIAGRAM
// -----------------------------------------------------------------------------

Widget anatomyLabel(String name, String description, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 6, right: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  )),
              const SizedBox(height: 2),
              Text(description, style: kCardBodyStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAnatomySection() {
  return panelContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Anatomy of a TextSelection', style: kCardTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'A TextSelection is fully described by four immutable fields. '
          'Two integers (baseOffset, extentOffset) capture the user-visible '
          'positions, while affinity and isDirectional control rendering '
          'and keyboard-extension semantics.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 14),
        panelContainer(
          color: const Color(0xFF0E1726),
          borderColor: kPanelBorderColor,
          padding: const EdgeInsets.all(16),
          child: const Text(
            "TextSelection(\n"
            "  baseOffset: 4,        // where the user STARTED selecting\n"
            "  extentOffset: 12,     // where the user is NOW (the caret)\n"
            "  affinity: TextAffinity.downstream,\n"
            "  isDirectional: false, // shift+arrow keeps extending the\n"
            "                        // same logical end of the selection\n"
            ")",
            style: kMonoStyle,
          ),
        ),
        const SizedBox(height: 14),
        anatomyLabel('baseOffset',
            'The anchor — where the selection began. Stays put while the '
                'user drags or shift-extends the selection.', kAccentTeal),
        anatomyLabel('extentOffset',
            'The moving end — where the cursor currently is. The visible '
                'caret is rendered at extentOffset.', kAccentAmber),
        anatomyLabel('affinity',
            'Resolves the ambiguity at line wraps. upstream = end of the '
                'previous visual line, downstream = start of the next.',
            kAccentPink),
        anatomyLabel('isDirectional',
            'When true, shift+arrow extension always grows from the same '
                'end of the range, regardless of base/extent ordering.',
            kAccentPurple),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 3 — SAMPLE SELECTION CARDS (six)
// -----------------------------------------------------------------------------

class SampleSelection {
  final String title;
  final String description;
  final String source;
  final TextSelection selection;
  final String literalSource;
  const SampleSelection({
    required this.title,
    required this.description,
    required this.source,
    required this.selection,
    required this.literalSource,
  });
}

const List<SampleSelection> kSampleSelections = <SampleSelection>[
  SampleSelection(
    title: '1. Forward range — middle word',
    description:
        'A typical drag-from-left-to-right selection. base < extent, '
        'so the selection is already normalized.',
    source: 'The quick brown fox jumps',
    selection: TextSelection(baseOffset: 4, extentOffset: 9),
    literalSource: 'TextSelection(baseOffset: 4, extentOffset: 9)',
  ),
  SampleSelection(
    title: '2. Backward range — selected from the right',
    description:
        'The user dragged right-to-left. base > extent, so the selection '
        'is NOT normalized but still produces correct start/end.',
    source: 'Hello, beautiful world!',
    selection: TextSelection(baseOffset: 17, extentOffset: 7),
    literalSource: 'TextSelection(baseOffset: 17, extentOffset: 7)',
  ),
  SampleSelection(
    title: '3. Collapsed cursor — caret in the middle',
    description:
        'A pure caret. baseOffset == extentOffset means no characters '
        'are highlighted — the position acts as an insertion point.',
    source: 'Insert here please',
    selection: TextSelection.collapsed(offset: 7),
    literalSource: 'TextSelection.collapsed(offset: 7)',
  ),
  SampleSelection(
    title: '4. Full document selection',
    description:
        'Ctrl/Cmd+A maps to a TextSelection that spans 0..length, '
        'covering the entire string.',
    source: 'select all of this',
    selection: TextSelection(baseOffset: 0, extentOffset: 18),
    literalSource: 'TextSelection(baseOffset: 0, extentOffset: 18)',
  ),
  SampleSelection(
    title: '5. Caret at end-of-text',
    description:
        'A caret can sit at offset == length. This is the "after the '
        'last character" position used after typing.',
    source: 'finished',
    selection: TextSelection.collapsed(offset: 8),
    literalSource: 'TextSelection.collapsed(offset: 8)',
  ),
  SampleSelection(
    title: '6. Invalid / no selection',
    description:
        'A selection with offset -1 represents "no selection at all". '
        'isValid returns false and rendering should suppress the caret.',
    source: 'no selection here',
    selection: TextSelection.collapsed(offset: -1),
    literalSource: 'TextSelection.collapsed(offset: -1)',
  ),
];

Widget buildSampleSelectionCard(SampleSelection s) {
  final TextSelection sel = s.selection;
  final bool valid = sel.isValid;
  return panelContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(s.title, style: kCardTitleStyle)),
            pillBadge(
                valid ? (sel.isCollapsed ? 'CARET' : 'RANGE') : 'INVALID',
                valid
                    ? (sel.isCollapsed ? kAccentPink : kAccentAmber)
                    : kTextDim),
          ],
        ),
        const SizedBox(height: 6),
        Text(s.description, style: kCardBodyStyle),
        const SizedBox(height: 14),
        const Text('SOURCE', style: kLabelStyle),
        const SizedBox(height: 6),
        panelContainer(
          color: const Color(0xFF0E1726),
          borderColor: kPanelBorderColor,
          padding: const EdgeInsets.all(12),
          child: highlightedSelectionText(s.source, sel),
        ),
        const SizedBox(height: 12),
        const Text('LITERAL', style: kLabelStyle),
        const SizedBox(height: 6),
        Text(s.literalSource, style: kMonoStyle),
        const SizedBox(height: 12),
        const Text('DERIVED FIELDS', style: kLabelStyle),
        const SizedBox(height: 4),
        keyValueRow('baseOffset', '${sel.baseOffset}'),
        keyValueRow('extentOffset', '${sel.extentOffset}'),
        keyValueRow('start', '${sel.start}',
            valueColor: valid ? kAccentGreen : kTextDim),
        keyValueRow('end', '${sel.end}',
            valueColor: valid ? kAccentGreen : kTextDim),
        keyValueRow('isCollapsed', '${sel.isCollapsed}'),
        keyValueRow('isNormalized', '${sel.isNormalized}'),
        keyValueRow('isValid', '${sel.isValid}'),
        keyValueRow('isDirectional', '${sel.isDirectional}'),
        keyValueRow('affinity', '${sel.affinity}'),
        if (valid && !sel.isCollapsed) ...[
          const SizedBox(height: 10),
          const Text('TEXTRANGE SLICES', style: kLabelStyle),
          const SizedBox(height: 4),
          _slicePreview('textBefore',
              _safeBefore(s.source, sel), kHighlightBefore, kTextSecondary),
          _slicePreview('textInside',
              _safeInside(s.source, sel), kHighlightInside, Colors.black),
          _slicePreview('textAfter',
              _safeAfter(s.source, sel), kHighlightAfter, kTextSecondary),
        ],
      ],
    ),
  );
}

String _safeBefore(String src, TextSelection sel) {
  final TextSelection norm = sel.isNormalized
      ? sel
      : TextSelection(baseOffset: sel.extentOffset, extentOffset: sel.baseOffset);
  return norm.textBefore(src);
}

String _safeInside(String src, TextSelection sel) {
  final TextSelection norm = sel.isNormalized
      ? sel
      : TextSelection(baseOffset: sel.extentOffset, extentOffset: sel.baseOffset);
  return norm.textInside(src);
}

String _safeAfter(String src, TextSelection sel) {
  final TextSelection norm = sel.isNormalized
      ? sel
      : TextSelection(baseOffset: sel.extentOffset, extentOffset: sel.baseOffset);
  return norm.textAfter(src);
}

Widget _slicePreview(
    String name, String value, Color background, Color textColor) {
  final String shown = value.isEmpty ? '∅' : value;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(name,
              style: const TextStyle(
                color: kTextDim,
                fontFamily: 'monospace',
                fontSize: 12.5,
              )),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              shown,
              style: TextStyle(
                color: textColor,
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSampleSelectionsSection() {
  final List<Widget> cards = <Widget>[];
  for (final SampleSelection s in kSampleSelections) {
    cards.add(buildSampleSelectionCard(s));
    cards.add(const SizedBox(height: 14));
  }
  if (cards.isNotEmpty) cards.removeLast();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cards,
  );
}

// -----------------------------------------------------------------------------
// SECTION 4 — TEXTAFFINITY PANEL
// -----------------------------------------------------------------------------

Widget affinitySideCard(String title, String description, String example,
    Color color, TextAffinity affinity) {
  return Expanded(
    child: panelContainer(
      color: const Color(0xFF0E1726),
      borderColor: color.withValues(alpha: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              pillBadge('$affinity'.split('.').last.toUpperCase(), color),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: kCardTitleStyle),
          const SizedBox(height: 6),
          Text(description, style: kCardBodyStyle),
          const SizedBox(height: 12),
          panelContainer(
            color: const Color(0xFF0A1320),
            borderColor: kPanelBorderColor,
            padding: const EdgeInsets.all(10),
            child: Text(example, style: kMonoStyle),
          ),
        ],
      ),
    ),
  );
}

Widget buildAffinitySection() {
  return panelContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TextAffinity — Where the cursor lives',
            style: kCardTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'When text wraps to a new line, an offset that sits exactly at '
          'the wrap point is ambiguous: it could be visually at the END of '
          'the previous line or the START of the next. TextAffinity '
          'resolves the ambiguity for both cursor rendering and arrow-key '
          'navigation.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 14),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #100, P1):
        // Page root is `Scaffold > SafeArea > SingleChildScrollView > Center >
        // ConstrainedBox(maxWidth: 880) > Column(stretch) > sections`, so the
        // Row below sits in an unbounded-height ancestor chain. Its
        // `crossAxisAlignment: CrossAxisAlignment.stretch` + the two
        // `affinitySideCard(...)` children (each `Expanded(panelContainer(...))`)
        // would propagate `BoxConstraints(h=Infinity)` down to the
        // `RenderConstrainedBox` inside `panelContainer`, tripping
        // "BoxConstraints forces an infinite height." (baseline frameworkErrors=1).
        // Wrap the Row in `IntrinsicHeight` so the cross axis bounds to the
        // taller of the two affinity cards — preserves the side-by-side
        // equal-height comparison the section is designed to teach.
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              affinitySideCard(
                'upstream',
                'The caret sticks to the END of the preceding visual line. '
                    'Useful for "I just typed the last character of the '
                    'previous line and I want to stay there".',
                "TextSelection.collapsed(\n"
                    "  offset: 12,\n"
                    "  affinity: TextAffinity.upstream,\n"
                    ")",
                kAccentTeal,
                TextAffinity.upstream),
            const SizedBox(width: 12),
            affinitySideCard(
                'downstream',
                'The caret moves to the START of the next visual line. This '
                    'is the default and matches the user expectation when '
                    'arrow-down lands on a new line.',
                "TextSelection.collapsed(\n"
                    "  offset: 12,\n"
                    "  affinity: TextAffinity.downstream,\n"
                    ")",
                kAccentAmber,
                TextAffinity.downstream),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Note: affinity ONLY matters when offset is the boundary of two '
          'visual lines (soft wrap). For interior offsets it is ignored '
          'by the renderer.',
          style: kCardBodyStyle,
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 5 — CONSTRUCTOR GALLERY
// -----------------------------------------------------------------------------

class ConstructorEntry {
  final String name;
  final String literal;
  final String description;
  final TextSelection result;
  final Color color;
  const ConstructorEntry({
    required this.name,
    required this.literal,
    required this.description,
    required this.result,
    required this.color,
  });
}

final List<ConstructorEntry> kConstructorEntries = <ConstructorEntry>[
  ConstructorEntry(
    name: 'TextSelection(...)',
    literal:
        "TextSelection(\n  baseOffset: 4,\n  extentOffset: 11,\n  affinity: TextAffinity.downstream,\n  isDirectional: false,\n)",
    description:
        'The general constructor. Accepts a base/extent pair and lets you '
            'override affinity and isDirectional. Most selections produced '
            'by gestures or shift-arrow flow through this constructor.',
    result: const TextSelection(baseOffset: 4, extentOffset: 11),
    color: kAccentBlue,
  ),
  ConstructorEntry(
    name: 'TextSelection.collapsed(...)',
    literal:
        "TextSelection.collapsed(\n  offset: 9,\n  affinity: TextAffinity.downstream,\n)",
    description:
        'A pure caret. Equivalent to passing the same offset for base and '
            'extent — the framework uses it everywhere a "cursor without '
            'selection" is needed.',
    result: const TextSelection.collapsed(offset: 9),
    color: kAccentTeal,
  ),
  ConstructorEntry(
    name: 'TextSelection.fromPosition(...)',
    literal:
        "TextSelection.fromPosition(\n  TextPosition(\n    offset: 6,\n    affinity: TextAffinity.upstream,\n  ),\n)",
    description:
        'Builds a collapsed selection from a TextPosition, preserving the '
            'position\'s affinity. Handy when promoting a hit-tested caret '
            'position into a selection.',
    result: TextSelection.fromPosition(
      const TextPosition(offset: 6, affinity: TextAffinity.upstream),
    ),
    color: kAccentPurple,
  ),
];

Widget buildConstructorCard(ConstructorEntry e) {
  return panelContainer(
    color: const Color(0xFF14202F),
    borderColor: e.color.withValues(alpha: 0.45),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pillBadge('CONSTRUCTOR', e.color),
            const SizedBox(width: 8),
            Expanded(
                child: Text(e.name,
                    style: kCardTitleStyle, overflow: TextOverflow.ellipsis)),
          ],
        ),
        const SizedBox(height: 8),
        Text(e.description, style: kCardBodyStyle),
        const SizedBox(height: 12),
        panelContainer(
          color: const Color(0xFF0A1320),
          borderColor: kPanelBorderColor,
          padding: const EdgeInsets.all(12),
          child: Text(e.literal, style: kMonoStyle),
        ),
        const SizedBox(height: 12),
        const Text('RESOLVED FIELDS', style: kLabelStyle),
        const SizedBox(height: 4),
        keyValueRow('baseOffset', '${e.result.baseOffset}'),
        keyValueRow('extentOffset', '${e.result.extentOffset}'),
        keyValueRow('start', '${e.result.start}'),
        keyValueRow('end', '${e.result.end}'),
        keyValueRow('isCollapsed', '${e.result.isCollapsed}'),
        keyValueRow('isValid', '${e.result.isValid}'),
        keyValueRow('affinity', '${e.result.affinity}'),
      ],
    ),
  );
}

Widget buildConstructorGallerySection() {
  final List<Widget> cards = <Widget>[];
  for (final ConstructorEntry e in kConstructorEntries) {
    cards.add(buildConstructorCard(e));
    cards.add(const SizedBox(height: 14));
  }
  if (cards.isNotEmpty) cards.removeLast();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cards,
  );
}

// -----------------------------------------------------------------------------
// SECTION 6 — TEXTSELECTION.EMPTY (DEPRECATED)
// -----------------------------------------------------------------------------

Widget buildEmptySection() {
  const TextSelection empty = TextSelection.collapsed(offset: -1);
  return panelContainer(
    color: const Color(0xFF231C2C),
    borderColor: kAccentPink.withValues(alpha: 0.45),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pillBadge('SPECIAL CASE', kAccentPink),
            const SizedBox(width: 8),
            pillBadge('LEGACY: TextSelection.empty', kTextDim),
          ],
        ),
        const SizedBox(height: 12),
        const Text('"No selection"', style: kCardTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'Historically, framework code used the constant '
          'TextSelection.empty to mean "there is no selection at all". '
          'That constant is deprecated; the modern, explicit equivalent is '
          'TextSelection.collapsed(offset: -1). Both share the same '
          'semantics: isValid returns false, and renderers suppress the '
          'caret.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 12),
        panelContainer(
          color: const Color(0xFF120A18),
          borderColor: kPanelBorderColor,
          padding: const EdgeInsets.all(12),
          child: const Text(
            "// Deprecated:\n"
            "// const TextSelection sel = TextSelection.empty;\n\n"
            "// Modern equivalent:\n"
            "const TextSelection sel = TextSelection.collapsed(offset: -1);",
            style: kMonoStyle,
          ),
        ),
        const SizedBox(height: 12),
        keyValueRow('baseOffset', '${empty.baseOffset}'),
        keyValueRow('extentOffset', '${empty.extentOffset}'),
        keyValueRow('isValid', '${empty.isValid}',
            valueColor: kAccentPink),
        keyValueRow('isCollapsed', '${empty.isCollapsed}'),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 7 — TEXTRANGE PARENT CLASS
// -----------------------------------------------------------------------------

Widget textRangeRow(String name, String type, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(name,
              style: const TextStyle(
                color: kAccentTeal,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              )),
        ),
        SizedBox(
          width: 90,
          child: Text(type,
              style: const TextStyle(
                color: kAccentPurple,
                fontFamily: 'monospace',
                fontSize: 11.5,
              )),
        ),
        Expanded(child: Text(description, style: kCardBodyStyle)),
      ],
    ),
  );
}

Widget buildTextRangeSection() {
  const TextRange demo = TextRange(start: 4, end: 9);
  const String demoSrc = 'The quick brown fox';
  return panelContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pillBadge('PARENT CLASS', kAccentPurple),
            const SizedBox(width: 8),
            pillBadge('TextRange', kAccentTeal),
          ],
        ),
        const SizedBox(height: 12),
        const Text('TextRange — what TextSelection inherits',
            style: kCardTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'TextRange is the immutable [start, end) interval primitive. It '
          'powers the slicing utilities used everywhere in the editing '
          'pipeline. TextSelection layers user-intent (base/extent, '
          'affinity) on top of this raw interval model.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 14),
        textRangeRow('start', 'int',
            'Inclusive start offset. Always <= end for a valid range.'),
        textRangeRow('end', 'int',
            'Exclusive end offset. -1 (with start = -1) means "empty".'),
        textRangeRow('isValid', 'bool',
            'True when start >= 0 and end >= 0.'),
        textRangeRow('isCollapsed', 'bool',
            'True when start == end. The interval has zero length.'),
        textRangeRow('isNormalized', 'bool',
            'True when start <= end. Slicing requires a normalized range.'),
        textRangeRow('textBefore(s)', 'String',
            'The substring of s strictly before start.'),
        textRangeRow('textInside(s)', 'String',
            'The substring of s between start and end.'),
        textRangeRow('textAfter(s)', 'String',
            'The substring of s strictly after end.'),
        const SizedBox(height: 14),
        const Text('LIVE EXAMPLE', style: kLabelStyle),
        const SizedBox(height: 6),
        panelContainer(
          color: const Color(0xFF0E1726),
          borderColor: kPanelBorderColor,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('const TextRange(start: 4, end: 9)',
                  style: kMonoStyle),
              const SizedBox(height: 6),
              Text('source = "$demoSrc"', style: kMonoDimStyle),
              const SizedBox(height: 6),
              Text('textBefore -> "${demo.textBefore(demoSrc)}"',
                  style: kMonoStyle),
              Text('textInside -> "${demo.textInside(demoSrc)}"',
                  style: kMonoStyle),
              Text('textAfter  -> "${demo.textAfter(demoSrc)}"',
                  style: kMonoStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 8 — ASCII NUMBER LINE FOR BACKWARD SELECTION
// -----------------------------------------------------------------------------

Widget buildNumberLineSection() {
  const TextSelection backward =
      TextSelection(baseOffset: 17, extentOffset: 7);
  const String src = 'Hello, beautiful world!';
  return panelContainer(
    color: const Color(0xFF0E1726),
    borderColor: kAccentAmber.withValues(alpha: 0.45),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pillBadge('ASCII DIAGRAM', kAccentAmber),
            const SizedBox(width: 8),
            pillBadge('backward selection', kAccentPink),
          ],
        ),
        const SizedBox(height: 12),
        const Text('Reading start/end vs base/extent',
            style: kCardTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'When a user drags right-to-left the selection is "backward": '
          'baseOffset > extentOffset. start always equals min(base, '
          'extent), end always equals max(base, extent). textBefore / '
          'textInside / textAfter are computed on the normalized range, '
          'not on (base, extent) directly.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 14),
        const Text('SOURCE', style: kLabelStyle),
        const SizedBox(height: 6),
        Text('"$src"', style: kMonoStyle),
        const SizedBox(height: 14),
        const Text('NUMBER LINE', style: kLabelStyle),
        const SizedBox(height: 6),
        const Text(
          "  index : 0    5    10   15   20\n"
          "          |    |    |    |    |\n"
          "  text  : H e l l o ,   b e a u t i f u l   w o r l d !\n"
          "                       ^                ^\n"
          "                       |                |\n"
          "                  extentOffset     baseOffset\n"
          "                     (=7)             (=17)\n"
          "                       <================<\n"
          "                       drag direction (RTL gesture)\n"
          "\n"
          "  start = min(base, extent) = 7\n"
          "  end   = max(base, extent) = 17\n"
          "  textInside('Hello, beautiful world!') == 'beautiful'",
          style: kMonoStyle,
        ),
        const SizedBox(height: 14),
        keyValueRow('baseOffset', '${backward.baseOffset}'),
        keyValueRow('extentOffset', '${backward.extentOffset}'),
        keyValueRow('start', '${backward.start}',
            valueColor: kAccentGreen),
        keyValueRow('end', '${backward.end}', valueColor: kAccentGreen),
        keyValueRow('isNormalized', '${backward.isNormalized}'),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 9 — RECIPE: EditableText + controlled selection
// -----------------------------------------------------------------------------

const String kRecipeCode = '''
class _MyFieldState extends State<MyField> {
  final TextEditingController _controller =
      TextEditingController(text: 'Hello world');
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Pre-select the first 5 characters of the field so the user can
    // immediately start typing to overwrite the greeting.
    _controller.selection = const TextSelection(
      baseOffset: 0,
      extentOffset: 5,
      affinity: TextAffinity.downstream,
      isDirectional: false,
    );
  }

  void _selectWordAtOffset(int offset) {
    final text = _controller.text;
    int start = offset;
    int end = offset;
    while (start > 0 && text[start - 1] != ' ') start--;
    while (end < text.length && text[end] != ' ') end++;
    _controller.selection =
        TextSelection(baseOffset: start, extentOffset: end);
  }

  void _collapseToEnd() {
    _controller.selection =
        TextSelection.collapsed(offset: _controller.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return EditableText(
      controller: _controller,
      focusNode: _focus,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      cursorColor: Colors.blue,
      backgroundCursorColor: Colors.grey,
      onSelectionChanged: (TextSelection sel, SelectionChangedCause? cause) {
        // Inspect sel.start, sel.end, sel.isCollapsed, sel.affinity
      },
    );
  }
}
''';

Widget buildRecipeSection() {
  return panelContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pillBadge('RECIPE', kAccentGreen),
            const SizedBox(width: 8),
            pillBadge('EditableText', kAccentBlue),
          ],
        ),
        const SizedBox(height: 12),
        const Text('Driving an EditableText with TextSelection',
            style: kCardTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'TextEditingController.selection is just a TextSelection. By '
          'assigning to it you can pre-select text on focus, expand a '
          'selection to a word, or move the caret programmatically.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 14),
        panelContainer(
          color: const Color(0xFF0A1320),
          borderColor: kPanelBorderColor,
          padding: const EdgeInsets.all(14),
          child: Text(kRecipeCode, style: kMonoStyle),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// SECTION 10 — PITFALLS
// -----------------------------------------------------------------------------

class Pitfall {
  final String title;
  final String body;
  final Color color;
  const Pitfall(this.title, this.body, this.color);
}

const List<Pitfall> kPitfalls = <Pitfall>[
  Pitfall(
    '-1 offset means "no selection"',
    'TextSelection.collapsed(offset: -1) is the canonical sentinel for '
        '"no current selection". Always check sel.isValid before treating '
        'baseOffset as a real index, otherwise you risk rendering a caret '
        'at an out-of-range position.',
    kAccentPink,
  ),
  Pitfall(
    'isDirectional matters for shift+arrow extension',
    'When isDirectional is true, the framework remembers which end of the '
        'selection is the "anchor" and shift+arrow always grows from the '
        'opposite end — even if base > extent. With isDirectional false, '
        'the active end is always extentOffset.',
    kAccentPurple,
  ),
  Pitfall(
    'textInside requires a normalized range',
    'Calling textInside on a backward (un-normalized) range can return an '
        'empty string. Either guard with isNormalized, or build a '
        'normalized TextSelection by swapping base and extent before '
        'slicing.',
    kAccentAmber,
  ),
  Pitfall(
    'TextSelection equality includes affinity',
    'Two selections with identical base/extent but different affinity '
        'compare unequal. Beware of this when caching selections in maps '
        'or comparing them in tests.',
    kAccentTeal,
  ),
];

Widget pitfallCard(Pitfall p) {
  return panelContainer(
    color: const Color(0xFF14202F),
    borderColor: p.color.withValues(alpha: 0.45),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: p.color, size: 18),
            const SizedBox(width: 6),
            Expanded(child: Text(p.title, style: kCardTitleStyle)),
          ],
        ),
        const SizedBox(height: 8),
        Text(p.body, style: kCardBodyStyle),
      ],
    ),
  );
}

Widget buildPitfallsSection() {
  final List<Widget> cards = <Widget>[];
  for (final Pitfall p in kPitfalls) {
    cards.add(pitfallCard(p));
    cards.add(const SizedBox(height: 12));
  }
  if (cards.isNotEmpty) cards.removeLast();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cards,
  );
}

// -----------------------------------------------------------------------------
// SECTION 11 — USAGE IN FLUTTER WIDGETS
// -----------------------------------------------------------------------------

Widget widgetUsageRow(IconData icon, String widget, String purpose) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: kAccentBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kAccentBlue.withValues(alpha: 0.4)),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: kAccentBlue, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget,
                  style: const TextStyle(
                    color: kTextPrimary,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  )),
              const SizedBox(height: 4),
              Text(purpose, style: kCardBodyStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildUsageSection() {
  return panelContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Where TextSelection is used', style: kCardTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'TextSelection is the unifying selection model across Flutter\'s '
          'text editing surface area. Every interactive text widget below '
          'reads, writes, or both, the selection on a TextEditingController.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 12),
        widgetUsageRow(Icons.edit, 'EditableText',
            'Low-level text editor. Owns rendering, caret painting, and '
                'selection handles. controller.selection IS a TextSelection.'),
        widgetUsageRow(Icons.text_fields, 'TextField',
            'Material wrapper around EditableText. Decoration aside, all '
                'selection mutations route through TextEditingController.'),
        widgetUsageRow(Icons.copy_rounded, 'SelectableText',
            'Read-only text that supports selection (copy, share). '
                'Reports current TextSelection via onSelectionChanged.'),
        widgetUsageRow(Icons.format_align_left, 'CupertinoTextField',
            'iOS-styled equivalent of TextField. Shares the same '
                'TextSelection-driven controller model.'),
        widgetUsageRow(Icons.text_format, 'RenderEditable',
            'Render object backing EditableText. Uses TextSelection to '
                'paint highlight rects and the caret.'),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// FOOTER
// -----------------------------------------------------------------------------

Widget buildFooter() {
  return panelContainer(
    color: const Color(0xFF0E1726),
    borderColor: kPanelBorderColor,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('In summary', style: kCardTitleStyle),
        const SizedBox(height: 8),
        const Text(
          'TextSelection is small, immutable, and absolutely central to '
          'text editing in Flutter. Master baseOffset / extentOffset / '
          'affinity / isDirectional and the inherited TextRange slicing '
          'methods, and you have a complete mental model for cursors, '
          'drag-selections, IME composition spans, copy / paste targets, '
          'and programmatic field manipulation.',
          style: kCardBodyStyle,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            pillBadge('package:flutter/services.dart', kAccentBlue),
            const SizedBox(width: 8),
            pillBadge('extends TextRange', kAccentTeal),
            const SizedBox(width: 8),
            pillBadge('immutable', kAccentGreen),
            const SizedBox(width: 8),
            pillBadge('@immutable', kAccentPurple),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Generated by the Tom AI flutter_ast visual demo corpus. '
          'No runApp, no controllers, no async — just a static build().',
          style: kMonoDimStyle,
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// ENTRY POINT
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  final List<Widget> sections = <Widget>[
    buildHeroSection(),
    sectionTitle('1', 'Anatomy of TextSelection'),
    buildAnatomySection(),
    sectionTitle('2', 'Six sample selections — visual'),
    buildSampleSelectionsSection(),
    sectionTitle('3', 'TextAffinity — upstream vs downstream'),
    buildAffinitySection(),
    sectionTitle('4', 'Constructor gallery'),
    buildConstructorGallerySection(),
    sectionTitle('5', 'TextSelection.empty / no-selection sentinel'),
    buildEmptySection(),
    sectionTitle('6', 'TextRange — the parent class'),
    buildTextRangeSection(),
    sectionTitle('7', 'ASCII number line — backward selection'),
    buildNumberLineSection(),
    sectionTitle('8', 'Recipe — controlling EditableText'),
    buildRecipeSection(),
    sectionTitle('9', 'Pitfalls'),
    buildPitfallsSection(),
    sectionTitle('10', 'Where TextSelection is used'),
    buildUsageSection(),
    const SizedBox(height: 32),
    buildFooter(),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextSelection — Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBackgroundColor,
    ),
    home: Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: sections,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
