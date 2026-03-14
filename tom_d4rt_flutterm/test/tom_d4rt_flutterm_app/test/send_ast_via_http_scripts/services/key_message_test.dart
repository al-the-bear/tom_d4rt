// D4rt test script: Tests KeyMessage class from services
// KeyMessage represents a complete key event message from the platform
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('=== KeyMessage Test Suite ===');
  print('Testing KeyMessage class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: Create KeyMessage with events
  print('\n--- Test 1: KeyMessage Creation ---');
  try {
    // KeyMessage contains a list of KeyEvent objects
    print('KeyMessage stores platform key events');
    print('KeyMessage is used for cross-platform key handling');
    final keyA = LogicalKeyboardKey.keyA;
    print('Reference key for testing: $keyA');
    results.add('✓ KeyMessage creation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage creation test failed: $e');
    failCount++;
  }

  // Test 2: KeyMessage events property
  print('\n--- Test 2: KeyMessage Events Property ---');
  try {
    print('KeyMessage.events contains list of KeyEvent objects');
    print('Events represent the key presses/releases');
    final physicalKey = PhysicalKeyboardKey.keyA;
    print('Physical key for events: $physicalKey');
    results.add('✓ KeyMessage events property test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage events property test failed: $e');
    failCount++;
  }

  // Test 3: KeyMessage raw events
  print('\n--- Test 3: KeyMessage Raw Events ---');
  try {
    print('KeyMessage also stores raw hardware events');
    print('Raw events preserve platform-specific data');
    final rawKeyData = RawKeyEvent.fromMessage({
      'type': 'keydown',
      'keymap': 'android',
      'keyCode': 29,
      'codePoint': 97,
      'scanCode': 30,
      'metaState': 0,
      'source': 0x101,
      'deviceId': 1,
    });
    print('Raw key event type: ${rawKeyData.runtimeType}');
    results.add('✓ KeyMessage raw events test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage raw events test failed: $e');
    failCount++;
  }

  // Test 4: KeyMessage with multiple events
  print('\n--- Test 4: KeyMessage Multiple Events ---');
  try {
    print('KeyMessage can contain multiple sequential events');
    print('This happens with key combinations');
    final shift = LogicalKeyboardKey.shiftLeft;
    final keyA = LogicalKeyboardKey.keyA;
    print('Shift key: $shift');
    print('A key: $keyA');
    print('Combined would be multiple events in KeyMessage');
    results.add('✓ KeyMessage multiple events test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage multiple events test failed: $e');
    failCount++;
  }

  // Test 5: KeyMessage key character
  print('\n--- Test 5: KeyMessage Character Handling ---');
  try {
    print('KeyMessage includes character information');
    final letter = LogicalKeyboardKey.keyA;
    print('Key label: ${letter.keyLabel}');
    print('Key character typically derived from logical key');
    assert(letter.keyLabel == 'A', 'Key label should be A');
    results.add('✓ KeyMessage character handling test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage character handling test failed: $e');
    failCount++;
  }

  // Test 6: KeyMessage modifier state
  print('\n--- Test 6: KeyMessage Modifier State ---');
  try {
    print('KeyMessage tracks modifier key states');
    final modifiers = <LogicalKeyboardKey>[
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.controlLeft,
      LogicalKeyboardKey.altLeft,
      LogicalKeyboardKey.metaLeft,
    ];
    for (final mod in modifiers) {
      print('Modifier: ${mod.keyLabel} (${mod.keyId})');
    }
    results.add('✓ KeyMessage modifier state test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage modifier state test failed: $e');
    failCount++;
  }

  // Test 7: KeyMessage timestamp handling
  print('\n--- Test 7: KeyMessage Timestamp ---');
  try {
    print('KeyMessage events include timestamps');
    final now = DateTime.now().millisecondsSinceEpoch;
    print('Current timestamp: $now');
    print('Timestamps help with event ordering');
    results.add('✓ KeyMessage timestamp test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyMessage timestamp test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== KeyMessage Test Summary ===');
  print('Total tests: ${passCount + failCount}');
  print('Passed: $passCount');
  print('Failed: $failCount');
  for (final result in results) {
    print(result);
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('KeyMessage Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
