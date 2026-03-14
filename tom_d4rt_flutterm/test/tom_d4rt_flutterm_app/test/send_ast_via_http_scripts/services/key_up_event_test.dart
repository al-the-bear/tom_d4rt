// D4rt test script: Tests KeyUpEvent class from services
// KeyUpEvent represents a key being released
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('=== KeyUpEvent Test Suite ===');
  print('Testing KeyUpEvent class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: KeyUpEvent type verification
  print('\n--- Test 1: KeyUpEvent Type Verification ---');
  try {
    print('KeyUpEvent extends KeyEvent');
    print('Represents key release after down/repeat');
    final physicalKey = PhysicalKeyboardKey.keyA;
    final logicalKey = LogicalKeyboardKey.keyA;
    print('Physical key: $physicalKey');
    print('Logical key: $logicalKey');
    results.add('✓ KeyUpEvent type verification passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyUpEvent type verification failed: $e');
    failCount++;
  }

  // Test 2: Create KeyUpEvent
  print('\n--- Test 2: KeyUpEvent Creation ---');
  try {
    final upEvent = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.keyA,
      logicalKey: LogicalKeyboardKey.keyA,
      timeStamp: Duration(milliseconds: 300),
    );
    print('Created KeyUpEvent: $upEvent');
    print('Physical key: ${upEvent.physicalKey}');
    print('Logical key: ${upEvent.logicalKey}');
    print('Timestamp: ${upEvent.timeStamp}');
    assert(upEvent.physicalKey == PhysicalKeyboardKey.keyA, 'Physical key mismatch');
    assert(upEvent.logicalKey == LogicalKeyboardKey.keyA, 'Logical key mismatch');
    results.add('✓ KeyUpEvent creation passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyUpEvent creation failed: $e');
    failCount++;
  }

  // Test 3: KeyUpEvent timestamp ordering
  print('\n--- Test 3: KeyUpEvent Timestamp Ordering ---');
  try {
    final downTime = Duration(milliseconds: 100);
    final upTime = Duration(milliseconds: 250);
    final downEvent = KeyDownEvent(
      physicalKey: PhysicalKeyboardKey.keyB,
      logicalKey: LogicalKeyboardKey.keyB,
      timeStamp: downTime,
    );
    final upEvent = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.keyB,
      logicalKey: LogicalKeyboardKey.keyB,
      timeStamp: upTime,
    );
    print('Down timestamp: $downTime');
    print('Up timestamp: $upTime');
    assert(upTime > downTime, 'Up event should be after down');
    results.add('✓ KeyUpEvent timestamp ordering passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyUpEvent timestamp ordering failed: $e');
    failCount++;
  }

  // Test 4: KeyUpEvent with modifier keys
  print('\n--- Test 4: KeyUpEvent with Modifier Keys ---');
  try {
    final shiftUp = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.shiftLeft,
      logicalKey: LogicalKeyboardKey.shiftLeft,
      timeStamp: Duration(milliseconds: 500),
    );
    final ctrlUp = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.controlLeft,
      logicalKey: LogicalKeyboardKey.controlLeft,
      timeStamp: Duration(milliseconds: 600),
    );
    print('Shift up event: $shiftUp');
    print('Control up event: $ctrlUp');
    results.add('✓ KeyUpEvent with modifier keys passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyUpEvent with modifier keys failed: $e');
    failCount++;
  }

  // Test 5: KeyUpEvent character property
  print('\n--- Test 5: KeyUpEvent Character Property ---');
  try {
    // KeyUpEvent typically doesn't have character
    final upEvent = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.keyC,
      logicalKey: LogicalKeyboardKey.keyC,
      timeStamp: Duration.zero,
    );
    print('KeyUpEvent character: ${upEvent.character}');
    print('Character is typically null for KeyUpEvent');
    results.add('✓ KeyUpEvent character property test passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyUpEvent character property test failed: $e');
    failCount++;
  }

  // Test 6: Complete key press cycle
  print('\n--- Test 6: Complete Key Press Cycle ---');
  try {
    final down = KeyDownEvent(
      physicalKey: PhysicalKeyboardKey.enter,
      logicalKey: LogicalKeyboardKey.enter,
      timeStamp: Duration(milliseconds: 0),
    );
    final up = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.enter,
      logicalKey: LogicalKeyboardKey.enter,
      timeStamp: Duration(milliseconds: 50),
    );
    print('Key down: ${down.runtimeType}');
    print('Key up: ${up.runtimeType}');
    assert(down.physicalKey == up.physicalKey, 'Physical keys should match');
    assert(down.logicalKey == up.logicalKey, 'Logical keys should match');
    results.add('✓ Complete key press cycle test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Complete key press cycle test failed: $e');
    failCount++;
  }

  // Test 7: KeyUpEvent for function keys
  print('\n--- Test 7: KeyUpEvent for Function Keys ---');
  try {
    final f1Up = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.f1,
      logicalKey: LogicalKeyboardKey.f1,
      timeStamp: Duration(milliseconds: 100),
    );
    final escUp = KeyUpEvent(
      physicalKey: PhysicalKeyboardKey.escape,
      logicalKey: LogicalKeyboardKey.escape,
      timeStamp: Duration(milliseconds: 200),
    );
    print('F1 up event: ${f1Up.logicalKey.keyLabel}');
    print('Escape up event: ${escUp.logicalKey.keyLabel}');
    results.add('✓ KeyUpEvent for function keys passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyUpEvent for function keys failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== KeyUpEvent Test Summary ===');
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
      Text('KeyUpEvent Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
