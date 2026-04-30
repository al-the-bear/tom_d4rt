// ignore_for_file: avoid_print
// ExtendSelectionVerticallyToAdjacentLineIntent – comprehensive deep demo
// Teal Abyss / Seafoam palette – intent extending the selection extent
// vertically to the same column on the adjacent line (Shift+Up/Down).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color vlTealAbyss = Color(0xFF004D40);
  const Color vlSeafoam = Color(0xFFE0F2F1);
  const Color vlOnTeal = Color(0xFFFFFFFF);
  const Color vlDeepTeal = Color(0xFF00251A);
  const Color vlLightMint = Color(0xFFF1F9F8);
  const Color vlTextDark = Color(0xFF1B3A34);
  const Color vlAccent = Color(0xFF00BFA5);
  const Color vlMuted = Color(0xFF80CBC4);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget vlHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [vlTealAbyss, vlDeepTeal],
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
                  color: vlOnTeal)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: vlOnTeal.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget vlSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: vlLightMint,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: vlTealAbyss.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: vlTealAbyss.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: vlTealAbyss)),
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

  Widget vlBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('● ',
              style: TextStyle(color: vlAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: vlTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget vlCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0D2E28),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: vlSeafoam,
              height: 1.5)),
    );
  }

  Widget vlKeyValue(String key, String value) {
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
                    color: vlDeepTeal)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: vlTextDark)),
          ),
        ],
      ),
    );
  }

  Widget vlHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: vlAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: vlAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: vlDeepTeal,
              height: 1.4)),
    );
  }

  Widget vlDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: vlMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget vlCompare(String label, String desc) {
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
              color: vlTealAbyss,
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
                          color: vlDeepTeal)),
                  TextSpan(
                      text: desc,
                      style:
                          const TextStyle(fontSize: 11, color: vlTextDark)),
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
    color: vlSeafoam,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          vlHeader(
            'ExtendSelectionVerticallyToAdjacentLineIntent',
            'Vertical selection – extends the selection extent up or down '
                'to the adjacent line while preserving column affinity',
          ),

          // ── 1. class overview ──
          vlSection('1 · Class Identity & Inheritance', [
            vlKeyValue('Class',
                'ExtendSelectionVerticallyToAdjacentLineIntent'),
            vlKeyValue('Extends',
                'DirectionalCaretMovementIntent → DirectionalTextEditingIntent'),
            vlKeyValue('Property – forward',
                'bool: true = downward / false = upward'),
            vlKeyValue('Mixin', 'Diagnosticable (via intent hierarchy)'),
            vlDivider(),
            vlBullet(
                'This intent represents a request to extend the current text '
                'selection vertically by exactly one line, keeping the horizontal '
                'column position as close as possible to the original.'),
            vlBullet(
                'It is the selection-extending counterpart of '
                'MoveSelectionToAdjacentLineIntent, which moves the caret '
                'without preserving the selection.'),
            vlCodeBlock(
                'class ExtendSelectionVerticallyToAdjacentLineIntent\n'
                '    extends DirectionalCaretMovementIntent {\n'
                '  const ExtendSelectionVerticallyToAdjacentLineIntent({\n'
                '    required bool forward,\n'
                '  }) : super(forward);\n'
                '}'),
          ]),

          // ── 2. vertical navigation model ──
          vlSection('2 · The Vertical Navigation Model', [
            vlHighlight(
                'Vertical movement in a text field means moving to the adjacent '
                'visual line while preserving the preferred horizontal column. '
                'The "column affinity" tracks the original X position so that '
                'moving through short lines and back to long ones returns the '
                'caret to its preferred column.'),
            vlBullet(
                'When forward=true, the extent moves to the line below; '
                'when forward=false, it moves to the line above.'),
            vlBullet(
                'The base offset remains unchanged, extending the selection '
                'to encompass text between the original base and the new extent.'),
            vlBullet(
                'Column affinity is reset when the user performs a horizontal '
                'movement; vertical-only movements preserve it.'),
            vlDivider(),
            vlKeyValue('Forward (true)', 'Extend downward to next visual line'),
            vlKeyValue('Forward (false)', 'Extend upward to previous visual line'),
            vlKeyValue('Column affinity', 'Preserved across consecutive vertical moves'),
          ]),

          // ── 3. column affinity explained ──
          vlSection('3 · Column Affinity in Detail', [
            vlBullet(
                'Column affinity is the pixel X-offset of the caret at the '
                'moment vertical movement begins. It is stored temporarily '
                'in the editable text state.'),
            vlBullet(
                'When the caret moves to a shorter line, it snaps to the end '
                'of that line. When it then moves to a longer line, it returns '
                'to the original pixel X-offset.'),
            vlBullet(
                'Example: caret at column 40 on line 1 → move down to line 2 '
                '(only 20 chars) → caret goes to end of line 2, column 20 → '
                'move down to line 3 (80 chars) → caret returns to column 40.'),
            vlCodeBlock(
                '// Column affinity walkthrough\n'
                '// Line 1: "The quick brown fox jumps over the lazy dog"\n'
                '//          ^ caret at column 40\n'
                '// Line 2: "Short line"\n'
                '//                    ^ snaps to end (column 10)\n'
                '// Line 3: "Another long line with plenty of text here"\n'
                '//                                        ^ returns to col 40'),
            vlDivider(),
            vlBullet(
                'Column affinity is measured in logical pixels, not character '
                'offsets, because proportional fonts make character-counting '
                'inaccurate for column positioning.'),
          ]),

          // ── 4. downward walkthrough ──
          vlSection('4 · Downward Extension Walk-Through', [
            vlBullet(
                'Text field with three lines. Selection is collapsed at line 1, '
                'offset 15.'),
            vlBullet(
                'User presses Shift+Down → fires intent with forward=true.'),
            vlBullet(
                'Action computes the pixel position of offset 15 on line 1. '
                'It then finds the closest offset on line 2 at that X position.'),
            vlBullet(
                'Suppose line 2 has a matching offset at 45. Selection becomes '
                'TextSelection(baseOffset: 15, extentOffset: 45).'),
            vlDivider(),
            vlBullet(
                'Pressing Shift+Down again extends further. The pixel X is '
                'preserved from the original column affinity, not from the '
                'current extent position on line 2.'),
            vlCodeBlock(
                '// Shift+Down from collapsed offset 15\n'
                'const intent = ExtendSelectionVerticallyTo\n'
                '    AdjacentLineIntent(forward: true);\n'
                '// Result: selection = TextSelection(base: 15, extent: 45)'),
          ]),

          // ── 5. upward walkthrough ──
          vlSection('5 · Upward Extension Walk-Through', [
            vlBullet(
                'Selection spans from line 1 offset 15 (base) to line 2 offset '
                '45 (extent). User presses Shift+Up.'),
            vlBullet(
                'Intent fires with forward=false. The extent at offset 45 '
                'needs to move up one visual line.'),
            vlBullet(
                'The system computes the X position for offset 45 (using '
                'column affinity if available), finds the nearest offset on '
                'line 1 at that X → suppose it resolves to offset 15.'),
            vlBullet(
                'Selection becomes collapsed: TextSelection.collapsed(offset: 15). '
                'The base and extent coincide.'),
            vlDivider(),
            vlBullet(
                'Pressing Shift+Up again from collapsed offset 15 would extend '
                'upward. If line 1 is the first line, no movement occurs.'),
            vlHighlight(
                'The interplay between upward and downward extension creates '
                'the familiar desktop text-selection experience: hold Shift '
                'and press Up/Down to grow or shrink the selection line by line.'),
          ]),

          // ── 6. soft-wrap interaction ──
          vlSection('6 · Soft-Wrap Line vs Hard-Line', [
            vlBullet(
                'A visual "line" in this context is a soft-wrapped line, NOT '
                'a logical paragraph separated by newline characters.'),
            vlBullet(
                'If a single paragraph wraps into three visual lines, pressing '
                'Shift+Down moves the extent to the next visual line within '
                'the same paragraph.'),
            vlBullet(
                'This is critical for long paragraphs in narrow text fields: '
                'the user expects line-by-line vertical movement matching '
                'what they see, not jump-to-next-paragraph.'),
            vlDivider(),
            vlKeyValue('Visual line', 'One row of rendered text (may be a wrap)'),
            vlKeyValue('Logical line', 'Text between newline characters'),
            vlKeyValue('This intent targets', 'Visual lines'),
            vlCodeBlock(
                '// Soft-wrapped paragraph\n'
                '// Visual line 1: "The quick brown fox jumps"\n'
                '// Visual line 2: "over the lazy dog near the"\n'
                '// Visual line 3: "river bank."\n'
                '// Shift+Down from line 1 → extent moves to line 2'),
          ]),

          // ── 7. comparison with related intents ──
          vlSection('7 · Comparison with Related Intents', [
            vlCompare('MoveSelectionVerticallyToAdjacentLineIntent',
                'Same vertical movement but collapses selection (no extend)'),
            vlCompare('ExtendSelectionVerticallyToAdjacentPageIntent',
                'Page-level vertical extend, not single-line'),
            vlCompare('ExtendSelectionToLineBreakIntent',
                'Extends horizontally to begin/end of line, not vertically'),
            vlCompare('ExtendSelectionByCharacterIntent',
                'Character-level, horizontal movement only'),
            vlCompare('ExtendSelectionToNextWordBoundaryIntent',
                'Word-level horizontal, no vertical movement'),
            vlDivider(),
            vlBullet(
                'The adjacent-line intent is unique in targeting visual lines '
                'vertically while preserving column affinity, which no '
                'horizontal intent does.'),
          ]),

          // ── 8. keyboard shortcuts ──
          vlSection('8 · Keyboard Shortcut Mapping', [
            vlKeyValue('All platforms', 'Shift+ArrowDown / Shift+ArrowUp'),
            vlKeyValue('macOS', 'Shift+Down/Up (same; no modifier difference)'),
            vlKeyValue('Web', 'Shift+Down/Up (Flutter overrides browser default)'),
            vlDivider(),
            vlBullet(
                'This is one of the most universally consistent shortcuts: '
                'Shift+Arrow Up/Down works the same everywhere.'),
            vlCodeBlock(
                '// Shortcut registration (simplified)\n'
                'SingleActivator(\n'
                '  LogicalKeyboardKey.arrowDown,\n'
                '  shift: true,\n'
                '): const ExtendSelectionVerticallyTo\n'
                '    AdjacentLineIntent(forward: true),\n'
                'SingleActivator(\n'
                '  LogicalKeyboardKey.arrowUp,\n'
                '  shift: true,\n'
                '): const ExtendSelectionVerticallyTo\n'
                '    AdjacentLineIntent(forward: false),'),
          ]),

          // ── 9. dispatch pipeline ──
          vlSection('9 · Action Dispatch Pipeline', [
            vlBullet(
                'EditableText registers an action for this intent type. The '
                'action reads the current selection extent offset and the '
                'stored column affinity pixel value.'),
            vlBullet(
                'Using TextPainter, it determines which visual line the extent '
                'is on, then finds the offset on the adjacent visual line '
                'at the same pixel X coordinate.'),
            vlBullet(
                'If no adjacent line exists in the requested direction '
                '(top or bottom of text), the action is a no-op.'),
            vlBullet(
                'The resulting selection preserves the original base offset '
                'and sets the extent to the newly computed offset.'),
            vlDivider(),
            vlCodeBlock(
                '// Pseudo-code for the action\n'
                'void invoke(ExtendSelectionVerticallyTo\n'
                '    AdjacentLineIntent intent) {\n'
                '  final pos = textPainter.getOffsetForCaret(\n'
                '    TextPosition(offset: selection.extentOffset),\n'
                '    Rect.zero,\n'
                '  );\n'
                '  final targetY = intent.forward\n'
                '      ? pos.dy + lineHeight\n'
                '      : pos.dy - lineHeight;\n'
                '  final newOffset = textPainter.getPositionForOffset(\n'
                '    Offset(columnAffinity ?? pos.dx, targetY),\n'
                '  ).offset;\n'
                '  updateSelection(TextSelection(\n'
                '    baseOffset: selection.baseOffset,\n'
                '    extentOffset: newOffset,\n'
                '  ));\n'
                '}'),
          ]),

          // ── 10. multi-line text fields ──
          vlSection('10 · Multi-Line Text Fields', [
            vlBullet(
                'This intent is most meaningful in multi-line text fields '
                '(maxLines > 1 or maxLines = null).'),
            vlBullet(
                'In single-line TextFields, vertical movement has no effect '
                'because there is only one visual line.'),
            vlBullet(
                'For TextFormField with maxLines: null, the field grows '
                'dynamically and Shift+Down extends selection into '
                'newly visible lines.'),
            vlDivider(),
            vlCodeBlock(
                '// Multi-line field where vertical selection works\n'
                'TextField(\n'
                '  maxLines: null,\n'
                '  minLines: 5,\n'
                '  controller: TextEditingController(\n'
                '    text: \'Line 1\\nLine 2\\nLine 3\\nLine 4\\nLine 5\',\n'
                '  ),\n'
                ')'),
          ]),

          // ── 11. scrolling interaction ──
          vlSection('11 · Scrolling & Viewport', [
            vlBullet(
                'When extending selection downward past the visible viewport, '
                'the EditableText automatically scrolls to keep the extent '
                'position visible.'),
            vlBullet(
                'Scroll speed is matched to the line height, so each '
                'Shift+Down scrolls by exactly one visual line.'),
            vlBullet(
                'The selection highlight paints continuously even through '
                'the scrolled region, giving visual feedback of the full '
                'selected range.'),
            vlHighlight(
                'This auto-scroll behavior means users can select large '
                'blocks of text by holding Shift+Down without manual '
                'scrolling – the viewport follows the extending selection.'),
          ]),

          // ── 12. RTL text ──
          vlSection('12 · RTL & Bidirectional Text', [
            vlBullet(
                'Vertical movement is direction-agnostic with respect to text '
                'direction: forward=true always means downward regardless of '
                'whether text is LTR or RTL.'),
            vlBullet(
                'Column affinity is pixel-based, so it naturally adapts to RTL '
                'layout where the caret starts on the right side.'),
            vlBullet(
                'In mixed-direction text, the column affinity tracks the desired '
                'X position; the nearest offset at that X on the target line '
                'may be logically distant but visually aligned.'),
            vlDivider(),
            vlKeyValue('LTR down', 'Caret moves visually downward'),
            vlKeyValue('RTL down', 'Caret moves visually downward (same)'),
            vlKeyValue('Difference', 'Column affinity X is measured from the right in RTL'),
          ]),

          // ── 13. custom action overrides ──
          vlSection('13 · Custom Action Overrides', [
            vlBullet(
                'Override the default action by wrapping in an Actions widget '
                'with a custom callback for this intent type.'),
            vlBullet(
                'Common customizations include skipping blank lines or '
                'extending by a fixed number of lines per press.'),
            vlCodeBlock(
                'Actions(\n'
                '  actions: <Type, Action<Intent>>{\n'
                '    ExtendSelectionVerticallyToAdjacentLineIntent:\n'
                '      CallbackAction<ExtendSelectionVertically\n'
                '          ToAdjacentLineIntent>(\n'
                '        onInvoke: (intent) {\n'
                '          print(\'Custom vertical extend: \'\n'
                '              \'forward=\${intent.forward}\');\n'
                '          return null;\n'
                '        },\n'
                '      ),\n'
                '  },\n'
                '  child: child,\n'
                ')'),
            vlDivider(),
            vlBullet(
                'The intent object provides the forward property so the '
                'custom action knows whether to extend up or down.'),
          ]),

          // ── 14. edge cases ──
          vlSection('14 · Edge Cases & Boundary Conditions', [
            vlBullet(
                'At first visual line, forward=false is a no-op – the extent '
                'cannot move above the top of the text.'),
            vlBullet(
                'At last visual line, forward=true is a no-op – the extent '
                'cannot move below the bottom of the text.'),
            vlBullet(
                'Empty text: both directions are no-ops since there are '
                'no lines to move between.'),
            vlBullet(
                'Single-character-per-line text: each Shift+Down/Up advances '
                'by exactly one character because each character is its own '
                'visual line.'),
            vlBullet(
                'Very long lines that soft-wrap multiple times: each '
                'Shift+Down moves by one visual wrap segment, not the '
                'entire logical line.'),
            vlDivider(),
            vlBullet(
                'Text fields with dense content (code editors) rely heavily '
                'on this intent for block selection with Shift+Down/Up '
                'navigation.'),
          ]),

          // ── 15. testing strategies ──
          vlSection('15 · Testing Strategies', [
            vlBullet(
                'Use tester.sendKeyDownEvent / sendKeyUpEvent for Shift key '
                'combined with tester.sendKeyEvent for Arrow keys.'),
            vlBullet(
                'Verify selection base stays fixed while extent changes '
                'with each Shift+Down/Up press.'),
            vlCodeBlock(
                'testWidgets(\'vertical extend one line down\',\n'
                '    (WidgetTester tester) async {\n'
                '  final controller = TextEditingController(\n'
                '    text: \'AAA\\nBBB\\nCCC\',\n'
                '  );\n'
                '  await tester.pumpWidget(MaterialApp(\n'
                '    home: Scaffold(\n'
                '      body: TextField(\n'
                '        maxLines: null,\n'
                '        controller: controller,\n'
                '      ),\n'
                '    ),\n'
                '  ));\n'
                '  // tap to place caret, then Shift+Down\n'
                '  await tester.tap(find.byType(TextField));\n'
                '  // verify selection base/extent\n'
                '});'),
            vlDivider(),
            vlBullet(
                'Golden tests for soft-wrapped paragraphs capture the exact '
                'highlight region painted after vertical extension.'),
          ]),

          // ── 16. performance ──
          vlSection('16 · Performance Considerations', [
            vlBullet(
                'Line-to-line offset resolution uses TextPainter.getPositionForOffset '
                'which is O(log n) on the line layout cache, very fast.'),
            vlBullet(
                'Column affinity storage is a single double value, no heap '
                'allocation per keystroke.'),
            vlBullet(
                'The selection change triggers a repaint of the highlight; '
                'for large selections this means repainting a larger area, '
                'but the highlight routine is optimized as a single path fill.'),
          ]),

          // ── 17. accessibility ──
          vlSection('17 · Accessibility & Screen Readers', [
            vlBullet(
                'Semantics updates announce the newly selected text range '
                'when the selection changes vertically.'),
            vlBullet(
                'Screen readers may read the entire newly selected line '
                'or just the delta depending on platform conventions.'),
            vlBullet(
                'VoiceOver on macOS reads "selected: <text>" when '
                'Shift+Down extends the selection by one line.'),
          ]),

          // ── 18. API summary ──
          vlSection('18 · Quick API Reference', [
            vlKeyValue('Constructor',
                'const ExtendSelectionVerticallyToAdjacentLineIntent'
                '({required bool forward})'),
            vlKeyValue('Property', 'forward: bool (true = down, false = up)'),
            vlKeyValue('Super', 'DirectionalCaretMovementIntent'),
            vlKeyValue('Root', 'Intent'),
            vlDivider(),
            vlCodeBlock(
                '// Extend selection down one visual line\n'
                'const down = ExtendSelectionVerticallyTo\n'
                '    AdjacentLineIntent(forward: true);\n'
                '\n'
                '// Extend selection up one visual line\n'
                'const up = ExtendSelectionVerticallyTo\n'
                '    AdjacentLineIntent(forward: false);'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: vlTealAbyss.withValues(alpha: 0.06),
            child: const Text(
              'ExtendSelectionVerticallyToAdjacentLineIntent · '
              'Teal Abyss Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: vlMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
