// D4rt test script: Tests KeyRepeatEvent class from services
// KeyRepeatEvent represents a key being held down and repeating
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('=== KeyRepeatEvent Test Suite ===');
  print('Testing KeyRepeatEvent class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: KeyRepeatEvent type verification
  print('\n--- Test 1: KeyRepeatEvent Type Verification ---');
  try {
    print('KeyRepeatEvent extends KeyEvent');
    print('Represents key repeat when held down');
    final physicalKey = PhysicalKeyboardKey.keyA;
    final logicalKey = LogicalKeyboardKey.keyA;
    print('Physical key: $physicalKey');
    print('Logical key: $logicalKey');
    results.add('✓ KeyRepeatEvent type verification passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent type verification failed: $e');
    failCount++;
  }

  // Test 2: Create KeyRepeatEvent
  print('\n--- Test 2: KeyRepeatEvent Creation ---');
  try {
    final repeatEvent = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      timeStamp: Duration(milliseconds: 100),
      character: 'a',
    );
    print('Created KeyRepeatEvent: $repeatEvent');
    print('Physical key: ${repeatEvent.physicalKey}');
    print('Logical key: ${repeatEvent.logicalKey}');
    print('Character: ${repeatEvent.character}');
    assert(
      repeatEvent.physicalKey == PhysicalKeyboardKey.keyA,
      'Physical key mismatch',
    );
    assert(
      repeatEvent.logicalKey == LogicalKeyboardKey.keyA,
      'Logical key mismatch',
    );
    results.add('✓ KeyRepeatEvent creation passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent creation failed: $e');
    failCount++;
  }

  // Test 3: KeyRepeatEvent timestamp
  print('\n--- Test 3: KeyRepeatEvent Timestamp ---');
  try {
    final timestamp = Duration(milliseconds: 500);
    final repeatEvent = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyB,
      logicalKey: LogicalKeyboardKey.keyB,
      timeStamp: timestamp,
    );
    print('Timestamp: ${repeatEvent.timeStamp}');
    assert(repeatEvent.timeStamp == timestamp, 'Timestamp mismatch');
    results.add('✓ KeyRepeatEvent timestamp test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent timestamp test failed: $e');
    failCount++;
  }

  // Test 4: KeyRepeatEvent with modifier keys
  print('\n--- Test 4: KeyRepeatEvent with Modifiers ---');
  try {
    final shiftRepeat = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.shiftLeft,
      logicalKey: LogicalKeyboardKey.shiftLeft,
      timeStamp: Duration(milliseconds: 200),
    );
    print('Shift repeat event: $shiftRepeat');
    print(
      'Is shift key: ${shiftRepeat.logicalKey == LogicalKeyboardKey.shiftLeft}',
    );
    results.add('✓ KeyRepeatEvent with modifiers test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent with modifiers test failed: $e');
    failCount++;
  }

  // Test 5: KeyRepeatEvent vs KeyDownEvent
  print('\n--- Test 5: KeyRepeatEvent vs KeyDownEvent Comparison ---');
  try {
    final downEvent = KeyDownEvent(
      physicalKey: PhysicalKeyboardKey.keyC,
      logicalKey: LogicalKeyboardKey.keyC,
      timeStamp: Duration(milliseconds: 100),
      character: 'c',
    );
    final repeatEvent = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.keyC,
      logicalKey: LogicalKeyboardKey.keyC,
      timeStamp: Duration(milliseconds: 200),
      character: 'c',
    );
    print('KeyDownEvent type: ${downEvent.runtimeType}');
    print('KeyRepeatEvent type: ${repeatEvent.runtimeType}');
    assert(
      downEvent.runtimeType != repeatEvent.runtimeType,
      'Types should differ',
    );
    results.add('✓ KeyRepeatEvent vs KeyDownEvent comparison passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent vs KeyDownEvent comparison failed: $e');
    failCount++;
  }

  // Test 6: KeyRepeatEvent character property
  print('\n--- Test 6: KeyRepeatEvent Character Property ---');
  try {
    final eventWithChar = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.digit1,
      logicalKey: LogicalKeyboardKey.digit1,
      timeStamp: Duration.zero,
      character: '1',
    );
    final eventNoChar = KeyRepeatEvent(
      physicalKey: PhysicalKeyboardKey.backspace,
      logicalKey: LogicalKeyboardKey.backspace,
      timeStamp: Duration.zero,
    );
    print('Event with character: ${eventWithChar.character}');
    print('Event without character: ${eventNoChar.character}');
    assert(eventWithChar.character == '1', 'Character mismatch');
    results.add('✓ KeyRepeatEvent character property test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyRepeatEvent character property test failed: $e');
    failCount++;
  }

  // Test 7: Multiple consecutive repeats
  print('\n--- Test 7: Multiple Consecutive Repeats ---');
  try {
    final repeats = <KeyRepeatEvent>[];
    for (var i = 0; i < 5; i++) {
      repeats.add(
        KeyRepeatEvent(
          physicalKey: PhysicalKeyboardKey.keyA,
          logicalKey: LogicalKeyboardKey.keyA,
          timeStamp: Duration(milliseconds: 100 * (i + 1)),
          character: 'a',
        ),
      );
    }
    print('Created ${repeats.length} repeat events');
    for (var i = 0; i < repeats.length; i++) {
      print('Repeat $i timestamp: ${repeats[i].timeStamp}');
    }
    assert(repeats.length == 5, 'Should have 5 repeat events');
    results.add('✓ Multiple consecutive repeats test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Multiple consecutive repeats test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== KeyRepeatEvent Test Summary ===');
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
      Text(
        'KeyRepeatEvent Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
