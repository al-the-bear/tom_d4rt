// ignore_for_file: avoid_print
// D4rt deep demo: DeltaTextInputClient — receiving granular text editing
// deltas (insertions, deletions, replacements) instead of full-state updates.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Copper / Bronze palette ───
  const Color copper = Color(0xFFB87333);
  const Color bronze = Color(0xFFCD7F32);
  const Color deepCopper = Color(0xFF8B5A2B);
  const Color paleCopper = Color(0xFFFFF8F0);
  const Color darkCopper = Color(0xFF5C3317);
  const Color burnished = Color(0xFFA0522D);
  const Color patina = Color(0xFF7B917B);
  const Color rust = Color(0xFFB7410E);
  const Color antiqueBrass = Color(0xFFCD9575);
  const Color champagne = Color(0xFFF7E7CE);

  print('[dt] ===== DELTA TEXT INPUT CLIENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget dtBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkCopper, deepCopper],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkCopper.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: copper,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: bronze, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget dtNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleCopper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: champagne),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkCopper.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget dtCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: champagne.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: copper, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkCopper,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: deepCopper)),
          ),
        ],
      ),
    );
  }

  Widget dtCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: champagne.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: darkCopper.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: copper.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkCopper)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget dtRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? copper.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: champagne.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkCopper : deepCopper)),
          );
        }).toList(),
      ),
    );
  }

  Widget dtFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkCopper : deepCopper,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.east, size: 12, color: bronze),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is DeltaTextInputClient? ━━━━━━
  print('[dt-01] Section 1: What is DeltaTextInputClient?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('01', 'What Is DeltaTextInputClient?'),
      dtNote(
        'DeltaTextInputClient is a mixin on TextInputClient that receives '
        'granular text editing deltas instead of full-state replacements. '
        'When the user types "abc", instead of receiving the entire text '
        '"Hello abc world", you receive just the insertion delta: '
        '"abc" was inserted at position 6. This enables rich text editors, '
        'collaborative editing, and efficient undo/redo.',
      ),
      dtCard(
        'Delta vs Full-State Model',
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paleCopper,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: antiqueBrass),
                ),
                child: Column(
                  children: [
                    Icon(Icons.swap_horiz, size: 22, color: deepCopper),
                    const SizedBox(height: 4),
                    Text('TextInputClient',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: deepCopper)),
                    const SizedBox(height: 6),
                    _dtDiffLine('Full state each time', rust),
                    _dtDiffLine('No change info', rust),
                    _dtDiffLine('Must diff yourself', rust),
                    _dtDiffLine('Simple but limited', patina),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: champagne.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: copper),
                ),
                child: Column(
                  children: [
                    Icon(Icons.difference, size: 22, color: copper),
                    const SizedBox(height: 4),
                    Text('DeltaTextInputClient',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: copper)),
                    const SizedBox(height: 6),
                    _dtDiffLine('Only changes sent', const Color(0xFF2E7D32)),
                    _dtDiffLine('Insert/delete/replace', const Color(0xFF2E7D32)),
                    _dtDiffLine('Exact change location', const Color(0xFF2E7D32)),
                    _dtDiffLine('Rich editing support', const Color(0xFF2E7D32)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: TextEditingDelta types ━━━━━━
  print('[dt-02] Section 2: TextEditingDelta types');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('02', 'TextEditingDelta Types'),
      dtNote(
        'There are four concrete delta types, each representing a different '
        'kind of text change. The system sends the most specific type so '
        'consumers can handle each change appropriately.',
      ),
      dtCard(
        'Delta Class Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dtTypeBox('TextEditingDelta', 'Abstract base',
                'Base class for all deltas', copper),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  _dtTypeBox('TextEditingDeltaInsertion', 'Typing',
                      'New text inserted at cursor position', bronze),
                  const SizedBox(height: 4),
                  _dtTypeBox('TextEditingDeltaDeletion', 'Backspace/Delete',
                      'Text removed from a range', rust),
                  const SizedBox(height: 4),
                  _dtTypeBox('TextEditingDeltaReplacement', 'Selection replace',
                      'Selected text replaced with new text', burnished),
                  const SizedBox(height: 4),
                  _dtTypeBox('TextEditingDeltaNonTextUpdate', 'Cursor move',
                      'Selection/composing changed, no text change', patina),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Insertion delta ━━━━━━
  print('[dt-03] Section 3: Insertion delta');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('03', 'TextEditingDeltaInsertion'),
      dtNote(
        'An insertion delta fires when new text is added at the cursor position. '
        'It contains the text that was inserted and the insertion offset. '
        'This is the most common delta — every keystroke produces one.',
      ),
      dtCard(
        'Insertion Visualization',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleCopper,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Before:', style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: darkCopper)),
              const SizedBox(height: 4),
              _dtTextDisplay('Hello| world', 5, copper),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.keyboard, size: 16, color: bronze),
                  const SizedBox(width: 6),
                  Text('User types: ", beautiful"',
                      style: TextStyle(
                          fontSize: 11, color: copper, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 10),
              Text('After:', style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: darkCopper)),
              const SizedBox(height: 4),
              _dtTextDisplay('Hello, beautiful| world', 16, copper),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: champagne.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: copper.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delta received:',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: darkCopper)),
                    Text('  type: TextEditingDeltaInsertion',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: deepCopper)),
                    Text('  insertionOffset: 5',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: deepCopper)),
                    Text('  textInserted: ", beautiful"',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: copper)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Deletion delta ━━━━━━
  print('[dt-04] Section 4: Deletion delta');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('04', 'TextEditingDeltaDeletion'),
      dtNote(
        'A deletion delta fires when text is removed — backspace, delete key, '
        'or cutting selected text. It contains the range that was deleted '
        'and the text that was removed.',
      ),
      dtCard(
        'Deletion Visualization',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleCopper,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Before: (selected "beautiful ")',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: darkCopper)),
              const SizedBox(height: 4),
              _dtTextWithSelection('Hello, beautiful world', 7, 17, rust),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.backspace, size: 16, color: rust),
                  const SizedBox(width: 6),
                  Text('User presses Delete/Backspace',
                      style: TextStyle(
                          fontSize: 11, color: rust, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 10),
              Text('After:', style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: darkCopper)),
              const SizedBox(height: 4),
              _dtTextDisplay('Hello, |world', 7, copper),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F0),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: rust.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delta received:',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: darkCopper)),
                    Text('  type: TextEditingDeltaDeletion',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: deepCopper)),
                    Text('  deletedRange: TextRange(start: 7, end: 17)',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: rust)),
                    Text('  textDeleted: "beautiful "',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: rust)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Replacement delta ━━━━━━
  print('[dt-05] Section 5: Replacement delta');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('05', 'TextEditingDeltaReplacement'),
      dtNote(
        'A replacement delta fires when selected text is replaced with new text '
        '— typing over a selection, autocomplete, or find-and-replace. '
        'It contains both the replaced range and the new text.',
      ),
      dtCard(
        'Replacement: Autocomplete',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleCopper,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Before: (IME suggests "flutter")',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: darkCopper)),
              const SizedBox(height: 4),
              _dtTextWithSelection('flut', 0, 4, burnished),
              const SizedBox(height: 6),
              Container(
                width: 120,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [BoxShadow(
                      color: darkCopper.withValues(alpha: 0.1),
                      blurRadius: 4)],
                ),
                child: Text('flutter',
                    style: TextStyle(
                        fontSize: 12, color: copper, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),
              Text('After:', style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: darkCopper)),
              const SizedBox(height: 4),
              _dtTextDisplay('flutter|', 7, copper),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: champagne.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: burnished.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delta received:',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: darkCopper)),
                    Text('  type: TextEditingDeltaReplacement',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: deepCopper)),
                    Text('  replacedRange: TextRange(start: 0, end: 4)',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: burnished)),
                    Text('  replacementText: "flutter"',
                        style: TextStyle(
                            fontSize: 10, fontFamily: 'monospace', color: copper)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Non-text update ━━━━━━
  print('[dt-06] Section 6: Non-text update');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('06', 'TextEditingDeltaNonTextUpdate'),
      dtNote(
        'A non-text update delta fires when the cursor position or composing '
        'region changes without any text modification. Arrow keys, tapping a '
        'different position, or IME composing region shifts produce these.',
      ),
      dtCard(
        'Non-Text Delta Examples',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dtNonTextItem('Arrow right', 'Cursor 5 → 6', Icons.arrow_forward, copper),
            _dtNonTextItem('Home key', 'Cursor 15 → 0', Icons.first_page, bronze),
            _dtNonTextItem('Shift+Arrow', 'Selection extends', Icons.text_fields, burnished),
            _dtNonTextItem('IME composing', 'Composing region shifts', Icons.language, patina),
            _dtNonTextItem('Tap to position', 'Cursor jumps to tap', Icons.touch_app, deepCopper),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Delta fields anatomy ━━━━━━
  print('[dt-07] Section 7: Delta fields');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('07', 'Anatomy of a Delta'),
      dtNote(
        'Every TextEditingDelta carries base fields from the abstract class: '
        'oldText (text before change), selection (new cursor/selection), and '
        'composing (new IME composing region). Subclasses add specific fields.',
      ),
      dtCard(
        'Field Reference',
        Column(
          children: [
            dtRow(['Field', 'Type', 'Description'], isHeader: true),
            dtRow(['oldText', 'String', 'Text before this delta']),
            dtRow(['selection', 'TextSelection', 'New cursor/selection after delta']),
            dtRow(['composing', 'TextRange', 'New IME composing region']),
            dtRow(['textInserted', 'String', 'Insertion: the new text']),
            dtRow(['insertionOffset', 'int', 'Insertion: where inserted']),
            dtRow(['deletedRange', 'TextRange', 'Deletion: range removed']),
            dtRow(['replacedRange', 'TextRange', 'Replacement: range replaced']),
            dtRow(['replacementText', 'String', 'Replacement: new text']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Rich text editor ━━━━━━
  print('[dt-08] Section 8: Rich text editor use case');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('08', 'Use Case: Rich Text Editor'),
      dtNote(
        'The primary motivation for DeltaTextInputClient is rich text editing. '
        'With full-state updates (TextInputClient), applying bold to one word '
        'would require reconstructing the entire attributed string. With deltas, '
        'you know exactly which characters changed and can update only the '
        'affected spans.',
      ),
      dtCard(
        'Rich Text Delta Handling',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: paleCopper,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: champagne),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13, color: darkCopper),
                  children: [
                    const TextSpan(text: 'Hello '),
                    TextSpan(
                      text: 'bold',
                      style: TextStyle(fontWeight: FontWeight.bold, color: copper),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'italic',
                      style: TextStyle(fontStyle: FontStyle.italic, color: burnished),
                    ),
                    const TextSpan(text: ' text with '),
                    TextSpan(
                      text: 'mixed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: rust,
                      ),
                    ),
                    const TextSpan(text: ' styles'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            dtFlow(['Delta received', 'Find affected span',
                'Apply inline style', 'Re-render span only']),
            const SizedBox(height: 8),
            Text(
              'Delta tells editor: "chars 6-10 were typed" → only update '
              'the bold span, leave italic span untouched.',
              style: TextStyle(fontSize: 11, color: deepCopper),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Collaborative editing ━━━━━━
  print('[dt-09] Section 9: Collaborative editing');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('09', 'Use Case: Collaborative Editing'),
      dtNote(
        'Collaborative editors (like Google Docs) use Operational Transform or '
        'CRDTs. Deltas map naturally to operations: insert(pos, text), '
        'delete(pos, len), replace(pos, len, text). This makes DeltaTextInputClient '
        'ideal for real-time collaboration.',
      ),
      dtCard(
        'Delta → OT Operation',
        Column(
          children: [
            dtRow(['Delta Type', 'OT Operation', 'Wire Format'], isHeader: true),
            dtRow(['Insertion', 'insert(pos, text)', '{op:"ins", p:5, t:"abc"}']),
            dtRow(['Deletion', 'delete(pos, len)', '{op:"del", p:3, l:4}']),
            dtRow(['Replacement', 'replace(pos, len, text)', '{op:"rep", p:0, l:3, t:"xyz"}']),
            dtRow(['NonText', '(no-op / cursor sync)', '{op:"sel", p:7}']),
          ],
        ),
      ),
      dtCard(
        'Two Users Editing',
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: paleCopper,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _dtUserBadge('Alice', copper),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('types "Hello" at position 0',
                        style: TextStyle(fontSize: 10, color: deepCopper)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _dtUserBadge('Bob', burnished),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('types "World" at position 0',
                        style: TextStyle(fontSize: 10, color: deepCopper)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('OT transforms Bob\'s insert to position 5 → "HelloWorld"',
                  style: TextStyle(
                      fontSize: 10,
                      color: darkCopper,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Undo/Redo ━━━━━━
  print('[dt-10] Section 10: Undo/Redo');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('10', 'Undo / Redo with Deltas'),
      dtNote(
        'Deltas enable precise undo/redo. Store each delta in a stack; '
        'to undo, apply the inverse delta. Insertion inverts to deletion, '
        'deletion inverts to insertion, replacement inverts by swapping old/new text.',
      ),
      dtCard(
        'Delta Undo Stack',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dtUndoEntry(1, 'Insert "H"', 'Delete at 0, len 1', copper),
            _dtUndoEntry(2, 'Insert "e"', 'Delete at 1, len 1', bronze),
            _dtUndoEntry(3, 'Insert "l"', 'Delete at 2, len 1', burnished),
            _dtUndoEntry(4, 'Insert "l"', 'Delete at 3, len 1', antiqueBrass),
            _dtUndoEntry(5, 'Insert "o"', 'Delete at 4, len 1', deepCopper),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: copper.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: copper),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.undo, size: 14, color: copper),
                      const SizedBox(width: 4),
                      Text('Undo', style: TextStyle(fontSize: 11, color: copper)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: bronze.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: bronze),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.redo, size: 14, color: bronze),
                      const SizedBox(width: 4),
                      Text('Redo', style: TextStyle(fontSize: 11, color: bronze)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: IME composition ━━━━━━
  print('[dt-11] Section 11: IME composition');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('11', 'IME Composition with Deltas'),
      dtNote(
        'Input Method Editors (for CJK, Korean, etc.) produce composing text '
        'that is provisional — underlined in the text field until committed. '
        'Deltas track both the composing region and the final commit, giving '
        'editors visibility into the full IME lifecycle.',
      ),
      dtCard(
        'Japanese IME Example',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dtImeStep(1, 'User types "ni"', 'に (composing)', 'Insertion + composing', copper),
            _dtImeStep(2, 'User types "ho"', 'にほ (composing)', 'Replacement + composing', bronze),
            _dtImeStep(3, 'User types "n"', 'にほん (composing)', 'Replacement + composing', burnished),
            _dtImeStep(4, 'User selects kanji', '日本 (committed)', 'Replacement + clear composing', darkCopper),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: champagne.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Each step is a delta — composing region tracked in '
                'delta.composing, final commit clears it.',
                style: TextStyle(fontSize: 10, color: darkCopper),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Performance ━━━━━━
  print('[dt-12] Section 12: Performance');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('12', 'Performance Benefits'),
      dtNote(
        'For large documents, full-state updates become expensive. A 50,000-word '
        'document sends the entire string on every keystroke with TextInputClient. '
        'DeltaTextInputClient sends only the change — typically a few characters.',
      ),
      dtCard(
        'Data Transfer Comparison',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _dtMetricBox('Full state', '200 KB/keystroke', rust)),
                const SizedBox(width: 6),
                Expanded(child: _dtMetricBox('Delta', '~50 bytes/keystroke', const Color(0xFF2E7D32))),
              ],
            ),
            const SizedBox(height: 8),
            dtRow(['Document Size', 'Full State', 'Delta'], isHeader: true),
            dtRow(['100 words', '~600 B', '~30 B']),
            dtRow(['1,000 words', '~6 KB', '~30 B']),
            dtRow(['10,000 words', '~60 KB', '~30 B']),
            dtRow(['100,000 words', '~600 KB', '~30 B']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: updateEditingValueWithDeltas ━━━━━━
  print('[dt-13] Section 13: The callback method');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('13', 'The updateEditingValueWithDeltas Callback'),
      dtNote(
        'The core method is updateEditingValueWithDeltas(List<TextEditingDelta>). '
        'It receives a batch of deltas that together describe the change from '
        'the previous state. Multiple deltas can arrive per frame when IME '
        'produces compound changes.',
      ),
      dtCard(
        'Method Signature',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dtCode('void updateEditingValueWithDeltas(',
                'Main callback method'),
            dtCode('  List<TextEditingDelta> deltas',
                'Batch of deltas per frame'),
            dtCode(')',
                'Apply each delta sequentially'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: paleCopper,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'If DeltaTextInputClient is mixed in, the framework calls '
                'updateEditingValueWithDeltas instead of updateEditingValue. '
                'You must implement both — the non-delta version is still '
                'called if the platform falls back to full-state.',
                style: TextStyle(fontSize: 10, color: darkCopper),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Migration from TextInputClient ━━━━━━
  print('[dt-14] Section 14: Migration');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('14', 'Migration from TextInputClient'),
      dtNote(
        'Adopting DeltaTextInputClient is incremental. Mix it in alongside '
        'TextInputClient, implement updateEditingValueWithDeltas, and keep '
        'updateEditingValue as a fallback. The framework auto-detects which '
        'interface to use.',
      ),
      dtCard(
        'Migration Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dtCheckItem('Add DeltaTextInputClient mixin', true, copper),
            _dtCheckItem('Implement updateEditingValueWithDeltas', true, bronze),
            _dtCheckItem('Keep updateEditingValue as fallback', true, burnished),
            _dtCheckItem('Handle all 4 delta types', true, deepCopper),
            _dtCheckItem('Update undo/redo to use deltas', false, patina),
            _dtCheckItem('Remove full-state diffing code', false, patina),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing deltas ━━━━━━
  print('[dt-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('15', 'Testing Delta-Based Editors'),
      dtNote(
        'Test delta handling by simulating TextEditingDelta objects directly. '
        'Create delta instances, call your handler, and verify the resulting '
        'document state. No need for platform channel mocking.',
      ),
      dtCard(
        'Test Approaches',
        Column(
          children: [
            dtRow(['Test', 'What', 'How'], isHeader: true),
            dtRow(['Insertion', 'Char added correctly', 'Create DeltaInsertion, verify text']),
            dtRow(['Deletion', 'Range removed', 'Create DeltaDeletion, verify text']),
            dtRow(['Replacement', 'Swap text', 'Create DeltaReplacement, verify']),
            dtRow(['Batch', 'Multiple deltas', 'List of deltas, apply all']),
            dtRow(['IME', 'Composing flow', 'Sequence of compose deltas']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[dt-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dtBanner('16', 'Summary Dashboard'),
      dtCard(
        'DeltaTextInputClient — Complete',
        Column(
          children: [
            dtRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            dtRow(['What', 'S01', 'Granular deltas vs full state']),
            dtRow(['Types', 'S02', '4 delta subclasses']),
            dtRow(['Insert', 'S03', 'Text added at cursor']),
            dtRow(['Delete', 'S04', 'Range removed']),
            dtRow(['Replace', 'S05', 'Selection swapped']),
            dtRow(['NonText', 'S06', 'Cursor/composing only']),
            dtRow(['Fields', 'S07', 'oldText, selection, composing']),
            dtRow(['Rich text', 'S08', 'Span-level updates']),
            dtRow(['Collab', 'S09', 'OT/CRDT integration']),
            dtRow(['Undo', 'S10', 'Inverse delta stacks']),
            dtRow(['IME', 'S11', 'Composing lifecycle']),
            dtRow(['Perf', 'S12', '~30B vs 600KB per keystroke']),
            dtRow(['Callback', 'S13', 'updateEditingValueWithDeltas']),
            dtRow(['Migration', 'S14', 'Incremental mixin adoption']),
            dtRow(['Testing', 'S15', 'Direct delta construction']),
          ],
        ),
      ),
      dtCard(
        'Copper / Bronze Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _dtColorSwatch('Copper', copper),
            _dtColorSwatch('Bronze', bronze),
            _dtColorSwatch('Deep', deepCopper),
            _dtColorSwatch('Rust', rust),
            _dtColorSwatch('Dark', darkCopper),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkCopper, deepCopper],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('DeltaTextInputClient — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From insertion through deletion, replacement, IME composition, '
              'rich text editing, collaborative editing, undo/redo, and '
              'performance optimization — the full text editing delta story.',
              style: TextStyle(color: champagne, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[dt] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('DeltaTextInputClient — Text Deltas'),
        backgroundColor: darkCopper,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFF9F4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _dtDiffLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _dtTypeBox(String name, String trigger, String desc, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 2),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(name,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color)),
        ),
        Expanded(
          flex: 1,
          child: Text(trigger,
              style: TextStyle(fontSize: 9, color: color)),
        ),
        Expanded(
          flex: 3,
          child: Text(desc,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _dtTextDisplay(String text, int cursorPos, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(text,
        style: TextStyle(
            fontSize: 13,
            fontFamily: 'monospace',
            color: const Color(0xFF5C3317))),
  );
}

Widget _dtTextWithSelection(String text, int start, int end, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 13,
            fontFamily: 'monospace',
            color: const Color(0xFF5C3317)),
        children: [
          TextSpan(text: text.substring(0, start)),
          TextSpan(
            text: text.substring(start, end),
            style: TextStyle(
              backgroundColor: color.withValues(alpha: 0.2),
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (end < text.length) TextSpan(text: text.substring(end)),
        ],
      ),
    ),
  );
}

Widget _dtNonTextItem(String action, String result, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(child: Icon(icon, size: 16, color: color)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(action,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ),
        Text(result,
            style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
      ],
    ),
  );
}

Widget _dtUserBadge(String name, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(name,
        style: const TextStyle(
            color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
  );
}

Widget _dtUndoEntry(int num, String action, String inverse, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(action,
              style: TextStyle(fontSize: 10, color: color)),
        ),
        Icon(Icons.swap_horiz, size: 12, color: color.withValues(alpha: 0.5)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(inverse,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _dtImeStep(int num, String input, String display, String delta, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(input,
              style: TextStyle(fontSize: 10, color: color)),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(display,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 3,
          child: Text(delta,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _dtMetricBox(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: color)),
        Text(label,
            style: TextStyle(fontSize: 10, color: color)),
      ],
    ),
  );
}

Widget _dtCheckItem(String text, bool done, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(
          done ? Icons.check_box : Icons.check_box_outline_blank,
          size: 16,
          color: done ? const Color(0xFF4CAF50) : color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 11,
                  color: color,
                  decoration: done ? TextDecoration.lineThrough : null)),
        ),
      ],
    ),
  );
}

Widget _dtColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
