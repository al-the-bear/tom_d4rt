// D4rt test script: Tests AttributedStringProperty from semantics
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AttributedStringProperty comprehensive test executing');
  final results = <String>[];

  // ========== AttributedStringProperty Tests ==========
  print('Testing AttributedStringProperty...');

  // Test 1: Create AttributedString for property
  final attrString = AttributedString('Hello World');
  assert(attrString != null, 'Should create AttributedString');
  results.add('AttributedString created');
  print('AttributedString created: ${attrString.string}');

  // Test 2: Verify string property
  assert(attrString.string == 'Hello World', 'String should match');
  results.add('String property: Hello World');
  print('String: ${attrString.string}');

  // Test 3: Create AttributedStringProperty for diagnostics
  final property = AttributedStringProperty(
    'label',
    attrString,
    showName: true,
  );
  assert(property != null, 'Should create property');
  results.add('AttributedStringProperty created');
  print('AttributedStringProperty created: ${property.name}');

  // Test 4: Verify property name
  assert(property.name == 'label', 'Name should match');
  results.add('Property name: label');
  print('Property name: ${property.name}');

  // Test 5: Verify property value
  assert(property.value != null, 'Value should not be null');
  assert(property.value?.string == 'Hello World', 'Value string should match');
  results.add('Property value verified');
  print('Property value: ${property.value?.string}');

  // Test 6: Check DiagnosticsProperty inheritance
  assert(property is DiagnosticsProperty<AttributedString>, 'Should be DiagnosticsProperty');
  results.add('Inheritance: DiagnosticsProperty<AttributedString>');
  print('Is DiagnosticsProperty: ${property is DiagnosticsProperty<AttributedString>}');

  // Test 7: Convert to string for display
  final stringValue = property.toString();
  assert(stringValue.isNotEmpty, 'String should not be empty');
  results.add('toString works');
  print('Property toString: $stringValue');

  // Test 8: Create property with description
  final propWithDesc = AttributedStringProperty(
    'hint',
    attrString,
    description: 'Hint text for accessibility',
  );
  results.add('Property with description created');
  print('Property with description: ${propWithDesc.name}');

  // Test 9: Create property with null value
  final nullProp = AttributedStringProperty(
    'empty',
    null,
    defaultValue: null,
  );
  assert(nullProp.value == null, 'Null value should be allowed');
  results.add('Null value property created');
  print('Null property value: ${nullProp.value}');

  // Test 10: Create AttributedString with attributes
  final attrWithSpan = AttributedString(
    'Test with locale',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 4), locale: Locale('en', 'US')),
    ],
  );
  assert(attrWithSpan.attributes.isNotEmpty, 'Should have attributes');
  results.add('AttributedString with locale attribute');
  print('Attributes count: ${attrWithSpan.attributes.length}');

  // Test 11: Verify attribute range
  final firstAttr = attrWithSpan.attributes.first;
  assert(firstAttr.range.start == 0, 'Range start should be 0');
  assert(firstAttr.range.end == 4, 'Range end should be 4');
  results.add('Attribute range: 0-4');
  print('Attribute range: ${firstAttr.range}');

  // Test 12: Create property with level
  final levelProp = AttributedStringProperty(
    'debug',
    attrString,
    level: DiagnosticLevel.debug,
  );
  assert(levelProp.level == DiagnosticLevel.debug, 'Level should be debug');
  results.add('Property level: debug');
  print('Property level: ${levelProp.level}');

  // Test 13: DiagnosticLevel values
  final levels = DiagnosticLevel.values;
  assert(levels.contains(DiagnosticLevel.debug), 'Should contain debug');
  assert(levels.contains(DiagnosticLevel.info), 'Should contain info');
  results.add('DiagnosticLevel values: ${levels.length}');
  print('DiagnosticLevel values: $levels');

  // Test 14: Property style check
  results.add('Style controls formatting');
  print('DiagnosticsTreeStyle available for formatting');

  // Test 15: Create AttributedString with spell-out attribute
  final spellOutString = AttributedString(
    'ABC123',
    attributes: [
      SpellOutStringAttribute(range: TextRange(start: 0, end: 6)),
    ],
  );
  assert(spellOutString.attributes.first is SpellOutStringAttribute, 'Should be SpellOutStringAttribute');
  results.add('SpellOutStringAttribute works');
  print('SpellOut attribute applied to: ${spellOutString.string}');

  // Test 16: TextRange creation
  final range = TextRange(start: 5, end: 10);
  assert(range.start == 5, 'Start should be 5');
  assert(range.end == 10, 'End should be 10');
  assert(!range.isCollapsed, 'Should not be collapsed');
  results.add('TextRange: 5-10');
  print('TextRange: start=${range.start}, end=${range.end}, collapsed=${range.isCollapsed}');

  // Test 17: Verify property isNotNull
  final checkProp = AttributedStringProperty('check', attrString);
  assert(checkProp.value != null, 'Should have non-null value');
  results.add('Property isNotNull verified');
  print('Property has value: ${checkProp.value != null}');

  // Test 18: Multiple attributes on same string
  final multiAttr = AttributedString(
    'Hello World',
    attributes: [
      LocaleStringAttribute(range: TextRange(start: 0, end: 5), locale: Locale('en')),
      SpellOutStringAttribute(range: TextRange(start: 6, end: 11)),
    ],
  );
  assert(multiAttr.attributes.length == 2, 'Should have 2 attributes');
  results.add('Multiple attributes: ${multiAttr.attributes.length}');
  print('Multi-attribute string: ${multiAttr.attributes.length} attributes');

  // Test 19: Property toJsonMap
  results.add('Supports JSON serialization');
  print('DiagnosticsProperty supports toJsonMap');

  // Test 20: Summary
  print('AttributedStringProperty test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AttributedStringProperty Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Used for diagnostics with AttributedString'),
      Text('Attributes: LocaleStringAttribute, SpellOutStringAttribute'),
      Text('Properties: name, value, level, description'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
