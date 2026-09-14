// ignore_for_file: avoid_print
// Deep demo: VerticalCaretMovementRun
// Demonstrates the VerticalCaretMovementRun iterator — tracks vertical
// caret movement (up/down arrow keys) through editable text while
// preserving the initial horizontal caret position.
import 'package:flutter/material.dart';

// ─── palette: Vermilion / Warm Ivory ──────────────────────────────
const Color _vcVermilion = Color(0xFFBF360C);
const Color _vcIvory = Color(0xFFFBE9E7);
const Color _vcAccent = Color(0xFFE64A19);
const Color _vcDark = Color(0xFF1A1A1A);
const Color _vcBlue = Color(0xFF1565C0);
const Color _vcGreen = Color(0xFF2E7D32);
const Color _vcPurple = Color(0xFF6A1B9A);
const Color _vcTeal = Color(0xFF00695C);
const Color _vcRed = Color(0xFFC62828);
const Color _vcGrey = Color(0xFF546E7A);

// ─── text helpers ─────────────────────────────────────────────────
Widget _vcTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _vcVermilion,
              letterSpacing: 0.3)),
    );

Widget _vcSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _vcAccent)),
    );

Widget _vcBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _vcCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vcDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFFFCCBC),
              height: 1.5)),
    );

Widget _vcNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _vcIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _vcVermilion.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _vcVermilion),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _vcVermilion, height: 1.4)),
          ),
        ],
      ),
    );

Widget _vcDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child:
          Container(height: 1, color: _vcVermilion.withValues(alpha: 0.1)),
    );

Widget _vcTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _vcLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _vcVermilion,
        letterSpacing: 0.2));

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _vcBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_vcVermilion, Color(0xFFE64A19)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.text_fields, size: 48, color: _vcIvory),
          const SizedBox(height: 10),
          const Text('VerticalCaretMovementRun',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text(
              'Iterator for moving the caret up/down while preserving '
              'horizontal position',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _vcTag('rendering', _vcAccent),
              _vcTag('text editing', _vcBlue),
              _vcTag('caret', _vcPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _vcWhatIs() => [
      _vcTitle('§2  What Is VerticalCaretMovementRun?'),
      _vcBody(
          'VerticalCaretMovementRun is an iterator that manages '
          'vertical caret (cursor) movement through editable text. '
          'When you press the up or down arrow key in a text field, '
          'this class tracks the movement and preserves the ideal '
          'horizontal position across line changes.'),
      _vcCode(
          'class VerticalCaretMovementRun implements Iterator<TextPosition> {\n'
          '  // Created by RenderEditable.startVerticalCaretMovement()\n'
          '  // Implements Iterator<TextPosition>\n'
          '  // moveNext() -> moves caret down one line\n'
          '  // movePrevious() -> moves caret up one line\n'
          '  TextPosition get current;\n'
          '  bool get isValid;\n'
          '}'),
      _vcBody(
          'This class is created by RenderEditable and returned when '
          'vertical caret movement begins. It remembers the starting '
          'horizontal pixel position and finds the closest character '
          'position on each subsequent line.'),
    ];

// ─── §3 The "sticky X" problem ───────────────────────────────────
List<Widget> _vcStickyX() => [
      _vcDivider(),
      _vcTitle('§3  The "Sticky X" Problem'),
      _vcBody(
          'Without sticky horizontal tracking, moving up/down through '
          'lines of different lengths would cause the caret to drift '
          'leftward. Consider this example:'),
      _vcSubtitle('Without sticky X (naive approach)'),
      _vcTextBlock([
        _VcLine(
            'This is a long line of text with many characters.',
            40, _vcGrey),
        _VcLine('Short.', 5, _vcRed),
        _VcLine(
            'Another fairly long line of text here.',
            35, _vcGrey),
      ], 'Caret drifts to position 5 on the long line'),
      _vcSubtitle('With sticky X (VerticalCaretMovementRun)'),
      _vcTextBlock([
        _VcLine(
            'This is a long line of text with many characters.',
            40, _vcGrey),
        _VcLine('Short.', 5, _vcGreen),
        _VcLine(
            'Another fairly long line of text here.',
            35, _vcGrey),
      ], 'Caret returns to position ~40 on the long line'),
      _vcNote(
          'The iterator remembers the original horizontal pixel offset. '
          'When the caret moves to a shorter line, it parks at the end. '
          'When it moves back to a longer line, it returns to the '
          'remembered position — the "sticky X" behavior users expect.'),
    ];

class _VcLine {
  final String text;
  final int caretPos;
  final Color highlight;
  const _VcLine(this.text, this.caretPos, this.highlight);
}

Widget _vcTextBlock(List<_VcLine> lines, String caption) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _vcVermilion.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...lines.map((line) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: Colors.black87),
                        children: [
                          if (line.caretPos <= line.text.length) ...[
                            TextSpan(
                                text: line.text.substring(
                                    0,
                                    line.caretPos.clamp(
                                        0, line.text.length))),
                            TextSpan(
                              text: '|',
                              style: TextStyle(
                                  color: line.highlight,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14),
                            ),
                            if (line.caretPos < line.text.length)
                              TextSpan(
                                  text: line.text
                                      .substring(line.caretPos)),
                          ] else
                            TextSpan(text: line.text),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: line.highlight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text('pos=${line.caretPos}',
                        style: TextStyle(
                            fontSize: 8.5,
                            color: line.highlight,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 6),
        Text(caption,
            style: const TextStyle(
                fontSize: 10.5,
                fontStyle: FontStyle.italic,
                color: Colors.black45)),
      ],
    ),
  );
}

// ─── §4 How it works ─────────────────────────────────────────────
List<Widget> _vcHowItWorks() => [
      _vcDivider(),
      _vcTitle('§4  How It Works'),
      _vcBody(
          'The iterator is created when vertical movement begins and '
          'maintains state across multiple up/down key presses:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vcIvory,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _vcLabel('Movement lifecycle'),
            const SizedBox(height: 10),
            _vcStep('1', 'User presses Down arrow',
                'RenderEditable.startVerticalCaretMovement() called',
                _vcVermilion),
            _vcStep('2', 'Iterator created',
                'Records current caret pixel X position', _vcBlue),
            _vcStep('3', 'moveNext() called',
                'Finds closest position on next line at saved X',
                _vcGreen),
            _vcStep('4', 'User presses Down again',
                'moveNext() finds position on next line at same X',
                _vcPurple),
            _vcStep('5', 'User presses Up',
                'movePrevious() goes back, still using saved X',
                _vcTeal),
            _vcStep('6', 'Horizontal key or click',
                'Run is invalidated — new run on next vertical move',
                _vcGrey),
          ],
        ),
      ),
      _vcCode(
          '// Usage inside EditableTextState\n'
          'VerticalCaretMovementRun? _caretRun;\n'
          '\n'
          'void _handleDownArrow() {\n'
          '  _caretRun ??= renderEditable\n'
          '      .startVerticalCaretMovement(\n'
          '        renderEditable.selection!.extent,\n'
          '      );\n'
          '  if (_caretRun!.moveNext()) {\n'
          '    _updateSelection(_caretRun!.current);\n'
          '  }\n'
          '}\n'
          '\n'
          'void _handleUpArrow() {\n'
          '  if (_caretRun?.movePrevious() ?? false) {\n'
          '    _updateSelection(_caretRun!.current);\n'
          '  }\n'
          '}'),
    ];

Widget _vcStep(String num, String action, String detail, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(num,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(action,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: c)),
                Text(detail,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §5 API surface ──────────────────────────────────────────────
List<Widget> _vcApi() => [
      _vcDivider(),
      _vcTitle('§5  API Surface'),
      _vcBody(
          'VerticalCaretMovementRun has a compact API focused on '
          'iteration:'),
      _vcMethodCard('current', 'TextPosition',
          'The current caret position in the text', _vcVermilion),
      _vcMethodCard('isValid', 'bool',
          'Whether the run is still valid (not invalidated)', _vcBlue),
      _vcMethodCard('moveNext()', 'bool',
          'Move caret down one line; returns false at last line',
          _vcGreen),
      _vcMethodCard('movePrevious()', 'bool',
          'Move caret up one line; returns false at first line',
          _vcPurple),
      _vcNote(
          'VerticalCaretMovementRun implements Iterator<TextPosition>, '
          'so moveNext() follows the standard Dart iterator contract. '
          'movePrevious() is an extension beyond the Iterator interface — '
          'it enables bidirectional traversal.'),
    ];

Widget _vcMethodCard(String name, String ret, String desc, Color c) =>
    Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: c,
                            fontFamily: 'monospace')),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: c.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(ret,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: c,
                              fontFamily: 'monospace')),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §6 Caret position mapping ───────────────────────────────────
List<Widget> _vcMapping() => [
      _vcDivider(),
      _vcTitle('§6  Caret Position Mapping'),
      _vcBody(
          'The iterator maps a horizontal pixel offset to a character '
          'position on each line. Different lines may have different '
          'character widths (especially with proportional fonts), so '
          'the same X offset can map to different character indices:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vcIvory,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _vcLabel('Pixel X = 120 maps to different positions'),
            const SizedBox(height: 10),
            _vcMapRow('Line 1: "Hello World"', 7, 'After "Hello W"',
                _vcVermilion),
            _vcMapRow('Line 2: "MMMM"', 3, 'After "MMM" (wide chars)',
                _vcBlue),
            _vcMapRow('Line 3: "iiiiiiiiiiii"', 10, 'After 10 "i" (narrow)',
                _vcGreen),
          ],
        ),
      ),
      _vcBody(
          'The iterator uses getPositionForOffset to find the closest '
          'character boundary to the saved horizontal position. This '
          'produces the most visually intuitive result even with '
          'variable-width characters.'),
    ];

Widget _vcMapRow(String line, int pos, String reason, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5, right: 8),
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(line,
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: c,
                        fontFamily: 'monospace')),
                Text('-> pos $pos: $reason',
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §7 Edge cases ───────────────────────────────────────────────
List<Widget> _vcEdgeCases() => [
      _vcDivider(),
      _vcTitle('§7  Edge Cases'),
      _vcSubtitle('Empty lines'),
      _vcBody(
          'When the caret moves to an empty line, it parks at position 0. '
          'The saved X is unchanged, so moving to the next non-empty line '
          'will snap back to the correct column.'),
      _vcTextBlock([
        _VcLine('void main() {', 10, _vcGrey),
        _VcLine('', 0, _vcAccent),
        _VcLine('  print("hello");', 10, _vcGrey),
      ], 'Empty line: caret at 0, but sticky X remembered'),
      _vcSubtitle('Line shorter than saved X'),
      _vcBody(
          'If the target line is shorter than the saved X position, '
          'the caret moves to the end of that line. This is the classic '
          '"short line" case:'),
      _vcTextBlock([
        _VcLine('A long line with many words.', 24, _vcGrey),
        _VcLine('Short.', 6, _vcAccent),
        _VcLine('Back to another long line.', 24, _vcGrey),
      ], 'Short line clamps caret, long line restores it'),
      _vcSubtitle('Bidirectional text'),
      _vcBody(
          'For right-to-left text, the iterator still uses pixel X, '
          'which correctly handles mixed directionality. The horizontal '
          'coordinate system is always left-edge relative.'),
    ];

// ─── §8 Invalidation ────────────────────────────────────────────
List<Widget> _vcInvalidation() => [
      _vcDivider(),
      _vcTitle('§8  Run Invalidation'),
      _vcBody(
          'A VerticalCaretMovementRun becomes invalid when the user '
          'performs a non-vertical action. The isValid property reflects '
          'this:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vcIvory,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _vcLabel('Actions that invalidate the run'),
            const SizedBox(height: 10),
            _vcInvRow('Left/Right arrow', Icons.arrow_back,
                'Horizontal movement resets X'),
            _vcInvRow('Mouse click', Icons.mouse,
                'New selection position'),
            _vcInvRow('Text insertion', Icons.edit,
                'Content change may reflow lines'),
            _vcInvRow('Text deletion', Icons.backspace,
                'Content change may reflow lines'),
            _vcInvRow('Selection change', Icons.select_all,
                'Programmatic selection update'),
          ],
        ),
      ),
      _vcCode(
          '// When the run is invalidated:\n'
          'if (!_caretRun.isValid) {\n'
          '  _caretRun = null;  // discard\n'
          '  // Next vertical key will create a new run\n'
          '}'),
      _vcNote(
          'Invalidation ensures the saved X position stays accurate. '
          'After any horizontal repositioning, the next vertical move '
          'starts fresh from the new caret location.'),
    ];

Widget _vcInvRow(String action, IconData icon, String reason) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 16, color: _vcAccent),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: Text(action,
                style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          ),
          Expanded(
            child: Text(reason,
                style: const TextStyle(
                    fontSize: 10.5, color: Colors.black54)),
          ),
        ],
      ),
    );

// ─── §9 Relationship to RenderEditable ───────────────────────────
List<Widget> _vcRenderEditable() => [
      _vcDivider(),
      _vcTitle('§9  Relationship to RenderEditable'),
      _vcBody(
          'VerticalCaretMovementRun is tightly coupled to RenderEditable. '
          'It is created by and operates on the text layout within '
          'RenderEditable:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vcIvory,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _vcLabel('Creation and ownership'),
            const SizedBox(height: 10),
            _vcRelBox('RenderEditable',
                'Creates the run via startVerticalCaretMovement()',
                _vcVermilion),
            const SizedBox(height: 4),
            const Center(
                child: Icon(Icons.arrow_downward,
                    size: 16, color: Colors.black38)),
            const SizedBox(height: 4),
            _vcRelBox('VerticalCaretMovementRun',
                'Holds reference to RenderEditable for layout queries',
                _vcBlue),
            const SizedBox(height: 4),
            const Center(
                child: Icon(Icons.arrow_downward,
                    size: 16, color: Colors.black38)),
            const SizedBox(height: 4),
            _vcRelBox('TextPainter / TextLayout',
                'Provides getPositionForOffset() and line metrics',
                _vcGreen),
          ],
        ),
      ),
      _vcCode(
          '// The run holds a reference to the RenderEditable\n'
          '// and uses its text layout for position calculations.\n'
          '// This means the run becomes invalid if the text layout\n'
          '// changes (reflow, content edit, etc.).'),
    ];

Widget _vcRelBox(String name, String desc, Color c) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: c,
                  fontFamily: 'monospace')),
          Text(desc,
              style: const TextStyle(
                  fontSize: 10.5, color: Colors.black54)),
        ],
      ),
    );

// ─── §10 Visual walkthrough ──────────────────────────────────────
List<Widget> _vcWalkthrough() => [
      _vcDivider(),
      _vcTitle('§10  Visual Walkthrough'),
      _vcBody(
          'Step-by-step visualization of pressing Down arrow three '
          'times starting from position 15 on line 1:'),
      _vcWalkStep('Initial', 'Line 1', 15,
          'Caret at position 15 — saved X = 90px', _vcVermilion),
      _vcWalkStep('After Down #1', 'Line 2', 12,
          'Shorter line — closest pos to X=90 is 12', _vcBlue),
      _vcWalkStep('After Down #2', 'Line 3', 15,
          'Back to full length — X=90 maps to pos 15', _vcGreen),
      _vcWalkStep('After Down #3', 'Line 4', 8,
          'Line 4 is short — caret at end (pos 8)', _vcPurple),
      _vcCode(
          '// Line data for this walkthrough:\n'
          '// Line 1: "The quick brown fox jumps."  (26 chars)\n'
          '// Line 2: "Short line."                 (11 chars)\n'
          '// Line 3: "Another standard length line" (27 chars)\n'
          '// Line 4: "Tiny one"                    (8 chars)'),
    ];

Widget _vcWalkStep(
    String title, String line, int pos, String desc, Color c) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: c)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('$line : pos $pos',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: c,
                            fontFamily: 'monospace')),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _vcSummary() => [
      _vcDivider(),
      _vcTitle('§11  Summary'),
      _vcBody(
          'VerticalCaretMovementRun provides the essential "sticky X" '
          'behavior that makes vertical arrow-key navigation intuitive.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _vcVermilion.withValues(alpha: 0.07),
              _vcIvory,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _vcVermilion.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _vcVermilion)),
            const SizedBox(height: 10),
            _vcSumPt('Sticky X',
                'Remembers horizontal pixel position across moves'),
            _vcSumPt('moveNext / movePrevious',
                'Bidirectional line-by-line traversal'),
            _vcSumPt('Created by RenderEditable',
                'startVerticalCaretMovement() factory'),
            _vcSumPt('Pixel-based mapping',
                'Uses getPositionForOffset for accurate placement'),
            _vcSumPt('Auto-invalidation',
                'Discarded on horizontal movement or editing'),
            _vcSumPt('Edge case handling',
                'Clamps to line end on short lines, restores on long'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _vcVermilion,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of VerticalCaretMovementRun Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _vcSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _vcAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _vcVermilion)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _vcBanner(),
        const SizedBox(height: 20),
        ..._vcWhatIs(),
        ..._vcStickyX(),
        ..._vcHowItWorks(),
        ..._vcApi(),
        ..._vcMapping(),
        ..._vcEdgeCases(),
        ..._vcInvalidation(),
        ..._vcRenderEditable(),
        ..._vcWalkthrough(),
        ..._vcSummary(),
      ],
    ),
  );
}
