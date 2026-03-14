// D4rt test script: Tests RawKeyEventDataFuchsia from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataFuchsia test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataFuchsia instance
  print('\n--- Test 1: Create RawKeyEventDataFuchsia instance ---');
  try {
    final data = RawKeyEventDataFuchsia(
      hidUsage: 4,
      codePoint: 97,
      modifiers: 0,
    );
    assert(data is RawKeyEventDataFuchsia);
    assert(data.hidUsage == 4);
    print('Created RawKeyEventDataFuchsia successfully');
    print('HID Usage: ${data.hidUsage}');
    print('CodePoint: ${data.codePoint}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test HID usage codes for common keys
  print('\n--- Test 2: Test HID usage codes for common keys ---');
  try {
    final keysAndHidUsage = {
      'A': 4,
      'B': 5,
      'C': 6,
      'Enter': 40,
      'Escape': 41,
      'Space': 44,
    };
    for (final entry in keysAndHidUsage.entries) {
      final data = RawKeyEventDataFuchsia(
        hidUsage: entry.value,
        codePoint: 0,
        modifiers: 0,
      );
      print('Key ${entry.key}: HID Usage ${data.hidUsage}');
      assert(data.hidUsage == entry.value);
    }
    results.add('Test 2 PASSED: HID usage codes');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test modifiers property
  print('\n--- Test 3: Test modifiers property ---');
  try {
    final modShift = 1;
    final modCtrl = 4;
    final modAlt = 2;
    final data = RawKeyEventDataFuchsia(
      hidUsage: 4,
      codePoint: 65,
      modifiers: modShift | modCtrl,
    );
    print('Modifiers value: ${data.modifiers}');
    print('Has Shift: ${(data.modifiers & modShift) != 0}');
    print('Has Ctrl: ${(data.modifiers & modCtrl) != 0}');
    print('Has Alt: ${(data.modifiers & modAlt) != 0}');
    results.add('Test 3 PASSED: Modifiers property');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test codePoint with different characters
  print('\n--- Test 4: Test codePoint with different characters ---');
  try {
    final codePoints = [65, 66, 67, 97, 98, 99, 48, 49, 50];
    for (final cp in codePoints) {
      final data = RawKeyEventDataFuchsia(
        hidUsage: 0,
        codePoint: cp,
        modifiers: 0,
      );
      final char = cp > 0 ? String.fromCharCode(cp) : '(none)';
      print('CodePoint $cp = character "$char"');
      assert(data.codePoint == cp);
    }
    results.add('Test 4 PASSED: CodePoint characters');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test logical key extraction
  print('\n--- Test 5: Test logical key extraction ---');
  try {
    final data = RawKeyEventDataFuchsia(
      hidUsage: 4,
      codePoint: 97,
      modifiers: 0,
    );
    final logicalKey = data.logicalKey;
    print('Logical key: ${logicalKey.debugName}');
    print('Key ID: ${logicalKey.keyId}');
    results.add('Test 5 PASSED: Logical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test physical key extraction
  print('\n--- Test 6: Test physical key extraction ---');
  try {
    final data = RawKeyEventDataFuchsia(
      hidUsage: 4,
      codePoint: 97,
      modifiers: 0,
    );
    final physicalKey = data.physicalKey;
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 6 PASSED: Physical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test modifier key combinations
  print('\n--- Test 7: Test modifier key combinations ---');
  try {
    final combinations = [
      {'name': 'No modifiers', 'value': 0},
      {'name': 'Shift only', 'value': 1},
      {'name': 'Ctrl only', 'value': 4},
      {'name': 'Alt only', 'value': 2},
      {'name': 'Shift+Ctrl', 'value': 5},
      {'name': 'Shift+Alt', 'value': 3},
      {'name': 'Ctrl+Alt', 'value': 6},
      {'name': 'All modifiers', 'value': 7},
    ];
    for (final combo in combinations) {
      final data = RawKeyEventDataFuchsia(
        hidUsage: 4,
        codePoint: 97,
        modifiers: combo['value'] as int,
      );
      print('${combo['name']}: modifiers=${data.modifiers}');
    }
    results.add('Test 7 PASSED: Modifier combinations');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Verify inheritance from RawKeyEventData
  print('\n--- Test 8: Verify inheritance from RawKeyEventData ---');
  try {
    final data = RawKeyEventDataFuchsia(
      hidUsage: 4,
      codePoint: 97,
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
  print('RawKeyEventDataFuchsia test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawKeyEventDataFuchsia Tests',
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
