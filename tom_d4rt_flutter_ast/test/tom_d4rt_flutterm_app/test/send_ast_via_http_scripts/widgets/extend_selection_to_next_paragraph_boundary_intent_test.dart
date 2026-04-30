// ignore_for_file: avoid_print
// Deep demo: ExtendSelectionToNextParagraphBoundaryIntent — extending the
// selection extent to the boundary of the next paragraph in a given direction,
// preserving the selection base (anchor) position.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Theme — Ocean Navy (#0D47A1) / Foam Blue (#E3F2FD)
  // ---------------------------------------------------------------------------
  const Color pbNavy = Color(0xFF0D47A1);
  const Color pbFoam = Color(0xFFE3F2FD);
  const Color pbAzure = Color(0xFF1565C0);
  const Color pbSky = Color(0xFF90CAF9);
  const Color pbSteel = Color(0xFF1976D2);
  const Color pbIce = Color(0xFFBBDEFB);
  const Color pbDeep = Color(0xFF0D47A1);
  const Color pbWhite = Color(0xFFFFFFFF);
  const Color pbBlack = Color(0xFF0A1929);
  const Color pbDivider = Color(0xFF42A5F5);

  // ---------------------------------------------------------------------------
  // Helper: section header
  // ---------------------------------------------------------------------------
  Widget pbHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [pbNavy, pbAzure],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: pbNavy.withValues(alpha: 0.35),
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
          color: pbWhite,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: sub-header
  // ---------------------------------------------------------------------------
  Widget pbSubHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: pbIce,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pbSky, width: 1.2),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: pbNavy,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: explanation card
  // ---------------------------------------------------------------------------
  Widget pbCard(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pbFoam,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pbSky.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: pbBlack,
          height: 1.55,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: code / monospace card
  // ---------------------------------------------------------------------------
  Widget pbCode(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pbBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pbDivider),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'monospace',
          color: pbIce,
          height: 1.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: table row
  // ---------------------------------------------------------------------------
  Widget pbRow(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: pbWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: pbSky.withValues(alpha: 0.3)),
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
                color: pbDeep,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: pbBlack,
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
  Widget pbBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '\u2022 ',
            style: TextStyle(
              fontSize: 14,
              color: pbSteel,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: pbBlack,
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
  Widget pbStep(int num, String text) {
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
              color: pbSteel,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$num',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: pbWhite,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: pbBlack,
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
  Widget pbCompare(String title, String body, Color bg) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: pbDivider.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: pbNavy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: const TextStyle(
                fontSize: 13,
                color: pbBlack,
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
  Widget pbDividerWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      height: 1.5,
      color: pbSky.withValues(alpha: 0.35),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: highlight badge
  // ---------------------------------------------------------------------------
  Widget pbBadge(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: pbSteel,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: pbWhite,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: visual diagram
  // ---------------------------------------------------------------------------
  Widget pbDiagram(String label, String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pbFoam,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pbDeep.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: pbDeep,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: pbBlack,
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
              colors: [pbNavy, pbAzure, pbSteel],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: pbNavy.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToNextParagraph\nBoundaryIntent',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: pbWhite,
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
                  color: pbWhite.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Paragraph-Level Selection Extension',
                  style: TextStyle(
                    fontSize: 14,
                    color: pbIce,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Extends the selection extent to the boundary of the '
                'next paragraph in a given direction — forward toward '
                'the end of the document or backward toward the start. '
                'The base (anchor) remains fixed, producing a selection '
                'that spans one or more paragraph boundaries.',
                style: TextStyle(
                  fontSize: 14,
                  color: pbFoam,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),

        // =====================================================================
        // 1. INHERITANCE & CLASS IDENTITY
        // =====================================================================
        pbHeader('1. Inheritance & Class Identity'),

        pbCard(
          'ExtendSelectionToNextParagraphBoundaryIntent operates at '
          'paragraph granularity — a level above lines but below the '
          'full document. It inherits from DirectionalTextEditingIntent '
          'with the standard "forward" boolean.',
        ),

        pbCode(
          'Object\n'
          '  \u2514\u2500 Intent\n'
          '       \u2514\u2500 DirectionalTextEditingIntent\n'
          '            \u251c\u2500 forward: bool\n'
          '            \u2514\u2500 ExtendSelectionToNextParagraphBoundaryIntent\n'
          '                 \u251c\u2500 forward: true  \u2192 next paragraph boundary\n'
          '                 \u2514\u2500 forward: false \u2192 previous paragraph boundary',
        ),

        pbSubHeader('Constructor'),

        pbCode(
          'const ExtendSelectionToNextParagraphBoundaryIntent({\n'
          '  required bool forward,\n'
          '}) : super(forward);',
        ),

        pbCard(
          'The intent carries no additional fields beyond "forward". '
          'All paragraph boundary logic is handled by the action that '
          'receives and processes this intent.',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 2. WHAT IS A PARAGRAPH IN FLUTTER TEXT?
        // =====================================================================
        pbHeader('2. What Is a Paragraph in Flutter Text?'),

        pbCard(
          'In Flutter\'s text editing model, a "paragraph" is defined '
          'by newline characters (\\n). Each newline terminates a '
          'paragraph. A paragraph boundary is the offset immediately '
          'before or after a newline character.',
        ),

        pbCode(
          'Text content with three paragraphs:\n\n'
          '  "First paragraph text.\\n"     \u2190 Paragraph 0\n'
          '  "Second paragraph text.\\n"    \u2190 Paragraph 1\n'
          '  "Third paragraph text."       \u2190 Paragraph 2\n\n'
          'Paragraph boundaries:\n'
          '  \u2022 Between para 0 and 1: offset of first \\n + 1\n'
          '  \u2022 Between para 1 and 2: offset of second \\n + 1\n'
          '  \u2022 Start of document: offset 0\n'
          '  \u2022 End of document: offset of last character + 1',
        ),

        pbSubHeader('Paragraph vs Line'),

        pbCard(
          'A paragraph can span multiple visual lines if the text wraps. '
          'A line break due to soft-wrapping is NOT a paragraph boundary. '
          'Only explicit newline characters define paragraph boundaries.',
        ),

        pbCode(
          'One paragraph, three visual lines (soft-wrapped):\n\n'
          '"This is a single paragraph that is long enough to\n'
          ' wrap across multiple visual lines in the text field\n'
          ' but it has no newline characters within it."\n\n'
          'Extend-to-paragraph would jump past ALL three visual\n'
          'lines to the next \\n or the document boundary.',
        ),

        pbRow('Paragraph separator', 'Newline character (\\n)'),
        pbRow('Line separator', 'Soft-wrap point (visual only)'),
        pbRow('Line break intent', 'Stops at visual/logical line end'),
        pbRow('Paragraph intent', 'Stops at next \\n boundary'),

        pbDividerWidget(),

        // =====================================================================
        // 3. FORWARD & BACKWARD SEMANTICS
        // =====================================================================
        pbHeader('3. Forward & Backward Semantics'),

        pbCard(
          'The "forward" boolean determines which paragraph boundary '
          'the extent moves toward:',
        ),

        pbRow('forward: true',
          'Extent moves to the END of the current paragraph (the '
          'position just before or at the next \\n). If already at '
          'a paragraph end, jumps to the end of the next paragraph.',
        ),
        pbRow('forward: false',
          'Extent moves to the START of the current paragraph (the '
          'position just after the preceding \\n). If already at '
          'a paragraph start, jumps to the start of the previous one.',
        ),

        pbSubHeader('Step-Through Behavior'),

        pbCard(
          'Unlike ExtendSelectionToLineBreakIntent (which is idempotent '
          'at the boundary), ExtendSelectionToNextParagraphBoundaryIntent '
          'can be invoked repeatedly to step through multiple paragraphs. '
          'Each invocation advances the extent to the next paragraph '
          'boundary.',
        ),

        pbDiagram(
          'Three consecutive forward invocations:',
          'Para 0: "Alpha paragraph."\n'
          'Para 1: "Beta paragraph."\n'
          'Para 2: "Gamma paragraph."\n'
          'Para 3: "Delta paragraph."\n\n'
          'Cursor starts in middle of Para 0:\n'
          '  "Alpha par|agraph."\n\n'
          'Invoke 1 (forward): extent \u2192 end of Para 0\n'
          '  "Alpha par[agraph.]"\n\n'
          'Invoke 2 (forward): extent \u2192 end of Para 1\n'
          '  "Alpha par[agraph.\\nBeta paragraph.]"\n\n'
          'Invoke 3 (forward): extent \u2192 end of Para 2\n'
          '  "Alpha par[agraph.\\nBeta...\\nGamma paragraph.]"',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 4. EXTEND vs EXPAND — PARAGRAPH LEVEL
        // =====================================================================
        pbHeader('4. Extend vs Expand — Paragraph Level'),

        pbCard(
          'The distinction between Extend and Expand applies at '
          'paragraph level just as it does at line and document levels.',
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pbCompare(
              'Extend (this intent)',
              'Moves EXTENT only.\n\n'
                  'Base stays fixed.\n\n'
                  'Selection can shrink if extent crosses base.\n\n'
                  'Supports reversed selections (extent < base).',
              pbFoam,
            ),
            pbCompare(
              'Expand',
              'Moves whichever end is needed to grow.\n\n'
                  'Selection can only expand, never shrink.\n\n'
                  'After expansion, base is always at the "near" '
                  'side.\n\n'
                  'No reversed selection possible.',
              pbIce,
            ),
          ],
        ),

        pbSubHeader('Concrete Example'),

        pbDiagram(
          'Existing forward selection across two paragraphs:',
          'Para 0: "Alpha [paragraph.\\n"\n'
          'Para 1: "Beta] paragraph.\\n"\n'
          'Para 2: "Gamma paragraph."\n\n'
          'base in Para 0, extent in middle of Para 1.',
        ),

        pbDiagram(
          'After Extend forward=false (backward):',
          'Para 0: "[Alpha ]paragraph.\\n"\n'
          'Para 1: "Beta paragraph.\\n"\n'
          'Para 2: "Gamma paragraph."\n\n'
          'Extent crossed base and moved to start of Para 0.\n'
          'Selection is now reversed: extent < base.',
        ),

        pbDiagram(
          'After Expand forward=false (backward) from same start:',
          'Para 0: "[Alpha paragraph.\\n"\n'
          'Para 1: "Beta] paragraph.\\n"\n'
          'Para 2: "Gamma paragraph."\n\n'
          'Expand moved the base to Para 0 start.\n'
          'Selection grew; it did not reverse.',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 5. KEYBOARD SHORTCUTS
        // =====================================================================
        pbHeader('5. Keyboard Shortcuts'),

        pbCard(
          'Paragraph-level selection extension is less universally '
          'standardized than line-level. Platform mappings vary:',
        ),

        pbRow('macOS', 'Shift+Option+Down / Shift+Option+Up'),
        pbRow('Windows', 'Shift+Ctrl+Down / Shift+Ctrl+Up (in some editors)'),
        pbRow('Linux', 'Shift+Ctrl+Down / Shift+Ctrl+Up (DE-dependent)'),
        pbRow('Web', 'Follows host platform conventions'),

        pbCard(
          'Note: Not all platforms provide a default paragraph-level '
          'selection shortcut. In Flutter, the shortcut map may differ '
          'from native text editors. Custom shortcut bindings can be '
          'added via the Shortcuts widget.',
        ),

        pbCode(
          '// Adding custom paragraph shortcuts:\n'
          'Shortcuts(\n'
          '  shortcuts: {\n'
          '    LogicalKeySet(\n'
          '      LogicalKeyboardKey.shift,\n'
          '      LogicalKeyboardKey.alt,\n'
          '      LogicalKeyboardKey.arrowDown,\n'
          '    ): const ExtendSelectionToNextParagraphBoundaryIntent(\n'
          '      forward: true,\n'
          '    ),\n'
          '    LogicalKeySet(\n'
          '      LogicalKeyboardKey.shift,\n'
          '      LogicalKeyboardKey.alt,\n'
          '      LogicalKeyboardKey.arrowUp,\n'
          '    ): const ExtendSelectionToNextParagraphBoundaryIntent(\n'
          '      forward: false,\n'
          '    ),\n'
          '  },\n'
          '  child: editableText,\n'
          ')',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 6. DISPATCH PIPELINE
        // =====================================================================
        pbHeader('6. Dispatch Pipeline'),

        pbCard(
          'The processing chain for paragraph-boundary selection '
          'extension follows the standard Flutter intent/action '
          'architecture:',
        ),

        pbStep(1,
          'User presses Shift+Option+Down (or platform equivalent). '
          'The key event reaches the Shortcuts widget.',
        ),
        pbStep(2,
          'Shortcuts maps the key combination to '
          'ExtendSelectionToNextParagraphBoundaryIntent(forward: true).',
        ),
        pbStep(3,
          'Actions widget walks up the tree looking for an '
          'Action<ExtendSelectionToNextParagraphBoundaryIntent>.',
        ),
        pbStep(4,
          'EditableText provides the matching action which reads '
          'the current TextEditingValue and TextSelection.',
        ),
        pbStep(5,
          'The action scans the text content for the next newline '
          'character in the specified direction, starting from the '
          'current extent offset.',
        ),
        pbStep(6,
          'A new TextSelection is produced with the original base '
          'and the new extent at the paragraph boundary offset.',
        ),
        pbStep(7,
          'The TextEditingValue is updated, the rendering layer '
          'repaints the selection highlight, and the viewport '
          'scrolls to keep the new extent visible.',
        ),

        pbCode(
          '// Simplified paragraph boundary detection:\n'
          'int findNextParagraphBoundary(String text, int from, bool forward) {\n'
          '  if (forward) {\n'
          '    final idx = text.indexOf(\'\\n\', from);\n'
          '    return idx == -1 ? text.length : idx;\n'
          '  } else {\n'
          '    final idx = text.lastIndexOf(\'\\n\', from - 1);\n'
          '    return idx == -1 ? 0 : idx + 1;\n'
          '  }\n'
          '}',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 7. MULTI-PARAGRAPH DOCUMENT WALKTHROUGH
        // =====================================================================
        pbHeader('7. Multi-Paragraph Document Walkthrough'),

        pbCard(
          'A detailed walkthrough showing how the intent interacts with '
          'a realistic multi-paragraph document:',
        ),

        pbCode(
          'Document content (4 paragraphs):\n\n'
          '  [0..44]  "Flutter is an open-source UI toolkit by Google.\\n"\n'
          '  [45..98] "It enables cross-platform apps from a single codebase.\\n"\n'
          '  [99..149] "Widgets are the building blocks of Flutter interfaces.\\n"\n'
          '  [150..189] "The framework uses a reactive programming model."',
        ),

        pbSubHeader('Step 1 — Cursor at offset 20'),

        pbDiagram(
          'Initial state:',
          '"Flutter is an open-|source UI toolkit by Google.\\n"\n'
          '"It enables cross-platform apps from a single codebase.\\n"\n'
          '...\n\n'
          'Cursor at offset 20, in paragraph 0.',
        ),

        pbSubHeader('Step 2 — Extend forward'),

        pbDiagram(
          'After ExtendSelectionToNextParagraphBoundaryIntent(forward: true):',
          '"Flutter is an open-[source UI toolkit by Google.]\\n"\n'
          '"It enables cross-platform apps from a single codebase.\\n"\n'
          '...\n\n'
          'base=20, extent=44  (end of paragraph 0, before \\n)',
        ),

        pbSubHeader('Step 3 — Extend forward again'),

        pbDiagram(
          'Second invocation (forward: true):',
          '"Flutter is an open-[source UI toolkit by Google.\\n"\n'
          '"It enables cross-platform apps from a single codebase.]\\n"\n'
          '...\n\n'
          'base=20, extent=98  (end of paragraph 1, before \\n)',
        ),

        pbSubHeader('Step 4 — Extend backward from same state'),

        pbDiagram(
          'Now invoke forward=false:',
          '"Flutter is an open-[source UI toolkit by Google.\\n"\n'
          '"It enables cross-platform apps from a single codebase.\\n"\n'
          '"Widgets are the building blocks of Flutter interfaces.\\n"\n'
          '"The framework uses a reactive programming model."\n\n'
          'Hmm — extent needs to move toward start of document.\n'
          'From extent=98, previous paragraph boundary is offset 45\n'
          '(start of paragraph 1).\n\n'
          'Result: base=20, extent=45\n'
          'Selection shrank but is still forward (45 > 20).',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 8. SELECTION INTENT FAMILY — PARAGRAPH POSITION
        // =====================================================================
        pbHeader('8. Selection Intent Family — Paragraph Position'),

        pbCard(
          'Comparing paragraph-level intents with other granularity '
          'levels in the extend-selection family:',
        ),

        pbRow('Character',
          'ExtendSelectionByCharacterIntent — one grapheme cluster',
        ),
        pbRow('Word',
          'ExtendSelectionToNextWordBoundaryIntent — word boundary',
        ),
        pbRow('Line',
          'ExtendSelectionToLineBreakIntent — line start/end',
        ),
        pbRow('Paragraph',
          'ExtendSelectionToNextParagraphBoundaryIntent \u2190 this demo',
        ),
        pbRow('Document',
          'ExtendSelectionToDocumentBoundaryIntent — doc start/end',
        ),

        pbSubHeader('Paragraph-Specific Intents'),

        pbRow(
          'Extend to paragraph',
          'Moves extent to paragraph boundary. '
          'Can repeat to traverse multiple paragraphs.',
        ),
        pbRow(
          'Expand to paragraph',
          'Grows selection to encompass paragraph boundary. '
          'Selection only grows, never shrinks.',
        ),
        pbRow(
          'Extend to paragraph\nor caret location',
          'Composite intent: extends to paragraph boundary '
          'OR caret location, whichever is appropriate.',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 9. CUSTOM ACTION PATTERNS
        // =====================================================================
        pbHeader('9. Custom Action Patterns'),

        pbSubHeader('Pattern A — Select Entire Paragraph'),

        pbCard(
          'A custom action that selects the entire paragraph containing '
          'the cursor, regardless of the direction parameter:',
        ),

        pbCode(
          'class SelectWholeParagraphAction\n'
          '    extends Action<ExtendSelectionToNextParagraphBoundaryIntent> {\n'
          '  SelectWholeParagraphAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(\n'
          '    ExtendSelectionToNextParagraphBoundaryIntent intent,\n'
          '  ) {\n'
          '    final text = state.textEditingValue.text;\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    final paraStart = findParagraphStart(text, sel.extentOffset);\n'
          '    final paraEnd = findParagraphEnd(text, sel.extentOffset);\n'
          '    state.userUpdateTextEditingValue(\n'
          '      state.textEditingValue.copyWith(\n'
          '        selection: TextSelection(\n'
          '          baseOffset: paraStart,\n'
          '          extentOffset: paraEnd,\n'
          '        ),\n'
          '      ),\n'
          '      SelectionChangedCause.keyboard,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        pbSubHeader('Pattern B — Paragraph Selection with Blank Lines'),

        pbCard(
          'A custom action that treats consecutive blank lines as '
          'paragraph separators, grouping content into logical '
          'sections even when individual newlines appear within a '
          'paragraph:',
        ),

        pbCode(
          'class BlankLineParagraphExtendAction\n'
          '    extends Action<ExtendSelectionToNextParagraphBoundaryIntent> {\n'
          '  BlankLineParagraphExtendAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(\n'
          '    ExtendSelectionToNextParagraphBoundaryIntent intent,\n'
          '  ) {\n'
          '    final text = state.textEditingValue.text;\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    // Look for "\\n\\n" as paragraph separator\n'
          '    final int boundary;\n'
          '    if (intent.forward) {\n'
          '      final idx = text.indexOf(\'\\n\\n\', sel.extentOffset);\n'
          '      boundary = idx == -1 ? text.length : idx;\n'
          '    } else {\n'
          '      final idx = text.lastIndexOf(\'\\n\\n\', sel.extentOffset - 1);\n'
          '      boundary = idx == -1 ? 0 : idx + 2;\n'
          '    }\n'
          '    state.userUpdateTextEditingValue(\n'
          '      state.textEditingValue.copyWith(\n'
          '        selection: sel.copyWith(extentOffset: boundary),\n'
          '      ),\n'
          '      SelectionChangedCause.keyboard,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        pbSubHeader('Pattern C — Paragraph Counter Overlay'),

        pbCard(
          'A logging action that tracks how many paragraphs have been '
          'traversed and prints selection statistics:',
        ),

        pbCode(
          'class ParagraphCounterAction\n'
          '    extends Action<ExtendSelectionToNextParagraphBoundaryIntent> {\n'
          '  ParagraphCounterAction(this.state, this.defaultAction);\n'
          '  final EditableTextState state;\n'
          '  final Action<ExtendSelectionToNextParagraphBoundaryIntent>\n'
          '      defaultAction;\n'
          '  int traversedCount = 0;\n\n'
          '  @override\n'
          '  void invoke(\n'
          '    ExtendSelectionToNextParagraphBoundaryIntent intent,\n'
          '  ) {\n'
          '    defaultAction.invoke(intent);\n'
          '    traversedCount++;\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    final selectedLength =\n'
          '        (sel.extentOffset - sel.baseOffset).abs();\n'
          '    print(\'Paragraph traversals: \$traversedCount\');\n'
          '    print(\'Selected characters: \$selectedLength\');\n'
          '  }\n'
          '}',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 10. EDGE CASES
        // =====================================================================
        pbHeader('10. Edge Cases'),

        pbSubHeader('Edge Case 1 — Single Paragraph Document'),

        pbCard(
          'When the document contains no newline characters, there is '
          'only one paragraph. Forward extends to the document end; '
          'backward extends to offset 0. The intent effectively becomes '
          'equivalent to ExtendSelectionToDocumentBoundaryIntent.',
        ),

        pbSubHeader('Edge Case 2 — Empty Paragraphs'),

        pbCode(
          'Text with empty paragraphs:\n'
          '  "Line one\\n"\n'
          '  "\\n"           \u2190 empty paragraph\n'
          '  "\\n"           \u2190 empty paragraph\n'
          '  "Line four"\n\n'
          'Extending forward from "Line one" lands at the first\n'
          'empty paragraph boundary (after first \\n).\n'
          'A second forward invocation lands at the next empty\n'
          'paragraph (after second \\n).\n'
          'A third forward invocation reaches "Line four".',
        ),

        pbSubHeader('Edge Case 3 — Cursor at Paragraph Boundary'),

        pbCard(
          'When the extent is already at a paragraph boundary (right '
          'after a \\n), invoking forward extends to the END of the '
          'next paragraph. The intent does not stop at the position '
          'it is already at — it always advances to the NEXT boundary.',
        ),

        pbSubHeader('Edge Case 4 — Very Long Paragraph'),

        pbCard(
          'A paragraph with thousands of characters and no newlines. '
          'Forward/backward jumps the full paragraph length in one '
          'step. The text field auto-scrolls to the new extent. '
          'Performance depends on TextPainter layout caching.',
        ),

        pbSubHeader('Edge Case 5 — Trailing Newline'),

        pbCode(
          'Text ending with newline:\n'
          '  "Last paragraph.\\n"\n\n'
          'Extending forward from "Last" goes to offset before \\n.\n'
          'Extending forward again goes to end of text (after \\n).\n'
          'The trailing \\n creates an implicit empty final paragraph.',
        ),

        pbSubHeader('Edge Case 6 — Mixed Content with Embedded Newlines'),

        pbCard(
          'In rich text or code content, \\n characters may appear '
          'inside strings, comments, or data. The paragraph boundary '
          'detection operates purely on character content — it does '
          'not understand syntax. Every \\n is a paragraph break '
          'regardless of semantic context.',
        ),

        pbDividerWidget(),

        // =====================================================================
        // 11. COMPARISON WITH DOCUMENT-LEVEL
        // =====================================================================
        pbHeader('11. Comparison with Document-Level Extension'),

        pbCard(
          'ExtendSelectionToDocumentBoundaryIntent always jumps to the '
          'absolute start or end of the document in a single invocation. '
          'In contrast, the paragraph intent provides incremental '
          'navigation through the document structure.',
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pbCompare(
              'Paragraph Boundary',
              'Incremental: one paragraph at a time.\n\n'
                  'Repeatable: each invocation advances further.\n\n'
                  'Useful for scanning through structured text.\n\n'
                  'The primary use case is extending selection '
                  'through logical text sections.',
              pbFoam,
            ),
            pbCompare(
              'Document Boundary',
              'Absolute: jumps to doc start/end in one step.\n\n'
                  'Idempotent: second invocation is a no-op.\n\n'
                  'Useful for "select to end" operations.\n\n'
                  'Equivalent to Ctrl+Shift+End / Ctrl+Shift+Home.',
              pbIce,
            ),
          ],
        ),

        pbDividerWidget(),

        // =====================================================================
        // 12. SUMMARY
        // =====================================================================
        pbHeader('12. Summary'),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                pbAzure.withValues(alpha: 0.12),
                pbFoam,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: pbSky),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToNextParagraphBoundaryIntent — '
                'Key Takeaways',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: pbNavy,
                ),
              ),
              const SizedBox(height: 12),
              pbBullet(
                'Extends the selection EXTENT to the next paragraph '
                'boundary (defined by \\n characters) in the given '
                'direction.',
              ),
              pbBullet(
                'The BASE remains fixed — only the extent moves to '
                'the paragraph boundary.',
              ),
              pbBullet(
                'forward: true = toward next \\n (or document end); '
                'forward: false = toward previous \\n (or document start).',
              ),
              pbBullet(
                'Paragraphs are delimited by newline characters — '
                'soft-wrap line breaks are NOT paragraph boundaries.',
              ),
              pbBullet(
                'Repeatable: each invocation advances to the next '
                'paragraph boundary, unlike line-break intents which '
                'are idempotent.',
              ),
              pbBullet(
                'Differs from Expand: Extend can shrink or reverse '
                'a selection; Expand can only grow.',
              ),
              pbBullet(
                'In a single-paragraph document, behaves like '
                'ExtendSelectionToDocumentBoundaryIntent.',
              ),
              pbBullet(
                'Empty paragraphs (consecutive \\n\\n) are traversed '
                'one at a time, stopping at each boundary.',
              ),
              pbBullet(
                'Custom actions can redefine paragraph boundaries '
                '(e.g., blank-line-separated sections) for domain-'
                'specific editing needs.',
              ),
              Wrap(
                children: [
                  pbBadge('Paragraph-Level'),
                  pbBadge('Directional'),
                  pbBadge('Repeatable'),
                  pbBadge('Extent Only'),
                  pbBadge('Newline-Delimited'),
                  pbBadge('Incremental'),
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
