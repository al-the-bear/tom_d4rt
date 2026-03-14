// D4rt test script: Tests RawKeyDownEvent from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyDownEvent test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyDownEvent with web data
  print('\n--- Test 1: Create RawKeyDownEvent with web data ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    assert(event is RawKeyDownEvent);
    assert(event.data == data);
    print('Created RawKeyDownEvent successfully');
    print('Event type: ${event.runtimeType}');
    print('Is key down: true (by type)');
    results.add('Test 1 PASSED: Create with web data');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Verify logical key from event
  print('\n--- Test 2: Verify logical key from event ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    final logicalKey = event.logicalKey;
    print('Logical key: ${logicalKey.debugName}');
    print('Key ID: ${logicalKey.keyId}');
    results.add('Test 2 PASSED: Logical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Verify physical key from event
  print('\n--- Test 3: Verify physical key from event ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    final physicalKey = event.physicalKey;
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 3 PASSED: Physical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Check character property
  print('\n--- Test 4: Check character property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data, character: 'a');
    print('Character: ${event.character}');
    print('Has character: ${event.character != null}');
    results.add('Test 4 PASSED: Character property check');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test repeat property
  print('\n--- Test 5: Test repeat property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    print('Is repeat: ${event.repeat}');
    results.add('Test 5 PASSED: Repeat property check');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test modifier keys detection
  print('\n--- Test 6: Test modifier keys detection ---');
  try {
    final dataWithShift = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'A',
      location: 0,
      metaState: 1,
      keyCode: 65,
    );
    final event = RawKeyDownEvent(data: dataWithShift);
    print('Is shift pressed: ${event.isShiftPressed}');
    print('Is control pressed: ${event.isControlPressed}');
    print('Is alt pressed: ${event.isAltPressed}');
    print('Is meta pressed: ${event.isMetaPressed}');
    results.add('Test 6 PASSED: Modifier keys detection');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Multiple key down events
  print('\n--- Test 7: Multiple key down events ---');
  try {
    final keys = ['KeyA', 'KeyB', 'KeyC', 'Enter', 'Space'];
    for (final code in keys) {
      final data = RawKeyEventDataWeb(
        code: code,
        key: code.toLowerCase(),
        location: 0,
        metaState: 0,
        keyCode: 0,
      );
      final event = RawKeyDownEvent(data: data);
      print('Created key down event for: $code');
      assert(event is RawKeyDownEvent);
    }
    results.add('Test 7 PASSED: Multiple key down events');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Verify event inheritance
  print('\n--- Test 8: Verify event inheritance ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    assert(event is RawKeyEvent);
    print('RawKeyDownEvent inherits from RawKeyEvent: true');
    print('Event class hierarchy verified');
    results.add('Test 8 PASSED: Inheritance verification');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyDownEvent test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RawKeyDownEvent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
