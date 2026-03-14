// D4rt test script: Tests RawKeyEventDataWindows from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataWindows test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataWindows instance
  print('\n--- Test 1: Create RawKeyEventDataWindows instance ---');
  try {
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
    );
    assert(data is RawKeyEventDataWindows);
    print('Created RawKeyEventDataWindows successfully');
    print('KeyCode: ${data.keyCode}');
    print('ScanCode: ${data.scanCode}');
    print('CharacterCodePoint: ${data.characterCodePoint}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test Windows virtual key codes
  print('\n--- Test 2: Test Windows virtual key codes ---');
  try {
    final vkCodes = {
      'A': 65,
      'B': 66,
      'C': 67,
      '0': 48,
      '1': 49,
      'Enter': 13,
      'Escape': 27,
      'Space': 32,
      'Tab': 9,
    };
    for (final entry in vkCodes.entries) {
      final data = RawKeyEventDataWindows(
        keyCode: entry.value,
        scanCode: 0,
        characterCodePoint: 0,
        modifiers: 0,
      );
      print('Key ${entry.key}: VK_CODE=${data.keyCode}');
      assert(data.keyCode == entry.value);
    }
    results.add('Test 2 PASSED: Virtual key codes');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test scanCode values
  print('\n--- Test 3: Test scanCode values ---');
  try {
    final scanCodes = [30, 31, 32, 33, 34, 35, 36, 37, 38];
    for (int i = 0; i < scanCodes.length; i++) {
      final data = RawKeyEventDataWindows(
        keyCode: 65 + i,
        scanCode: scanCodes[i],
        characterCodePoint: 97 + i,
        modifiers: 0,
      );
      print('ScanCode: ${data.scanCode}');
      assert(data.scanCode == scanCodes[i]);
    }
    results.add('Test 3 PASSED: ScanCode values');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test characterCodePoint
  print('\n--- Test 4: Test characterCodePoint ---');
  try {
    final codePoints = [97, 65, 48, 64, 33, 35];
    for (final cp in codePoints) {
      final data = RawKeyEventDataWindows(
        keyCode: 65,
        scanCode: 30,
        characterCodePoint: cp,
        modifiers: 0,
      );
      final char = cp > 0 ? String.fromCharCode(cp) : '(none)';
      print('CodePoint $cp = "$char"');
      assert(data.characterCodePoint == cp);
    }
    results.add('Test 4 PASSED: CharacterCodePoint');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test Windows modifier flags
  print('\n--- Test 5: Test Windows modifier flags ---');
  try {
    final modShift = 1;
    final modControl = 4;
    final modAlt = 2;
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 65,
      modifiers: modShift | modControl,
    );
    print('Modifiers: ${data.modifiers}');
    print('Shift: ${(data.modifiers & modShift) != 0}');
    print('Control: ${(data.modifiers & modControl) != 0}');
    print('Alt: ${(data.modifiers & modAlt) != 0}');
    results.add('Test 5 PASSED: Modifier flags');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test logical key extraction
  print('\n--- Test 6: Test logical key extraction ---');
  try {
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
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
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
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
    final data = RawKeyEventDataWindows(
      keyCode: 65,
      scanCode: 30,
      characterCodePoint: 97,
      modifiers: 0,
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
  print('RawKeyEventDataWindows test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawKeyEventDataWindows Tests',
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
