// ignore_for_file: avoid_print
// Deep demo: ExtendSelectionToLineBreakIntent — extending text selection to
// the nearest line break boundary in a given direction while preserving the
// selection base (anchor) position.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Theme — Deep Plum (#4A148C) / Lilac Mist (#F3E5F5)
  // ---------------------------------------------------------------------------
  const Color lbPlum = Color(0xFF4A148C);
  const Color lbLilac = Color(0xFFF3E5F5);
  const Color lbOrchid = Color(0xFF9C27B0);
  const Color lbAmethyst = Color(0xFFCE93D8);
  const Color lbGrape = Color(0xFF6A1B9A);
  const Color lbLavender = Color(0xFFE1BEE7);
  const Color lbMauve = Color(0xFF8E24AA);
  const Color lbWhite = Color(0xFFFFFFFF);
  const Color lbBlack = Color(0xFF1A0033);
  const Color lbDivider = Color(0xFF7B1FA2);

  // ---------------------------------------------------------------------------
  // Helper: section header
  // ---------------------------------------------------------------------------
  Widget lbHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [lbPlum, lbGrape],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: lbPlum.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lbWhite,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: sub-header
  // ---------------------------------------------------------------------------
  Widget lbSubHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: lbLavender,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lbAmethyst, width: 1.2),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: lbPlum,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: explanation card
  // ---------------------------------------------------------------------------
  Widget lbCard(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: lbLilac,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lbAmethyst.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: lbBlack,
          height: 1.55,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: code / monospace card
  // ---------------------------------------------------------------------------
  Widget lbCode(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: lbBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lbDivider),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'monospace',
          color: lbLavender,
          height: 1.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: table row
  // ---------------------------------------------------------------------------
  Widget lbRow(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: lbWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: lbAmethyst.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: lbGrape,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: lbBlack,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: bullet point
  // ---------------------------------------------------------------------------
  Widget lbBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '\u2022 ',
            style: TextStyle(
              fontSize: 14,
              color: lbOrchid,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: lbBlack,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: numbered step
  // ---------------------------------------------------------------------------
  Widget lbStep(int num, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              color: lbMauve,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$num',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: lbWhite,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: lbBlack,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: comparison cell
  // ---------------------------------------------------------------------------
  Widget lbCompare(String title, String body, Color bg) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: lbDivider.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: lbPlum,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: const TextStyle(
                fontSize: 13,
                color: lbBlack,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: divider
  // ---------------------------------------------------------------------------
  Widget lbDividerWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      height: 1.5,
      color: lbAmethyst.withValues(alpha: 0.35),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: highlight badge
  // ---------------------------------------------------------------------------
  Widget lbBadge(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: lbOrchid,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: lbWhite,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: visual selection diagram
  // ---------------------------------------------------------------------------
  Widget lbDiagram(String label, String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: lbLilac,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lbGrape.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: lbGrape,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: lbBlack,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // MAIN LAYOUT
  // ===========================================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================================================================
        // BANNER
        // =====================================================================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [lbPlum, lbGrape, lbMauve],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: lbPlum.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToLineBreakIntent',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: lbWhite,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: lbWhite.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Shift + End / Shift + Home — Line-Level Selection Extension',
                  style: TextStyle(
                    fontSize: 14,
                    color: lbLavender,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Extends the selection extent (the moving end of the '
                'selection) to the nearest line break in a given direction, '
                'while the base (anchor) stays fixed. This is the bread-and-'
                'butter shortcut for selecting text to the end or beginning '
                'of the current visual or logical line.',
                style: TextStyle(
                  fontSize: 14,
                  color: lbLilac,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),

        // =====================================================================
        // 1. INHERITANCE & CLASS IDENTITY
        // =====================================================================
        lbHeader('1. Inheritance & Class Identity'),

        lbCard(
          'ExtendSelectionToLineBreakIntent sits in the text editing intent '
          'hierarchy specifically for line-level granularity. It extends '
          'only the "extent" of the selection — the end that moves when the '
          'user holds Shift while pressing Home or End.',
        ),

        lbCode(
          'Object\n'
          '  \u2514\u2500 Intent\n'
          '       \u2514\u2500 DirectionalTextEditingIntent\n'
          '            \u251c\u2500 forward: bool\n'
          '            \u2514\u2500 ExtendSelectionToLineBreakIntent\n'
          '                 \u251c\u2500 forward: true  \u2192 extend to line end\n'
          '                 \u2514\u2500 forward: false \u2192 extend to line start',
        ),

        lbCard(
          'The class inherits a single field — "forward" — from '
          'DirectionalTextEditingIntent. When forward is true the extent '
          'moves toward the end of the line; when false, toward the start.',
        ),

        lbSubHeader('Constructor Signature'),

        lbCode(
          'const ExtendSelectionToLineBreakIntent({\n'
          '  required bool forward,\n'
          '}) : super(forward);',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 2. EXTEND vs EXPAND — THE LINE BREAK DISTINCTION
        // =====================================================================
        lbHeader('2. Extend vs Expand — The Line Break Distinction'),

        lbCard(
          'Flutter provides both ExtendSelectionToLineBreakIntent and '
          'ExpandSelectionToLineBreakIntent. They sound alike but differ '
          'fundamentally in how the selection anchors behave.',
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            lbCompare(
              'ExtendSelectionToLineBreakIntent',
              'Moves only the EXTENT to the line break.\n\n'
                  'Base stays exactly where it was.\n\n'
                  'Selection can shrink if extent crosses base.\n\n'
                  'Directional: forward = true moves extent toward '
                  'end of line; false toward start of line.\n\n'
                  'Typical trigger: Shift+End or Shift+Home.',
              lbLilac,
            ),
            lbCompare(
              'ExpandSelectionToLineBreakIntent',
              'May move BOTH base and extent to ensure '
              'the selection grows toward the line break.\n\n'
              'The selection can only expand, never shrink.\n\n'
              'After the operation the base is always at the '
              'side closest to the line break target.\n\n'
              'Used by some platform-specific shortcut layers.',
              lbLavender,
            ),
          ],
        ),

        lbSubHeader('Visual Comparison'),

        lbDiagram(
          'Initial state  — cursor at column 15, no selection:',
          'Line: "The quick brown fox jumps over the lazy dog."\n'
          '       0         1         2         3         4\n'
          '       0123456789012345678901234567890123456789012345678\n'
          '                  ^ cursor (offset 15)',
        ),

        lbDiagram(
          'After Extend forward=true  (Shift+End):',
          '"The quick brown [fox jumps over the lazy dog.]"\n'
          '                  ^base                      ^extent\n'
          'Selection: offsets 15..48  (base=15, extent=48)',
        ),

        lbDiagram(
          'After Extend forward=false  (Shift+Home):',
          '"[The quick brown] fox jumps over the lazy dog."\n'
          ' ^extent          ^base\n'
          'Selection: offsets 0..15  (base=15, extent=0)',
        ),

        lbDiagram(
          'After Expand forward=true  (compare):',
          '"The quick brown [fox jumps over the lazy dog.]"\n'
          '                  ^base                      ^extent\n'
          'For a collapsed cursor, Expand and Extend give\n'
          'the same result. Differences show with existing selection.',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 3. LINE BREAK TYPES — LOGICAL vs VISUAL
        // =====================================================================
        lbHeader('3. Line Break Types — Logical vs Visual'),

        lbCard(
          'The term "line break" can refer to either a logical line break '
          '(a newline character in the text) or a visual line break (where '
          'the text wraps due to viewport width). The behavior of '
          'ExtendSelectionToLineBreakIntent depends on the text renderer '
          'and platform conventions.',
        ),

        lbSubHeader('Logical Line Break'),

        lbCode(
          'Text content:\n'
          '"First line\\n"\n'
          '"Second line\\n"\n'
          '"Third line"\n\n'
          'Each \\n is a logical line break. Pressing Shift+End on\n'
          '"First line" moves extent to the position just before \\n.',
        ),

        lbSubHeader('Visual (Soft-Wrap) Line Break'),

        lbCode(
          'Viewport width = 20 characters:\n'
          '                    \u2502\n'
          '"The quick brown fox\u2502"   \u2190 visual line 1\n'
          '"jumps over the lazy\u2502"   \u2190 visual line 2\n'
          '"dog.                \u2502"   \u2190 visual line 3\n'
          '                    \u2502\n'
          'One logical line, three visual lines.\n'
          'Shift+End on visual line 1 may stop at column 20\n'
          'or continue to the logical end — platform-dependent.',
        ),

        lbCard(
          'On macOS, Shift+End typically moves to the end of the visual '
          'line (soft-wrap boundary). On Windows and Linux, Shift+End '
          'often moves to the logical line end. Flutter\'s default '
          'EditableText action set respects the platform convention.',
        ),

        lbRow('macOS', 'Shift+End \u2192 visual (soft-wrap) line end'),
        lbRow('Windows', 'Shift+End \u2192 logical line end'),
        lbRow('Linux', 'Shift+End \u2192 logical line end (most DEs)'),
        lbRow('iOS', 'No hardware End key; equivalent gesture varies'),
        lbRow('Android', 'Shift+End on external keyboard \u2192 logical end'),

        lbDividerWidget(),

        // =====================================================================
        // 4. FORWARD & BACKWARD — DIRECTIONAL SEMANTICS
        // =====================================================================
        lbHeader('4. Forward & Backward — Directional Semantics'),

        lbCard(
          'The "forward" boolean from DirectionalTextEditingIntent '
          'maps directly to the line direction:',
        ),

        lbRow('forward: true', 'Extend extent toward line END (right in LTR)'),
        lbRow('forward: false', 'Extend extent toward line START (left in LTR)'),
        lbRow('In RTL text', 'forward: true = visual left; false = visual right'),

        lbSubHeader('Dispatched Shortcut Bindings'),

        lbCode(
          '// Default Flutter shortcut map entries:\n'
          '//\n'
          '// Shift+End \u2192\n'
          '//   ExtendSelectionToLineBreakIntent(forward: true)\n'
          '//\n'
          '// Shift+Home \u2192\n'
          '//   ExtendSelectionToLineBreakIntent(forward: false)\n'
          '//\n'
          '// On macOS with Cmd key:\n'
          '// Shift+Cmd+Right \u2192\n'
          '//   ExtendSelectionToLineBreakIntent(forward: true)\n'
          '//\n'
          '// Shift+Cmd+Left \u2192\n'
          '//   ExtendSelectionToLineBreakIntent(forward: false)',
        ),

        lbCard(
          'The macOS Cmd-arrow mappings exist because Mac keyboards often '
          'lack dedicated Home/End keys. Cmd+Right is the Mac equivalent '
          'of the End key; adding Shift extends the selection.',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 5. EXISTING SELECTION SCENARIOS
        // =====================================================================
        lbHeader('5. Existing Selection Scenarios'),

        lbCard(
          'When ExtendSelectionToLineBreakIntent is dispatched and there '
          'is already an active selection, the behavior depends entirely '
          'on where the base and extent currently sit relative to the '
          'target line break.',
        ),

        lbSubHeader('Scenario A — Extend Forward, Extent After Base'),

        lbDiagram(
          'Before:',
          '"Hello, [world] today is fine."\n'
          '         ^base  ^extent\n'
          '  base=7, extent=12',
        ),
        lbDiagram(
          'After Extend forward=true:',
          '"Hello, [world today is fine.]"\n'
          '         ^base               ^extent\n'
          '  base=7, extent=29  (extent moved to end of line)',
        ),

        lbSubHeader('Scenario B — Extend Backward, Extent After Base'),

        lbDiagram(
          'Before:',
          '"Hello, [world] today is fine."\n'
          '         ^base  ^extent\n'
          '  base=7, extent=12',
        ),
        lbDiagram(
          'After Extend forward=false:',
          '"[Hello, ]world today is fine."\n'
          ' ^extent  ^base\n'
          '  base=7, extent=0  (extent crossed base, moved to line start)',
        ),

        lbCard(
          'Notice that in Scenario B the extent crosses below the base. '
          'The selection is now "reversed" — the extent is at a lower '
          'offset than the base. This is perfectly valid and reflects '
          'the directional nature of "extend" operations.',
        ),

        lbSubHeader('Scenario C — Extend Forward, Extent Before Base'),

        lbDiagram(
          'Before (reversed selection):',
          '"Hello, [world] today is fine."\n'
          '         ^extent ^base\n'
          '  base=12, extent=7',
        ),
        lbDiagram(
          'After Extend forward=true:',
          '"Hello, world [today is fine.]"\n'
          '               ^base         ^extent\n'
          '  base=12, extent=29  (extent jumped past base to line end)',
        ),

        lbSubHeader('Scenario D — Collapsed Cursor'),

        lbDiagram(
          'Before (collapsed):',
          '"Hello, world today| is fine."\n'
          '                   ^ cursor at offset 18',
        ),
        lbDiagram(
          'After Extend forward=true:',
          '"Hello, world today[ is fine.]"\n'
          '                   ^base     ^extent\n'
          '  base=18, extent=29',
        ),
        lbDiagram(
          'After Extend forward=false:',
          '"[Hello, world today] is fine."\n'
          ' ^extent             ^base\n'
          '  base=18, extent=0',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 6. DISPATCH PIPELINE
        // =====================================================================
        lbHeader('6. Dispatch Pipeline'),

        lbCard(
          'When the user presses Shift+End inside an EditableText, the '
          'following pipeline processes the intent:',
        ),

        lbStep(1,
          'RawKeyboardListener / HardwareKeyboard detects Shift+End key '
          'combination and notifies the Shortcuts widget.',
        ),
        lbStep(2,
          'Shortcuts widget maps the key combo to '
          'ExtendSelectionToLineBreakIntent(forward: true) using the '
          'platform-appropriate ShortcutActivator.',
        ),
        lbStep(3,
          'The Actions widget receives the intent and looks up '
          'the registered Action<ExtendSelectionToLineBreakIntent> '
          'in the action dispatch chain.',
        ),
        lbStep(4,
          'EditableText registers an ExtendSelectionToLineBreakAction '
          '(or equivalent CallbackAction) that calls into the '
          'TextEditingActionTarget.',
        ),
        lbStep(5,
          'The action implementation reads the current TextSelection, '
          'calculates the line break position from the TextPainter '
          'layout metrics, and produces a new TextSelection with the '
          'same base but a new extent at the line boundary.',
        ),
        lbStep(6,
          'The TextEditingValue is updated, the text field repaints with '
          'the new selection highlight, and the cursor (now at the extent '
          'position) scrolls into view if necessary.',
        ),

        lbCode(
          '// Simplified action logic:\n'
          'void invoke(ExtendSelectionToLineBreakIntent intent) {\n'
          '  final TextSelection sel = textEditingValue.selection;\n'
          '  final int newExtent;\n'
          '  if (intent.forward) {\n'
          '    newExtent = getLineBreakForward(sel.extentOffset);\n'
          '  } else {\n'
          '    newExtent = getLineBreakBackward(sel.extentOffset);\n'
          '  }\n'
          '  textEditingValue = textEditingValue.copyWith(\n'
          '    selection: sel.copyWith(extentOffset: newExtent),\n'
          '  );\n'
          '}',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 7. KEYBOARD SHORTCUT REFERENCE
        // =====================================================================
        lbHeader('7. Keyboard Shortcut Reference'),

        lbCard(
          'Complete mapping of keyboard shortcuts that dispatch '
          'ExtendSelectionToLineBreakIntent across platforms:',
        ),

        lbRow('Shift + End', 'forward: true  (Windows, Linux, web)'),
        lbRow('Shift + Home', 'forward: false  (Windows, Linux, web)'),
        lbRow('Shift + Cmd + Right', 'forward: true  (macOS)'),
        lbRow('Shift + Cmd + Left', 'forward: false  (macOS)'),
        lbRow('Shift + Fn + Right', 'forward: true  (Mac laptop, fn=End)'),
        lbRow('Shift + Fn + Left', 'forward: false  (Mac laptop, fn=Home)'),

        lbCard(
          'Note: On macOS, Shift+End may also be available if the keyboard '
          'has dedicated End/Home keys (e.g., full-size Apple keyboard or '
          'external PC keyboard). The Cmd-Arrow variants are the idiomatic '
          'Mac shortcuts.',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 8. SELECTION INTENT FAMILY — LINE GRANULARITY
        // =====================================================================
        lbHeader('8. Selection Intent Family — Line Granularity'),

        lbCard(
          'ExtendSelectionToLineBreakIntent belongs to a family of '
          'intents that operate at various text granularity levels. '
          'Comparing line-level intents specifically:',
        ),

        lbRow(
          'ExtendSelectionTo\nLineBreakIntent',
          'Moves EXTENT to line break. Base stays. '
          'Selection can grow or shrink.',
        ),
        lbRow(
          'ExpandSelectionTo\nLineBreakIntent',
          'Moves base or extent (whichever is needed) to '
          'ensure the selection encompasses the line break. '
          'Selection can only grow.',
        ),
        lbRow(
          'MoveSelectionTo\nLineBreakIntent',
          'Collapses cursor to line break position. '
          'No selection remains — equivalent to End/Home '
          'without Shift.',
        ),
        lbRow(
          'DeleteToLine\nBreakIntent',
          'Deletes from cursor to the line break. '
          'Does not select first — destructive operation.',
        ),

        lbSubHeader('Cross-Granularity Comparison'),

        lbRow('Character', 'ExtendSelectionByCharacterIntent'),
        lbRow('Word', 'ExtendSelectionToNextWordBoundaryIntent'),
        lbRow('Line', 'ExtendSelectionToLineBreakIntent  \u2190 this demo'),
        lbRow('Paragraph', 'ExtendSelectionToNextParagraphBoundaryIntent'),
        lbRow('Document', 'ExtendSelectionToDocumentBoundaryIntent'),

        lbCard(
          'The granularity hierarchy goes: character < word < line < '
          'paragraph < document. ExtendSelectionToLineBreakIntent sits '
          'in the middle of this hierarchy, operating on the current '
          'line only — not crossing newline boundaries in its intent.',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 9. MULTI-LINE TEXT FIELD BEHAVIOR
        // =====================================================================
        lbHeader('9. Multi-Line Text Field Behavior'),

        lbCard(
          'In a multi-line TextField, the line break intent interacts '
          'with the current line that contains the extent offset. It '
          'does NOT jump across logical line boundaries.',
        ),

        lbCode(
          'Multi-line content:\n'
          '  Line 0: "def factorial(n):"\n'
          '  Line 1: "    if n <= 1:"\n'
          '  Line 2: "        return 1"\n'
          '  Line 3: "    return n * factorial(n - 1)"\n\n'
          'Cursor on Line 2, column 10:\n'
          '  "        re|turn 1"\n\n'
          'Shift+End \u2192 extends to:\n'
          '  "        re[turn 1]"   \u2190 end of line 2 only\n\n'
          'Shift+Home \u2192 extends to:\n'
          '  "[        re]turn 1"   \u2190 start of line 2 only\n\n'
          'The extent does NOT cross into line 1 or line 3.',
        ),

        lbSubHeader('Consecutive Invocations'),

        lbCard(
          'Unlike word or character intents, invoking Extend to Line Break '
          'a second time does NOT advance to the next line. The extent '
          'is already at the line boundary, so the operation is a no-op. '
          'To select across multiple lines, the user must combine this '
          'intent with other navigation intents (e.g., arrow keys).',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 10. CUSTOM ACTION PATTERNS
        // =====================================================================
        lbHeader('10. Custom Action Patterns'),

        lbSubHeader('Pattern A — Select Entire Current Line'),

        lbCard(
          'A custom action that performs both backward and forward '
          'extension in sequence, effectively selecting the entire '
          'current line:',
        ),

        lbCode(
          'class SelectEntireLineAction\n'
          '    extends Action<ExtendSelectionToLineBreakIntent> {\n'
          '  SelectEntireLineAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(ExtendSelectionToLineBreakIntent intent) {\n'
          '    // First: move cursor to line start (collapse)\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    final lineStart = getLineStart(sel.extentOffset);\n'
          '    final lineEnd = getLineEnd(sel.extentOffset);\n'
          '    state.userUpdateTextEditingValue(\n'
          '      state.textEditingValue.copyWith(\n'
          '        selection: TextSelection(\n'
          '          baseOffset: lineStart,\n'
          '          extentOffset: lineEnd,\n'
          '        ),\n'
          '      ),\n'
          '      SelectionChangedCause.keyboard,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        lbSubHeader('Pattern B — Extend with Column Memory'),

        lbCard(
          'A custom action that remembers the original column position '
          'when extending to line start, so that pressing Shift+End '
          'afterward restores to the remembered column rather than '
          'going all the way to line end:',
        ),

        lbCode(
          'class ColumnMemoryExtendAction\n'
          '    extends Action<ExtendSelectionToLineBreakIntent> {\n'
          '  ColumnMemoryExtendAction(this.state);\n'
          '  final EditableTextState state;\n'
          '  int? rememberedColumn;\n\n'
          '  @override\n'
          '  void invoke(ExtendSelectionToLineBreakIntent intent) {\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    if (!intent.forward) {\n'
          '      // Going to line start: remember current column\n'
          '      rememberedColumn = getColumn(sel.extentOffset);\n'
          '      // Perform default extend-to-line-start\n'
          '      performDefault(intent);\n'
          '    } else if (rememberedColumn != null) {\n'
          '      // Going to line end but we have a memory:\n'
          '      // Restore to the remembered column instead\n'
          '      final target = getOffsetForColumn(\n'
          '        sel.extentOffset,\n'
          '        rememberedColumn!,\n'
          '      );\n'
          '      updateExtent(target);\n'
          '      rememberedColumn = null;\n'
          '    } else {\n'
          '      performDefault(intent);\n'
          '    }\n'
          '  }\n'
          '}',
        ),

        lbSubHeader('Pattern C — Line Selection with Indentation Skip'),

        lbCard(
          'A code-editor style action where Shift+Home first extends '
          'to the first non-whitespace character, and a second press '
          'extends to column 0:',
        ),

        lbCode(
          'class SmartHomeExtendAction\n'
          '    extends Action<ExtendSelectionToLineBreakIntent> {\n'
          '  SmartHomeExtendAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(ExtendSelectionToLineBreakIntent intent) {\n'
          '    if (intent.forward) {\n'
          '      // Forward always goes to line end\n'
          '      performDefault(intent);\n'
          '      return;\n'
          '    }\n'
          '    // Backward: smart home behavior\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    final lineStart = getLineStart(sel.extentOffset);\n'
          '    final firstNonSpace = getFirstNonWhitespace(\n'
          '      sel.extentOffset,\n'
          '    );\n'
          '    final target = (sel.extentOffset == firstNonSpace)\n'
          '        ? lineStart   // Already at indent; go to col 0\n'
          '        : firstNonSpace; // Go to first non-space\n'
          '    updateExtent(target);\n'
          '  }\n'
          '}',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 11. EDGE CASES
        // =====================================================================
        lbHeader('11. Edge Cases'),

        lbSubHeader('Edge Case 1 — Empty Line'),

        lbCard(
          'When the cursor is on an empty line (just a newline character), '
          'both forward and backward extension produce a collapsed cursor '
          'at the same position. The line start and line end are the same '
          'offset.',
        ),

        lbSubHeader('Edge Case 2 — Cursor Already at Line Boundary'),

        lbCard(
          'If the extent is already at the line end and Shift+End is '
          'pressed, nothing changes. The operation is idempotent: '
          'extending to a boundary you are already at is a no-op.',
        ),

        lbSubHeader('Edge Case 3 — Single Character Line'),

        lbCode(
          'Line content: "X"\n'
          'Cursor at offset 0 (before X):\n'
          '  Shift+End   \u2192 selection [X], extent=1\n'
          '  Shift+Home  \u2192 no-op, already at start\n\n'
          'Cursor at offset 1 (after X):\n'
          '  Shift+End   \u2192 no-op, already at end\n'
          '  Shift+Home  \u2192 selection [X], extent=0',
        ),

        lbSubHeader('Edge Case 4 — Very Long Unwrapped Line'),

        lbCard(
          'For an extremely long line that extends beyond the viewport, '
          'the extent jumps to the logical line end regardless of what '
          'is currently visible. The text field then auto-scrolls '
          'horizontally to bring the new extent into view.',
        ),

        lbSubHeader('Edge Case 5 — RTL Text Within LTR Context'),

        lbCode(
          'Mixed directional content:\n'
          '  "Hello \u0645\u0631\u062D\u0628\u0627 World"\n\n'
          'Cursor in the Arabic segment:\n'
          '  Shift+End (forward=true) still means\n'
          '  "toward end of line" in document order,\n'
          '  not visual direction. The text shaper\n'
          '  handles bidi runs internally.',
        ),

        lbSubHeader('Edge Case 6 — TextField maxLines: 1'),

        lbCard(
          'In a single-line TextField, the line break is simply the '
          'start or end of the entire text content. '
          'ExtendSelectionToLineBreakIntent(forward: true) extends to '
          'the end of all text; forward: false extends to offset 0.',
        ),

        lbSubHeader('Edge Case 7 — Composing Region Active'),

        lbCard(
          'When an IME composing region is active (e.g., CJK input), '
          'the extend-to-line-break action may need to finalize the '
          'composition first, then perform the selection extension. The '
          'framework handles this by committing the composing text before '
          'applying the new selection.',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 12. COMPARISON WITH MOVE INTENT
        // =====================================================================
        lbHeader('12. Comparison with MoveSelectionToLineBreakIntent'),

        lbCard(
          'MoveSelectionToLineBreakIntent collapses the cursor to the '
          'line break — it removes any selection. '
          'ExtendSelectionToLineBreakIntent preserves and extends the '
          'selection. They share the same target position but differ in '
          'what happens to the base offset.',
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            lbCompare(
              'Move (End key)',
              'Collapses selection.\n'
                  'Cursor moves to line end.\n'
                  'base == extent afterward.\n'
                  'No text is highlighted.',
              lbLilac,
            ),
            lbCompare(
              'Extend (Shift+End)',
              'Preserves selection base.\n'
                  'Extent moves to line end.\n'
                  'base != extent (usually).\n'
                  'Text between base and line end is highlighted.',
              lbLavender,
            ),
          ],
        ),

        lbCode(
          'Before (collapsed cursor at offset 10):\n'
          '  "0123456789|0123456789"\n\n'
          'After Move forward=true:\n'
          '  "01234567890123456789|"   \u2190 cursor at end, no selection\n\n'
          'After Extend forward=true:\n'
          '  "0123456789[0123456789]"  \u2190 base=10, extent=20',
        ),

        lbDividerWidget(),

        // =====================================================================
        // 13. SUMMARY
        // =====================================================================
        lbHeader('13. Summary'),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lbGrape.withValues(alpha: 0.12),
                lbLilac,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: lbAmethyst),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToLineBreakIntent — Key Takeaways',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: lbPlum,
                ),
              ),
              const SizedBox(height: 12),
              lbBullet(
                'Extends the selection EXTENT to the nearest line break '
                '(start or end) in the given direction.',
              ),
              lbBullet(
                'The BASE (anchor) of the selection never moves — only '
                'the extent shifts to the line boundary.',
              ),
              lbBullet(
                'forward: true = toward line end (Shift+End); '
                'forward: false = toward line start (Shift+Home).',
              ),
              lbBullet(
                'Line break can mean logical (newline) or visual '
                '(soft-wrap), depending on platform conventions.',
              ),
              lbBullet(
                'Differs from Expand: Extend can shrink a selection if '
                'extent crosses base; Expand only grows.',
              ),
              lbBullet(
                'Differs from Move: Move collapses the selection; '
                'Extend preserves and grows it.',
              ),
              lbBullet(
                'In multi-line fields, operates within the current line '
                'only — does not cross newline boundaries.',
              ),
              lbBullet(
                'Idempotent at boundaries: pressing Shift+End when extent '
                'is already at line end is a no-op.',
              ),
              lbBullet(
                'Custom actions can add smart-home, column-memory, or '
                'whole-line-selection behaviors.',
              ),
              Wrap(
                children: [
                  lbBadge('Shift+End'),
                  lbBadge('Shift+Home'),
                  lbBadge('Line-Level'),
                  lbBadge('Directional'),
                  lbBadge('Extent Only'),
                  lbBadge('Platform-Aware'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),
      ],
    ),
  );
}
