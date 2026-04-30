// ignore_for_file: avoid_print
// D4rt deep demo: TextLayoutMetrics — the abstract mixin that defines
// the contract for measuring text layout: character positions, line
// boundaries, word boundaries, and caret metrics used for cursor navigation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Emerald / Jade palette ───
  const Color emerald = Color(0xFF059669);
  const Color jade = Color(0xFF10B981);
  const Color deepEmerald = Color(0xFF064E3B);
  const Color paleSage = Color(0xFFECFDF5);
  const Color malachite = Color(0xFF047857);
  const Color mint = Color(0xFFD1FAE5);
  const Color hunter = Color(0xFF065F46);
  const Color seafoam = Color(0xFF34D399);
  const Color honeydew = Color(0xFFA7F3D0);
  const Color viridian = Color(0xFF0D9488);

  print('===== TEXT LAYOUT METRICS DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepEmerald, hunter],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepEmerald.withValues(alpha: 0.35),
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
              color: emerald,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: seafoam, width: 1.5),
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

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleSage,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mint),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepEmerald.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mint),
        boxShadow: [
          BoxShadow(
            color: emerald.withValues(alpha: 0.07),
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
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleSage,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepEmerald)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepEmerald)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: hunter)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepEmerald.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepEmerald),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: deepEmerald)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: honeydew,
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textSample(String text, int cursorPos, Color accentColor) {
    final before = text.substring(0, cursorPos.clamp(0, text.length));
    final after = text.substring(cursorPos.clamp(0, text.length));
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: mint),
      ),
      child: Row(
        children: [
          Text(before, style: TextStyle(fontSize: 14, color: deepEmerald)),
          Container(width: 2, height: 18, color: accentColor),
          Text(after, style: TextStyle(fontSize: 14, color: deepEmerald)),
        ],
      ),
    );
  }

  Widget measurementLine(String label, double widthPx, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 10, color: deepEmerald)),
          const SizedBox(height: 2),
          Row(
            children: [
              Container(
                width: widthPx.clamp(10, 280),
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 6),
              Text('${widthPx.toStringAsFixed(0)}px',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: color)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview & Purpose ───
  print('[Section 1] Overview & Purpose');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'TextLayoutMetrics is an abstract mixin that defines how to '
          'measure the spatial properties of rendered text. It provides '
          'methods to find character positions, line boundaries, word '
          'boundaries, and caret locations. EditableTextState is the '
          'primary implementer, using RenderEditable under the hood to '
          'perform actual measurements from the text rendering pipeline.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Abstract mixin class'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Text measurement contract'),
              dataRow('Primary implementer', 'EditableTextState'),
              dataRow('Uses', 'Cursor navigation, text selection'),
            ],
          )),
      infoCard(
          'Why It Exists',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Abstraction', 'Decouple measurement from rendering'),
              dataRow('Testing', 'Mock measurements in tests'),
              dataRow('Extensibility', 'Custom layout measurements'),
              dataRow('Platform', 'Consistent API across renderers'),
            ],
          )),
    ],
  );

  // ─── Section 2: Core Methods ───
  print('[Section 2] Core Methods');

  final methods = <Map<String, String>>[
    {'method': 'getLineAtOffset()', 'returns': 'TextSelection', 'purpose': 'Get full line containing the offset'},
    {'method': 'getWordBoundary()', 'returns': 'TextRange', 'purpose': 'Get word boundaries at position'},
    {'method': 'getTextPositionAbove()', 'returns': 'TextPosition', 'purpose': 'Character position one line up'},
    {'method': 'getTextPositionBelow()', 'returns': 'TextPosition', 'purpose': 'Character position one line down'},
  ];

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Core Methods'),
      noteBox(
          'The mixin defines four key measurement methods that enable '
          'precise text navigation. Each method takes a TextPosition and '
          'returns spatial information about the text layout.'),
      for (final m in methods)
        infoCard(
            m['method']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Method', m['method']!),
                dataRow('Returns', m['returns']!),
                dataRow('Purpose', m['purpose']!),
              ],
            )),
    ],
  );

  // ─── Section 3: getLineAtOffset() In Depth ───
  print('[Section 3] getLineAtOffset() In Depth');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'getLineAtOffset() In Depth'),
      noteBox(
          'getLineAtOffset() returns a TextSelection representing the '
          'entire visual line containing the given text position. This '
          'is used for operations like "select line" or "home/end" key '
          'navigation.'),
      infoCard(
          'How It Works',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Input', 'TextPosition (offset + affinity)'),
              dataRow('Output', 'TextSelection covering whole line'),
              dataRow('Visual lines', 'Respects soft word wraps'),
              dataRow('Hard breaks', 'Stops at newline characters'),
            ],
          )),
      infoCard(
          'Visual Line Examples',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textSample('Hello World', 5, emerald),
              dataRow('Cursor at 5', 'Line is "Hello World" (0..11)'),
              const SizedBox(height: 8),
              textSample('First line\nSecond line', 12, jade),
              dataRow('Cursor at 12', 'Line is "Second line" (11..22)'),
            ],
          )),
      infoCard(
          'Wrapped Text',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Long text', 'Wraps to multiple visual lines'),
              dataRow('Line A', 'First visual line up to wrap point'),
              dataRow('Line B', 'Continuation after wrap'),
              dataRow('getLineAtOffset', 'Returns current visual line only'),
            ],
          )),
    ],
  );

  // ─── Section 4: getWordBoundary() In Depth ───
  print('[Section 4] getWordBoundary() In Depth');

  final wordExamples = <Map<String, dynamic>>[
    {'text': 'Hello World', 'pos': 2, 'wordStart': 0, 'wordEnd': 5, 'word': 'Hello'},
    {'text': 'Hello World', 'pos': 6, 'wordStart': 6, 'wordEnd': 11, 'word': 'World'},
    {'text': 'foo_bar_baz', 'pos': 4, 'wordStart': 0, 'wordEnd': 11, 'word': 'foo_bar_baz'},
    {'text': 'a.b.c', 'pos': 2, 'wordStart': 2, 'wordEnd': 3, 'word': 'b'},
    {'text': 'Hello, World!', 'pos': 5, 'wordStart': 5, 'wordEnd': 6, 'word': ','},
  ];

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'getWordBoundary() In Depth'),
      noteBox(
          'getWordBoundary() returns a TextRange identifying the word '
          'at the given position. This powers double-click/tap word '
          'selection and Ctrl+Arrow word-by-word cursor navigation.'),
      for (final ex in wordExamples)
        infoCard(
            '"${ex['text']}" at ${ex['pos']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textSample(ex['text'] as String, ex['pos'] as int, jade),
                dataRow('Word', '"${ex['word']}"'),
                dataRow('Range', '${ex['wordStart']}..${ex['wordEnd']}'),
              ],
            )),
      infoCard(
          'Word Boundary Rules',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Letters + digits', 'Part of the same word'),
              dataRow('Underscores', 'Usually part of the word'),
              dataRow('Punctuation', 'Typically separate words'),
              dataRow('Spaces', 'Separate words (not included)'),
              dataRow('CJK characters', 'Each character is a word'),
            ],
          )),
    ],
  );

  // ─── Section 5: getTextPositionAbove/Below ───
  print('[Section 5] getTextPositionAbove/Below');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Position Above & Below'),
      noteBox(
          'getTextPositionAbove() and getTextPositionBelow() find the '
          'character position directly above or below the current cursor. '
          'These power the Up/Down arrow key navigation in multi-line text.'),
      infoCard(
          'getTextPositionAbove()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Input', 'TextPosition of current cursor'),
              dataRow('Output', 'TextPosition one visual line up'),
              dataRow('X-position', 'Preserved (same column)'),
              dataRow('Top of text', 'Returns position 0'),
            ],
          )),
      infoCard(
          'getTextPositionBelow()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Input', 'TextPosition of current cursor'),
              dataRow('Output', 'TextPosition one visual line down'),
              dataRow('X-position', 'Preserved (same column)'),
              dataRow('Bottom of text', 'Returns end position'),
            ],
          )),
      infoCard(
          'Column Memory',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Concept', 'Remember the x-position'),
              dataRow('Short line', 'Snap cursor to end of short line'),
              dataRow('Return to long', 'Restore original column'),
              dataRow('Implementation', 'RenderEditable tracks ideal x'),
            ],
          )),
      infoCard(
          'Multi-Line Navigation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textSample('Line one here\nShort\nAnother longer line', 8, emerald),
              dataRow('Start at pos 8', '"Line one |here"'),
              dataRow('Arrow Down', 'Move to pos 19 in "Short"'),
              dataRow('Arrow Down', 'Move to pos 28 in "Another..."'),
            ],
          )),
    ],
  );

  // ─── Section 6: Character Metrics ───
  print('[Section 6] Character Metrics');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Character Metrics'),
      noteBox(
          'The layout metrics depend on precise character measurements — '
          'how wide each glyph is, how tall lines are, and where each '
          'character starts and ends in the layout.'),
      infoCard(
          'Glyph Dimensions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              measurementLine('Monospace "M"', 60, emerald),
              measurementLine('Proportional "i"', 20, jade),
              measurementLine('CJK character "日"', 80, malachite),
              measurementLine('Emoji "🎉"', 90, viridian),
              measurementLine('Ligature "ffi"', 45, seafoam),
            ],
          )),
      infoCard(
          'Line Height Components',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              measurementLine('Ascent (above baseline)', 140, emerald),
              measurementLine('Descent (below baseline)', 50, jade),
              measurementLine('Leading (line spacing)', 20, malachite),
              measurementLine('Total line height', 210, hunter),
            ],
          )),
      infoCard(
          'Variable Width',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Proportional fonts', 'Each char has different width'),
              dataRow('Kerning', 'Spacing adjusted between pairs'),
              dataRow('Ligatures', 'Multiple chars → single glyph'),
              dataRow('Impact', 'Position above/below is not column-aligned'),
            ],
          )),
    ],
  );

  // ─── Section 7: Text Direction ───
  print('[Section 7] Text Direction');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Text Direction'),
      noteBox(
          'TextLayoutMetrics must handle both LTR and RTL text, as well '
          'as bidirectional text that mixes both directions. The '
          'measurements account for visual position, not logical offset.'),
      infoCard(
          'LTR Text',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Direction', 'Left to right'),
              dataRow('Languages', 'English, French, German, etc.'),
              dataRow('Line start', 'Left edge'),
              dataRow('Home key', 'Moves cursor to left edge'),
            ],
          )),
      infoCard(
          'RTL Text',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Direction', 'Right to left'),
              dataRow('Languages', 'Arabic, Hebrew, Urdu, etc.'),
              dataRow('Line start', 'Right edge'),
              dataRow('Home key', 'Moves cursor to right edge'),
            ],
          )),
      infoCard(
          'Bidirectional Text',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mixed content', 'Arabic text with English words'),
              dataRow('Bidi algorithm', 'Unicode Bidi resolves order'),
              dataRow('Visual vs logical', 'Layout position ≠ string index'),
              dataRow('Cursor movement', 'Follows visual order'),
            ],
          )),
    ],
  );

  // ─── Section 8: Affinity ───
  print('[Section 8] Affinity');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'TextAffinity'),
      noteBox(
          'TextAffinity resolves ambiguity at line breaks: when a cursor '
          'is at a line wrap point, it could belong to the end of the '
          'previous line (upstream) or the start of the next line '
          '(downstream). TextLayoutMetrics uses affinity to disambiguate.'),
      infoCard(
          'TextAffinity Values',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('upstream', 'Cursor at end of previous line'),
              dataRow('downstream', 'Cursor at start of next line'),
              dataRow('Same offset', 'Both refer to same text position'),
              dataRow('Different visual', 'Rendered at different locations'),
            ],
          )),
      infoCard(
          'When Affinity Matters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Soft wrap', 'Word-wrap creates ambiguity'),
              dataRow('Hard break', 'No ambiguity (newline char)'),
              dataRow('Arrow up/down', 'Affinity determines which line'),
              dataRow('Caret rendering', 'Affinity positions the caret'),
            ],
          )),
      infoCard(
          'Visual Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Text', '"The quick brown fox jumps"'),
              dataRow('Wraps at', '"fox" — "fox|jumps"'),
              dataRow('Offset 20', 'upstream: end of line 1'),
              dataRow('Offset 20', 'downstream: start of line 2'),
            ],
          )),
    ],
  );

  // ─── Section 9: Cursor Navigation Patterns ───
  print('[Section 9] Cursor Navigation Patterns');

  final navPatterns = <Map<String, String>>[
    {'key': 'Left arrow', 'action': 'Move one character left', 'uses': 'Offset - 1'},
    {'key': 'Right arrow', 'action': 'Move one character right', 'uses': 'Offset + 1'},
    {'key': 'Up arrow', 'action': 'Move one line up', 'uses': 'getTextPositionAbove()'},
    {'key': 'Down arrow', 'action': 'Move one line down', 'uses': 'getTextPositionBelow()'},
    {'key': 'Home', 'action': 'Go to line start', 'uses': 'getLineAtOffset().start'},
    {'key': 'End', 'action': 'Go to line end', 'uses': 'getLineAtOffset().end'},
    {'key': 'Ctrl+Left', 'action': 'Jump word left', 'uses': 'getWordBoundary()'},
    {'key': 'Ctrl+Right', 'action': 'Jump word right', 'uses': 'getWordBoundary()'},
  ];

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Cursor Navigation Patterns'),
      noteBox(
          'TextLayoutMetrics is the foundation for keyboard cursor '
          'navigation. Each arrow key and shortcut maps to one or more '
          'metric methods to compute the new cursor position.'),
      for (final nav in navPatterns)
        infoCard(
            nav['key']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Key', nav['key']!),
                dataRow('Action', nav['action']!),
                dataRow('Uses', nav['uses']!),
              ],
            )),
    ],
  );

  // ─── Section 10: Text Selection ───
  print('[Section 10] Text Selection');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Text Selection'),
      noteBox(
          'Text selection operations heavily depend on layout metrics. '
          'Double-tap selects a word, triple-tap selects a line, and '
          'drag gestures use character positions to define the selection '
          'range.'),
      infoCard(
          'Selection Gestures',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Single tap', 'Place cursor (getPositionForOffset)'),
              dataRow('Double tap', 'Select word (getWordBoundary)'),
              dataRow('Triple tap', 'Select line (getLineAtOffset)'),
              dataRow('Long press', 'Select word + show magnifier'),
              dataRow('Drag', 'Extend selection (character positions)'),
            ],
          )),
      infoCard(
          'Shift+Arrow Selection',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Shift+Up', 'Extend selection up one line'),
              dataRow('Shift+Down', 'Extend selection down one line'),
              dataRow('Shift+Home', 'Extend to line start'),
              dataRow('Shift+End', 'Extend to line end'),
              dataRow('Shift+Ctrl+Left', 'Extend word left'),
            ],
          )),
    ],
  );

  // ─── Section 11: EditableTextState Implementation ───
  print('[Section 11] EditableTextState Implementation');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'EditableTextState Implementation'),
      noteBox(
          'EditableTextState is the primary implementer of TextLayoutMetrics. '
          'It delegates to RenderEditable which performs actual text layout '
          'measurements using the Skia/Impeller text engine.'),
      infoCard(
          'Delegation Chain',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('EditableTextState', 'Implements TextLayoutMetrics'),
              dataRow('Delegates to', 'RenderEditable render object'),
              dataRow('RenderEditable', 'Uses TextPainter for layout'),
              dataRow('TextPainter', 'Uses engine for glyph metrics'),
            ],
          )),
      infoCard(
          'Implementation Details',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('getLineAtOffset()', 'Queries RenderEditable.getLineAtOffset'),
              dataRow('getWordBoundary()', 'Queries RenderEditable.getWordBoundary'),
              dataRow('getTextPositionAbove()', 'Uses RenderEditable + preferred x'),
              dataRow('getTextPositionBelow()', 'Uses RenderEditable + preferred x'),
            ],
          )),
    ],
  );

  // ─── Section 12: Soft Wrap Complexities ───
  print('[Section 12] Soft Wrap Complexities');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Soft Wrap Complexities'),
      noteBox(
          'Soft wrapping (word wrap) creates visual lines that don\'t have '
          'newline characters. TextLayoutMetrics must distinguish between '
          'visual and logical lines, which creates subtle complexities '
          'for navigation.'),
      infoCard(
          'Visual vs Logical Lines',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Logical line', 'Delimited by newline characters'),
              dataRow('Visual line', 'Delimited by wrapping or newline'),
              dataRow('One logical', 'Can span multiple visual lines'),
              dataRow('getLineAtOffset', 'Returns visual line'),
            ],
          )),
      infoCard(
          'Wrap Point Challenges',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Character at wrap', 'Affinity resolves ambiguity'),
              dataRow('Very long word', 'Breaks mid-word if no space'),
              dataRow('Hyphenation', 'Not automatic in Flutter'),
              dataRow('Overflow', 'TextOverflow.ellipsis truncates'),
            ],
          )),
      infoCard(
          'Width Sensitivity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Resize window', 'Wrap points change completely'),
              dataRow('Font change', 'Different char widths → new wraps'),
              dataRow('Padding change', 'Available width changes wraps'),
              dataRow('Metrics invalidated', 'Must re-query after changes'),
            ],
          )),
    ],
  );

  // ─── Section 13: Testing Layout Metrics ───
  print('[Section 13] Testing Layout Metrics');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Testing Layout Metrics'),
      noteBox(
          'Testing TextLayoutMetrics implementations requires either '
          'real rendered text (widget tests) or mock implementations '
          'that return predictable values for unit testing navigation.'),
      infoCard(
          'Widget Test Approach',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Create TextField', 'In a test widget'),
              dataRow('Enter text', 'tester.enterText()'),
              dataRow('Simulate keys', 'tester.sendKeyEvent()'),
              dataRow('Verify cursor', 'Check controller.selection'),
            ],
          )),
      infoCard(
          'Mock Metrics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Implement mixin', 'Create mock class'),
              dataRow('Return fixed values', 'Predictable word boundaries'),
              dataRow('Test navigation', 'Verify correct method calls'),
              dataRow('No rendering', 'Pure unit test'),
            ],
          )),
    ],
  );

  // ─── Section 14: Performance ───
  print('[Section 14] Performance');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Performance'),
      noteBox(
          'Text layout measurement can be expensive, especially for long '
          'documents. The framework caches layout results and invalidates '
          'the cache only when text, constraints, or style changes.'),
      infoCard(
          'Cost Profile',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('getWordBoundary()', 0.15, emerald),
              progressBar('getLineAtOffset()', 0.20, jade),
              progressBar('getTextPositionAbove()', 0.30, malachite),
              progressBar('Full layout', 0.80, hunter),
            ],
          )),
      infoCard(
          'Optimization Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Caching', 'TextPainter caches layout'),
              dataRow('Lazy layout', 'Only layout visible portion'),
              dataRow('Batch queries', 'Group multiple measurements'),
              dataRow('Avoid in build', 'Query in post-frame callback'),
            ],
          )),
    ],
  );

  // ─── Section 15: Related API ───
  print('[Section 15] Related API');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Related API'),
      noteBox(
          'TextLayoutMetrics is part of a larger measurement ecosystem '
          'in Flutter that includes TextPainter, RenderEditable, and '
          'various text position/range classes.'),
      infoCard(
          'Measurement Classes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextPainter', 'Direct text layout and measure'),
              dataRow('RenderEditable', 'Render object with metrics'),
              dataRow('RenderParagraph', 'Non-editable text rendering'),
              dataRow('InlineSpan', 'Spans with measurement data'),
            ],
          )),
      infoCard(
          'Position & Range Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextPosition', 'Offset + affinity'),
              dataRow('TextSelection', 'Base + extent positions'),
              dataRow('TextRange', 'Start + end integer offsets'),
              dataRow('TextBox', 'Rect for a text run'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the TextLayoutMetrics deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Emerald', emerald),
              colorSwatch('Jade', jade),
              colorSwatch('Deep Emerald', deepEmerald),
              colorSwatch('Pale Sage', paleSage),
              colorSwatch('Malachite', malachite),
              colorSwatch('Mint', mint),
              colorSwatch('Hunter', hunter),
              colorSwatch('Seafoam', seafoam),
              colorSwatch('Honeydew', honeydew),
              colorSwatch('Viridian', viridian),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, emerald),
              progressBar('Core Methods', 1.0, jade),
              progressBar('getLineAtOffset()', 1.0, malachite),
              progressBar('getWordBoundary()', 1.0, viridian),
              progressBar('Position Above/Below', 1.0, seafoam),
              progressBar('Character Metrics', 1.0, emerald),
              progressBar('Text Direction', 1.0, jade),
              progressBar('TextAffinity', 1.0, malachite),
              progressBar('Navigation Patterns', 1.0, viridian),
              progressBar('Text Selection', 1.0, seafoam),
              progressBar('EditableTextState', 1.0, emerald),
              progressBar('Soft Wrap', 1.0, jade),
              progressBar('Testing', 1.0, malachite),
              progressBar('Performance', 1.0, viridian),
              progressBar('Related API', 1.0, seafoam),
              progressBar('Dashboard', 1.0, emerald),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Emerald / Jade'),
              dataRow('Palette colors', '10'),
              dataRow('Core methods', '${methods.length}'),
              dataRow('Word examples', '${wordExamples.length}'),
              dataRow('Nav patterns', '${navPatterns.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('TextLayoutMetrics', emerald, Colors.white),
          tag('Word Boundary', jade, Colors.white),
          tag('Line Boundary', malachite, Colors.white),
          tag('Cursor Nav', viridian, Colors.white),
          tag('Affinity', seafoam, deepEmerald),
          tag('Text Measurement', hunter, Colors.white),
        ],
      ),
    ],
  );

  print('===== END TEXT LAYOUT METRICS DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
