// D4rt test script: Tests RawKeyUpEvent from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyUpEvent test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyUpEvent with web data
  print('\n--- Test 1: Create RawKeyUpEvent with web data ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyUpEvent(data: data);
    assert(event is RawKeyUpEvent);
    assert(event.data == data);
    print('Created RawKeyUpEvent successfully');
    print('Event type: ${event.runtimeType}');
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
    final event = RawKeyUpEvent(data: data);
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
    final event = RawKeyUpEvent(data: data);
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

  // Test 4: Test modifier keys with up event
  print('\n--- Test 4: Test modifier keys with up event ---');
  try {
    final dataWithModifiers = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'A',
      location: 0,
      metaState: 3,
      keyCode: 65,
    );
    final event = RawKeyUpEvent(data: dataWithModifiers);
    print('isShiftPressed: ${event.isShiftPressed}');
    print('isControlPressed: ${event.isControlPressed}');
    print('isAltPressed: ${event.isAltPressed}');
    print('isMetaPressed: ${event.isMetaPressed}');
    results.add('Test 4 PASSED: Modifier keys detection');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test repeat property (should be false for up events)
  print('\n--- Test 5: Test repeat property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyUpEvent(data: data);
    print('Is repeat: ${event.repeat}');
    results.add('Test 5 PASSED: Repeat property');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Create key up events for multiple keys
  print('\n--- Test 6: Create key up events for multiple keys ---');
  try {
    final keys = ['KeyA', 'KeyB', 'KeyC', 'Enter', 'Space', 'Escape'];
    for (final code in keys) {
      final data = RawKeyEventDataWeb(
        code: code,
        key: code.toLowerCase(),
        location: 0,
        metaState: 0,
        keyCode: 0,
      );
      final event = RawKeyUpEvent(data: data);
      print('Created key up event for: $code');
      assert(event is RawKeyUpEvent);
    }
    results.add('Test 6 PASSED: Multiple key up events');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Verify event inheritance
  print('\n--- Test 7: Verify event inheritance ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final event = RawKeyUpEvent(data: data);
    assert(event is RawKeyEvent);
    print('RawKeyUpEvent inherits from RawKeyEvent: true');
    print('Event class hierarchy verified');
    results.add('Test 7 PASSED: Inheritance verification');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Simulate down/up event pair
  print('\n--- Test 8: Simulate down/up event pair ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    final downEvent = RawKeyDownEvent(data: data);
    final upEvent = RawKeyUpEvent(data: data);
    assert(downEvent is RawKeyDownEvent);
    assert(upEvent is RawKeyUpEvent);
    print('Down event: ${downEvent.runtimeType}');
    print('Up event: ${upEvent.runtimeType}');
    print('Both share same data reference: ${downEvent.data == upEvent.data}');
    results.add('Test 8 PASSED: Down/up event pair');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyUpEvent test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawKeyUpEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        'Passed: $testsPassed, Failed: $testsFailed',
        style: TextStyle(
          color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000),
        ),
      ),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
