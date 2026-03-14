// D4rt test script: Tests RawKeyEventDataLinux from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataLinux test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataLinux with GTK toolkit
  print('\n--- Test 1: Create RawKeyEventDataLinux with GTK ---');
  try {
    final data = RawKeyEventDataLinux(
      keyHelper: const GtkKeyHelper(),
      unicodeScalarValues: 97,
      scanCode: 38,
      keyCode: 38,
      modifiers: 0,
      isDown: true,
    );
    assert(data is RawKeyEventDataLinux);
    print('Created RawKeyEventDataLinux successfully');
    print('ScanCode: ${data.scanCode}');
    print('KeyCode: ${data.keyCode}');
    print('IsDown: ${data.isDown}');
    results.add('Test 1 PASSED: GTK instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Create RawKeyEventDataLinux with GLFW toolkit
  print('\n--- Test 2: Create RawKeyEventDataLinux with GLFW ---');
  try {
    final data = RawKeyEventDataLinux(
      keyHelper: const GLFWKeyHelper(),
      unicodeScalarValues: 97,
      scanCode: 38,
      keyCode: 65,
      modifiers: 0,
      isDown: true,
    );
    assert(data is RawKeyEventDataLinux);
    print('Created with GLFW key helper');
    print('KeyCode: ${data.keyCode}');
    results.add('Test 2 PASSED: GLFW instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test unicodeScalarValues
  print('\n--- Test 3: Test unicodeScalarValues ---');
  try {
    final chars = {'a': 97, 'A': 65, '1': 49, '@': 64};
    for (final entry in chars.entries) {
      final data = RawKeyEventDataLinux(
        keyHelper: const GtkKeyHelper(),
        unicodeScalarValues: entry.value,
        scanCode: 38,
        keyCode: 38,
        modifiers: 0,
        isDown: true,
      );
      print('Char "${entry.key}": unicode=${data.unicodeScalarValues}');
      assert(data.unicodeScalarValues == entry.value);
    }
    results.add('Test 3 PASSED: UnicodeScalarValues');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test modifier flags
  print('\n--- Test 4: Test modifier flags ---');
  try {
    final modShift = 1;
    final modControl = 4;
    final modAlt = 8;
    final modMeta = 64;
    final data = RawKeyEventDataLinux(
      keyHelper: const GtkKeyHelper(),
      unicodeScalarValues: 65,
      scanCode: 38,
      keyCode: 38,
      modifiers: modShift | modControl,
      isDown: true,
    );
    print('Modifiers: ${data.modifiers}');
    print('Shift: ${(data.modifiers & modShift) != 0}');
    print('Control: ${(data.modifiers & modControl) != 0}');
    print('Alt: ${(data.modifiers & modAlt) != 0}');
    print('Meta: ${(data.modifiers & modMeta) != 0}');
    results.add('Test 4 PASSED: Modifier flags');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test isDown property
  print('\n--- Test 5: Test isDown property ---');
  try {
    final downEvent = RawKeyEventDataLinux(
      keyHelper: const GtkKeyHelper(),
      unicodeScalarValues: 97,
      scanCode: 38, keyCode: 38, modifiers: 0, isDown: true,
    );
    final upEvent = RawKeyEventDataLinux(
      keyHelper: const GtkKeyHelper(),
      unicodeScalarValues: 97,
      scanCode: 38, keyCode: 38, modifiers: 0, isDown: false,
    );
    print('Down event isDown: ${downEvent.isDown}');
    print('Up event isDown: ${upEvent.isDown}');
    assert(downEvent.isDown == true);
    assert(upEvent.isDown == false);
    results.add('Test 5 PASSED: IsDown property');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test logical key extraction
  print('\n--- Test 6: Test logical key extraction ---');
  try {
    final data = RawKeyEventDataLinux(
      keyHelper: const GtkKeyHelper(),
      unicodeScalarValues: 97,
      scanCode: 38,
      keyCode: 38,
      modifiers: 0,
      isDown: true,
    );
    final logicalKey = data.logicalKey;
    print('Logical key: ${logicalKey.debugName}');
    print('Key ID: ${logicalKey.keyId}');
    results.add('Test 6 PASSED: Logical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test physical key extraction
  print('\n--- Test 7: Test physical key extraction ---');
  try {
    final data = RawKeyEventDataLinux(
      keyHelper: const GtkKeyHelper(),
      unicodeScalarValues: 97,
      scanCode: 38,
      keyCode: 38,
      modifiers: 0,
      isDown: true,
    );
    final physicalKey = data.physicalKey;
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 7 PASSED: Physical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Verify inheritance from RawKeyEventData
  print('\n--- Test 8: Verify inheritance from RawKeyEventData ---');
  try {
    final data = RawKeyEventDataLinux(
      keyHelper: const GtkKeyHelper(),
      unicodeScalarValues: 97,
      scanCode: 38, keyCode: 38, modifiers: 0, isDown: true,
    );
    assert(data is RawKeyEventData);
    print('Inherits from RawKeyEventData: true');
    print('Runtime type: ${data.runtimeType}');
    results.add('Test 8 PASSED: Inheritance verified');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyEventDataLinux test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RawKeyEventDataLinux Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
