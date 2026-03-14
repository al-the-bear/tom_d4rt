// D4rt test script: Tests RawKeyEventDataWeb from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataWeb test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataWeb instance
  print('\n--- Test 1: Create RawKeyEventDataWeb instance ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    assert(data is RawKeyEventDataWeb);
    print('Created RawKeyEventDataWeb successfully');
    print('Code: ${data.code}');
    print('Key: ${data.key}');
    print('KeyCode: ${data.keyCode}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test code property (DOM key code string)
  print('\n--- Test 2: Test code property ---');
  try {
    final codes = ['KeyA', 'KeyB', 'Enter', 'Space', 'Escape', 'ShiftLeft', 'ControlRight'];
    for (final code in codes) {
      final data = RawKeyEventDataWeb(
        code: code, key: '', location: 0, metaState: 0, keyCode: 0,
      );
      print('Code: ${data.code}');
      assert(data.code == code);
    }
    results.add('Test 2 PASSED: Code property');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test key property (character produced)
  print('\n--- Test 3: Test key property ---');
  try {
    final keys = ['a', 'A', '1', '!', 'Enter', 'Escape', 'Tab'];
    for (final key in keys) {
      final data = RawKeyEventDataWeb(
        code: 'KeyA', key: key, location: 0, metaState: 0, keyCode: 65,
      );
      print('Key: "${data.key}"');
      assert(data.key == key);
    }
    results.add('Test 3 PASSED: Key property');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test location property
  print('\n--- Test 4: Test location property ---');
  try {
    final locations = {0: 'Standard', 1: 'Left', 2: 'Right', 3: 'Numpad'};
    for (final entry in locations.entries) {
      final data = RawKeyEventDataWeb(
        code: 'ShiftLeft', key: 'Shift', location: entry.key, metaState: 0, keyCode: 16,
      );
      print('Location ${entry.key} (${entry.value}): ${data.location}');
      assert(data.location == entry.key);
    }
    results.add('Test 4 PASSED: Location property');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test metaState flags
  print('\n--- Test 5: Test metaState flags ---');
  try {
    final metaShift = 1;
    final metaCtrl = 2;
    final metaAlt = 4;
    final metaMeta = 8;
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'A', location: 0,
      metaState: metaShift | metaCtrl,
      keyCode: 65,
    );
    print('MetaState: ${data.metaState}');
    print('Shift: ${(data.metaState & metaShift) != 0}');
    print('Ctrl: ${(data.metaState & metaCtrl) != 0}');
    print('Alt: ${(data.metaState & metaAlt) != 0}');
    print('Meta: ${(data.metaState & metaMeta) != 0}');
    results.add('Test 5 PASSED: MetaState flags');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test logical key extraction
  print('\n--- Test 6: Test logical key extraction ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
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
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
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
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
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
  print('RawKeyEventDataWeb test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RawKeyEventDataWeb Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
