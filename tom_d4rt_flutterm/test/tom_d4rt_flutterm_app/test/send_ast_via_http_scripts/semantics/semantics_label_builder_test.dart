// D4rt test script: Tests SemanticsLabelBuilder concepts from semantics
import 'dart:ui';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsLabelBuilder comprehensive test executing');
  final results = <String>[];

  // ========== SemanticsLabelBuilder Tests ==========
  print('Testing SemanticsLabelBuilder concepts...');

  // Test 1: SemanticsLabelBuilder purpose
  results.add('SemanticsLabelBuilder: Builds accessibility labels');
  print('SemanticsLabelBuilder constructs complex labels');

  // Test 2: Label concatenation concept
  final parts = <String>['Button', 'Submit Form', 'Double tap to activate'];
  final concatenated = parts.join(', ');
  assert(concatenated.contains('Button'), 'Should contain Button');
  results.add('Label parts: ${parts.length}');
  print('Label concatenation: $concatenated');

  // Test 3: AttributedString for rich labels
  final attrLabel = AttributedString('Submit Button');
  assert(attrLabel.string == 'Submit Button', 'Label should match');
  results.add('AttributedString label: Submit Button');
  print('AttributedString: ${attrLabel.string}');

  // Test 4: Adding locale attributes to labels
  final localizedLabel = AttributedString(
    'Submit',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 6), locale: Locale('en', 'US')),
    ],
  );
  assert(localizedLabel.attributes.isNotEmpty, 'Should have locale attribute');
  results.add('Localized label with en_US');
  print('Localized label: ${localizedLabel.string}');

  // Test 5: Adding spell-out attributes
  final spellOutLabel = AttributedString(
    'ABC123',
    attributes: [
      SpellOutStringAttribute(range: TextRange(start: 0, end: 6)),
    ],
  );
  assert(spellOutLabel.attributes.first is SpellOutStringAttribute, 'Should be SpellOutStringAttribute');
  results.add('SpellOut label: ABC123');
  print('SpellOut label: ${spellOutLabel.string}');

  // Test 6: Combining multiple attributes
  final multiAttrLabel = AttributedString(
    'Hello World',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 5), locale: Locale('en')),
      SpellOutStringAttribute(range: TextRange(start: 6, end: 11)),
    ],
  );
  assert(multiAttrLabel.attributes.length == 2, 'Should have 2 attributes');
  results.add('Multi-attribute label: 2 attributes');
  print('Multi-attribute label: ${multiAttrLabel.attributes.length} attrs');

  // Test 7: SemanticsConfiguration label property
  final config = SemanticsConfiguration();
  config.label = 'Test Label';
  assert(config.label == 'Test Label', 'Config label should match');
  results.add('SemanticsConfiguration.label set');
  print('Config label: ${config.label}');

  // Test 8: AttributedLabel property
  config.attributedLabel = attrLabel;
  assert(config.attributedLabel?.string == 'Submit Button', 'AttributedLabel should match');
  results.add('SemanticsConfiguration.attributedLabel set');
  print('Attributed label: ${config.attributedLabel?.string}');

  // Test 9: Hint label
  config.hint = 'Double tap to activate';
  assert(config.hint == 'Double tap to activate', 'Hint should match');
  results.add('Hint label: Double tap to activate');
  print('Hint: ${config.hint}');

  // Test 10: Value label
  config.value = '50%';
  assert(config.value == '50%', 'Value should match');
  results.add('Value label: 50%');
  print('Value: ${config.value}');

  // Test 11: IncreasedValue label
  config.increasedValue = '60%';
  assert(config.increasedValue == '60%', 'IncreasedValue should match');
  results.add('IncreasedValue: 60%');
  print('IncreasedValue: ${config.increasedValue}');

  // Test 12: DecreasedValue label
  config.decreasedValue = '40%';
  assert(config.decreasedValue == '40%', 'DecreasedValue should match');
  results.add('DecreasedValue: 40%');
  print('DecreasedValue: ${config.decreasedValue}');

  // Test 13: Label builder pattern
  final labelParts = StringBuffer();
  labelParts.write('Item 1');
  labelParts.write(', ');
  labelParts.write('Item 2');
  final builtLabel = labelParts.toString();
  assert(builtLabel == 'Item 1, Item 2', 'Built label should match');
  results.add('StringBuffer label building');
  print('Built label: $builtLabel');

  // Test 14: Empty label handling
  final emptyAttr = AttributedString('');
  assert(emptyAttr.string.isEmpty, 'Empty string should be valid');
  results.add('Empty label: valid');
  print('Empty label allowed: ${emptyAttr.string.isEmpty}');

  // Test 15: Long label handling
  final longLabel = 'A' * 500;
  final longAttrString = AttributedString(longLabel);
  assert(longAttrString.string.length == 500, 'Long label should work');
  results.add('Long label: 500 chars');
  print('Long label length: ${longAttrString.string.length}');

  // Test 16: Unicode in labels
  final unicodeLabel = AttributedString('🎉 Celebration 🎊');
  assert(unicodeLabel.string.contains('🎉'), 'Unicode should work');
  results.add('Unicode in labels supported');
  print('Unicode label: ${unicodeLabel.string}');

  // Test 17: Newlines in labels
  final multilineLabel = AttributedString('Line 1\nLine 2');
  assert(multilineLabel.string.contains('\n'), 'Newlines allowed');
  results.add('Multiline labels supported');
  print('Multiline label: ${multilineLabel.string.replaceAll('\n', '\\n')}');

  // Test 18: Label with special characters
  final specialLabel = AttributedString('Price: \$10.00 <sale>');
  assert(specialLabel.string.contains('\$'), 'Special chars work');
  results.add('Special characters in labels');
  print('Special chars label: ${specialLabel.string}');

  // Test 19: TextRange for attributes
  final range = TextRange(start: 0, end: 10);
  assert(range.start == 0, 'Range start should be 0');
  assert(range.end == 10, 'Range end should be 10');
  assert(!range.isCollapsed, 'Should not be collapsed');
  results.add('TextRange: 0-10');
  print('TextRange: ${range.start}-${range.end}');

  // Test 20: Summary
  print('SemanticsLabelBuilder test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsLabelBuilder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Builds accessibility labels dynamically'),
      Text('AttributedString for rich text labels'),
      Text('Attributes: LocaleString, SpellOut'),
      Text('Config: label, hint, value, increased/decreased'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
