// D4rt test script: Tests InlineSpanSemanticsInformation from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InlineSpanSemanticsInformation test executing');
  final results = <String>[];

  // ========== InlineSpanSemanticsInformation Tests ==========
  print('Testing InlineSpanSemanticsInformation...');

  // Test 1: Create basic InlineSpanSemanticsInformation
  final info1 = InlineSpanSemanticsInformation('Hello World');
  assert(info1.text == 'Hello World', 'Text should match');
  results.add('InlineSpanSemanticsInformation text: ${info1.text}');
  print('InlineSpanSemanticsInformation created: ${info1.text}');

  // Test 2: InlineSpanSemanticsInformation with semanticsLabel
  final info2 = InlineSpanSemanticsInformation(
    'Icon',
    semanticsLabel: 'Star icon',
  );
  assert(info2.semanticsLabel == 'Star icon', 'Semantics label should match');
  results.add('InlineSpanSemanticsInformation label: ${info2.semanticsLabel}');
  print(
    'InlineSpanSemanticsInformation semanticsLabel: ${info2.semanticsLabel}',
  );

  // Test 3: InlineSpanSemanticsInformation isPlaceholder false
  final info3 = InlineSpanSemanticsInformation('Regular text');
  assert(info3.isPlaceholder == false, 'isPlaceholder should be false');
  results.add(
    'InlineSpanSemanticsInformation isPlaceholder: ${info3.isPlaceholder}',
  );
  print('InlineSpanSemanticsInformation isPlaceholder: ${info3.isPlaceholder}');

  // Test 4: InlineSpanSemanticsInformation placeholder
  final info4 = InlineSpanSemanticsInformation.placeholder;
  assert(info4.isPlaceholder == true, 'Placeholder should be true');
  results.add(
    'InlineSpanSemanticsInformation placeholder: ${info4.isPlaceholder}',
  );
  print('InlineSpanSemanticsInformation placeholder verified');

  // Test 5: InlineSpanSemanticsInformation requiresOwnNode
  final info5 = InlineSpanSemanticsInformation(
    'Link text',
    isPlaceholder: false,
    requiresOwnNode: true,
  );
  assert(info5.requiresOwnNode == true, 'requiresOwnNode should be true');
  results.add(
    'InlineSpanSemanticsInformation requiresOwnNode: ${info5.requiresOwnNode}',
  );
  print(
    'InlineSpanSemanticsInformation requiresOwnNode: ${info5.requiresOwnNode}',
  );

  // Test 6: InlineSpanSemanticsInformation with all parameters
  final info6 = InlineSpanSemanticsInformation(
    'Complex text',
    semanticsLabel: 'Descriptive label',
    isPlaceholder: false,
    requiresOwnNode: false,
  );
  assert(info6.text == 'Complex text', 'Text should match');
  assert(info6.semanticsLabel == 'Descriptive label', 'Label should match');
  results.add('InlineSpanSemanticsInformation full: text=${info6.text}');
  print('InlineSpanSemanticsInformation with all params verified');

  // Test 7: InlineSpanSemanticsInformation text length
  final info7 = InlineSpanSemanticsInformation('Short');
  assert(info7.text.length == 5, 'Text length should be 5');
  results.add('InlineSpanSemanticsInformation length: ${info7.text.length}');
  print('InlineSpanSemanticsInformation text length: ${info7.text.length}');

  // Test 8: InlineSpanSemanticsInformation empty text
  final info8 = InlineSpanSemanticsInformation('');
  assert(info8.text.isEmpty, 'Text should be empty');
  results.add('InlineSpanSemanticsInformation empty: ${info8.text.isEmpty}');
  print('InlineSpanSemanticsInformation empty text verified');

  // Test 9: InlineSpanSemanticsInformation with unicode
  final info9 = InlineSpanSemanticsInformation('Hello 🌍');
  assert(info9.text.contains('🌍'), 'Should contain unicode');
  results.add('InlineSpanSemanticsInformation unicode: ${info9.text}');
  print('InlineSpanSemanticsInformation unicode: ${info9.text}');

  // Test 10: InlineSpanSemanticsInformation only label
  final info10 = InlineSpanSemanticsInformation(
    '',
    semanticsLabel: 'Only label provided',
  );
  assert(info10.semanticsLabel == 'Only label provided', 'Label should match');
  results.add(
    'InlineSpanSemanticsInformation label only: ${info10.semanticsLabel}',
  );
  print('InlineSpanSemanticsInformation label only verified');

  // Test 11: InlineSpanSemanticsInformation toString
  final info11 = InlineSpanSemanticsInformation('Test');
  final str = info11.toString();
  assert(str.isNotEmpty, 'toString should not be empty');
  results.add('InlineSpanSemanticsInformation toString: ${str.length} chars');
  print('InlineSpanSemanticsInformation toString length: ${str.length}');

  // Test 12: InlineSpanSemanticsInformation equality
  final infoA = InlineSpanSemanticsInformation('Same');
  final infoB = InlineSpanSemanticsInformation('Same');
  assert(infoA == infoB, 'Same info should be equal');
  results.add('InlineSpanSemanticsInformation equality: ${infoA == infoB}');
  print('InlineSpanSemanticsInformation equality verified');

  // Test 13: InlineSpanSemanticsInformation hashCode
  final hash1 = infoA.hashCode;
  final hash2 = infoB.hashCode;
  assert(hash1 == hash2, 'Equal objects should have same hash');
  results.add('InlineSpanSemanticsInformation hashCode: $hash1');
  print('InlineSpanSemanticsInformation hashCode: $hash1');

  print(
    'InlineSpanSemanticsInformation test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InlineSpanSemanticsInformation Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
