// ignore_for_file: avoid_print
// ExtendSelectionVerticallyToAdjacentPageIntent – comprehensive deep demo
// Indigo Night / Periwinkle palette – intent extending selection extent
// vertically by a full page (Shift+PageUp / Shift+PageDown).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color vpIndigoNight = Color(0xFF1A237E);
  const Color vpPeriwinkle = Color(0xFFE8EAF6);
  const Color vpOnIndigo = Color(0xFFFFFFFF);
  const Color vpDeepIndigo = Color(0xFF0D1040);
  const Color vpLightLavender = Color(0xFFF3F4FC);
  const Color vpTextDark = Color(0xFF1A1A3E);
  const Color vpAccent = Color(0xFF536DFE);
  const Color vpMuted = Color(0xFF9FA8DA);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget vpHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [vpIndigoNight, vpDeepIndigo],
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
                  color: vpOnIndigo)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: vpOnIndigo.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget vpSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: vpLightLavender,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: vpIndigoNight.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: vpIndigoNight.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: vpIndigoNight)),
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

  Widget vpBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('● ',
              style: TextStyle(color: vpAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: vpTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget vpCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF121333),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: vpPeriwinkle,
              height: 1.5)),
    );
  }

  Widget vpKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: vpDeepIndigo)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: vpTextDark)),
          ),
        ],
      ),
    );
  }

  Widget vpHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: vpAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: vpAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: vpDeepIndigo,
              height: 1.4)),
    );
  }

  Widget vpDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: vpMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget vpCompare(String label, String desc) {
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
              color: vpIndigoNight,
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
                          color: vpDeepIndigo)),
                  TextSpan(
                      text: desc,
                      style:
                          const TextStyle(fontSize: 11, color: vpTextDark)),
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
    color: vpPeriwinkle,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          vpHeader(
            'ExtendSelectionVerticallyToAdjacentPageIntent',
            'Page-level vertical selection – extends the selection extent '
                'up or down by a full viewport page (Shift+PageUp/PageDown)',
          ),

          // ── 1. class overview ──
          vpSection('1 · Class Identity & Inheritance', [
            vpKeyValue('Class',
                'ExtendSelectionVerticallyToAdjacentPageIntent'),
            vpKeyValue('Extends',
                'DirectionalCaretMovementIntent → DirectionalTextEditingIntent'),
            vpKeyValue('Property – forward',
                'bool: true = page down / false = page up'),
            vpKeyValue('Mixin', 'Diagnosticable (via intent hierarchy)'),
            vpDivider(),
            vpBullet(
                'This intent represents a request to extend the current text '
                'selection vertically by one viewport page, moving the extent '
                'while keeping the base fixed.'),
            vpBullet(
                'It is the page-level counterpart of '
                'ExtendSelectionVerticallyToAdjacentLineIntent, which moves '
                'by a single line instead of a full page.'),
            vpCodeBlock(
                'class ExtendSelectionVerticallyToAdjacentPageIntent\n'
                '    extends DirectionalCaretMovementIntent {\n'
                '  const ExtendSelectionVerticallyToAdjacentPageIntent({\n'
                '    required bool forward,\n'
                '  }) : super(forward);\n'
                '}'),
          ]),

          // ── 2. page sizing concept ──
          vpSection('2 · Page Size Determination', [
            vpHighlight(
                'A "page" in this context is the number of visual lines that '
                'fit within the current viewport height of the scrollable text '
                'field. The page size depends on the text field dimensions, '
                'font size, and line height – it is dynamic, not fixed.'),
            vpBullet(
                'The page size is computed as: viewport height / line height, '
                'rounded to a whole number of lines.'),
            vpBullet(
                'If the text field is 300px tall and each line is 20px, '
                'one page is 15 lines.'),
            vpBullet(
                'Font size changes or dynamic layout changes will alter the '
                'effective page size for subsequent invocations.'),
            vpDivider(),
            vpKeyValue('Formula', 'pageLines = viewport.height / lineHeight'),
            vpKeyValue('Rounded', 'Floor; partial lines are not counted'),
            vpKeyValue('Minimum', '1 line (always moves at least one line)'),
          ]),

          // ── 3. page-down walkthrough ──
          vpSection('3 · Page-Down Extension Walk-Through', [
            vpBullet(
                'Text field showing 15 lines. Selection collapsed at line 3, '
                'offset 45. User presses Shift+PageDown.'),
            vpBullet(
                'Intent fires with forward=true. The action computes the '
                'target line: line 3 + 15 = line 18.'),
            vpBullet(
                'It finds the nearest character offset on line 18 at the '
                'same column affinity X-position.'),
            vpBullet(
                'Selection becomes TextSelection(baseOffset: 45, '
                'extentOffset: offsetOnLine18). The viewport scrolls to '
                'reveal line 18.'),
            vpDivider(),
            vpCodeBlock(
                '// Shift+PageDown from line 3 (viewport = 15 lines)\n'
                'const intent = ExtendSelectionVerticallyTo\n'
                '    AdjacentPageIntent(forward: true);\n'
                '// Extent jumps from line 3 to line 18\n'
                '// Selection now spans 15 lines of text'),
          ]),

          // ── 4. page-up walkthrough ──
          vpSection('4 · Page-Up Extension Walk-Through', [
            vpBullet(
                'Selection spans from line 3 (base, offset 45) to line 18 '
                '(extent). User presses Shift+PageUp.'),
            vpBullet(
                'Intent fires with forward=false. Target line: 18 - 15 = 3.'),
            vpBullet(
                'Extent moves back to line 3, near the original base position. '
                'If the resolved offset equals the base, the selection collapses.'),
            vpBullet(
                'Pressing Shift+PageUp again from collapsed line 3 would '
                'extend upward. Target: max(line 0, 3 - 15) = line 0.'),
            vpDivider(),
            vpHighlight(
                'Page-up from a position within the first page of text '
                'extends the selection to line 0 (the very beginning) – '
                'the intent never tries to go before the text start.'),
          ]),

          // ── 5. column affinity ──
          vpSection('5 · Column Affinity Across Pages', [
            vpBullet(
                'Column affinity works exactly as with the adjacent-line intent: '
                'the desired X-pixel position is preserved across page jumps.'),
            vpBullet(
                'If the target page has shorter lines, the extent snaps to '
                'the line end. Jumping to the next page with longer lines '
                'restores the original column.'),
            vpBullet(
                'This means Shift+PageDown followed by Shift+PageUp may not '
                'return to the exact same offset if the line lengths differ, '
                'but the column pixel position is preserved.'),
            vpDivider(),
            vpKeyValue('Preserved', 'Column affinity X (pixel value)'),
            vpKeyValue('Not preserved', 'Character offset (depends on line length)'),
          ]),

          // ── 6. scroll viewport behavior ──
          vpSection('6 · Scroll Viewport Behavior', [
            vpBullet(
                'After the page-level extension, the viewport scrolls to keep '
                'the new extent position visible.'),
            vpBullet(
                'The scroll amount typically equals one viewport height, '
                'matching the page displacement of the extent.'),
            vpBullet(
                'If the extent reaches the end or beginning of text, the '
                'scroll stops at the text boundary – no over-scrolling.'),
            vpCodeBlock(
                '// Viewport scrolling behavior:\n'
                '// Before Shift+PageDown: viewport shows lines 1-15\n'
                '// After  Shift+PageDown: viewport shows lines 16-30\n'
                '//   (extent is at line 18, visible in new viewport)'),
            vpDivider(),
            vpBullet(
                'The scroll animation may be immediate or smoothly animated '
                'depending on the platform scroll physics configuration.'),
          ]),

          // ── 7. comparison with related intents ──
          vpSection('7 · Comparison with Related Intents', [
            vpCompare('ExtendSelectionVerticallyToAdjacentLineIntent',
                'Single-line vertical extend (Shift+Arrow); this is page-level'),
            vpCompare('MoveSelectionVerticallyToAdjacentPageIntent',
                'Same page jump but collapses selection (PageUp/PageDown without Shift)'),
            vpCompare('ScrollToDocumentBoundaryIntent',
                'Scrolls to top/bottom without changing selection'),
            vpCompare('ExtendSelectionToDocumentBoundaryIntent',
                'Extends to the very start/end of text, not by page'),
            vpCompare('ExtendSelectionToLineBreakIntent',
                'Horizontal line-end extend, not vertical'),
            vpDivider(),
            vpBullet(
                'The page intent fills the gap between single-line '
                'precision and whole-document leaps.'),
          ]),

          // ── 8. keyboard shortcuts ──
          vpSection('8 · Keyboard Shortcut Mapping', [
            vpKeyValue('Windows / Linux',
                'Shift+PageDown / Shift+PageUp'),
            vpKeyValue('macOS',
                'Fn+Shift+ArrowDown / Fn+Shift+ArrowUp (virtual PageDown/Up)'),
            vpKeyValue('Web',
                'Shift+PageDown/Up (Flutter overrides browser default)'),
            vpDivider(),
            vpBullet(
                'macOS keyboards without dedicated Page keys simulate them '
                'with Fn+Arrow; the intent mapping handles this transparently.'),
            vpCodeBlock(
                '// Shortcut registration (simplified)\n'
                'SingleActivator(\n'
                '  LogicalKeyboardKey.pageDown,\n'
                '  shift: true,\n'
                '): const ExtendSelectionVerticallyTo\n'
                '    AdjacentPageIntent(forward: true),\n'
                'SingleActivator(\n'
                '  LogicalKeyboardKey.pageUp,\n'
                '  shift: true,\n'
                '): const ExtendSelectionVerticallyTo\n'
                '    AdjacentPageIntent(forward: false),'),
          ]),

          // ── 9. dispatch pipeline ──
          vpSection('9 · Action Dispatch Pipeline', [
            vpBullet(
                'EditableText registers an action for this intent. The action '
                'looks up the viewport height via the scroll controller.'),
            vpBullet(
                'It calculates the page line count: viewportHeight / lineHeight, '
                'then delegates to the same offset-finding logic as the '
                'adjacent-line intent, repeated for the page count.'),
            vpBullet(
                'The final offset replaces only the extent in the TextSelection.'),
            vpDivider(),
            vpCodeBlock(
                '// Pseudo-code for page-extend action\n'
                'void invoke(ExtendSelectionVerticallyTo\n'
                '    AdjacentPageIntent intent) {\n'
                '  final int pageLines =\n'
                '      (viewport.height / lineHeight).floor();\n'
                '  final currentPos = textPainter.getOffsetForCaret(\n'
                '    TextPosition(offset: selection.extentOffset),\n'
                '    Rect.zero,\n'
                '  );\n'
                '  final double deltaY = intent.forward\n'
                '      ? pageLines * lineHeight\n'
                '      : -pageLines * lineHeight;\n'
                '  final newOffset = textPainter.getPositionForOffset(\n'
                '    Offset(columnAffinity ?? currentPos.dx,\n'
                '        currentPos.dy + deltaY),\n'
                '  ).offset;\n'
                '  updateSelection(TextSelection(\n'
                '    baseOffset: selection.baseOffset,\n'
                '    extentOffset: newOffset,\n'
                '  ));\n'
                '}'),
          ]),

          // ── 10. single-line fields ──
          vpSection('10 · Single-Line vs Multi-Line Fields', [
            vpBullet(
                'In single-line TextFields, this intent has no visible effect '
                'because the entire text fits on one visual line.'),
            vpBullet(
                'For multi-line fields (maxLines > 1 or null), the intent '
                'performs the expected page-level selection extension.'),
            vpBullet(
                'In code editors built with EditableText, this intent is '
                'essential for quickly selecting large blocks of code.'),
            vpDivider(),
            vpCodeBlock(
                '// Multi-line field for page selection\n'
                'TextField(\n'
                '  maxLines: null,\n'
                '  minLines: 20,\n'
                '  controller: TextEditingController(\n'
                '    text: List.generate(100,\n'
                '        (i) => \'Line \${i + 1}: content here\').join(\'\\n\'),\n'
                '  ),\n'
                ')'),
          ]),

          // ── 11. RTL text ──
          vpSection('11 · RTL & Bidirectional Text', [
            vpBullet(
                'Page movement is purely vertical; the forward property '
                'means down/up and is unaffected by text direction.'),
            vpBullet(
                'Column affinity is pixel-based, so RTL text naturally '
                'preserves the correct caret X from the right side.'),
            vpBullet(
                'Mixed-direction text within a page follows the same rules: '
                'the X position at the target line is matched to the nearest '
                'character offset.'),
          ]),

          // ── 12. custom actions ──
          vpSection('12 · Custom Action Overrides', [
            vpBullet(
                'Override this intent to customize page size, implement half-page '
                'scrolling, or add momentum-based page extend logic.'),
            vpCodeBlock(
                'Actions(\n'
                '  actions: <Type, Action<Intent>>{\n'
                '    ExtendSelectionVerticallyToAdjacentPageIntent:\n'
                '      CallbackAction<ExtendSelectionVerticallyTo\n'
                '          AdjacentPageIntent>(\n'
                '        onInvoke: (intent) {\n'
                '          print(\'Page extend: \'\n'
                '              \'forward=\${intent.forward}\');\n'
                '          // Custom: half-page extend\n'
                '          return null;\n'
                '        },\n'
                '      ),\n'
                '  },\n'
                '  child: child,\n'
                ')'),
            vpDivider(),
            vpBullet(
                'A common customization is half-page scrolling: override the '
                'action to compute pageLines / 2 instead of the full viewport.'),
          ]),

          // ── 13. edge cases ──
          vpSection('13 · Edge Cases & Boundary Conditions', [
            vpBullet(
                'At the very start of text, Shift+PageUp is a no-op – '
                'the extent cannot move above offset 0.'),
            vpBullet(
                'At the very end of text, Shift+PageDown is a no-op – '
                'the extent cannot move past the last character.'),
            vpBullet(
                'Text shorter than one page: Shift+PageDown extends to the '
                'very end; Shift+PageUp extends to the very start.'),
            vpBullet(
                'Viewport resizing (e.g., keyboard appearing on mobile) '
                'changes the effective page size for subsequent invocations.'),
            vpBullet(
                'Empty text: both directions are no-ops since there is '
                'nowhere to extend.'),
            vpDivider(),
            vpBullet(
                'Dynamic text insertion while extending: if text is being '
                'live-typed by another source, the page size and line mapping '
                'update on every invocation.'),
          ]),

          // ── 14. testing strategies ──
          vpSection('14 · Testing Strategies', [
            vpBullet(
                'Use a SizedBox to constrain the text field height, ensuring '
                'a known viewport size for predictable page calculations.'),
            vpBullet(
                'Verify that the extent offset jumps by approximately one '
                'page worth of characters after Shift+PageDown.'),
            vpCodeBlock(
                'testWidgets(\'page extend selects one viewport\',\n'
                '    (WidgetTester tester) async {\n'
                '  final text = List.generate(\n'
                '      50, (i) => \'Line \${i + 1}\').join(\'\\n\');\n'
                '  final controller = TextEditingController(text: text);\n'
                '  await tester.pumpWidget(MaterialApp(\n'
                '    home: Scaffold(\n'
                '      body: SizedBox(\n'
                '        height: 200,\n'
                '        child: TextField(\n'
                '          maxLines: null,\n'
                '          controller: controller,\n'
                '        ),\n'
                '      ),\n'
                '    ),\n'
                '  ));\n'
                '  // tap, then Shift+PageDown, verify extent offset\n'
                '});'),
            vpDivider(),
            vpBullet(
                'Integration tests can capture scroll offset changes alongside '
                'selection changes to verify viewport-following behavior.'),
          ]),

          // ── 15. performance ──
          vpSection('15 · Performance Considerations', [
            vpBullet(
                'Page-level offset resolution is a single O(log n) lookup '
                'via TextPainter.getPositionForOffset, same as line-level.'),
            vpBullet(
                'The larger selection area means a bigger highlight to paint, '
                'but the selection path is a single rectangular fill – efficient.'),
            vpBullet(
                'Scrolling one full page triggers a repaint of the entire '
                'viewport, which is already budgeted in the frame.'),
          ]),

          // ── 16. accessibility ──
          vpSection('16 · Accessibility', [
            vpBullet(
                'Screen readers announce the newly selected range; for page '
                'jumps this may be a substantial amount of text.'),
            vpBullet(
                'VoiceOver and TalkBack typically read a summary of the '
                'selection ("X characters selected") rather than the full text.'),
            vpBullet(
                'Semantic node updates correctly reflect the new selection '
                'boundaries after each page extend.'),
          ]),

          // ── 17. API summary ──
          vpSection('17 · Quick API Reference', [
            vpKeyValue('Constructor',
                'const ExtendSelectionVerticallyToAdjacentPageIntent'
                '({required bool forward})'),
            vpKeyValue('Property', 'forward: bool (true = page down, false = page up)'),
            vpKeyValue('Super', 'DirectionalCaretMovementIntent'),
            vpKeyValue('Root', 'Intent'),
            vpDivider(),
            vpCodeBlock(
                '// Extend selection down by one page\n'
                'const pgDown = ExtendSelectionVerticallyTo\n'
                '    AdjacentPageIntent(forward: true);\n'
                '\n'
                '// Extend selection up by one page\n'
                'const pgUp = ExtendSelectionVerticallyTo\n'
                '    AdjacentPageIntent(forward: false);'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: vpIndigoNight.withValues(alpha: 0.06),
            child: const Text(
              'ExtendSelectionVerticallyToAdjacentPageIntent · '
              'Indigo Night Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: vpMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
