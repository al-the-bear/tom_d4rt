// D4rt test script: Tests RawKeyEvent base class from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEvent test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEvent via RawKeyDownEvent
  print('\n--- Test 1: Create RawKeyEvent via RawKeyDownEvent ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    assert(event is RawKeyEvent);
    print('RawKeyDownEvent is RawKeyEvent: true');
    print('Event type: ${event.runtimeType}');
    results.add('Test 1 PASSED: RawKeyDownEvent creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Create RawKeyEvent via RawKeyUpEvent
  print('\n--- Test 2: Create RawKeyEvent via RawKeyUpEvent ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final event = RawKeyUpEvent(data: data);
    assert(event is RawKeyEvent);
    print('RawKeyUpEvent is RawKeyEvent: true');
    print('Event type: ${event.runtimeType}');
    results.add('Test 2 PASSED: RawKeyUpEvent creation');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test data property access
  print('\n--- Test 3: Test data property access ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    assert(event.data == data);
    print('Data property accessible: true');
    print('Data type: ${event.data.runtimeType}');
    results.add('Test 3 PASSED: Data property access');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test logicalKey property
  print('\n--- Test 4: Test logicalKey property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    final logicalKey = event.logicalKey;
    print('Logical key: ${logicalKey.debugName}');
    print('Key ID: ${logicalKey.keyId}');
    results.add('Test 4 PASSED: LogicalKey property');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test physicalKey property
  print('\n--- Test 5: Test physicalKey property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    final physicalKey = event.physicalKey;
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 5 PASSED: PhysicalKey property');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test character property
  print('\n--- Test 6: Test character property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final eventWithChar = RawKeyDownEvent(data: data, character: 'a');
    final eventNoChar = RawKeyDownEvent(data: data);
    print('Event with character: "${eventWithChar.character}"');
    print('Event without character: "${eventNoChar.character}"');
    results.add('Test 6 PASSED: Character property');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test modifier key properties
  print('\n--- Test 7: Test modifier key properties ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'A', location: 0, metaState: 3, keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    print('isShiftPressed: ${event.isShiftPressed}');
    print('isControlPressed: ${event.isControlPressed}');
    print('isAltPressed: ${event.isAltPressed}');
    print('isMetaPressed: ${event.isMetaPressed}');
    results.add('Test 7 PASSED: Modifier properties');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test repeat property
  print('\n--- Test 8: Test repeat property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final event = RawKeyDownEvent(data: data);
    print('Is repeat: ${event.repeat}');
    results.add('Test 8 PASSED: Repeat property');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Test 9: Simulate key event sequence
  print('\n--- Test 9: Simulate key event sequence ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final downEvent = RawKeyDownEvent(data: data);
    final upEvent = RawKeyUpEvent(data: data);
    print('Down event type: ${downEvent.runtimeType}');
    print('Up event type: ${upEvent.runtimeType}');
    assert(downEvent is RawKeyDownEvent);
    assert(upEvent is RawKeyUpEvent);
    results.add('Test 9 PASSED: Key sequence simulation');
    testsPassed++;
  } catch (e) {
    print('Test 9 FAILED: $e');
    results.add('Test 9 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyEvent test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RawKeyEvent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
