// ignore_for_file: avoid_print
// Deep demo: ExtendSelectionToNextWordBoundaryIntent — extending the selection
// extent to the boundary of the next word in a given direction while the
// selection base (anchor) stays fixed.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Theme — Emerald Pine (#1B5E20) / Dew Green (#E8F5E9)
  // ---------------------------------------------------------------------------
  const Color wbPine = Color(0xFF1B5E20);
  const Color wbDew = Color(0xFFE8F5E9);
  const Color wbForest = Color(0xFF2E7D32);
  const Color wbMint = Color(0xFFA5D6A7);
  const Color wbEvergreen = Color(0xFF388E3C);
  const Color wbSage = Color(0xFFC8E6C9);
  const Color wbMoss = Color(0xFF43A047);
  const Color wbWhite = Color(0xFFFFFFFF);
  const Color wbBlack = Color(0xFF0D2B0D);
  const Color wbDivider = Color(0xFF66BB6A);

  // ---------------------------------------------------------------------------
  // Helper: section header
  // ---------------------------------------------------------------------------
  Widget wbHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [wbPine, wbForest],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: wbPine.withValues(alpha: 0.35),
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
          color: wbWhite,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: sub-header
  // ---------------------------------------------------------------------------
  Widget wbSubHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: wbSage,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wbMint, width: 1.2),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: wbPine,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: explanation card
  // ---------------------------------------------------------------------------
  Widget wbCard(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: wbDew,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wbMint.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: wbBlack,
          height: 1.55,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: code card
  // ---------------------------------------------------------------------------
  Widget wbCode(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: wbBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wbDivider),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'monospace',
          color: wbSage,
          height: 1.6,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: row
  // ---------------------------------------------------------------------------
  Widget wbRow(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: wbWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: wbMint.withValues(alpha: 0.3)),
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
                color: wbForest,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: wbBlack,
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
  Widget wbBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '\u2022 ',
            style: TextStyle(
              fontSize: 14,
              color: wbEvergreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: wbBlack,
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
  Widget wbStep(int num, String text) {
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
              color: wbMoss,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$num',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: wbWhite,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: wbBlack,
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
  Widget wbCompare(String title, String body, Color bg) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: wbDivider.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: wbPine,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: const TextStyle(
                fontSize: 13,
                color: wbBlack,
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
  Widget wbDividerWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      height: 1.5,
      color: wbMint.withValues(alpha: 0.35),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: badge
  // ---------------------------------------------------------------------------
  Widget wbBadge(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: wbEvergreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: wbWhite,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: diagram
  // ---------------------------------------------------------------------------
  Widget wbDiagram(String label, String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: wbDew,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wbForest.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: wbForest,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
              color: wbBlack,
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
              colors: [wbPine, wbForest, wbEvergreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: wbPine.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToNextWord\nBoundaryIntent',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: wbWhite,
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
                  color: wbWhite.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Shift + Ctrl/Option + Arrow — Word-Level Selection',
                  style: TextStyle(
                    fontSize: 14,
                    color: wbSage,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Extends the selection extent to the boundary of the '
                'next word in a given direction. The base (anchor) '
                'stays fixed, creating or growing a selection that '
                'spans complete words. This is the most frequently '
                'used mid-granularity selection intent — finer than '
                'line-level, coarser than character-level.',
                style: TextStyle(
                  fontSize: 14,
                  color: wbDew,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),

        // =====================================================================
        // 1. INHERITANCE & CLASS IDENTITY
        // =====================================================================
        wbHeader('1. Inheritance & Class Identity'),

        wbCard(
          'ExtendSelectionToNextWordBoundaryIntent is the word-level '
          'member of the "Extend" selection intent family. It inherits '
          'the "forward" boolean from DirectionalTextEditingIntent.',
        ),

        wbCode(
          'Object\n'
          '  \u2514\u2500 Intent\n'
          '       \u2514\u2500 DirectionalTextEditingIntent\n'
          '            \u251c\u2500 forward: bool\n'
          '            \u2514\u2500 ExtendSelectionToNextWordBoundaryIntent\n'
          '                 \u251c\u2500 forward: true  \u2192 next word boundary (right in LTR)\n'
          '                 \u2514\u2500 forward: false \u2192 previous word boundary (left in LTR)',
        ),

        wbSubHeader('Constructor'),

        wbCode(
          'const ExtendSelectionToNextWordBoundaryIntent({\n'
          '  required bool forward,\n'
          '}) : super(forward);',
        ),

        wbCard(
          'The intent is simple — direction only. All word boundary '
          'detection logic is in the action implementation, which '
          'uses the platform\'s text layout engine to determine where '
          'word boundaries fall.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 2. WHAT DEFINES A WORD BOUNDARY?
        // =====================================================================
        wbHeader('2. What Defines a Word Boundary?'),

        wbCard(
          'Word boundaries are determined by Unicode text segmentation '
          'rules (UAX #29) as implemented by the platform\'s text '
          'shaping engine. The exact behavior varies by platform and '
          'locale, but follows general patterns:',
        ),

        wbSubHeader('Common Word Boundary Rules'),

        wbRow('Whitespace \u2192 letter',
          'Boundary between space and next word start: '
          '"hello |world"',
        ),
        wbRow('Letter \u2192 whitespace',
          'Boundary between word end and space: '
          '"hello| world"',
        ),
        wbRow('Letter \u2192 punctuation',
          'Boundary at punctuation: "hello|, world" '
          '(platform-dependent)',
        ),
        wbRow('Punctuation \u2192 letter',
          'Boundary after punctuation: "hello, |world"',
        ),
        wbRow('CamelCase',
          'Some platforms break at case changes: '
          '"camel|Case" (IDE-specific, not default)',
        ),
        wbRow('Underscore',
          'Usually treated as part of a word in code: '
          '"my_variable" = one word',
        ),
        wbRow('Hyphen',
          'Usually a boundary: "well|-known" = two words',
        ),

        wbSubHeader('Platform-Specific Differences'),

        wbCode(
          'Text: "obj.method(arg1, arg2)"\n\n'
          'macOS word boundaries (Option+Right):\n'
          '  "obj|.|method|(|arg1|,| |arg2|)"\n'
          '  Periods and parentheses are separate "words".\n\n'
          'Windows/Linux word boundaries (Ctrl+Right):\n'
          '  "obj|.|method|(|arg1|, |arg2|)"\n'
          '  Comma+space may be grouped together.\n\n'
          'ICU-based (Android):\n'
          '  "obj|.method|(arg1|, arg2|)"\n'
          '  Dot may attach to next word.',
        ),

        wbCard(
          'The key takeaway: word boundary definitions are NOT universal. '
          'Flutter delegates to the platform\'s text engine for boundary '
          'detection, which means the same intent may produce slightly '
          'different results on different platforms.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 3. VISUAL WALKTHROUGH — FORWARD
        // =====================================================================
        wbHeader('3. Visual Walkthrough — Forward Selection'),

        wbCard(
          'Step-by-step demonstration of forward word selection '
          'starting from a collapsed cursor:',
        ),

        wbDiagram(
          'Initial — cursor at offset 4:',
          '"The |quick brown fox jumps over the lazy dog."\n'
          '      ^ cursor (offset 4)',
        ),

        wbDiagram(
          'After 1st Extend forward (Shift+Ctrl+Right):',
          '"The [quick] brown fox jumps over the lazy dog."\n'
          '      ^base ^extent\n'
          '  base=4, extent=9  (selected "quick")',
        ),

        wbDiagram(
          'After 2nd Extend forward:',
          '"The [quick brown] fox jumps over the lazy dog."\n'
          '      ^base      ^extent\n'
          '  base=4, extent=15  (selected "quick brown")',
        ),

        wbDiagram(
          'After 3rd Extend forward:',
          '"The [quick brown fox] jumps over the lazy dog."\n'
          '      ^base          ^extent\n'
          '  base=4, extent=19  (selected "quick brown fox")',
        ),

        wbCard(
          'Each invocation advances the extent to the next word boundary. '
          'The selection grows word-by-word, which is the most common '
          'text selection workflow for selecting phrases or clauses.',
        ),

        wbSubHeader('Whitespace Handling'),

        wbCard(
          'Whether the trailing space is included in the word selection '
          'depends on the platform. On most platforms, Ctrl+Shift+Right '
          'stops at the END of the next word (before the space). On '
          'some, it stops at the START of the next word (after the space).',
        ),

        wbCode(
          'Style A — stop at word end (Windows default):\n'
          '  "The [quick]| brown fox..."   \u2192 extent before space\n\n'
          'Style B — stop at next word start (some macOS apps):\n'
          '  "The [quick |]brown fox..."   \u2192 extent includes space',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 4. VISUAL WALKTHROUGH — BACKWARD
        // =====================================================================
        wbHeader('4. Visual Walkthrough — Backward Selection'),

        wbDiagram(
          'Initial — cursor at offset 30:',
          '"The quick brown fox jumps over| the lazy dog."\n'
          '                               ^ cursor (offset 30)',
        ),

        wbDiagram(
          'After 1st Extend backward (Shift+Ctrl+Left):',
          '"The quick brown fox jumps [over] the lazy dog."\n'
          '                           ^extent ^base\n'
          '  base=30, extent=25  (selected "over")',
        ),

        wbDiagram(
          'After 2nd Extend backward:',
          '"The quick brown fox [jumps over] the lazy dog."\n'
          '                     ^extent     ^base\n'
          '  base=30, extent=19  (selected "jumps over")',
        ),

        wbDiagram(
          'After 3rd Extend backward:',
          '"The quick brown [fox jumps over] the lazy dog."\n'
          '                 ^extent         ^base\n'
          '  base=30, extent=15  (selected "fox jumps over")',
        ),

        wbCard(
          'Backward selection creates reversed selections where '
          'extent < base. This is valid and visually indistinguishable '
          'from a forward selection covering the same range.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 5. EXTEND vs EXPAND — WORD LEVEL
        // =====================================================================
        wbHeader('5. Extend vs Expand — Word Level'),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wbCompare(
              'Extend (this intent)',
              'Moves EXTENT to word boundary.\n\n'
                  'Base stays fixed.\n\n'
                  'Selection can shrink if extent crosses base.\n\n'
                  'Supports reversed selections.\n\n'
                  'Used by: Shift+Ctrl+Arrow.',
              wbDew,
            ),
            wbCompare(
              'Expand',
              'Grows selection to encompass the word.\n\n'
                  'Both base and extent may move.\n\n'
                  'Selection can only grow.\n\n'
                  'No reversed selections.\n\n'
                  'Used by: double-click drag.',
              wbSage,
            ),
          ],
        ),

        wbSubHeader('Shrinking Example'),

        wbDiagram(
          'Existing selection — "quick brown fox" selected:',
          '"The [quick brown fox] jumps over..."\n'
          '      ^base          ^extent\n'
          '  base=4, extent=19',
        ),

        wbDiagram(
          'After Extend backward (extent moves left):',
          '"The [quick brown] fox jumps over..."\n'
          '      ^base      ^extent\n'
          '  base=4, extent=15\n'
          '  Selection SHRANK — "fox" was deselected.',
        ),

        wbDiagram(
          'After another Extend backward:',
          '"The [quick] brown fox jumps over..."\n'
          '      ^base ^extent\n'
          '  base=4, extent=9\n'
          '  Shrank again — only "quick" selected.',
        ),

        wbCard(
          'This shrinking behavior is unique to "Extend" intents. '
          '"Expand" would never shrink the selection — it would move '
          'the base instead to keep the selection growing.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 6. KEYBOARD SHORTCUTS
        // =====================================================================
        wbHeader('6. Keyboard Shortcuts'),

        wbRow('Windows / Linux', 'Shift+Ctrl+Right = forward: true\n'
          'Shift+Ctrl+Left = forward: false',
        ),
        wbRow('macOS', 'Shift+Option+Right = forward: true\n'
          'Shift+Option+Left = forward: false',
        ),
        wbRow('Web', 'Follows host OS conventions'),
        wbRow('iOS', 'No direct keyboard shortcut; gesture-based '
          'word selection via double-tap-drag.',
        ),
        wbRow('Android', 'Shift+Ctrl+Arrow on external keyboard'),

        wbCard(
          'The macOS use of Option instead of Ctrl for word-level '
          'operations is a key platform difference. Ctrl on macOS is '
          'reserved for Emacs-style shortcuts (Ctrl+A = Home, '
          'Ctrl+E = End, etc.).',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 7. DISPATCH PIPELINE
        // =====================================================================
        wbHeader('7. Dispatch Pipeline'),

        wbStep(1,
          'Key event: Shift+Ctrl+Right detected by the keyboard '
          'listener within the FocusScope hierarchy.',
        ),
        wbStep(2,
          'Shortcuts widget maps the key combo to '
          'ExtendSelectionToNextWordBoundaryIntent(forward: true).',
        ),
        wbStep(3,
          'Actions widget walks up to find the registered action. '
          'EditableText provides the word-boundary action.',
        ),
        wbStep(4,
          'The action reads the current TextSelection and queries '
          'the TextPainter for the next word boundary offset.',
        ),
        wbStep(5,
          'TextPainter.getWordBoundary(TextPosition) returns a '
          'TextRange identifying the word at the current position. '
          'The action uses the appropriate end of this range.',
        ),
        wbStep(6,
          'A new TextSelection is created with the same base and '
          'the new extent at the word boundary.',
        ),
        wbStep(7,
          'TextEditingValue is updated, selection highlight repaints, '
          'and the viewport scrolls to keep the extent visible.',
        ),

        wbCode(
          '// Core of the action implementation:\n'
          'void invoke(ExtendSelectionToNextWordBoundaryIntent intent) {\n'
          '  final sel = textEditingValue.selection;\n'
          '  final TextPosition pos = TextPosition(\n'
          '    offset: sel.extentOffset,\n'
          '  );\n'
          '  final TextRange wordRange = renderEditable\n'
          '      .getWordBoundary(pos);\n'
          '  final int newExtent;\n'
          '  if (intent.forward) {\n'
          '    // Move to end of current word, or start of next\n'
          '    newExtent = sel.extentOffset == wordRange.end\n'
          '        ? getNextWordEnd(sel.extentOffset)\n'
          '        : wordRange.end;\n'
          '  } else {\n'
          '    newExtent = sel.extentOffset == wordRange.start\n'
          '        ? getPreviousWordStart(sel.extentOffset)\n'
          '        : wordRange.start;\n'
          '  }\n'
          '  textEditingValue = textEditingValue.copyWith(\n'
          '    selection: sel.copyWith(extentOffset: newExtent),\n'
          '  );\n'
          '}',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 8. WORD BOUNDARY IN DIFFERENT LANGUAGES
        // =====================================================================
        wbHeader('8. Word Boundaries in Different Languages'),

        wbCard(
          'Word boundary detection varies significantly across '
          'languages and writing systems:',
        ),

        wbSubHeader('Latin Scripts (English, French, German)'),

        wbCode(
          '"The quick brown fox"\n'
          ' ^^^|^^^^^|^^^^^|^^^\n'
          ' w0  w1    w2    w3\n'
          '\n'
          'Words separated by spaces. Boundaries are clear.',
        ),

        wbSubHeader('CJK (Chinese, Japanese, Korean)'),

        wbCode(
          '"\u4ECA\u65E5\u306F\u826F\u3044\u5929\u6C17\u3067\u3059"  (Japanese)\n'
          'No spaces between words.\n'
          'Word boundary detection uses dictionary-based\n'
          'segmentation (ICU BreakIterator).\n'
          'Results: "\u4ECA\u65E5|\u306F|\u826F\u3044|\u5929\u6C17|\u3067\u3059"',
        ),

        wbSubHeader('Thai'),

        wbCode(
          '"\u0E2A\u0E27\u0E31\u0E2A\u0E14\u0E35\u0E04\u0E23\u0E31\u0E1A"  (Thai: "Hello")\n'
          'Thai has no spaces between words.\n'
          'Requires dictionary-based word breaking.\n'
          'Platform ICU libraries handle segmentation.',
        ),

        wbSubHeader('Arabic / Hebrew (RTL)'),

        wbCode(
          '"\u0645\u0631\u062D\u0628\u0627 \u0628\u0627\u0644\u0639\u0627\u0644\u0645"  (Arabic: "Hello World")\n'
          'Words separated by spaces (like Latin).\n'
          'forward=true moves extent LEFT visually.\n'
          'forward=false moves extent RIGHT visually.\n'
          'Text direction does not affect forward/backward\n'
          'semantics — they always mean document order.',
        ),

        wbCard(
          'Flutter\'s word boundary detection delegates to the '
          'platform\'s ICU (International Components for Unicode) '
          'implementation, ensuring correct behavior for all '
          'supported locales.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 9. EXISTING SELECTION SCENARIOS
        // =====================================================================
        wbHeader('9. Existing Selection Scenarios'),

        wbSubHeader('Scenario A — Forward with Forward Selection'),

        wbDiagram(
          'Before — two words selected:',
          '"The [quick brown] fox jumps"\n'
          '      ^base      ^extent\n'
          '  base=4, extent=15',
        ),
        wbDiagram(
          'After Extend forward:',
          '"The [quick brown fox] jumps"\n'
          '      ^base          ^extent\n'
          '  base=4, extent=19  (grew by one word)',
        ),

        wbSubHeader('Scenario B — Backward with Forward Selection'),

        wbDiagram(
          'Before:',
          '"The [quick brown] fox jumps"\n'
          '      ^base      ^extent',
        ),
        wbDiagram(
          'After Extend backward:',
          '"The [quick] brown fox jumps"\n'
          '      ^base ^extent\n'
          '  Selection shrank — "brown" deselected.',
        ),

        wbSubHeader('Scenario C — Extent Crosses Base'),

        wbDiagram(
          'Before — one word selected:',
          '"The [quick] brown fox jumps"\n'
          '      ^base ^extent\n'
          '  base=4, extent=9',
        ),
        wbDiagram(
          'After two Extend backward invocations:',
          '"[The ]quick brown fox jumps"\n'
          ' ^extent ^base\n'
          '  base=4, extent=0  (extent crossed base!)',
        ),

        wbCard(
          'When the extent crosses the base, the selection reverses '
          'direction. Text between the new extent and the base is '
          'now highlighted. This is the standard "Extend" behavior.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 10. SELECTION INTENT FAMILY — WORD POSITION
        // =====================================================================
        wbHeader('10. Selection Intent Family — Word Position'),

        wbRow('Character',
          'ExtendSelectionByCharacterIntent — finest granularity',
        ),
        wbRow('Word',
          'ExtendSelectionToNextWordBoundaryIntent \u2190 this demo',
        ),
        wbRow('Word or Caret',
          'ExtendSelectionToNextWordBoundaryOrCaretLocationIntent — '
          'composite with caret awareness',
        ),
        wbRow('Line',
          'ExtendSelectionToLineBreakIntent — line-level',
        ),
        wbRow('Paragraph',
          'ExtendSelectionToNextParagraphBoundaryIntent — para-level',
        ),
        wbRow('Document',
          'ExtendSelectionToDocumentBoundaryIntent — doc-level',
        ),

        wbCard(
          'Word-level sits between character and line in the '
          'granularity hierarchy. It is the most commonly used '
          'selection granularity for editing text — selecting words '
          'and phrases is a fundamental editing operation.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 11. CUSTOM ACTION PATTERNS
        // =====================================================================
        wbHeader('11. Custom Action Patterns'),

        wbSubHeader('Pattern A — CamelCase-Aware Word Selection'),

        wbCard(
          'A custom action that breaks CamelCase identifiers at '
          'case transitions, useful for code editors:',
        ),

        wbCode(
          'class CamelCaseWordExtendAction\n'
          '    extends Action<ExtendSelectionToNextWordBoundaryIntent> {\n'
          '  CamelCaseWordExtendAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(ExtendSelectionToNextWordBoundaryIntent intent) {\n'
          '    final text = state.textEditingValue.text;\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    int pos = sel.extentOffset;\n'
          '    if (intent.forward) {\n'
          '      while (pos < text.length) {\n'
          '        pos++;\n'
          '        if (pos < text.length &&\n'
          '            text[pos] == text[pos].toUpperCase() &&\n'
          '            text[pos] != text[pos].toLowerCase()) {\n'
          '          break; // Found uppercase letter = camelCase boundary\n'
          '        }\n'
          '      }\n'
          '    } else {\n'
          '      while (pos > 0) {\n'
          '        pos--;\n'
          '        if (text[pos] == text[pos].toUpperCase() &&\n'
          '            text[pos] != text[pos].toLowerCase()) {\n'
          '          break;\n'
          '        }\n'
          '      }\n'
          '    }\n'
          '    state.userUpdateTextEditingValue(\n'
          '      state.textEditingValue.copyWith(\n'
          '        selection: sel.copyWith(extentOffset: pos),\n'
          '      ),\n'
          '      SelectionChangedCause.keyboard,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        wbSubHeader('Pattern B — Select Entire Word Under Cursor'),

        wbCard(
          'A custom action that ignores direction and selects the '
          'complete word under the cursor (like double-click):',
        ),

        wbCode(
          'class SelectWholeWordAction\n'
          '    extends Action<ExtendSelectionToNextWordBoundaryIntent> {\n'
          '  SelectWholeWordAction(this.state);\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(ExtendSelectionToNextWordBoundaryIntent intent) {\n'
          '    final sel = state.textEditingValue.selection;\n'
          '    final wordRange = state.renderEditable.getWordBoundary(\n'
          '      TextPosition(offset: sel.extentOffset),\n'
          '    );\n'
          '    state.userUpdateTextEditingValue(\n'
          '      state.textEditingValue.copyWith(\n'
          '        selection: TextSelection(\n'
          '          baseOffset: wordRange.start,\n'
          '          extentOffset: wordRange.end,\n'
          '        ),\n'
          '      ),\n'
          '      SelectionChangedCause.keyboard,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        wbSubHeader('Pattern C — Word Selection with Logging'),

        wbCode(
          'class LoggingWordExtendAction\n'
          '    extends Action<ExtendSelectionToNextWordBoundaryIntent> {\n'
          '  LoggingWordExtendAction(this.defaultAction, this.state);\n'
          '  final Action<ExtendSelectionToNextWordBoundaryIntent>\n'
          '      defaultAction;\n'
          '  final EditableTextState state;\n\n'
          '  @override\n'
          '  void invoke(ExtendSelectionToNextWordBoundaryIntent intent) {\n'
          '    final before = state.textEditingValue.selection;\n'
          '    defaultAction.invoke(intent);\n'
          '    final after = state.textEditingValue.selection;\n'
          '    final selectedText = state.textEditingValue.text\n'
          '        .substring(\n'
          '          after.start,\n'
          '          after.end,\n'
          '        );\n'
          '    print(\'Word selection: "\$selectedText"\');\n'
          '    print(\'Direction: \'\n'
          '        \'\${intent.forward ? "forward" : "backward"}\');\n'
          '    print(\'Extent moved: \'\n'
          '        \'\${before.extentOffset} \u2192 \${after.extentOffset}\');\n'
          '  }\n'
          '}',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 12. EDGE CASES
        // =====================================================================
        wbHeader('12. Edge Cases'),

        wbSubHeader('Edge Case 1 — Cursor Inside a Word'),

        wbCode(
          'Text: "Hello World"\n'
          'Cursor at offset 2 (inside "Hello"):\n'
          '  "He|llo World"\n\n'
          'Forward: extent moves to offset 5 (end of "Hello")\n'
          'Backward: extent moves to offset 0 (start of "Hello")\n\n'
          'The first invocation completes the current word.\n'
          'Subsequent invocations advance to further words.',
        ),

        wbSubHeader('Edge Case 2 — Multiple Spaces Between Words'),

        wbCode(
          'Text: "Hello    World"  (4 spaces)\n'
          'Cursor after "Hello":\n'
          '  "Hello|    World"\n\n'
          'Forward: extent jumps to "World" (skips all spaces).\n'
          'Spaces between words are typically treated as a single\n'
          'boundary gap, not individual "space words".',
        ),

        wbSubHeader('Edge Case 3 — Punctuation Clusters'),

        wbCode(
          'Text: "Hello!!! World"\n'
          'Cursor at start:\n'
          '  "|Hello!!! World"\n\n'
          'Forward invocations may produce:\n'
          '  1st: extent at 5 ("Hello" selected)\n'
          '  2nd: extent at 8 ("!!!" selected as punctuation word)\n'
          '  3rd: extent at 14 (" World" selected)\n\n'
          'Or (platform-dependent):\n'
          '  1st: extent at 8 ("Hello!!!" as one unit)\n'
          '  2nd: extent at 14 (" World" selected)',
        ),

        wbSubHeader('Edge Case 4 — Empty Text'),

        wbCard(
          'With an empty text field (text = ""), the cursor is at '
          'offset 0 and there are no word boundaries. The intent is '
          'a no-op — the extent cannot move.',
        ),

        wbSubHeader('Edge Case 5 — Single Character'),

        wbCode(
          'Text: "X"\n'
          'Cursor at offset 0:\n'
          '  Forward: extent moves to 1 (selects "X")\n'
          'Cursor at offset 1:\n'
          '  Backward: extent moves to 0 (selects "X")\n'
          '  Forward: no-op (already at end)',
        ),

        wbSubHeader('Edge Case 6 — Newline as Word Boundary'),

        wbCard(
          'Newline characters (\\n) act as word boundaries. When '
          'extending word-by-word forward, the extent will stop at '
          'the newline and then cross to the first word of the next '
          'line on the subsequent invocation.',
        ),

        wbSubHeader('Edge Case 7 — Emoji and Grapheme Clusters'),

        wbCode(
          'Text: "Hello \uD83D\uDE00\uD83D\uDE01 World"\n'
          'Emojis are typically treated as individual words.\n'
          'Forward from cursor after "Hello ":\n'
          '  1st: selects \uD83D\uDE00 (one emoji = one word)\n'
          '  2nd: selects \uD83D\uDE01 (next emoji)\n'
          '  3rd: selects " World"\n\n'
          'Multi-codepoint emojis (flags, skin tones) are\n'
          'kept as single grapheme clusters by the text system.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 13. COMPARISON WITH CHARACTER INTENT
        // =====================================================================
        wbHeader('13. Comparison with Character Intent'),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wbCompare(
              'Character (Shift+Arrow)',
              'Finest granularity.\n\n'
                  'Moves one grapheme cluster at a time.\n\n'
                  'Predictable — always one unit.\n\n'
                  'Slow for selecting phrases.',
              wbDew,
            ),
            wbCompare(
              'Word (Shift+Ctrl+Arrow)',
              'Medium granularity.\n\n'
                  'Jumps to next word boundary.\n\n'
                  'Boundary is locale/platform-dependent.\n\n'
                  'Fast for selecting phrases.',
              wbSage,
            ),
          ],
        ),

        wbCard(
          'In practice, users alternate between character and word '
          'selection: use word-level to quickly get close to the '
          'desired range, then switch to character-level for '
          'fine-tuning the selection boundaries.',
        ),

        wbDividerWidget(),

        // =====================================================================
        // 14. SUMMARY
        // =====================================================================
        wbHeader('14. Summary'),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                wbForest.withValues(alpha: 0.12),
                wbDew,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: wbMint),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ExtendSelectionToNextWordBoundaryIntent — '
                'Key Takeaways',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: wbPine,
                ),
              ),
              const SizedBox(height: 12),
              wbBullet(
                'Extends the selection EXTENT to the next word boundary '
                'in the given direction, keeping the base fixed.',
              ),
              wbBullet(
                'forward: true = next word boundary (Shift+Ctrl+Right); '
                'forward: false = previous word boundary (Shift+Ctrl+Left).',
              ),
              wbBullet(
                'Word boundaries are determined by Unicode UAX #29 rules '
                'as implemented by the platform\'s ICU library.',
              ),
              wbBullet(
                'Repeatable: each invocation advances one word further. '
                'This is the most common editing flow for phrase selection.',
              ),
              wbBullet(
                'Can shrink or reverse a selection — the extent may cross '
                'the base when moving backward through selected text.',
              ),
              wbBullet(
                'Platform-dependent: macOS uses Option+Arrow, Windows/Linux '
                'uses Ctrl+Arrow. Boundary detection may differ by platform.',
              ),
              wbBullet(
                'Handles CJK, Thai, Arabic, emoji and other complex scripts '
                'through the platform\'s text segmentation engine.',
              ),
              wbBullet(
                'Differs from Expand: Extend can shrink selections; '
                'Expand only grows. Extend supports reversed selections.',
              ),
              wbBullet(
                'Custom actions can implement CamelCase-aware boundaries, '
                'whole-word selection, or logging wrappers.',
              ),
              Wrap(
                children: [
                  wbBadge('Word-Level'),
                  wbBadge('Shift+Ctrl+Arrow'),
                  wbBadge('Repeatable'),
                  wbBadge('Extent Only'),
                  wbBadge('Unicode UAX #29'),
                  wbBadge('Platform-Aware'),
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
