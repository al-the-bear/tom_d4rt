// D4rt test script: Tests TextInputType from services
// TextInputType defines the type of keyboard to display for text input
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('================================================');
  print('TextInputType Comprehensive Test Suite');
  print('================================================');

  int testsPassed = 0;
  int totalTests = 0;

  // ========== Test 1: TextInputType.text ==========
  print('\n--- Test 1: TextInputType.text ---');
  totalTests++;

  final textType = TextInputType.text;
  print('TextInputType.text:');
  print('type: $textType');
  print('index: ${textType.index}');
  print('signed: ${textType.signed}');
  print('decimal: ${textType.decimal}');
  assert(textType == TextInputType.text, 'Should be text type');
  print('Test 1 PASSED: TextInputType.text works');
  testsPassed++;

  // ========== Test 2: TextInputType.multiline ==========
  print('\n--- Test 2: TextInputType.multiline ---');
  totalTests++;

  final multilineType = TextInputType.multiline;
  print('TextInputType.multiline:');
  print('type: $multilineType');
  print('index: ${multilineType.index}');
  print('Different from text: ${multilineType != TextInputType.text}');
  assert(multilineType == TextInputType.multiline, 'Should be multiline type');
  print('Test 2 PASSED: TextInputType.multiline works');
  testsPassed++;

  // ========== Test 3: TextInputType.number ==========
  print('\n--- Test 3: TextInputType.number ---');
  totalTests++;

  final numberType = TextInputType.number;
  print('TextInputType.number:');
  print('type: $numberType');
  print('signed: ${numberType.signed}');
  print('decimal: ${numberType.decimal}');
  assert(numberType == TextInputType.number, 'Should be number type');
  print('Test 3 PASSED: TextInputType.number works');
  testsPassed++;

  // ========== Test 4: TextInputType.numberWithOptions ==========
  print('\n--- Test 4: TextInputType.numberWithOptions ---');
  totalTests++;

  final signedNumber = TextInputType.numberWithOptions(signed: true);
  final decimalNumber = TextInputType.numberWithOptions(decimal: true);
  final signedDecimal = TextInputType.numberWithOptions(signed: true, decimal: true);
  print('Number with options:');
  print('signed only: signed=${signedNumber.signed}, decimal=${signedNumber.decimal}');
  print('decimal only: signed=${decimalNumber.signed}, decimal=${decimalNumber.decimal}');
  print('both: signed=${signedDecimal.signed}, decimal=${signedDecimal.decimal}');
  assert(signedNumber.signed == true, 'Should allow signed');
  assert(decimalNumber.decimal == true, 'Should allow decimal');
  print('Test 4 PASSED: TextInputType.numberWithOptions works');
  testsPassed++;

  // ========== Test 5: TextInputType.phone ==========
  print('\n--- Test 5: TextInputType.phone ---');
  totalTests++;

  final phoneType = TextInputType.phone;
  print('TextInputType.phone:');
  print('type: $phoneType');
  print('index: ${phoneType.index}');
  print('Shows phone keyboard on mobile devices');
  assert(phoneType == TextInputType.phone, 'Should be phone type');
  print('Test 5 PASSED: TextInputType.phone works');
  testsPassed++;

  // ========== Test 6: TextInputType.datetime ==========
  print('\n--- Test 6: TextInputType.datetime ---');
  totalTests++;

  final datetimeType = TextInputType.datetime;
  print('TextInputType.datetime:');
  print('type: $datetimeType');
  print('index: ${datetimeType.index}');
  print('Optimized for date/time input');
  assert(datetimeType == TextInputType.datetime, 'Should be datetime type');
  print('Test 6 PASSED: TextInputType.datetime works');
  testsPassed++;

  // ========== Test 7: TextInputType.emailAddress ==========
  print('\n--- Test 7: TextInputType.emailAddress ---');
  totalTests++;

  final emailType = TextInputType.emailAddress;
  print('TextInputType.emailAddress:');
  print('type: $emailType');
  print('index: ${emailType.index}');
  print('Shows @ symbol prominently on keyboard');
  assert(emailType == TextInputType.emailAddress, 'Should be email type');
  print('Test 7 PASSED: TextInputType.emailAddress works');
  testsPassed++;

  // ========== Test 8: TextInputType.url ==========
  print('\n--- Test 8: TextInputType.url ---');
  totalTests++;

  final urlType = TextInputType.url;
  print('TextInputType.url:');
  print('type: $urlType');
  print('index: ${urlType.index}');
  print('Shows .com and / prominently on keyboard');
  assert(urlType == TextInputType.url, 'Should be URL type');
  print('Test 8 PASSED: TextInputType.url works');
  testsPassed++;

  // ========== Test 9: TextInputType.visiblePassword ==========
  print('\n--- Test 9: TextInputType.visiblePassword ---');
  totalTests++;

  final passwordType = TextInputType.visiblePassword;
  print('TextInputType.visiblePassword:');
  print('type: $passwordType');
  print('index: ${passwordType.index}');
  print('Used with obscureText for password fields');
  assert(passwordType == TextInputType.visiblePassword, 'Should be visiblePassword type');
  print('Test 9 PASSED: TextInputType.visiblePassword works');
  testsPassed++;

  // ========== Test 10: TextInputType.name ==========
  print('\n--- Test 10: TextInputType.name ---');
  totalTests++;

  final nameType = TextInputType.name;
  print('TextInputType.name:');
  print('type: $nameType');
  print('index: ${nameType.index}');
  print('Optimized for name input with capitalization');
  assert(nameType == TextInputType.name, 'Should be name type');
  print('Test 10 PASSED: TextInputType.name works');
  testsPassed++;

  // ========== Test 11: TextInputType.streetAddress ==========
  print('\n--- Test 11: TextInputType.streetAddress ---');
  totalTests++;

  final addressType = TextInputType.streetAddress;
  print('TextInputType.streetAddress:');
  print('type: $addressType');
  print('index: ${addressType.index}');
  print('Optimized for address input');
  assert(addressType == TextInputType.streetAddress, 'Should be streetAddress type');
  print('Test 11 PASSED: TextInputType.streetAddress works');
  testsPassed++;

  // ========== Test 12: TextInputType Equality ==========
  print('\n--- Test 12: TextInputType Equality ---');
  totalTests++;

  print('Equality checks:');
  print('text == text: ${TextInputType.text == TextInputType.text}');
  print('text != number: ${TextInputType.text != TextInputType.number}');
  print('email != url: ${TextInputType.emailAddress != TextInputType.url}');
  assert(TextInputType.text == TextInputType.text, 'Same types should be equal');
  assert(TextInputType.text != TextInputType.number, 'Different types should not be equal');
  print('Test 12 PASSED: Equality checks work');
  testsPassed++;

  // ========== Test 13: Configuration with Different Types ==========
  print('\n--- Test 13: Configuration with Different Types ---');
  totalTests++;

  final configs = [
    TextInputConfiguration(inputType: TextInputType.text),
    TextInputConfiguration(inputType: TextInputType.number),
    TextInputConfiguration(inputType: TextInputType.email),
    TextInputConfiguration(inputType: TextInputType.phone),
  ];
  print('Configurations with different types:');
  for (final config in configs) {
    print('- ${config.inputType}');
  }
  assert(configs.length == 4, 'Should have 4 configs');
  print('Test 13 PASSED: Configurations with types work');
  testsPassed++;

  // ========== Summary ==========
  print('\n================================================');
  print('Test Summary: $testsPassed/$totalTests tests passed');
  print('================================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextInputType Tests'),
      Text('Passed: $testsPassed/$totalTests'),
      Text('text, multiline, number, phone tested'),
      Text('email, url, password, name tested'),
    ],
  );
}
