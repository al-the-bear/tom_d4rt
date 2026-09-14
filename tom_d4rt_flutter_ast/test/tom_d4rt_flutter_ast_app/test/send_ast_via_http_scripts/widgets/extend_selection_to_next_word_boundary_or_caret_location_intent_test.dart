// ignore_for_file: avoid_print
// ExtendSelectionToNextWordBoundaryOrCaretLocationIntent – comprehensive deep demo
// Crimson Lake / Rose Quartz palette – composite intent extending selection
// to the next word boundary OR the caret location, whichever is closer.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color wcCrimson = Color(0xFFA51C30);
  const Color wcRoseQuartz = Color(0xFFFCE4EC);
  const Color wcOnCrimson = Color(0xFFFFFFFF);
  const Color wcDarkRose = Color(0xFF880E4F);
  const Color wcLightBlush = Color(0xFFFFF0F3);
  const Color wcTextDark = Color(0xFF3E2723);
  const Color wcAccent = Color(0xFFFF5252);
  const Color wcMuted = Color(0xFFBCAAA4);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget wcHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [wcCrimson, wcDarkRose],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: wcOnCrimson)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: wcOnCrimson.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget wcSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: wcLightBlush,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: wcCrimson.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: wcCrimson.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: wcCrimson)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget wcBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('● ',
              style: TextStyle(color: wcAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: wcTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget wcCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2020),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: wcRoseQuartz,
              height: 1.5)),
    );
  }

  Widget wcKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: wcDarkRose)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: wcTextDark)),
          ),
        ],
      ),
    );
  }

  Widget wcHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: wcAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: wcAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: wcDarkRose,
              height: 1.4)),
    );
  }

  Widget wcDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: wcMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget wcCompare(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: wcCrimson,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: wcDarkRose)),
                  TextSpan(
                      text: desc,
                      style:
                          const TextStyle(fontSize: 11, color: wcTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: wcRoseQuartz,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          wcHeader(
            'ExtendSelectionToNextWordBoundaryOrCaretLocationIntent',
            'Composite intent – extends selection extent to the next word '
                'boundary or the caret (base) location, whichever is closer',
          ),

          // ── 1. class overview ──
          wcSection('1 · Class Identity & Inheritance', [
            wcKeyValue('Class',
                'ExtendSelectionToNextWordBoundaryOrCaretLocationIntent'),
            wcKeyValue('Extends',
                'DirectionalCaretMovementIntent → DirectionalTextEditingIntent'),
            wcKeyValue('Property – forward',
                'bool indicating the direction of exploration'),
            wcKeyValue('Mixin', 'Diagnosticable (via intent hierarchy)'),
            wcDivider(),
            wcBullet(
                'This intent represents a combined movement: the selection extent '
                'moves to whichever is closer – the next word boundary or the '
                'current caret (base) location.'),
            wcBullet(
                'The intent is directional: when forward is true it explores toward '
                'the end of text; when false, toward the start.'),
            wcBullet(
                'It is one of several "OrCaretLocation" intents that offer compound '
                'destination logic, differing from simple boundary intents that '
                'always jump to the boundary.'),
            wcCodeBlock(
                'class ExtendSelectionToNextWordBoundaryOrCaretLocationIntent\n'
                '    extends DirectionalCaretMovementIntent {\n'
                '  const ExtendSelectionToNextWordBoundaryOrCaretLocationIntent({\n'
                '    required bool forward,\n'
                '  }) : super(forward);\n'
                '}'),
          ]),

          // ── 2. the composite destination concept ──
          wcSection('2 · The Composite Destination Concept', [
            wcHighlight(
                'Instead of always jumping to the word boundary, the system checks '
                'two candidate positions – the next word boundary and the caret '
                '(base) position – and extends the selection extent to whichever '
                'is nearer in the intended direction.'),
            wcBullet(
                'If the selection is collapsed, the caret position IS the base, '
                'so the word boundary is always chosen (like a plain '
                'ExtendSelectionToNextWordBoundaryIntent).'),
            wcBullet(
                'If the selection is non-collapsed and the word boundary is farther '
                'than the base, the selection snaps back to the base – '
                'effectively collapsing the selection.'),
            wcBullet(
                'This behavior models Option+Shift+Arrow on macOS and '
                'Ctrl+Shift+Arrow on some platforms when near the base.'),
            wcDivider(),
            wcKeyValue('Collapsed selection', 'Always jumps to word boundary'),
            wcKeyValue('Extent past base',
                'Snaps to whichever is closer to extent'),
            wcKeyValue('Extent equals base', 'Behaves like simple word-boundary'),
          ]),

          // ── 3. forward walkthrough ──
          wcSection('3 · Forward Selection Walk-Through', [
            wcBullet(
                'Text: "The quick brown fox" with caret at offset 4 (before "q").'),
            wcBullet(
                'Forward=true → intent fires. Candidate 1: next word boundary = '
                'offset 9 (end of "quick"). Candidate 2: caret base = 4.'),
            wcBullet(
                'Selection is collapsed, so extent moves to offset 9. '
                'Result: selection = TextSelection(baseOffset: 4, extentOffset: 9).'),
            wcDivider(),
            wcBullet(
                'Now extent is at 9, base still at 4. Fire again forward.'),
            wcBullet(
                'Next word boundary from 9 = offset 15 (end of "brown"). '
                'Caret base = 4. Nearer to 9 is neither especially; '
                'word boundary at 15 is chosen because base is behind extent.'),
            wcBullet(
                'Result: TextSelection(baseOffset: 4, extentOffset: 15).'),
            wcCodeBlock(
                '// Scenario: collapsed at offset 4\n'
                'const intent = ExtendSelectionToNextWordBoundary\n'
                '    OrCaretLocationIntent(forward: true);\n'
                '// After dispatch:\n'
                '// selection = TextSelection(base: 4, extent: 9)'),
          ]),

          // ── 4. backward walkthrough ──
          wcSection('4 · Backward Selection Walk-Through', [
            wcBullet(
                'Text: "The quick brown fox" with selection(base: 9, extent: 15).'),
            wcBullet(
                'Fire with forward=false from extent at 15. Candidate 1: previous '
                'word boundary from 15 = offset 10 (start of "brown"). '
                'Candidate 2: base = 9.'),
            wcBullet(
                'Offset 10 is closer to 15 than 9 is? 10 vs 9, both close. '
                'Word boundary at 10 is nearer → extent moves to 10.'),
            wcBullet(
                'Result: TextSelection(baseOffset: 9, extentOffset: 10).'),
            wcDivider(),
            wcBullet(
                'Fire backward again from extent at 10. Previous word boundary '
                'from 10 = offset 4 (start of "quick"). Base = 9.'),
            wcBullet(
                'Base at 9 is nearer to 10 than word boundary at 4 → selection '
                'snaps to base, collapsing: TextSelection.collapsed(offset: 9).'),
            wcHighlight(
                'This snap-to-base behavior distinguishes the "OrCaretLocation" '
                'intents from plain boundary intents. The selection '
                'collapses instead of overshooting past the original caret.'),
          ]),

          // ── 5. comparison with related intents ──
          wcSection('5 · Comparison with Related Intents', [
            wcCompare('ExtendSelectionToNextWordBoundaryIntent',
                'Always extends to word boundary; never snaps to base'),
            wcCompare('ExtendSelectionToLineBreakIntent',
                'Targets line break, not word boundary'),
            wcCompare(
                'ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent',
                'Same "or caret" pattern but at paragraph granularity'),
            wcCompare('ExtendSelectionByCharacterIntent',
                'Single character; no boundary logic'),
            wcCompare('DirectionalCaretMovementIntent',
                'Base class for all directional caret intents'),
            wcDivider(),
            wcBullet(
                'The "OrCaretLocation" family adds selection-collapse intelligence '
                'that raw boundary intents lack, making text editing feel more '
                'natural when the user reverses direction near the base.'),
          ]),

          // ── 6. keyboard shortcut mapping ──
          wcSection('6 · Keyboard Shortcut Mapping', [
            wcKeyValue('macOS',
                'Option+Shift+Right / Option+Shift+Left (word-level extend)'),
            wcKeyValue('Linux / Windows',
                'Ctrl+Shift+Right / Ctrl+Shift+Left'),
            wcKeyValue('iOS',
                'Option+Shift+Arrow with on-screen keyboard shortcuts'),
            wcKeyValue('Android',
                'Typically Ctrl+Shift+Arrow on physical keyboards'),
            wcDivider(),
            wcBullet(
                'Platform-specific DefaultTextEditingShortcuts maps the physical '
                'key combo to this intent through the Shortcuts widget ancestor.'),
            wcBullet(
                'On macOS the Option modifier is critical; Ctrl+Shift targets '
                'a different granularity depending on the intent table.'),
            wcCodeBlock(
                '// macOS shortcut registration (simplified)\n'
                'Shortcuts(\n'
                '  shortcuts: <ShortcutActivator, Intent>{\n'
                '    const SingleActivator(\n'
                '      LogicalKeyboardKey.arrowRight,\n'
                '      shift: true,\n'
                '      alt: true,\n'
                '    ): const ExtendSelectionToNextWordBoundary\n'
                '        OrCaretLocationIntent(forward: true),\n'
                '  },\n'
                '  child: child,\n'
                ')'),
          ]),

          // ── 7. dispatch pipeline ──
          wcSection('7 · Action Dispatch Pipeline', [
            wcBullet(
                'EditableText registers an Action<ExtendSelectionToNextWord'
                'BoundaryOrCaretLocationIntent> that reads the current '
                'TextEditingValue and computes the new selection.'),
            wcBullet(
                'The action fetches two candidate offsets: '
                '(a) wordBoundary via TextPainter.getWordBoundary, '
                '(b) base offset of current selection.'),
            wcBullet(
                'It compares distances from the current extent offset '
                'in the specified direction and picks the closer one.'),
            wcBullet(
                'The new TextSelection preserves the original base and '
                'updates only the extent offset.'),
            wcDivider(),
            wcCodeBlock(
                '// Pseudo-code for the action invoke\n'
                'void invoke(ExtendSelectionToNextWordBoundary\n'
                '    OrCaretLocationIntent intent) {\n'
                '  final int extent = selection.extentOffset;\n'
                '  final int wordEdge = intent.forward\n'
                '      ? getNextWordEnd(extent)\n'
                '      : getPreviousWordStart(extent);\n'
                '  final int base = selection.baseOffset;\n'
                '  final int target = _closer(extent, wordEdge, base,\n'
                '      forward: intent.forward);\n'
                '  updateSelection(TextSelection(\n'
                '    baseOffset: base,\n'
                '    extentOffset: target,\n'
                '  ));\n'
                '}'),
          ]),

          // ── 8. soft-wrap interaction ──
          wcSection('8 · Soft-Wrap & Long-Line Behavior', [
            wcBullet(
                'Word boundaries are computed on the logical text string, not '
                'on visual line positions, so soft-wrapping does not affect '
                'word boundary offsets.'),
            wcBullet(
                'However the caret visual position after extending may jump to '
                'a different visual line if the word boundary crosses a wrap.'),
            wcBullet(
                'The intent does not scroll automatically; the enclosing '
                'EditableText scrolls to reveal the new extent position.'),
            wcHighlight(
                'This means pressing Option+Shift+Right at the end of a wrapped '
                'segment will visually jump to the next visual line where the '
                'next word starts – the selection highlight spans the wrap.'),
          ]),

          // ── 9. RTL & bidirectional text ──
          wcSection('9 · RTL & Bidirectional Text', [
            wcBullet(
                'The "forward" property is logical, not visual: forward=true '
                'means toward higher offsets regardless of text direction.'),
            wcBullet(
                'In RTL text, forward=true extends toward the visual left. '
                'Keyboard shortcuts are remapped by DefaultTextEditingShortcuts '
                'so the arrow direction feels natural.'),
            wcBullet(
                'Mixed-direction text can produce visually surprising selection '
                'extents because the word boundary is computed on the logical '
                'string, not the visual glyph order.'),
            wcDivider(),
            wcKeyValue('LTR forward', 'Visually rightward'),
            wcKeyValue('RTL forward', 'Visually leftward'),
            wcKeyValue('Mixed bidi', 'Visual position depends on embedding level'),
          ]),

          // ── 10. custom action overrides ──
          wcSection('10 · Custom Action Overrides', [
            wcBullet(
                'You can override the default action by wrapping the EditableText '
                'in an Actions widget with a custom callback.'),
            wcBullet(
                'Useful for implementing different granularity rules, e.g. '
                'treating CamelCase sub-words as word boundaries.'),
            wcCodeBlock(
                'Actions(\n'
                '  actions: <Type, Action<Intent>>{\n'
                '    ExtendSelectionToNextWordBoundary\n'
                '        OrCaretLocationIntent:\n'
                '      CallbackAction<ExtendSelectionToNextWordBoundary\n'
                '          OrCaretLocationIntent>(\n'
                '        onInvoke: (intent) {\n'
                '          // custom sub-word boundary logic\n'
                '          print(\'Custom word-or-caret extend: \'\n'
                '              \'forward=\${intent.forward}\');\n'
                '          return null;\n'
                '        },\n'
                '      ),\n'
                '  },\n'
                '  child: child,\n'
                ')'),
            wcDivider(),
            wcBullet(
                'In the custom action you receive the intent\'s forward property '
                'and can implement any selection logic you need.'),
            wcBullet(
                'Return null from the callback for a void action; '
                'the framework only requires the Action<Intent> type match.'),
          ]),

          // ── 11. integration with TextField ──
          wcSection('11 · Integration with TextField & CupertinoTextField', [
            wcBullet(
                'Both TextField and CupertinoTextField use EditableText internally, '
                'so they automatically support this intent.'),
            wcBullet(
                'InputDecoration does not interfere with selection intents; '
                'the decoration layer is purely visual.'),
            wcKeyValue('TextField',
                'MaterialApp → DefaultTextEditingShortcuts → registered'),
            wcKeyValue('CupertinoTextField',
                'CupertinoApp → DefaultTextEditingShortcuts → registered'),
            wcDivider(),
            wcCodeBlock(
                '// Works out of the box in a TextField\n'
                'TextField(\n'
                '  controller: TextEditingController(\n'
                '    text: \'The quick brown fox jumps\',\n'
                '  ),\n'
                '  decoration: const InputDecoration(\n'
                '    labelText: \'Try Option+Shift+Arrow\',\n'
                '  ),\n'
                ')'),
          ]),

          // ── 12. edge cases ──
          wcSection('12 · Edge Cases & Boundary Conditions', [
            wcBullet(
                'Empty text: the intent fires but both candidates resolve to '
                'offset 0, so nothing changes.'),
            wcBullet(
                'Single word: forward from start → extent goes to end of word. '
                'Backward from end → snap-to-base if selection has extent past base.'),
            wcBullet(
                'Whitespace-only text: word-boundary finder treats whitespace '
                'runs as a single entity; the boundary is at whitespace edges.'),
            wcBullet(
                'Selection at text start with forward=false: no previous word '
                'boundary exists; intent is a no-op.'),
            wcBullet(
                'Selection at text end with forward=true: no next word boundary; '
                'intent is a no-op.'),
            wcDivider(),
            wcBullet(
                'Punctuation-heavy text: word boundaries vary by Unicode rules. '
                'Dart uses ICU-based word segmentation.'),
            wcBullet(
                'Emoji and extended grapheme clusters are treated as whole units, '
                'so a word boundary will not split a multi-code-point emoji.'),
          ]),

          // ── 13. testing strategies ──
          wcSection('13 · Testing Strategies', [
            wcBullet(
                'Use tester.sendKeyEvent to simulate Option+Shift+Arrow and '
                'verify the resulting selection matches expectations.'),
            wcBullet(
                'Compare with plain ExtendSelectionToNextWordBoundaryIntent '
                'to confirm snap-to-base behavior.'),
            wcCodeBlock(
                '// Example test skeleton\n'
                'testWidgets(\'word-or-caret extends correctly\',\n'
                '    (WidgetTester tester) async {\n'
                '  final controller = TextEditingController(\n'
                '    text: \'Hello world example\',\n'
                '  );\n'
                '  await tester.pumpWidget(\n'
                '    MaterialApp(\n'
                '      home: Scaffold(\n'
                '        body: TextField(controller: controller),\n'
                '      ),\n'
                '    ),\n'
                '  );\n'
                '  await tester.tap(find.byType(TextField));\n'
                '  // position caret, send shortcut, verify selection\n'
                '});'),
            wcDivider(),
            wcBullet(
                'Golden tests can verify highlight rendering when selection '
                'crosses soft-wrap boundaries.'),
          ]),

          // ── 14. performance notes ──
          wcSection('14 · Performance Considerations', [
            wcBullet(
                'Word boundary lookup is O(text_length) in the worst case when '
                'scanning for Unicode boundaries, but typically sub-millisecond '
                'for normal text lengths.'),
            wcBullet(
                'The composite distance comparison adds negligible overhead: '
                'it is a simple integer comparison after the boundary lookup.'),
            wcBullet(
                'No layout reflow is triggered by the intent itself; only the '
                'resulting selection change triggers a repaint of the selection '
                'highlight.'),
          ]),

          // ── 15. platform differences ──
          wcSection('15 · Platform-Specific Behaviors', [
            wcKeyValue('macOS',
                'Option+Shift+Arrow mapped by default; uses system '
                'word-boundary rules via CoreText'),
            wcKeyValue('Windows',
                'Ctrl+Shift+Arrow; word boundaries follow Win32 conventions'),
            wcKeyValue('Linux',
                'Ctrl+Shift+Arrow; ICU-based word segmentation'),
            wcKeyValue('Web',
                'Browser handles some word movement natively; Flutter '
                'overrides with its own intent-action mapping'),
            wcDivider(),
            wcBullet(
                'Platform channel is not involved; word boundary detection is '
                'performed entirely in Dart via the TextPainter and its '
                'underlying paragraph object.'),
          ]),

          // ── 16. accessibility ──
          wcSection('16 · Accessibility & Screen Readers', [
            wcBullet(
                'When the selection changes, the Semantics tree updates to '
                'announce the newly selected text range.'),
            wcBullet(
                'VoiceOver on macOS reads the selected word as the user presses '
                'Option+Shift+Arrow, providing audio feedback for the '
                'extend operation.'),
            wcBullet(
                'TalkBack on Android similarly announces selection changes '
                'triggered by Ctrl+Shift+Arrow on physical keyboards.'),
          ]),

          // ── 17. API summary ──
          wcSection('17 · Quick API Reference', [
            wcKeyValue('Constructor',
                'const ExtendSelectionToNextWordBoundary'
                'OrCaretLocationIntent({required bool forward})'),
            wcKeyValue('Property – forward', 'bool (inherited from super)'),
            wcKeyValue('Super', 'DirectionalCaretMovementIntent'),
            wcKeyValue('Grandparent', 'DirectionalTextEditingIntent'),
            wcKeyValue('Root', 'Intent'),
            wcDivider(),
            wcCodeBlock(
                '// Forward extend – jump to next word end or caret\n'
                'const fwd = ExtendSelectionToNextWordBoundary\n'
                '    OrCaretLocationIntent(forward: true);\n'
                '\n'
                '// Backward extend – jump to previous word start or caret\n'
                'const bwd = ExtendSelectionToNextWordBoundary\n'
                '    OrCaretLocationIntent(forward: false);'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: wcCrimson.withValues(alpha: 0.06),
            child: const Text(
              'ExtendSelectionToNextWordBoundaryOrCaretLocationIntent · '
              'Crimson Lake Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: wcMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
