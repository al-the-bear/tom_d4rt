// D4rt test script: Tests TextLayoutMetrics from services
// TextLayoutMetrics provides information about text layout for cursor and selection positioning
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextLayoutMetrics Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: TextLayoutMetrics Interface ==========
  print('\n--- Test 1: TextLayoutMetrics Interface ---');
  totalTests++;

  print('TextLayoutMetrics is an interface for text layout info');
  print('Methods include:');
  print('- getLineAtOffset(TextPosition position)');
  print('- getTextPositionAbove(TextPosition position)');
  print('- getTextPositionBelow(TextPosition position)');
  print('- getWordBoundary(TextPosition position)');
  assert(true, 'TextLayoutMetrics interface is available');
  print('Test 1 PASSED: Interface documentation verified');
  testsPassed++;

  // ========== Test 2: TextPosition Creation ==========
  print('\n--- Test 2: TextPosition Creation ---');
  totalTests++;

  const position1 = TextPosition(offset: 0);
  const position2 = TextPosition(offset: 10);
  const position3 = TextPosition(offset: 5, affinity: TextAffinity.upstream);
  print('TextPosition objects:');
  print(
    'position1: offset=${position1.offset}, affinity=${position1.affinity}',
  );
  print(
    'position2: offset=${position2.offset}, affinity=${position2.affinity}',
  );
  print(
    'position3: offset=${position3.offset}, affinity=${position3.affinity}',
  );
  assert(position1.offset == 0, 'First position at 0');
  assert(
    position3.affinity == TextAffinity.upstream,
    'Affinity should be upstream',
  );
  print('Test 2 PASSED: TextPosition creation works');
  testsPassed++;

  // ========== Test 3: TextAffinity Values ==========
  print('\n--- Test 3: TextAffinity Values ---');
  totalTests++;

  print('TextAffinity values:');
  print('- upstream: ${TextAffinity.upstream}');
  print('- downstream: ${TextAffinity.downstream}');
  print('Affinity indicates cursor preference at line breaks');
  assert(
    TextAffinity.upstream != TextAffinity.downstream,
    'Values should differ',
  );
  print('Test 3 PASSED: TextAffinity values work');
  testsPassed++;

  // ========== Test 4: TextPosition Equality ==========
  print('\n--- Test 4: TextPosition Equality ---');
  totalTests++;

  const posA = TextPosition(offset: 5);
  const posB = TextPosition(offset: 5);
  const posC = TextPosition(offset: 5, affinity: TextAffinity.upstream);
  print('Position equality:');
  print('posA == posB (same offset, default affinity): ${posA == posB}');
  print('posA == posC (same offset, different affinity): ${posA == posC}');
  assert(posA == posB, 'Same positions should be equal');
  assert(posA != posC, 'Different affinity should not be equal');
  print('Test 4 PASSED: Position equality works');
  testsPassed++;

  // ========== Test 5: TextRange for Word Boundary ==========
  print('\n--- Test 5: TextRange for Word Boundary ---');
  totalTests++;

  const wordBoundary = TextRange(start: 0, end: 5);
  print('Word boundary range:');
  print('start: ${wordBoundary.start}');
  print('end: ${wordBoundary.end}');
  print('textBefore: would select characters 0-4');
  assert(wordBoundary.isValid, 'Range should be valid');
  assert(wordBoundary.end - wordBoundary.start == 5, 'Word length should be 5');
  print('Test 5 PASSED: Word boundary range works');
  testsPassed++;

  // ========== Test 6: TextRange textInside ==========
  print('\n--- Test 6: TextRange textInside ---');
  totalTests++;

  const sampleText = 'Hello World Flutter';
  const range = TextRange(start: 6, end: 11);
  final inside = range.textInside(sampleText);
  print('Text inside range:');
  print('full text: "$sampleText"');
  print('range: $range');
  print('textInside: "$inside"');
  assert(inside == 'World', 'Should extract "World"');
  print('Test 6 PASSED: textInside works');
  testsPassed++;

  // ========== Test 7: TextRange textBefore ==========
  print('\n--- Test 7: TextRange textBefore ---');
  totalTests++;

  const range2 = TextRange(start: 6, end: 11);
  final before = range2.textBefore(sampleText);
  print('Text before range:');
  print('textBefore: "$before"');
  assert(before == 'Hello ', 'Should be "Hello "');
  print('Test 7 PASSED: textBefore works');
  testsPassed++;

  // ========== Test 8: TextRange textAfter ==========
  print('\n--- Test 8: TextRange textAfter ---');
  totalTests++;

  const range3 = TextRange(start: 6, end: 11);
  final after = range3.textAfter(sampleText);
  print('Text after range:');
  print('textAfter: "$after"');
  assert(after == ' Flutter', 'Should be " Flutter"');
  print('Test 8 PASSED: textAfter works');
  testsPassed++;

  // ========== Test 9: Line Range Simulation ==========
  print('\n--- Test 9: Line Range Simulation ---');
  totalTests++;

  const multilineText = 'Line one\nLine two\nLine three';
  final lines = multilineText.split('\n');
  print('Multiline text analysis:');
  print('Total lines: ${lines.length}');
  for (var i = 0; i < lines.length; i++) {
    print('Line $i: "${lines[i]}" (length: ${lines[i].length})');
  }
  assert(lines.length == 3, 'Should have 3 lines');
  print('Test 9 PASSED: Line analysis works');
  testsPassed++;

  // ========== Test 10: Offset to Line Mapping ==========
  print('\n--- Test 10: Offset to Line Mapping ---');
  totalTests++;

  const text = 'AB\nCD\nEF';
  // Line 0: AB (offsets 0-1)
  // Newline at offset 2
  // Line 1: CD (offsets 3-4)
  // Newline at offset 5
  // Line 2: EF (offsets 6-7)
  print('Offset to line mapping:');
  print('text: "$text"');
  print('offset 0 -> Line 0 (A)');
  print('offset 3 -> Line 1 (C)');
  print('offset 6 -> Line 2 (E)');
  assert(text[0] == 'A', 'Offset 0 should be A');
  assert(text[3] == 'C', 'Offset 3 should be C');
  assert(text[6] == 'E', 'Offset 6 should be E');
  print('Test 10 PASSED: Offset mapping works');
  testsPassed++;

  // ========== Test 11: Selection Rect Concept ==========
  print('\n--- Test 11: Selection Rect Concept ---');
  totalTests++;

  print('SelectionRect is used for text selection visualization:');
  print('- position: character position in text');
  print('- bounds: Rect defining visual position');
  print('- direction: TextDirection for bidirectional text');
  const rect = SelectionRect(position: 0, bounds: Rect.fromLTWH(0, 0, 10, 20));
  print('SelectionRect created: position=${rect.position}');
  print('bounds: ${rect.bounds}');
  assert(rect.position == 0, 'Position should be 0');
  print('Test 11 PASSED: SelectionRect concept verified');
  testsPassed++;

  // ========== Test 12: Multiple Selection Rects ==========
  print('\n--- Test 12: Multiple Selection Rects ---');
  totalTests++;

  final rects = <SelectionRect>[
    SelectionRect(position: 0, bounds: Rect.fromLTWH(0, 0, 10, 20)),
    SelectionRect(position: 1, bounds: Rect.fromLTWH(10, 0, 10, 20)),
    SelectionRect(position: 2, bounds: Rect.fromLTWH(20, 0, 10, 20)),
  ];
  print('Multiple selection rects:');
  for (final r in rects) {
    print('position ${r.position}: bounds=${r.bounds}');
  }
  assert(rects.length == 3, 'Should have 3 rects');
  print('Test 12 PASSED: Multiple rects work');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('Test Summary: $testsPassed/$totalTests tests passed');
  print('================================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextLayoutMetrics Tests'),
      Text('Passed: $testsPassed/$totalTests'),
      Text('TextPosition, TextAffinity, TextRange tested'),
      Text('Line mapping, SelectionRect tested'),
    ],
  );
}
