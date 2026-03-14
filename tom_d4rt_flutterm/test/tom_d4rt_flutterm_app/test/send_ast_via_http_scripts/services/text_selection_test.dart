// D4rt test script: Tests TextSelection from services
// TextSelection represents a range of text selection with base and extent offsets
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextSelection Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: Basic TextSelection ==========
  print('\n--- Test 1: Basic TextSelection ---');
  totalTests++;

  const selection1 = TextSelection(baseOffset: 0, extentOffset: 5);
  print('Basic TextSelection:');
  print('baseOffset: ${selection1.baseOffset}');
  print('extentOffset: ${selection1.extentOffset}');
  print('isCollapsed: ${selection1.isCollapsed}');
  print('isDirectional: ${selection1.isDirectional}');
  assert(selection1.baseOffset == 0, 'Base should be 0');
  assert(selection1.extentOffset == 5, 'Extent should be 5');
  print('Test 1 PASSED: Basic TextSelection works');
  testsPassed++;

  // ========== Test 2: Collapsed Selection (Cursor) ==========
  print('\n--- Test 2: Collapsed Selection (Cursor) ---');
  totalTests++;

  const cursor = TextSelection.collapsed(offset: 10);
  print('Collapsed selection (cursor):');
  print('offset: ${cursor.baseOffset}');
  print('isCollapsed: ${cursor.isCollapsed}');
  print(
    'baseOffset == extentOffset: ${cursor.baseOffset == cursor.extentOffset}',
  );
  assert(cursor.isCollapsed == true, 'Should be collapsed');
  assert(cursor.baseOffset == 10, 'Cursor at position 10');
  print('Test 2 PASSED: Collapsed selection works');
  testsPassed++;

  // ========== Test 3: Selection with Affinity ==========
  print('\n--- Test 3: Selection with Affinity ---');
  totalTests++;

  const selectionUpstream = TextSelection.collapsed(
    offset: 5,
    affinity: TextAffinity.upstream,
  );
  const selectionDownstream = TextSelection.collapsed(
    offset: 5,
    affinity: TextAffinity.downstream,
  );
  print('Selection with affinity:');
  print('upstream: ${selectionUpstream.affinity}');
  print('downstream: ${selectionDownstream.affinity}');
  assert(
    selectionUpstream.affinity == TextAffinity.upstream,
    'Should be upstream',
  );
  assert(
    selectionDownstream.affinity == TextAffinity.downstream,
    'Should be downstream',
  );
  print('Test 3 PASSED: Affinity works');
  testsPassed++;

  // ========== Test 4: Reverse Selection ==========
  print('\n--- Test 4: Reverse Selection ---');
  totalTests++;

  const reverseSelection = TextSelection(baseOffset: 10, extentOffset: 5);
  print('Reverse selection (base > extent):');
  print('baseOffset: ${reverseSelection.baseOffset}');
  print('extentOffset: ${reverseSelection.extentOffset}');
  print('start: ${reverseSelection.start}');
  print('end: ${reverseSelection.end}');
  assert(reverseSelection.start == 5, 'Start should be min');
  assert(reverseSelection.end == 10, 'End should be max');
  print('Test 4 PASSED: Reverse selection works');
  testsPassed++;

  // ========== Test 5: Selection Text Extraction ==========
  print('\n--- Test 5: Selection Text Extraction ---');
  totalTests++;

  const text = 'Hello Flutter World';
  const selection5 = TextSelection(baseOffset: 6, extentOffset: 13);
  final selectedText = text.substring(selection5.start, selection5.end);
  print('Text extraction:');
  print('full text: "$text"');
  print(
    'selection: base=${selection5.baseOffset}, extent=${selection5.extentOffset}',
  );
  print('selected: "$selectedText"');
  assert(selectedText == 'Flutter', 'Should select "Flutter"');
  print('Test 5 PASSED: Text extraction works');
  testsPassed++;

  // ========== Test 6: Selection Equality ==========
  print('\n--- Test 6: Selection Equality ---');
  totalTests++;

  const sel1 = TextSelection(baseOffset: 0, extentOffset: 5);
  const sel2 = TextSelection(baseOffset: 0, extentOffset: 5);
  const sel3 = TextSelection(baseOffset: 0, extentOffset: 10);
  print('Selection equality:');
  print('sel1 == sel2: ${sel1 == sel2}');
  print('sel1 == sel3: ${sel1 == sel3}');
  assert(sel1 == sel2, 'Same selections should be equal');
  assert(sel1 != sel3, 'Different selections should not be equal');
  print('Test 6 PASSED: Equality works');
  testsPassed++;

  // ========== Test 7: Selection copyWith ==========
  print('\n--- Test 7: Selection copyWith ---');
  totalTests++;

  const original = TextSelection(baseOffset: 0, extentOffset: 5);
  final modified = original.copyWith(extentOffset: 10);
  print('copyWith:');
  print(
    'original: base=${original.baseOffset}, extent=${original.extentOffset}',
  );
  print(
    'modified: base=${modified.baseOffset}, extent=${modified.extentOffset}',
  );
  assert(modified.extentOffset == 10, 'Extent should be modified');
  assert(modified.baseOffset == 0, 'Base should remain');
  print('Test 7 PASSED: copyWith works');
  testsPassed++;

  // ========== Test 8: Selection isValid ==========
  print('\n--- Test 8: Selection isValid ---');
  totalTests++;

  const validSel = TextSelection(baseOffset: 0, extentOffset: 5);
  const invalidSel = TextSelection(baseOffset: -1, extentOffset: 5);
  print('Selection validity:');
  print('valid selection (0-5): isValid=${validSel.isValid}');
  print('invalid selection (-1-5): isValid=${invalidSel.isValid}');
  assert(validSel.isValid == true, 'Should be valid');
  assert(invalidSel.isValid == false, 'Should be invalid');
  print('Test 8 PASSED: isValid works');
  testsPassed++;

  // ========== Test 9: Selection isNormalized ==========
  print('\n--- Test 9: Selection isNormalized ---');
  totalTests++;

  const normalizedSel = TextSelection(baseOffset: 0, extentOffset: 5);
  const notNormalizedSel = TextSelection(baseOffset: 5, extentOffset: 0);
  print('Selection normalized:');
  print(
    'normalized (0-5): ${normalizedSel.baseOffset <= normalizedSel.extentOffset}',
  );
  print(
    'not normalized (5-0): ${notNormalizedSel.baseOffset <= notNormalizedSel.extentOffset}',
  );
  assert(
    normalizedSel.baseOffset <= normalizedSel.extentOffset,
    'Is normalized',
  );
  assert(
    notNormalizedSel.baseOffset > notNormalizedSel.extentOffset,
    'Not normalized',
  );
  print('Test 9 PASSED: Normalization check works');
  testsPassed++;

  // ========== Test 10: Selection expandTo ==========
  print('\n--- Test 10: Selection expandTo ---');
  totalTests++;

  const startSel = TextSelection.collapsed(offset: 5);
  final expanded = startSel.expandTo(TextPosition(offset: 10));
  print('expandTo:');
  print('start: ${startSel.baseOffset} (collapsed)');
  print(
    'expanded to 10: base=${expanded.baseOffset}, extent=${expanded.extentOffset}',
  );
  assert(expanded.baseOffset == 5, 'Base should stay');
  assert(expanded.extentOffset == 10, 'Extent should expand to 10');
  print('Test 10 PASSED: expandTo works');
  testsPassed++;

  // ========== Test 11: Selection extendTo ==========
  print('\n--- Test 11: Selection extendTo ---');
  totalTests++;

  const baseSel = TextSelection(baseOffset: 0, extentOffset: 5);
  final extended = baseSel.extendTo(TextPosition(offset: 15));
  print('extendTo:');
  print('original: base=${baseSel.baseOffset}, extent=${baseSel.extentOffset}');
  print(
    'extended: base=${extended.baseOffset}, extent=${extended.extentOffset}',
  );
  assert(extended.extentOffset == 15, 'Extent should extend to 15');
  print('Test 11 PASSED: extendTo works');
  testsPassed++;

  // ========== Test 12: TextRange from Selection ==========
  print('\n--- Test 12: TextRange from Selection ---');
  totalTests++;

  const selection12 = TextSelection(baseOffset: 3, extentOffset: 8);
  final range = TextRange(start: selection12.start, end: selection12.end);
  print('TextRange from selection:');
  print(
    'selection: base=${selection12.baseOffset}, extent=${selection12.extentOffset}',
  );
  print('range: start=${range.start}, end=${range.end}');
  assert(range.start == 3, 'Range start matches selection start');
  assert(range.end == 8, 'Range end matches selection end');
  print('Test 12 PASSED: TextRange conversion works');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('Test Summary: $testsPassed/$totalTests tests passed');
  print('================================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelection Tests'),
      Text('Passed: $testsPassed/$totalTests'),
      Text('base/extent, collapsed, affinity tested'),
      Text('copyWith, expandTo, extendTo tested'),
    ],
  );
}
