// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo of WordBoundary - text word boundary for selection
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertyRow(String property, String type, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            property,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.indigo.shade800,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildWordBoundaryCard(
  String text,
  int start,
  int end,
  String word,
  Color highlightColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: highlightColor.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: highlightColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Word: "$word"',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: highlightColor,
                ),
              ),
            ),
            Spacer(),
            Text(
              'Range($start, $end)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Full text: "$text"',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextRangeMethodCard(
  String methodName,
  String input,
  String output,
  String description,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          methodName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Input:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(input, style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Output:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget buildWhitespaceCard(
  String scenario,
  String text,
  List<Map<String, dynamic>> words,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.orange.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scenario,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.orange.shade800,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            '"$text"',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(height: 8),
        ...words.map((wordInfo) {
          return Container(
            margin: EdgeInsets.only(bottom: 4),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Text(
                  'Word ${wordInfo['index']}:',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '"${wordInfo['word']}"',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  'Range(${wordInfo['start']}, ${wordInfo['end']})',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget buildOffsetCard(
  String title,
  String leadingDesc,
  String trailingDesc,
  int leadingOffset,
  int trailingOffset,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.purple.shade400,
                      size: 20,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Leading',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Offset: $leadingOffset',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      leadingDesc,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.purple.shade400,
                      size: 20,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Trailing',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Offset: $trailingOffset',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      trailingDesc,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSelectionVisualCard(
  String text,
  int selStart,
  int selEnd,
  String selectedText,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.teal.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.select_all, color: Colors.teal.shade700, size: 20),
            SizedBox(width: 8),
            Text(
              'Selection Visualization',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'monospace',
                color: Colors.black87,
              ),
              children: [
                TextSpan(text: text.substring(0, selStart)),
                TextSpan(
                  text: text.substring(selStart, selEnd),
                  style: TextStyle(
                    backgroundColor: Colors.yellow.shade300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: text.substring(selEnd)),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Start',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  '$selStart',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'End',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  '$selEnd',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Length',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  '${selEnd - selStart}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 6),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Selected: "$selectedText"',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildScenarioCard(
  String scenario,
  String description,
  String example,
  String wordBoundaryResult,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.cyan.shade700,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              scenario,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.cyan.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Example: $example',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Result: $wordBoundaryResult',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildConceptCard(String title, String explanation, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.indigo.shade600, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                explanation,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('WordBoundary deep demo executing');

  // Section 1: WordBoundary Concept
  print('\n=== SECTION 1: WORDBOUNDARY CONCEPT ===');
  print('WordBoundary is used to identify word extents in text');
  print('It extends TextBoundary abstract class');
  print('Created via TextPainter.wordBoundaries property');
  print('Key method: getTextBoundaryAt(position) returns TextRange');
  print('Used for double-tap word selection in text fields');

  // Section 2: TextRange with Word Selection
  print('\n=== SECTION 2: TEXTRANGE WITH WORD SELECTION ===');

  var simpleText = 'Hello World';
  var helloRange = TextRange(start: 0, end: 5);
  var worldRange = TextRange(start: 6, end: 11);

  print('Simple text: "$simpleText"');
  print('Word "Hello" range: $helloRange');
  print('Word "World" range: $worldRange');
  print('helloRange.textInside: "${helloRange.textInside(simpleText)}"');
  print('worldRange.textInside: "${worldRange.textInside(simpleText)}"');

  var sentenceText = 'The quick brown fox';
  var theRange = TextRange(start: 0, end: 3);
  var quickRange = TextRange(start: 4, end: 9);
  var brownRange = TextRange(start: 10, end: 15);
  var foxRange = TextRange(start: 16, end: 19);

  print('\nSentence: "$sentenceText"');
  print('Word "The" range: $theRange -> "${theRange.textInside(sentenceText)}"');
  print('Word "quick" range: $quickRange -> "${quickRange.textInside(sentenceText)}"');
  print('Word "brown" range: $brownRange -> "${brownRange.textInside(sentenceText)}"');
  print('Word "fox" range: $foxRange -> "${foxRange.textInside(sentenceText)}"');

  // Section 3: Leading and Trailing Offsets
  print('\n=== SECTION 3: LEADING AND TRAILING OFFSETS ===');

  var offsetText = '  Hello  World  ';
  print('Text with spaces: "$offsetText"');

  var helloWithLeading = TextRange(start: 2, end: 7);
  var worldWithTrailing = TextRange(start: 9, end: 14);

  print('Hello range (with leading spaces): $helloWithLeading');
  print('Leading offset for Hello: 2 (two spaces before)');
  print('Trailing offset for Hello: 7 (excludes trailing spaces)');
  print('World range: $worldWithTrailing');
  print('Leading offset for World: 9');
  print('Trailing offset for World: 14');

  var textWithTabs = 'Word1\tWord2\tWord3';
  print('\nText with tabs: "$textWithTabs"');
  print('Tab character creates boundary between words');
  print('Word1 leading: 0, trailing: 5');
  print('Word2 leading: 6, trailing: 11');
  print('Word3 leading: 12, trailing: 17');

  // Section 4: Whitespace Handling
  print('\n=== SECTION 4: WHITESPACE HANDLING ===');

  var singleSpaceText = 'one two three';
  print('Single space separation: "$singleSpaceText"');
  print('Word boundaries: [0,3], [4,7], [8,13]');

  var multiSpaceText = 'one  two   three';
  print('\nMultiple spaces: "$multiSpaceText"');
  print('Word boundaries include handling multiple spaces');
  print('Word "one": [0,3]');
  print('Word "two": [5,8]');
  print('Word "three": [11,16]');

  var leadingSpaceText = '   leading';
  print('\nLeading whitespace: "$leadingSpaceText"');
  print('Word "leading" starts at offset 3');
  print('Range: [3, 10]');

  var trailingSpaceText = 'trailing   ';
  print('\nTrailing whitespace: "$trailingSpaceText"');
  print('Word "trailing" range: [0, 8]');
  print('Trailing spaces not part of word boundary');

  var newlineText = 'line1\nline2';
  print('\nNewline separation: "$newlineText"');
  print('Newline acts as word separator');
  print('Word "line1": [0, 5]');
  print('Word "line2": [6, 11]');

  // Section 5: Selection Visualization
  print('\n=== SECTION 5: SELECTION VISUALIZATION ===');

  var selText = 'Select this word here';
  var selRange = TextRange(start: 7, end: 11);
  print('Full text: "$selText"');
  print('Selection range for "this": $selRange');
  print('Selected text: "${selRange.textInside(selText)}"');
  print('Text before selection: "${selRange.textBefore(selText)}"');
  print('Text after selection: "${selRange.textAfter(selText)}"');

  var multiWordSel = TextRange(start: 7, end: 16);
  print('\nMulti-word selection: $multiWordSel');
  print('Selected: "${multiWordSel.textInside(selText)}"');

  var collapsedSel = TextRange.collapsed(5);
  print('\nCollapsed selection (cursor): $collapsedSel');
  print('isCollapsed: ${collapsedSel.isCollapsed}');

  // Section 6: Common Text Scenarios
  print('\n=== SECTION 6: COMMON TEXT SCENARIOS ===');

  var hyphenatedText = 'self-contained';
  print('Hyphenated word: "$hyphenatedText"');
  print('May be treated as single word or multiple depending on rules');

  var contractedText = "don't";
  print('\nContracted word: "$contractedText"');
  print('Apostrophe handling varies by implementation');

  var camelCaseText = 'camelCaseWord';
  print('\nCamelCase: "$camelCaseText"');
  print('Typically treated as single word');

  var numberText = 'word123number';
  print('\nWord with numbers: "$numberText"');
  print('Numbers attached to words form single boundary');

  var punctuationText = 'Hello, World!';
  print('\nPunctuation: "$punctuationText"');
  print('Punctuation typically excluded from word range');
  print('Word "Hello": [0, 5] (excludes comma)');
  print('Word "World": [7, 12] (excludes exclamation)');

  var emailText = 'user@domain.com';
  print('\nEmail address: "$emailText"');
  print('Special characters affect boundaries');

  var urlText = 'https://example.com';
  print('\nURL: "$urlText"');
  print('URL may be multiple boundaries or single');

  var unicodeText = 'café';
  print('\nUnicode: "$unicodeText"');
  print('Accented characters part of word');

  var emojiText = 'Hello 👋 World';
  print('\nWith emoji: "$emojiText"');
  print('Emoji handled as separate element');

  print('\nWordBoundary deep demo completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade600, Colors.indigo.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.text_fields, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                'WordBoundary Deep Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Text word boundary concept for selection',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Section 1: WordBoundary Concept
        buildSectionHeader('1. WordBoundary Concept'),

        buildConceptCard(
          'What is WordBoundary?',
          'WordBoundary is a class that defines how words are identified within text. It extends TextBoundary and provides methods to find word extents at any position.',
          Icons.help_outline,
        ),

        buildConceptCard(
          'TextBoundary Base Class',
          'WordBoundary extends TextBoundary, which is an abstract class for computing text boundaries. This includes words, lines, paragraphs, and other text units.',
          Icons.account_tree,
        ),

        buildConceptCard(
          'Creation via TextPainter',
          'WordBoundary instances are created through TextPainter.wordBoundaries property. The TextPainter must have text and layout computed first.',
          Icons.build,
        ),

        buildConceptCard(
          'Primary Method',
          'getTextBoundaryAt(TextPosition position) returns a TextRange representing the word at that position. Returns TextRange.empty if no word found.',
          Icons.functions,
        ),

        buildConceptCard(
          'Double-Tap Selection',
          'In text fields, double-tapping calls the word boundary to select the entire word under the tap position. This is the primary use case.',
          Icons.touch_app,
        ),

        buildPropertyRow('textBoundaryAt', 'Method', 'Gets word range at position'),
        buildPropertyRow('getLeadingTextBoundaryAt', 'Method', 'Gets start of word'),
        buildPropertyRow('getTrailingTextBoundaryAt', 'Method', 'Gets end of word'),

        // Section 2: TextRange with Word Selection
        buildSectionHeader('2. TextRange with Word Selection'),

        buildInfoCard('TextRange', 'Represents a range of text with start and end offsets'),
        buildInfoCard('Usage', 'WordBoundary returns TextRange for word extents'),

        buildWordBoundaryCard(simpleText, 0, 5, 'Hello', Colors.blue),
        buildWordBoundaryCard(simpleText, 6, 11, 'World', Colors.green),

        buildTextRangeMethodCard(
          'textInside(text)',
          'TextRange(0, 5) on "$simpleText"',
          '"Hello"',
          'Returns the substring within the range',
        ),

        buildTextRangeMethodCard(
          'textBefore(text)',
          'TextRange(6, 11) on "$simpleText"',
          '"Hello "',
          'Returns text before the range start',
        ),

        buildTextRangeMethodCard(
          'textAfter(text)',
          'TextRange(0, 5) on "$simpleText"',
          '" World"',
          'Returns text after the range end',
        ),

        buildWordBoundaryCard(sentenceText, 0, 3, 'The', Colors.purple),
        buildWordBoundaryCard(sentenceText, 4, 9, 'quick', Colors.orange),
        buildWordBoundaryCard(sentenceText, 10, 15, 'brown', Colors.teal),
        buildWordBoundaryCard(sentenceText, 16, 19, 'fox', Colors.pink),

        buildPropertyRow('start', 'int', 'Beginning offset of range (inclusive)'),
        buildPropertyRow('end', 'int', 'Ending offset of range (exclusive)'),
        buildPropertyRow('isValid', 'bool', 'True if start >= 0 and end >= 0'),
        buildPropertyRow('isNormalized', 'bool', 'True if start <= end'),
        buildPropertyRow('isCollapsed', 'bool', 'True if start == end (cursor)'),

        // Section 3: Leading and Trailing Offsets
        buildSectionHeader('3. Leading and Trailing Offsets'),

        buildInfoCard(
          'Leading Offset',
          'The position where a word starts, excluding preceding whitespace',
        ),
        buildInfoCard(
          'Trailing Offset',
          'The position where a word ends, excluding following whitespace',
        ),

        buildOffsetCard(
          'Word "Hello" in "$offsetText"',
          'Starts at 2',
          'Ends at 7',
          2,
          7,
        ),

        buildOffsetCard(
          'Word "World" in "$offsetText"',
          'Starts at 9',
          'Ends at 14',
          9,
          14,
        ),

        buildOffsetCard(
          'Word "quick" in "$sentenceText"',
          'After "The "',
          'Before " brown"',
          4,
          9,
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Offset Calculation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Leading offset = index of first character of word',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Trailing offset = index after last character of word',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Length = trailing - leading',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Section 4: Whitespace Handling
        buildSectionHeader('4. Whitespace Handling'),

        buildWhitespaceCard(
          'Single Space Separation',
          singleSpaceText,
          [
            {'index': 1, 'word': 'one', 'start': 0, 'end': 3},
            {'index': 2, 'word': 'two', 'start': 4, 'end': 7},
            {'index': 3, 'word': 'three', 'start': 8, 'end': 13},
          ],
        ),

        buildWhitespaceCard(
          'Multiple Spaces',
          multiSpaceText,
          [
            {'index': 1, 'word': 'one', 'start': 0, 'end': 3},
            {'index': 2, 'word': 'two', 'start': 5, 'end': 8},
            {'index': 3, 'word': 'three', 'start': 11, 'end': 16},
          ],
        ),

        buildWhitespaceCard(
          'Leading Whitespace',
          leadingSpaceText,
          [
            {'index': 1, 'word': 'leading', 'start': 3, 'end': 10},
          ],
        ),

        buildWhitespaceCard(
          'Trailing Whitespace',
          trailingSpaceText,
          [
            {'index': 1, 'word': 'trailing', 'start': 0, 'end': 8},
          ],
        ),

        buildWhitespaceCard(
          'Newline Separation',
          'line1\\nline2',
          [
            {'index': 1, 'word': 'line1', 'start': 0, 'end': 5},
            {'index': 2, 'word': 'line2', 'start': 6, 'end': 11},
          ],
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Whitespace Characters Recognized',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('Space'), backgroundColor: Colors.green.shade100),
                  Chip(label: Text('Tab \\t'), backgroundColor: Colors.green.shade100),
                  Chip(label: Text('Newline \\n'), backgroundColor: Colors.green.shade100),
                  Chip(label: Text('Carriage Return \\r'), backgroundColor: Colors.green.shade100),
                  Chip(label: Text('Form Feed \\f'), backgroundColor: Colors.green.shade100),
                ],
              ),
            ],
          ),
        ),

        // Section 5: Selection Visualization
        buildSectionHeader('5. Selection Visualization'),

        buildSelectionVisualCard(selText, 7, 11, 'this'),
        buildSelectionVisualCard(selText, 0, 6, 'Select'),
        buildSelectionVisualCard(selText, 12, 16, 'word'),
        buildSelectionVisualCard(selText, 17, 21, 'here'),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Multi-Word Selection',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Full text: "$selText"',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'monospace',
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(text: 'Select '),
                      TextSpan(
                        text: 'this word',
                        style: TextStyle(
                          backgroundColor: Colors.blue.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' here'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Range: TextRange(7, 16) selects "this word"',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Collapsed Selection (Cursor)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('TextRange.collapsed(5)', style: TextStyle(fontSize: 12)),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'isCollapsed: true',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Represents cursor position with no selection',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        // Section 6: Common Text Scenarios
        buildSectionHeader('6. Common Text Scenarios'),

        buildScenarioCard(
          'Hyphenated Words',
          'Hyphenated words may be treated as single or multiple words depending on the boundary rules implementation',
          '"self-contained"',
          'May return [0,14] or [0,4], [5,14]',
        ),

        buildScenarioCard(
          'Contractions',
          'Words with apostrophes like contractions are typically treated as single words',
          '"don\'t"',
          'Returns [0,5] as single word',
        ),

        buildScenarioCard(
          'CamelCase',
          'CamelCase identifiers are typically treated as single words unless using smart word boundary detection',
          '"camelCaseWord"',
          'Returns [0,13] as single word',
        ),

        buildScenarioCard(
          'Numbers in Words',
          'Numbers attached to words are included in the word boundary',
          '"word123number"',
          'Returns [0,13] as single token',
        ),

        buildScenarioCard(
          'Punctuation',
          'Most punctuation marks are excluded from word boundaries and act as separators',
          '"Hello, World!"',
          '"Hello" = [0,5], "World" = [7,12]',
        ),

        buildScenarioCard(
          'Email Addresses',
          'Email addresses contain special characters that affect word boundary detection',
          '"user@domain.com"',
          'May be multiple boundaries at @, .',
        ),

        buildScenarioCard(
          'URLs',
          'URLs with protocols and paths may be single or multiple word boundaries',
          '"https://example.com"',
          'Implementation dependent',
        ),

        buildScenarioCard(
          'Unicode Characters',
          'Accented and special Unicode characters are properly included in word boundaries',
          '"café"',
          'Returns [0,4] including accent',
        ),

        buildScenarioCard(
          'Emoji',
          'Emoji characters are handled as separate elements from surrounding text',
          '"Hello 👋 World"',
          '"Hello" = [0,5], "World" = [9,14]',
        ),

        // Summary section
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 12),
              buildInfoCard('WordBoundary', 'Extends TextBoundary for word detection'),
              buildInfoCard('TextRange', 'Holds start/end offsets for word extent'),
              buildInfoCard('Leading Offset', 'Index where word starts'),
              buildInfoCard('Trailing Offset', 'Index after word ends'),
              buildInfoCard('Whitespace', 'Acts as word separator'),
              buildInfoCard('Use Case', 'Double-tap word selection'),
            ],
          ),
        ),

        SizedBox(height: 24),
      ],
    ),
  );
}
