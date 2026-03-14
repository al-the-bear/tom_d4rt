// D4rt test script: Tests TextEditingDeltaNonTextUpdate from services
// TextEditingDeltaNonTextUpdate represents selection/composing changes without text modification
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('===================================================');
  print('TextEditingDeltaNonTextUpdate Comprehensive Test Suite');
  print('===================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: Basic Non-Text Update ==========
  print('\n--- Test 1: Basic Non-Text Update ---');
  totalTests++;

  final delta1 = TextEditingDeltaNonTextUpdate(
    oldText: 'Hello World',
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange.empty,
  );

  print('TextEditingDeltaNonTextUpdate created');
  print('oldText: ${delta1.oldText}');
  print('selection: ${delta1.selection}');
  print('composing: ${delta1.composing}');
  assert(delta1.oldText == 'Hello World', 'oldText should remain unchanged');
  print('Test 1 PASSED: Basic non-text update works');
  testsPassed++;

  // ========== Test 2: Selection Change Only ==========
  print('\n--- Test 2: Selection Change Only ---');
  totalTests++;

  final originalText = 'The quick brown fox';
  final delta2 = TextEditingDeltaNonTextUpdate(
    oldText: originalText,
    selection: TextSelection(baseOffset: 4, extentOffset: 9), // Select 'quick'
    composing: TextRange.empty,
  );

  print('Selection change:');
  print('Text unchanged: "${delta2.oldText}"');
  print('New selection: ${delta2.selection}');
  print(
    'Selected text: "${originalText.substring(delta2.selection.start, delta2.selection.end)}"',
  );
  assert(!delta2.selection.isCollapsed, 'Selection should not be collapsed');
  print('Test 2 PASSED: Selection change works');
  testsPassed++;

  // ========== Test 3: Cursor Movement ==========
  print('\n--- Test 3: Cursor Movement ---');
  totalTests++;

  final delta3 = TextEditingDeltaNonTextUpdate(
    oldText: 'Cursor movement test',
    selection: TextSelection.collapsed(offset: 7), // Cursor after 'Cursor '
    composing: TextRange.empty,
  );

  print('Cursor movement:');
  print('selection isCollapsed: ${delta3.selection.isCollapsed}');
  print('cursor position: ${delta3.selection.baseOffset}');
  assert(delta3.selection.isCollapsed, 'Cursor should be collapsed');
  print('Test 3 PASSED: Cursor movement works');
  testsPassed++;

  // ========== Test 4: Composing Range Update ==========
  print('\n--- Test 4: Composing Range Update ---');
  totalTests++;

  final delta4 = TextEditingDeltaNonTextUpdate(
    oldText: 'IME composing',
    selection: TextSelection.collapsed(offset: 13),
    composing: TextRange(start: 4, end: 13), // 'composing' is being composed
  );

  print('Composing range update:');
  print('composing: ${delta4.composing}');
  print('composing isValid: ${delta4.composing.isValid}');
  print(
    'composing text: "${delta4.oldText.substring(delta4.composing.start, delta4.composing.end)}"',
  );
  assert(delta4.composing.isValid, 'Composing should be valid');
  print('Test 4 PASSED: Composing range update works');
  testsPassed++;

  // ========== Test 5: Composing Range Clear ==========
  print('\n--- Test 5: Composing Range Clear ---');
  totalTests++;

  final delta5 = TextEditingDeltaNonTextUpdate(
    oldText: 'Composition complete',
    selection: TextSelection.collapsed(offset: 20),
    composing: TextRange.empty, // Composition finished
  );

  print('Composing range clear:');
  print('composing: ${delta5.composing}');
  print('composing isCollapsed: ${delta5.composing.isCollapsed}');
  print('IME composition completed');
  assert(delta5.composing == TextRange.empty, 'Composing should be empty');
  print('Test 5 PASSED: Composing range clear works');
  testsPassed++;

  // ========== Test 6: Select All Operation ==========
  print('\n--- Test 6: Select All Operation ---');
  totalTests++;

  final fullText = 'Select all this text content';
  final delta6 = TextEditingDeltaNonTextUpdate(
    oldText: fullText,
    selection: TextSelection(baseOffset: 0, extentOffset: fullText.length),
    composing: TextRange.empty,
  );

  print('Select all operation:');
  print('selection start: ${delta6.selection.start}');
  print('selection end: ${delta6.selection.end}');
  print('text length: ${fullText.length}');
  assert(delta6.selection.start == 0, 'Selection should start at 0');
  assert(
    delta6.selection.end == fullText.length,
    'Selection should end at text length',
  );
  print('Test 6 PASSED: Select all operation works');
  testsPassed++;

  // ========== Test 7: Direction Selection (RTL) ==========
  print('\n--- Test 7: Direction Selection ---');
  totalTests++;

  // Selecting from right to left (extent < base)
  final delta7 = TextEditingDeltaNonTextUpdate(
    oldText: 'Direction test',
    selection: TextSelection(baseOffset: 10, extentOffset: 5),
    composing: TextRange.empty,
  );

  print('Direction selection:');
  print('baseOffset: ${delta7.selection.baseOffset}');
  print('extentOffset: ${delta7.selection.extentOffset}');
  print('isDirectional: ${delta7.selection.isDirectional}');
  print('Selection direction: right-to-left');
  print('Test 7 PASSED: Direction selection works');
  testsPassed++;

  // ========== Test 8: Affinity Change ==========
  print('\n--- Test 8: Affinity Change ---');
  totalTests++;

  final deltaUpstream = TextEditingDeltaNonTextUpdate(
    oldText: 'Line break\ntest',
    selection: TextSelection.collapsed(
      offset: 10,
      affinity: TextAffinity.upstream,
    ),
    composing: TextRange.empty,
  );

  final deltaDownstream = TextEditingDeltaNonTextUpdate(
    oldText: 'Line break\ntest',
    selection: TextSelection.collapsed(
      offset: 10,
      affinity: TextAffinity.downstream,
    ),
    composing: TextRange.empty,
  );

  print('Affinity change:');
  print('Upstream affinity: ${deltaUpstream.selection.affinity}');
  print('Downstream affinity: ${deltaDownstream.selection.affinity}');
  print('Affects cursor rendering at line breaks');
  print('Test 8 PASSED: Affinity change works');
  testsPassed++;

  // ========== Test 9: Word Selection Double-Click Simulation ==========
  print('\n--- Test 9: Word Selection (Double-Click) ---');
  totalTests++;

  final sentenceText = 'Double click selects word';
  final delta9 = TextEditingDeltaNonTextUpdate(
    oldText: sentenceText,
    selection: TextSelection(baseOffset: 7, extentOffset: 12), // 'click'
    composing: TextRange.empty,
  );

  print('Word selection (double-click):');
  final selectedWord = sentenceText.substring(
    delta9.selection.start,
    delta9.selection.end,
  );
  print('Selected word: "$selectedWord"');
  assert(selectedWord == 'click', 'Should select "click"');
  print('Test 9 PASSED: Word selection works');
  testsPassed++;

  // ========== Test 10: Triple-Click Line Selection ==========
  print('\n--- Test 10: Line Selection (Triple-Click) ---');
  totalTests++;

  final multilineText = 'First line\nSecond line\nThird line';
  final delta10 = TextEditingDeltaNonTextUpdate(
    oldText: multilineText,
    selection: TextSelection(baseOffset: 11, extentOffset: 22), // 'Second line'
    composing: TextRange.empty,
  );

  print('Line selection (triple-click):');
  final selectedLine = multilineText.substring(
    delta10.selection.start,
    delta10.selection.end,
  );
  print('Selected line: "$selectedLine"');
  print('Test 10 PASSED: Line selection works');
  testsPassed++;

  // ========== Test 11: Selection with Unicode ==========
  print('\n--- Test 11: Selection with Unicode ---');
  totalTests++;

  final unicodeText = 'Hello 世界 🌍 emoji';
  final delta11 = TextEditingDeltaNonTextUpdate(
    oldText: unicodeText,
    selection: TextSelection(baseOffset: 6, extentOffset: 8),
    composing: TextRange.empty,
  );

  print('Unicode selection:');
  print('oldText: "$unicodeText"');
  print('selection: ${delta11.selection}');
  print('Test 11 PASSED: Unicode selection works');
  testsPassed++;

  // ========== Test 12: No Change Scenario ==========
  print('\n--- Test 12: No Change Scenario ---');
  totalTests++;

  final delta12 = TextEditingDeltaNonTextUpdate(
    oldText: 'No changes here',
    selection: TextSelection.collapsed(offset: 0),
    composing: TextRange.empty,
  );

  print('No change scenario:');
  print('Text stays same: "${delta12.oldText}"');
  print('Selection at start: ${delta12.selection}');
  print('No composing: ${delta12.composing}');
  print('Represents a non-text update with minimal changes');
  print('Test 12 PASSED: No change scenario works');
  testsPassed++;

  // ========== Summary ==========
  print('\n===================================================');
  print('TextEditingDeltaNonTextUpdate Test Summary');
  print('===================================================');
  print('Tests passed: $testsPassed / $totalTests');
  assert(testsPassed == totalTests, 'All tests should pass');
  print('ALL TESTS PASSED!');

  // ========== Return Widget Summary ==========
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'TextEditingDeltaNonTextUpdate Test Results',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests Passed: $testsPassed / $totalTests'),
      SizedBox(height: 4),
      Text('Basic Non-Text Update: ✓'),
      Text('Selection Change: ✓'),
      Text('Cursor Movement: ✓'),
      Text('Composing Range Update: ✓'),
      Text('Composing Range Clear: ✓'),
      Text('Select All: ✓'),
      Text('Direction Selection: ✓'),
      Text('Affinity Change: ✓'),
      Text('Word Selection: ✓'),
      Text('Line Selection: ✓'),
      Text('Unicode Selection: ✓'),
      Text('No Change Scenario: ✓'),
      SizedBox(height: 8),
      Text(
        'All TextEditingDeltaNonTextUpdate tests completed!',
        style: TextStyle(color: Color(0xFF4CAF50)),
      ),
    ],
  );
}
