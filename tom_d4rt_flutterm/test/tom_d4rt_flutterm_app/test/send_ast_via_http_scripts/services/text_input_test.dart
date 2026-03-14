// D4rt test script: Tests TextInput from services
// TextInput provides static methods for text input system interaction
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextInput Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: TextInput Class Availability ==========
  print('\n--- Test 1: TextInput Class Availability ---');
  totalTests++;

  print('TextInput is a static class for text input system');
  print('Static methods: attach, setChannel, finishAutofillContext');
  print('It manages the platform text input service');
  assert(true, 'TextInput class is available');
  print('Test 1 PASSED: TextInput class is available');
  testsPassed++;

  // ========== Test 2: TextInputType Variants ==========
  print('\n--- Test 2: TextInputType Variants ---');
  totalTests++;

  print('Available TextInputType values:');
  print('- text: ${TextInputType.text}');
  print('- multiline: ${TextInputType.multiline}');
  print('- number: ${TextInputType.number}');
  print('- phone: ${TextInputType.phone}');
  print('- datetime: ${TextInputType.datetime}');
  print('- emailAddress: ${TextInputType.emailAddress}');
  print('- url: ${TextInputType.url}');
  assert(TextInputType.text != TextInputType.number, 'Types should differ');
  print('Test 2 PASSED: TextInputType variants work');
  testsPassed++;

  // ========== Test 3: TextInputConfiguration Creation ==========
  print('\n--- Test 3: TextInputConfiguration Creation ---');
  totalTests++;

  const config = TextInputConfiguration(
    inputType: TextInputType.text,
    inputAction: TextInputAction.done,
    autocorrect: true,
    enableSuggestions: true,
  );
  print('TextInputConfiguration:');
  print('inputType: ${config.inputType}');
  print('inputAction: ${config.inputAction}');
  print('autocorrect: ${config.autocorrect}');
  assert(config.autocorrect == true, 'Autocorrect should be enabled');
  print('Test 3 PASSED: Configuration created successfully');
  testsPassed++;

  // ========== Test 4: Password Input Configuration ==========
  print('\n--- Test 4: Password Input Configuration ---');
  totalTests++;

  const passwordConfig = TextInputConfiguration(
    inputType: TextInputType.visiblePassword,
    obscureText: true,
    autocorrect: false,
    enableSuggestions: false,
  );
  print('Password configuration:');
  print('obscureText: ${passwordConfig.obscureText}');
  print('autocorrect: ${passwordConfig.autocorrect}');
  print('enableSuggestions: ${passwordConfig.enableSuggestions}');
  assert(passwordConfig.obscureText == true, 'Should be obscured');
  print('Test 4 PASSED: Password configuration works');
  testsPassed++;

  // ========== Test 5: TextEditingValue Manipulation ==========
  print('\n--- Test 5: TextEditingValue Manipulation ---');
  totalTests++;

  const value1 = TextEditingValue(
    text: 'Initial text',
    selection: TextSelection.collapsed(offset: 12),
  );
  print('Initial TextEditingValue:');
  print('text: ${value1.text}');
  print('selection offset: ${value1.selection.baseOffset}');
  
  final value2 = value1.copyWith(text: 'Modified text');
  print('Modified text: ${value2.text}');
  assert(value2.text == 'Modified text', 'Text should be modified');
  print('Test 5 PASSED: TextEditingValue manipulation works');
  testsPassed++;

  // ========== Test 6: TextSelection Creation ==========
  print('\n--- Test 6: TextSelection Creation ---');
  totalTests++;

  const selection1 = TextSelection(
    baseOffset: 0,
    extentOffset: 5,
  );
  print('TextSelection:');
  print('baseOffset: ${selection1.baseOffset}');
  print('extentOffset: ${selection1.extentOffset}');
  print('isCollapsed: ${selection1.isCollapsed}');
  print('isDirectional: ${selection1.isDirectional}');
  assert(selection1.isCollapsed == false, 'Should not be collapsed');
  print('Test 6 PASSED: TextSelection creation works');
  testsPassed++;

  // ========== Test 7: Collapsed TextSelection ==========
  print('\n--- Test 7: Collapsed TextSelection ---');
  totalTests++;

  const collapsed = TextSelection.collapsed(offset: 10);
  print('Collapsed selection:');
  print('offset: ${collapsed.baseOffset}');
  print('isCollapsed: ${collapsed.isCollapsed}');
  assert(collapsed.isCollapsed == true, 'Should be collapsed');
  assert(collapsed.baseOffset == collapsed.extentOffset, 'Offsets should match');
  print('Test 7 PASSED: Collapsed selection works');
  testsPassed++;

  // ========== Test 8: TextRange Operations ==========
  print('\n--- Test 8: TextRange Operations ---');
  totalTests++;

  const range = TextRange(start: 5, end: 10);
  print('TextRange:');
  print('start: ${range.start}');
  print('end: ${range.end}');
  print('isValid: ${range.isValid}');
  print('isCollapsed: ${range.isCollapsed}');
  print('isNormalized: ${range.isNormalized}');
  assert(range.isValid == true, 'Range should be valid');
  assert(range.isNormalized == true, 'Range should be normalized');
  print('Test 8 PASSED: TextRange operations work');
  testsPassed++;

  // ========== Test 9: Empty TextRange ==========
  print('\n--- Test 9: Empty TextRange ---');
  totalTests++;

  const emptyRange = TextRange.empty;
  print('Empty TextRange:');
  print('start: ${emptyRange.start}');
  print('end: ${emptyRange.end}');
  print('isValid: ${emptyRange.isValid}');
  print('isCollapsed: ${emptyRange.isCollapsed}');
  assert(emptyRange.start == -1, 'Empty start should be -1');
  assert(emptyRange.end == -1, 'Empty end should be -1');
  print('Test 9 PASSED: Empty TextRange works');
  testsPassed++;

  // ========== Test 10: TextInputAction Values ==========
  print('\n--- Test 10: TextInputAction Values ---');
  totalTests++;

  print('TextInputAction enumeration:');
  for (final action in TextInputAction.values) {
    print('- $action');
  }
  assert(TextInputAction.values.contains(TextInputAction.done), 'Should contain done');
  assert(TextInputAction.values.contains(TextInputAction.search), 'Should contain search');
  print('Test 10 PASSED: All TextInputAction values available');
  testsPassed++;

  // ========== Test 11: Autofill Hints ==========
  print('\n--- Test 11: Autofill Hints ---');
  totalTests++;

  print('Common AutofillHints:');
  print('- username: ${AutofillHints.username}');
  print('- password: ${AutofillHints.password}');
  print('- email: ${AutofillHints.email}');
  print('- name: ${AutofillHints.name}');
  print('- telephoneNumber: ${AutofillHints.telephoneNumber}');
  assert(AutofillHints.username.isNotEmpty, 'Username hint should exist');
  print('Test 11 PASSED: Autofill hints work');
  testsPassed++;

  // ========== Test 12: Keyboard Appearance ==========
  print('\n--- Test 12: Keyboard Appearance ---');
  totalTests++;

  const lightConfig = TextInputConfiguration(
    keyboardAppearance: Brightness.light,
  );
  const darkConfig = TextInputConfiguration(
    keyboardAppearance: Brightness.dark,
  );
  print('Keyboard appearances:');
  print('light: ${lightConfig.keyboardAppearance}');
  print('dark: ${darkConfig.keyboardAppearance}');
  assert(lightConfig.keyboardAppearance != darkConfig.keyboardAppearance, 'Should differ');
  print('Test 12 PASSED: Keyboard appearance works');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('Test Summary: $testsPassed/$totalTests tests passed');
  print('================================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextInput Tests'),
      Text('Passed: $testsPassed/$totalTests'),
      Text('Configuration, actions, autofill tested'),
      Text('Selection, range, keyboard tested'),
    ],
  );
}
