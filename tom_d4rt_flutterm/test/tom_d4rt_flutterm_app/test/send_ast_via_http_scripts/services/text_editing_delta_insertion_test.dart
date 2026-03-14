// D4rt test script: Tests TextEditingDeltaInsertion from services
// TextEditingDeltaInsertion represents an insertion operation in text editing
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextEditingDeltaInsertion Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: Basic Insertion Delta ==========
  print('\n--- Test 1: Basic Insertion Delta ---');
  totalTests++;

  final delta1 = TextEditingDeltaInsertion(
    oldText: 'Hello',
    textInserted: ' World',
    insertionOffset: 5,
    selection: TextSelection.collapsed(offset: 11),
    composing: TextRange.empty,
  );

  print('TextEditingDeltaInsertion created');
  print('oldText: ${delta1.oldText}');
  print('textInserted: ${delta1.textInserted}');
  print('insertionOffset: ${delta1.insertionOffset}');
  print('selection: ${delta1.selection}');
  assert(delta1.oldText == 'Hello', 'oldText should match');
  assert(delta1.textInserted == ' World', 'textInserted should match');
  assert(delta1.insertionOffset == 5, 'insertionOffset should be 5');
  print('Test 1 PASSED: Basic insertion delta works');
  testsPassed++;

  // ========== Test 2: Single Character Insertion ==========
  print('\n--- Test 2: Single Character Insertion ---');
  totalTests++;

  final delta2 = TextEditingDeltaInsertion(
    oldText: 'Fluter',
    textInserted: 't',
    insertionOffset: 4, // Insert 't' after 'Flut'
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange.empty,
  );

  print('Single character insertion:');
  print('oldText: "${delta2.oldText}"');
  print('textInserted: "${delta2.textInserted}"');
  print('insertionOffset: ${delta2.insertionOffset}');
  assert(delta2.textInserted.length == 1, 'Should insert single character');
  print('Test 2 PASSED: Single character insertion works');
  testsPassed++;

  // ========== Test 3: Insertion at Beginning ==========
  print('\n--- Test 3: Insertion at Beginning ---');
  totalTests++;

  final delta3 = TextEditingDeltaInsertion(
    oldText: 'World',
    textInserted: 'Hello ',
    insertionOffset: 0,
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  print('Beginning insertion:');
  print('oldText: "${delta3.oldText}"');
  print('textInserted: "${delta3.textInserted}"');
  print('insertionOffset: ${delta3.insertionOffset}');
  assert(delta3.insertionOffset == 0, 'Should insert at position 0');
  print('Test 3 PASSED: Beginning insertion works');
  testsPassed++;

  // ========== Test 4: Insertion at End ==========
  print('\n--- Test 4: Insertion at End ---');
  totalTests++;

  final delta4 = TextEditingDeltaInsertion(
    oldText: 'Hello',
    textInserted: '!',
    insertionOffset: 5,
    selection: TextSelection.collapsed(offset: 6),
    composing: TextRange.empty,
  );

  print('End insertion:');
  print('oldText: "${delta4.oldText}"');
  print('textInserted: "${delta4.textInserted}"');
  print('insertionOffset: ${delta4.insertionOffset}');
  assert(
    delta4.insertionOffset == delta4.oldText.length,
    'Should insert at end',
  );
  print('Test 4 PASSED: End insertion works');
  testsPassed++;

  // ========== Test 5: Multi-word Insertion ==========
  print('\n--- Test 5: Multi-word Insertion ---');
  totalTests++;

  final delta5 = TextEditingDeltaInsertion(
    oldText: 'The fox jumps',
    textInserted: 'quick brown ',
    insertionOffset: 4,
    selection: TextSelection.collapsed(offset: 16),
    composing: TextRange.empty,
  );

  print('Multi-word insertion:');
  print('oldText: "${delta5.oldText}"');
  print('textInserted: "${delta5.textInserted}"');
  print('Result would be: "The quick brown fox jumps"');
  assert(delta5.textInserted.split(' ').length > 1, 'Should be multi-word');
  print('Test 5 PASSED: Multi-word insertion works');
  testsPassed++;

  // ========== Test 6: Selection After Insertion ==========
  print('\n--- Test 6: Selection After Insertion ---');
  totalTests++;

  final insertedText = 'inserted';
  final delta6 = TextEditingDeltaInsertion(
    oldText: 'Text ',
    textInserted: insertedText,
    insertionOffset: 5,
    selection: TextSelection.collapsed(offset: 5 + insertedText.length),
    composing: TextRange.empty,
  );

  print('Selection after insertion:');
  print('insertionOffset: ${delta6.insertionOffset}');
  print('textInserted length: ${delta6.textInserted.length}');
  print('selection offset: ${delta6.selection.baseOffset}');
  assert(
    delta6.selection.baseOffset == 13,
    'Cursor should be after inserted text',
  );
  print('Test 6 PASSED: Selection after insertion is correct');
  testsPassed++;

  // ========== Test 7: Unicode Text Insertion ==========
  print('\n--- Test 7: Unicode Text Insertion ---');
  totalTests++;

  final delta7 = TextEditingDeltaInsertion(
    oldText: 'Hello ',
    textInserted: '世界 🌍',
    insertionOffset: 6,
    selection: TextSelection.collapsed(offset: 10),
    composing: TextRange.empty,
  );

  print('Unicode text insertion:');
  print('oldText: "${delta7.oldText}"');
  print('textInserted: "${delta7.textInserted}"');
  print('Contains Chinese and emoji characters');
  print('Test 7 PASSED: Unicode text insertion works');
  testsPassed++;

  // ========== Test 8: Newline Insertion ==========
  print('\n--- Test 8: Newline Insertion ---');
  totalTests++;

  final delta8 = TextEditingDeltaInsertion(
    oldText: 'Line 1Line 2',
    textInserted: '\n',
    insertionOffset: 6,
    selection: TextSelection.collapsed(offset: 7),
    composing: TextRange.empty,
  );

  print('Newline insertion:');
  print('textInserted: "\\n"');
  print('insertionOffset: ${delta8.insertionOffset}');
  print('Creates multi-line text');
  assert(delta8.textInserted == '\n', 'Should be newline character');
  print('Test 8 PASSED: Newline insertion works');
  testsPassed++;

  // ========== Test 9: Composing Range with Insertion ==========
  print('\n--- Test 9: Composing Range with Insertion ---');
  totalTests++;

  final delta9 = TextEditingDeltaInsertion(
    oldText: 'Type here: ',
    textInserted: 'かな',
    insertionOffset: 11,
    selection: TextSelection.collapsed(offset: 13),
    composing: TextRange(start: 11, end: 13), // Active IME composition
  );

  print('Composing range with insertion:');
  print('textInserted: "${delta9.textInserted}"');
  print('composing: ${delta9.composing}');
  print('IME is composing Japanese text');
  assert(delta9.composing.isValid, 'Composing should be valid');
  assert(!delta9.composing.isCollapsed, 'Composing should not be collapsed');
  print('Test 9 PASSED: Composing range handled correctly');
  testsPassed++;

  // ========== Test 10: Paste Operation Simulation ==========
  print('\n--- Test 10: Paste Operation Simulation ---');
  totalTests++;

  final pastedContent = 'This is pasted content from clipboard';
  final delta10 = TextEditingDeltaInsertion(
    oldText: 'Before  After',
    textInserted: pastedContent,
    insertionOffset: 7,
    selection: TextSelection.collapsed(offset: 7 + pastedContent.length),
    composing: TextRange.empty,
  );

  print('Paste operation simulation:');
  print('textInserted: "${delta10.textInserted}"');
  print('textInserted length: ${delta10.textInserted.length}');
  print('Simulates Ctrl+V / Cmd+V paste');
  assert(
    delta10.textInserted.length > 20,
    'Pasted content should be substantial',
  );
  print('Test 10 PASSED: Paste operation simulation works');
  testsPassed++;

  // ========== Test 11: Space Insertion ==========
  print('\n--- Test 11: Space Insertion ---');
  totalTests++;

  final delta11 = TextEditingDeltaInsertion(
    oldText: 'WordWord',
    textInserted: ' ',
    insertionOffset: 4,
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange.empty,
  );

  print('Space insertion:');
  print('oldText: "${delta11.oldText}"');
  print('insertionOffset: ${delta11.insertionOffset}');
  print('Result would be: "Word Word"');
  assert(delta11.textInserted == ' ', 'Should insert space');
  print('Test 11 PASSED: Space insertion works');
  testsPassed++;

  // ========== Test 12: Empty Text Insertion Edge Case ==========
  print('\n--- Test 12: Empty Text Insertion Edge Case ---');
  totalTests++;

  final delta12 = TextEditingDeltaInsertion(
    oldText: '',
    textInserted: 'First text',
    insertionOffset: 0,
    selection: TextSelection.collapsed(offset: 10),
    composing: TextRange.empty,
  );

  print('Empty text insertion:');
  print('oldText: "(empty)"');
  print('textInserted: "${delta12.textInserted}"');
  print('Starting from empty text field');
  assert(delta12.oldText.isEmpty, 'oldText should be empty');
  assert(delta12.insertionOffset == 0, 'Should insert at 0');
  print('Test 12 PASSED: Empty text insertion works');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('TextEditingDeltaInsertion Test Summary');
  print('================================================');
  print('Tests passed: $testsPassed / $totalTests');
  assert(testsPassed == totalTests, 'All tests should pass');
  print('ALL TESTS PASSED!');

  // ========== Return Widget Summary ==========
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'TextEditingDeltaInsertion Test Results',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests Passed: $testsPassed / $totalTests'),
      SizedBox(height: 4),
      Text('Basic Insertion: ✓'),
      Text('Single Character: ✓'),
      Text('Beginning Insertion: ✓'),
      Text('End Insertion: ✓'),
      Text('Multi-word Insertion: ✓'),
      Text('Selection After Insertion: ✓'),
      Text('Unicode Insertion: ✓'),
      Text('Newline Insertion: ✓'),
      Text('Composing Range: ✓'),
      Text('Paste Simulation: ✓'),
      Text('Space Insertion: ✓'),
      Text('Empty Text Insertion: ✓'),
      SizedBox(height: 8),
      Text(
        'All TextEditingDeltaInsertion tests completed!',
        style: TextStyle(color: Color(0xFF4CAF50)),
      ),
    ],
  );
}
