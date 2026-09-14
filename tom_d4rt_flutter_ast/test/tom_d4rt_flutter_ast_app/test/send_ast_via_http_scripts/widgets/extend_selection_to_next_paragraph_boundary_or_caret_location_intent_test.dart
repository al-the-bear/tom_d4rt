// ignore_for_file: avoid_print
// Deep demo: ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent —
// a composite intent that extends the selection extent to EITHER the next
// paragraph boundary OR the caret's current visual location, depending on
// context and prior selection state.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Theme — Bronze (#795548) / Sand (#EFEBE9)
  // ---------------------------------------------------------------------------
  const Color pcBronze = Color(0xFF795548);
  const Color pcSand = Color(0xFFEFEBE9);
  const Color pcCopper = Color(0xFF8D6E63);
  const Color pcTan = Color(0xFFD7CCC8);
  const Color pcUmber = Color(0xFF5D4037);
  const Color pcCream = Color(0xFFF5F0ED);
  const Color pcSienna = Color(0xFF6D4C41);
  const Color pcWhite = Color(0xFFFFFFFF);
  const Color pcBlack = Color(0xFF2C1810);
  const Color pcDivider = Color(0xFFA1887F);

  // ---------------------------------------------------------------------------
  // Helper: section header
  // ---------------------------------------------------------------------------
  Widget pcHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [pcBronze, pcUmber],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: pcBronze.withValues(alpha: 0.35),
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
          color: pcWhite,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: sub-header
  // ---------------------------------------------------------------------------
  Widget pcSubHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: pcTan,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pcCopper, width: 1.2),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: pcUmber,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: explanation card
  // ---------------------------------------------------------------------------
  Widget pcCard(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pcSand,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pcCopper.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: pcBlack,
          height: 1.55,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: code card
  // ---------------------------------------------------------------------------
  Widget pcCode(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pcBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pcDivider),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'monospace',
          color: pcTan,
          height: 1.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: row
  // ---------------------------------------------------------------------------
  Widget pcRow(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: pcWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: pcCopper.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: pcUmber,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: pcBlack,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: bullet
  // ---------------------------------------------------------------------------
  Widget pcBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '\u2022 ',
            style: TextStyle(
              fontSize: 14,
              color: pcSienna,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: pcBlack,
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
  Widget pcStep(int num, String text) {
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
              color: pcSienna,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$num',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: pcWhite,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: pcBlack,
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
  Widget pcCompare(String title, String body, Color bg) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: pcDivider.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: pcUmber,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: const TextStyle(
                fontSize: 13,
                color: pcBlack,
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
  Widget pcDividerWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      height: 1.5,
      color: pcCopper.withValues(alpha: 0.3),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: badge
  // ---------------------------------------------------------------------------
  Widget pcBadge(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: pcSienna,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: pcWhite,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: diagram
  // ---------------------------------------------------------------------------
  Widget pcDiagram(String label, String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pcCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pcUmber.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: pcUmber,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: pcBlack,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: callout box
  // ---------------------------------------------------------------------------
  Widget pcCallout(String title, String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pcTan.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: pcBronze, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: pcBronze,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: pcBlack,
              height: 1.5,
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
              colors: [pcUmber, pcBronze, pcSienna],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: pcUmber.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToNextParagraph\nBoundaryOrCaretLocationIntent',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: pcWhite,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: pcWhite.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Composite Intent — Paragraph Boundary OR Caret Location',
                  style: TextStyle(
                    fontSize: 13,
                    color: pcTan,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'A specialized composite intent that extends the selection '
                'extent to EITHER the next paragraph boundary OR the '
                'caret\'s current vertical location on a different line. '
                'This dual-target behavior provides a more intuitive '
                'paragraph-aware selection that respects the user\'s '
                'horizontal cursor position.',
                style: TextStyle(
                  fontSize: 14,
                  color: pcSand,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),

        // =====================================================================
        // 1. INHERITANCE & CLASS IDENTITY
        // =====================================================================
        pcHeader('1. Inheritance & Class Identity'),

        pcCard(
          'This intent has the longest name in Flutter\'s text editing '
          'intent family. It combines paragraph-boundary semantics with '
          'caret-location awareness, producing context-dependent behavior.',
        ),

        pcCode(
          'Object\n'
          '  \u2514\u2500 Intent\n'
          '       \u2514\u2500 DirectionalTextEditingIntent\n'
          '            \u251c\u2500 forward: bool\n'
          '            \u2514\u2500 ExtendSelectionToNextParagraphBoundary\n'
          '                 OrCaretLocationIntent\n'
          '                 \u251c\u2500 forward: true  \u2192 extend toward next para / caret\n'
          '                 \u2514\u2500 forward: false \u2192 extend toward prev para / caret',
        ),

        pcSubHeader('Constructor'),

        pcCode(
          'const ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent({\n'
          '  required bool forward,\n'
          '}) : super(forward);',
        ),

        pcCard(
          'Like all DirectionalTextEditingIntent subclasses, this '
          'intent carries only the "forward" boolean. The "OrCaretLocation" '
          'logic is entirely in the action that handles this intent.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 2. THE "OR CARET LOCATION" CONCEPT
        // =====================================================================
        pcHeader('2. The "Or Caret Location" Concept'),

        pcCard(
          'The key innovation of this intent is the "or caret location" '
          'fallback. Instead of always jumping to the paragraph boundary, '
          'the action may stop at the horizontal position of the original '
          'caret on the target paragraph\'s line. This preserves the '
          'user\'s column position during vertical selection.',
        ),

        pcCallout(
          'Why does this matter?',
          'Consider selecting text downward through paragraphs. With a '
          'plain paragraph-boundary intent, the extent always jumps to '
          'column 0 or the end of the paragraph. With the caret-location '
          'variant, the extent lands at the same horizontal position the '
          'cursor was at, creating a more rectangular selection shape '
          'that feels natural for column-oriented work.',
        ),

        pcSubHeader('Decision Logic'),

        pcCode(
          '// Pseudocode for the action\'s invoke method:\n'
          'void invoke(intent) {\n'
          '  final paragraphBoundary = findNextParagraphBoundary(\n'
          '    text, extent, intent.forward,\n'
          '  );\n'
          '  final caretLocation = findCaretLocationOnTargetLine(\n'
          '    extent, intent.forward,\n'
          '  );\n'
          '  \n'
          '  // Choose the nearer target:\n'
          '  if (intent.forward) {\n'
          '    newExtent = min(paragraphBoundary, caretLocation);\n'
          '  } else {\n'
          '    newExtent = max(paragraphBoundary, caretLocation);\n'
          '  }\n'
          '  // Update selection with new extent, keep base.\n'
          '}',
        ),

        pcCard(
          'The "nearer target" rule means the extent stops at whichever '
          'position it encounters first while moving in the given '
          'direction. If the caret location on the next line is closer '
          'than the paragraph boundary, it stops there. If the paragraph '
          'boundary comes first, it stops at the boundary.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 3. VISUAL WALKTHROUGH — FORWARD
        // =====================================================================
        pcHeader('3. Visual Walkthrough — Forward'),

        pcCard(
          'A step-by-step visual demonstration of forward selection '
          'with this composite intent:',
        ),

        pcCode(
          'Document (3 paragraphs, columns numbered):\n\n'
          '  Col:  0         1         2         3\n'
          '        0123456789012345678901234567890123456\n'
          '  P0:  "The framework provides reactive UI.\\n"\n'
          '  P1:  "Widgets compose into complex layouts.\\n"\n'
          '  P2:  "State management drives rebuilds."',
        ),

        pcSubHeader('Case A — Caret Location Is Nearer'),

        pcDiagram(
          'Cursor at P0, column 12:',
          'P0: "The framewor|k provides reactive UI.\\n"\n'
          'P1: "Widgets compose into complex layouts.\\n"\n'
          'P2: "State management drives rebuilds."\n\n'
          'Paragraph boundary (end of P0) = column 36\n'
          'Caret location on P1 at column 12 = "Widgets comp|ose..."\n\n'
          'Column 12 on P1 < column 36 (paragraph end)\n'
          '\u2192 Extent moves to P1 column 12 (caret location wins)',
        ),

        pcDiagram(
          'Result:',
          'P0: "The framewor[k provides reactive UI.\\n"\n'
          'P1: "Widgets comp]ose into complex layouts.\\n"\n'
          '\n'
          'base = P0:12, extent = P1:12\n'
          'Selection spans the same column range across paragraphs.',
        ),

        pcSubHeader('Case B — Paragraph Boundary Is Nearer'),

        pcDiagram(
          'Cursor at P0, column 34:',
          'P0: "The framework provides reactive U|I.\\n"\n'
          'P1: "Widgets compose into complex layouts.\\n"\n\n'
          'Paragraph boundary (end of P0) = column 36\n'
          'Caret location on P1 at column 34 = "...complex layou|ts.\\n"\n\n'
          'Column 36 (paragraph end) < Column 34+offset-in-P1\n'
          '\u2192 Extent moves to P0 column 36 (paragraph boundary wins)',
        ),

        pcDiagram(
          'Result:',
          'P0: "The framework provides reactive U[I.]\\n"\n'
          '\n'
          'base = P0:34, extent = P0:36\n'
          'Selection stopped at paragraph end — did not cross to P1.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 4. VISUAL WALKTHROUGH — BACKWARD
        // =====================================================================
        pcHeader('4. Visual Walkthrough — Backward'),

        pcCard(
          'The backward direction mirrors the forward logic but moves '
          'the extent toward the beginning of the document:',
        ),

        pcDiagram(
          'Cursor at P1, column 18:',
          'P0: "The framework provides reactive UI.\\n"\n'
          'P1: "Widgets compose int|o complex layouts.\\n"\n'
          'P2: "State management drives rebuilds."\n\n'
          'Previous paragraph boundary (start of P1) = column 0 of P1\n'
          'Caret location on P0 at column 18 = "The framework provi|des..."',
        ),

        pcDiagram(
          'Backward — caret location nearer:',
          'P0: "The framework provi[des reactive UI.\\n"\n'
          'P1: "Widgets compose int]o complex layouts.\\n"\n\n'
          'base = P1:18, extent = P0:18\n'
          'Extent moved to same column on previous paragraph.',
        ),

        pcDiagram(
          'Backward — paragraph boundary nearer (cursor at P1, column 3):',
          'P0: "The framework provides reactive UI.\\n"\n'
          'P1: "Wid[gets compose into complex layouts.\\n"\n\n'
          'base = P1:3, extent = P1:0 (start of P1)\n'
          'Extent stopped at paragraph start.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 5. COMPARISON WITH PLAIN PARAGRAPH INTENT
        // =====================================================================
        pcHeader('5. Comparison with Plain Paragraph Intent'),

        pcCard(
          'The critical difference between this composite intent and '
          'the plain ExtendSelectionToNextParagraphBoundaryIntent is '
          'the caret-location consideration.',
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pcCompare(
              'Plain Paragraph',
              'Always jumps to paragraph boundary.\n\n'
                  'No column awareness.\n\n'
                  'Extent goes to end/start of paragraph.\n\n'
                  'Repeatable across multiple paragraphs.',
              pcSand,
            ),
            pcCompare(
              'Paragraph Or Caret (this)',
              'Considers caret horizontal position.\n\n'
                  'Column-aware selection.\n\n'
                  'Extent may stop mid-paragraph.\n\n'
                  'Produces more rectangular selections.',
              pcCream,
            ),
          ],
        ),

        pcSubHeader('Side-by-Side Example'),

        pcDiagram(
          'Same starting position — cursor at column 10, paragraph 0:',
          'Plain paragraph (forward):\n'
          '  P0: "The quick [brown fox jumps over.]\\n"\n'
          '  Extent = end of P0 (column 31)\n\n'
          'Paragraph-or-caret (forward):\n'
          '  P0: "The quick [brown fox jumps over.\\n"\n'
          '  P1: "The lazy d]og sleeps all day.\\n"\n'
          '  Extent = P1 column 10\n\n'
          'The plain intent stops at the paragraph break.\n'
          'The composite intent continues to the same column\n'
          'on the next line (within the next paragraph).',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 6. DISPATCH PIPELINE
        // =====================================================================
        pcHeader('6. Dispatch Pipeline'),

        pcStep(1,
          'Key event detected: typically a modifier+arrow combination '
          'that maps to paragraph-level selection with caret awareness.',
        ),
        pcStep(2,
          'Shortcuts widget maps the key to '
          'ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent.',
        ),
        pcStep(3,
          'Actions widget locates the registered action — typically '
          'provided by the EditableText widget.',
        ),
        pcStep(4,
          'The action reads the current TextSelection and TextPainter '
          'layout to determine both the paragraph boundary and the '
          'caret-equivalent position on the target line.',
        ),
        pcStep(5,
          'The action compares the two candidate positions and selects '
          'the one that is closer in the given direction.',
        ),
        pcStep(6,
          'A new TextSelection is produced: same base, new extent at '
          'the chosen position.',
        ),
        pcStep(7,
          'TextEditingValue is updated, selection highlight repaints, '
          'and viewport scrolls to show the new extent.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 7. KEYBOARD SHORTCUT MAPPINGS
        // =====================================================================
        pcHeader('7. Keyboard Shortcut Mappings'),

        pcCard(
          'This composite intent is typically mapped to Option+Shift+Arrow '
          'on macOS. The exact mappings vary by platform and Flutter '
          'version:',
        ),

        pcRow('macOS',
          'Shift+Option+Down = forward: true\n'
          'Shift+Option+Up = forward: false',
        ),
        pcRow('Windows',
          'May map to Shift+Ctrl+Down in some configurations, '
          'but the plain paragraph intent is more common.',
        ),
        pcRow('Linux',
          'Similar to Windows; desktop-environment dependent.',
        ),
        pcRow('iOS', 'Used internally by the text system for '
          'gesture-based paragraph selection.',
        ),

        pcCard(
          'The intent name\'s length reflects its specialized role — '
          'it bridges paragraph navigation with positional awareness, '
          'a combination that is mainly relevant on platforms where '
          'Option+Arrow paragraph navigation is expected (macOS).',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 8. USE CASES
        // =====================================================================
        pcHeader('8. Practical Use Cases'),

        pcSubHeader('Use Case 1 — Column-Aligned Code Selection'),

        pcCard(
          'When editing code, a developer may want to select the same '
          'column range across multiple paragraphs (functions separated '
          'by blank lines). The caret-location behavior makes the '
          'selection follow the cursor\'s column rather than jumping '
          'to paragraph ends.',
        ),

        pcCode(
          'void methodA() {          \u2502\n'
          '  final x = compute();   \u2502 \u2190 cursor at column 18\n'
          '  return x;              \u2502\n'
          '}                        \u2502\n'
          '                         \u2502 \u2190 paragraph boundary\n'
          'void methodB() {          \u2502\n'
          '  final y = transform(); \u2502 \u2190 caret location: column 18\n'
          '  return y;              \u2502\n'
          '}                        \u2502',
        ),

        pcCard(
          'Using the composite intent, the extent would land at column '
          '18 on the first line of methodB — allowing the developer to '
          'see both method signatures in the selection.',
        ),

        pcSubHeader('Use Case 2 — Document Editing'),

        pcCard(
          'When editing prose with paragraphs of varying length, the '
          'caret-location fallback prevents the jarring jump to the '
          'end of a long paragraph. The selection grows naturally, '
          'following the vertical cursor position.',
        ),

        pcSubHeader('Use Case 3 — Selection for Copy/Paste'),

        pcCard(
          'The more predictable selection shape (maintaining column '
          'alignment) makes it easier to select content for copy '
          'operations where the user wants a consistent indentation '
          'or column boundary.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 9. INTERACTION WITH SOFT WRAPPING
        // =====================================================================
        pcHeader('9. Interaction with Soft Wrapping'),

        pcCard(
          'Soft wrapping adds complexity to the caret-location '
          'calculation. When a paragraph wraps across multiple visual '
          'lines, the "same column" on the next paragraph may not '
          'correspond to the same visual horizontal position.',
        ),

        pcCode(
          'Wrapped paragraph (viewport width = 30):\n\n'
          'P0: "Short paragraph.\\n"\n'
          'P1: "This is a much longer paragra"  \u2190 visual line 1\n'
          '    "ph that wraps to a second vi"  \u2190 visual line 2\n'
          '    "sual line.\\n"                  \u2190 visual line 3\n'
          'P2: "Final paragraph."\n\n'
          'Cursor at P0, column 10:\n'
          '  Caret location on P1 = column 10 of visual line 1\n'
          '  (which is offset 10 from start of P1)\n'
          '  Paragraph boundary of P1 = end of "sual line."\n\n'
          'Column 10 < paragraph end \u2192 caret location wins.',
        ),

        pcCard(
          'The caret location is calculated using the TextPainter, '
          'which accounts for the visual layout including wrapping. '
          'The position is the offset within the paragraph that '
          'corresponds to the same horizontal pixel position as the '
          'original cursor.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 10. CUSTOM ACTION PATTERNS
        // =====================================================================
        pcHeader('10. Custom Action Patterns'),

        pcSubHeader('Pattern A — Always Prefer Paragraph Boundary'),

        pcCard(
          'A custom action that disables the caret-location fallback '
          'and always extends to the paragraph boundary:',
        ),

        pcCode(
          'class AlwaysParagraphBoundaryAction extends Action<\n'
          '    ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent> {\n'
          '  AlwaysParagraphBoundaryAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(\n'
          '    ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent\n'
          '        intent,\n'
          '  ) {\n'
          '    final text = state.textEditingValue.text;\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    final boundary = findParagraphBoundary(\n'
          '      text, sel.extentOffset, intent.forward,\n'
          '    );\n'
          '    state.userUpdateTextEditingValue(\n'
          '      state.textEditingValue.copyWith(\n'
          '        selection: sel.copyWith(extentOffset: boundary),\n'
          '      ),\n'
          '      SelectionChangedCause.keyboard,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        pcSubHeader('Pattern B — Always Prefer Caret Location'),

        pcCard(
          'A custom action that always uses the caret location, '
          'ignoring paragraph boundaries entirely:',
        ),

        pcCode(
          'class AlwaysCaretLocationAction extends Action<\n'
          '    ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent> {\n'
          '  AlwaysCaretLocationAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(\n'
          '    ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent\n'
          '        intent,\n'
          '  ) {\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    final caretPos = getCaretLocationOnAdjacentLine(\n'
          '      sel.extentOffset,\n'
          '      intent.forward,\n'
          '    );\n'
          '    state.userUpdateTextEditingValue(\n'
          '      state.textEditingValue.copyWith(\n'
          '        selection: sel.copyWith(extentOffset: caretPos),\n'
          '      ),\n'
          '      SelectionChangedCause.keyboard,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        pcSubHeader('Pattern C — Logging the Decision'),

        pcCard(
          'A wrapper action that logs which target was chosen '
          '(paragraph boundary vs caret location) for debugging:',
        ),

        pcCode(
          'class LoggingParagraphOrCaretAction extends Action<\n'
          '    ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent> {\n'
          '  LoggingParagraphOrCaretAction(this.defaultAction);\n'
          '  final Action<\n'
          '    ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent\n'
          '  > defaultAction;\n\n'
          '  @override\n'
          '  void invoke(\n'
          '    ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent\n'
          '        intent,\n'
          '  ) {\n'
          '    print(\'Before: extent at \'\n'
          '        \'\${getExtentOffset()}\');\n'
          '    defaultAction.invoke(intent);\n'
          '    print(\'After: extent at \'\n'
          '        \'\${getExtentOffset()}\');\n'
          '    print(\'Direction: \'\n'
          '        \'\${intent.forward ? "forward" : "backward"}\');\n'
          '  }\n'
          '}',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 11. EDGE CASES
        // =====================================================================
        pcHeader('11. Edge Cases'),

        pcSubHeader('Edge Case 1 — Single-Line Document'),

        pcCard(
          'When there is only one paragraph (no newlines), there are no '
          'paragraph boundaries to consider. The caret-location '
          'calculation has no adjacent line to target. The intent '
          'typically falls back to document boundary behavior.',
        ),

        pcSubHeader('Edge Case 2 — Cursor at Column 0'),

        pcCard(
          'When the cursor is at column 0, the caret location on the '
          'adjacent paragraph is also column 0 (the paragraph start). '
          'This coincides with the paragraph boundary, so both targets '
          'agree on the same position.',
        ),

        pcSubHeader('Edge Case 3 — Target Paragraph Shorter Than Column'),

        pcCode(
          'P0: "A very long line with many characters.\\n"\n'
          'P1: "Short.\\n"\n\n'
          'Cursor at P0, column 30:\n'
          '  Caret location on P1 cannot reach column 30\n'
          '  (P1 is only 6 characters).\n'
          '  Caret location = end of P1 (column 6).\n'
          '  Paragraph boundary = also end of P1 (column 6).\n'
          '  Both targets agree.',
        ),

        pcSubHeader('Edge Case 4 — Empty Paragraph Between Others'),

        pcCode(
          'P0: "Content paragraph.\\n"\n'
          'P1: "\\n"  \u2190 empty paragraph\n'
          'P2: "Another content paragraph."\n\n'
          'Forward from P0: paragraph boundary = end of P0.\n'
          'Caret location on P1 = column 0 (it\'s empty).\n'
          'The paragraph boundary (end of P0) is nearer.\n'
          'Next invocation: boundary = end of P1 (also column 0+1).',
        ),

        pcSubHeader('Edge Case 5 — Already at Document Start/End'),

        pcCard(
          'If the extent is at the very start of the document and the '
          'intent is backward, or at the very end and the intent is '
          'forward, the operation is a no-op. There is no adjacent '
          'paragraph to target in that direction.',
        ),

        pcSubHeader('Edge Case 6 — RTL Paragraphs'),

        pcCard(
          'In right-to-left text, the "column" concept is measured from '
          'the right edge. The caret-location calculation uses pixel '
          'positions from the TextPainter, which handles bidi layout '
          'automatically. The forward direction still means "toward the '
          'end of the text in document order."',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 12. WHEN TO USE WHICH INTENT
        // =====================================================================
        pcHeader('12. When to Use Which Intent'),

        pcCard(
          'A decision guide for choosing between the paragraph-level '
          'selection intents:',
        ),

        pcRow('Quick select to para end',
          'Use ExtendSelectionToNextParagraphBoundaryIntent — '
          'simple, predictable.',
        ),
        pcRow('Column-aware selection',
          'Use this composite intent — respects horizontal position.',
        ),
        pcRow('Select entire paragraph',
          'Use ExpandSelectionToNextParagraphBoundaryIntent — '
          'grows selection symmetrically.',
        ),
        pcRow('Platform-native feel',
          'Use this composite intent, especially on macOS — '
          'matches Option+Arrow behavior.',
        ),
        pcRow('Programmatic selection',
          'Use the plain paragraph intent — deterministic behavior.',
        ),

        pcDividerWidget(),

        // =====================================================================
        // 13. SUMMARY
        // =====================================================================
        pcHeader('13. Summary'),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                pcBronze.withValues(alpha: 0.12),
                pcSand,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: pcCopper),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToNextParagraphBoundary'
                'OrCaretLocationIntent — Key Takeaways',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: pcUmber,
                ),
              ),
              const SizedBox(height: 12),
              pcBullet(
                'Composite intent: extends selection extent to the '
                'nearer of two targets — paragraph boundary OR caret '
                'location on the adjacent line.',
              ),
              pcBullet(
                'Caret location = same horizontal position on the '
                'target paragraph\'s line, calculated via TextPainter.',
              ),
              pcBullet(
                'Produces more rectangular, column-aligned selections '
                'compared to the plain paragraph boundary intent.',
              ),
              pcBullet(
                'The base stays fixed — only the extent moves, '
                'consistent with all "Extend" intent semantics.',
              ),
              pcBullet(
                'Primarily used on macOS where Option+Arrow paragraph '
                'navigation with Shift creates column-aware selections.',
              ),
              pcBullet(
                'Falls back to paragraph boundary when the caret '
                'location cannot be determined (e.g., at document edges).',
              ),
              pcBullet(
                'Soft wrapping is handled by TextPainter pixel-based '
                'position calculation, not character offsets.',
              ),
              pcBullet(
                'When the target paragraph is shorter than the cursor '
                'column, the caret location snaps to the paragraph end.',
              ),
              pcBullet(
                'Custom actions can override the paragraph/caret '
                'decision to always prefer one strategy over the other.',
              ),
              Wrap(
                children: [
                  pcBadge('Composite'),
                  pcBadge('Paragraph-Level'),
                  pcBadge('Caret-Aware'),
                  pcBadge('Column-Aligned'),
                  pcBadge('macOS-Focused'),
                  pcBadge('Extent Only'),
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
