// D4rt test script: Tests RawKeyboard from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyboard test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Access RawKeyboard singleton instance
  print('\n--- Test 1: Access RawKeyboard singleton instance ---');
  try {
    final keyboard = RawKeyboard.instance;
    assert(keyboard != null);
    print('RawKeyboard instance obtained');
    print('Instance type: ${keyboard.runtimeType}');
    results.add('Test 1 PASSED: Singleton instance access');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Check initial keyboard state
  print('\n--- Test 2: Check initial keyboard state ---');
  try {
    final keyboard = RawKeyboard.instance;
    final keysPressed = keyboard.keysPressed;
    print('Keys currently pressed: ${keysPressed.length}');
    print('Keys pressed set: $keysPressed');
    results.add('Test 2 PASSED: Initial state check');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Check physical keys pressed
  print('\n--- Test 3: Check physical keys pressed ---');
  try {
    final keyboard = RawKeyboard.instance;
    final physicalKeys = keyboard.physicalKeysPressed;
    print('Physical keys pressed count: ${physicalKeys.length}');
    print('Physical keys: $physicalKeys');
    results.add('Test 3 PASSED: Physical keys check');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test key listener registration
  print('\n--- Test 4: Test key listener registration ---');
  try {
    final keyboard = RawKeyboard.instance;
    bool listenerCalled = false;
    void testListener(RawKeyEvent event) {
      listenerCalled = true;
    }
    keyboard.addListener(testListener);
    print('Listener added successfully');
    keyboard.removeListener(testListener);
    print('Listener removed successfully');
    results.add('Test 4 PASSED: Listener registration/removal');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Verify LogicalKeyboardKey constants
  print('\n--- Test 5: Verify LogicalKeyboardKey constants ---');
  try {
    final testKeys = [
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyB,
      LogicalKeyboardKey.enter,
      LogicalKeyboardKey.space,
      LogicalKeyboardKey.escape,
      LogicalKeyboardKey.shift,
      LogicalKeyboardKey.control,
      LogicalKeyboardKey.alt,
    ];
    for (final key in testKeys) {
      print('Key: ${key.debugName}, ID: ${key.keyId}');
      assert(key.keyId > 0);
    }
    results.add('Test 5 PASSED: LogicalKeyboardKey constants');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Verify PhysicalKeyboardKey constants
  print('\n--- Test 6: Verify PhysicalKeyboardKey constants ---');
  try {
    final physicalKeys = [
      PhysicalKeyboardKey.keyA,
      PhysicalKeyboardKey.keyB,
      PhysicalKeyboardKey.enter,
      PhysicalKeyboardKey.space,
      PhysicalKeyboardKey.shiftLeft,
      PhysicalKeyboardKey.shiftRight,
    ];
    for (final key in physicalKeys) {
      print('Physical key: ${key.debugName}, USB HID: ${key.usbHidUsage}');
      assert(key.usbHidUsage > 0);
    }
    results.add('Test 6 PASSED: PhysicalKeyboardKey constants');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test keyboard state consistency
  print('\n--- Test 7: Test keyboard state consistency ---');
  try {
    final keyboard = RawKeyboard.instance;
    final logical = keyboard.keysPressed;
    final physical = keyboard.physicalKeysPressed;
    print('Logical keys count: ${logical.length}');
    print('Physical keys count: ${physical.length}');
    assert(logical.length == physical.length);
    results.add('Test 7 PASSED: State consistency check');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Multiple listener management
  print('\n--- Test 8: Multiple listener management ---');
  try {
    final keyboard = RawKeyboard.instance;
    final listeners = <void Function(RawKeyEvent)>[];
    for (int i = 0; i < 5; i++) {
      final listener = (RawKeyEvent event) => print('Listener $i');
      listeners.add(listener);
      keyboard.addListener(listener);
      print('Added listener $i');
    }
    for (final listener in listeners) {
      keyboard.removeListener(listener);
    }
    print('Removed all ${listeners.length} listeners');
    results.add('Test 8 PASSED: Multiple listeners');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyboard test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RawKeyboard Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
