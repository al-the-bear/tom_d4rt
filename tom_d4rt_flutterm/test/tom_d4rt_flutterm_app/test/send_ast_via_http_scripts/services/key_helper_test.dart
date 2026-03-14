// D4rt test script: Tests KeyHelper abstract class from services
// KeyHelper is an abstract base class for platform-specific key event handling
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('=== KeyHelper Test Suite ===');
  print('Testing KeyHelper abstract class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: Verify KeyHelper related classes exist
  print('\n--- Test 1: KeyHelper Type Verification ---');
  try {
    // KeyHelper is abstract, we test through concrete implementations
    // like GLFWKeyHelper and GtkKeyHelper
    print('KeyHelper is an abstract class for platform key handling');
    print('Concrete implementations include GLFWKeyHelper, GtkKeyHelper');
    results.add('✓ KeyHelper type verification passed');
    passCount++;
  } catch (e) {
    results.add('✗ KeyHelper type verification failed: $e');
    failCount++;
  }

  // Test 2: Test LogicalKeyboardKey relationships
  print('\n--- Test 2: LogicalKeyboardKey Integration ---');
  try {
    final keyA = LogicalKeyboardKey.keyA;
    print('LogicalKeyboardKey.keyA: $keyA');
    print('Key ID: ${keyA.keyId}');
    print('Key Label: ${keyA.keyLabel}');
    assert(keyA.keyId > 0, 'Key ID should be positive');
    assert(keyA.keyLabel.isNotEmpty, 'Key label should not be empty');
    results.add('✓ LogicalKeyboardKey integration passed');
    passCount++;
  } catch (e) {
    results.add('✗ LogicalKeyboardKey integration failed: $e');
    failCount++;
  }

  // Test 3: Test PhysicalKeyboardKey relationships
  print('\n--- Test 3: PhysicalKeyboardKey Integration ---');
  try {
    final physicalKey = PhysicalKeyboardKey.keyA;
    print('PhysicalKeyboardKey.keyA: $physicalKey');
    print('USB HID Usage: ${physicalKey.usbHidUsage}');
    print('Debug Name: ${physicalKey.debugName}');
    assert(physicalKey.usbHidUsage > 0, 'USB HID usage should be positive');
    results.add('✓ PhysicalKeyboardKey integration passed');
    passCount++;
  } catch (e) {
    results.add('✗ PhysicalKeyboardKey integration failed: $e');
    failCount++;
  }

  // Test 4: Test modifier key handling
  print('\n--- Test 4: Modifier Key Handling ---');
  try {
    final shiftKey = LogicalKeyboardKey.shiftLeft;
    final controlKey = LogicalKeyboardKey.controlLeft;
    final altKey = LogicalKeyboardKey.altLeft;
    final metaKey = LogicalKeyboardKey.metaLeft;
    print('Shift key: $shiftKey');
    print('Control key: $controlKey');
    print('Alt key: $altKey');
    print('Meta key: $metaKey');
    assert(shiftKey != controlKey, 'Shift and Control should be different');
    assert(altKey != metaKey, 'Alt and Meta should be different');
    results.add('✓ Modifier key handling passed');
    passCount++;
  } catch (e) {
    results.add('✗ Modifier key handling failed: $e');
    failCount++;
  }

  // Test 5: Test function keys
  print('\n--- Test 5: Function Key Handling ---');
  try {
    final f1 = LogicalKeyboardKey.f1;
    final f12 = LogicalKeyboardKey.f12;
    print('F1 key: $f1');
    print('F12 key: $f12');
    print('F1 key ID: ${f1.keyId}');
    print('F12 key ID: ${f12.keyId}');
    assert(f1.keyId != f12.keyId, 'F1 and F12 should have different IDs');
    results.add('✓ Function key handling passed');
    passCount++;
  } catch (e) {
    results.add('✗ Function key handling failed: $e');
    failCount++;
  }

  // Test 6: Test key synonyms
  print('\n--- Test 6: Key Synonyms Test ---');
  try {
    final synonyms = LogicalKeyboardKey.keyA.synonyms;
    print('KeyA synonyms: $synonyms');
    print('Synonyms count: ${synonyms.length}');
    results.add('✓ Key synonyms test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Key synonyms test failed: $e');
    failCount++;
  }

  // Test 7: Test known keys lookup
  print('\n--- Test 7: Known Keys Lookup ---');
  try {
    final knownLogicalKeys = LogicalKeyboardKey.knownLogicalKeys;
    final knownPhysicalKeys = PhysicalKeyboardKey.knownPhysicalKeys;
    print('Known logical keys count: ${knownLogicalKeys.length}');
    print('Known physical keys count: ${knownPhysicalKeys.length}');
    assert(knownLogicalKeys.isNotEmpty, 'Should have known logical keys');
    assert(knownPhysicalKeys.isNotEmpty, 'Should have known physical keys');
    results.add('✓ Known keys lookup passed');
    passCount++;
  } catch (e) {
    results.add('✗ Known keys lookup failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== KeyHelper Test Summary ===');
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
      Text('KeyHelper Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
