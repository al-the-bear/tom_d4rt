// D4rt test script: Tests RawKeyEventDataIos from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataIos test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataIos instance
  print('\n--- Test 1: Create RawKeyEventDataIos instance ---');
  try {
    final data = RawKeyEventDataIos(
      characters: 'a',
      charactersIgnoringModifiers: 'a',
      keyCode: 0,
      modifiers: 0,
    );
    assert(data is RawKeyEventDataIos);
    print('Created RawKeyEventDataIos successfully');
    print('Characters: ${data.characters}');
    print('KeyCode: ${data.keyCode}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test characters property
  print('\n--- Test 2: Test characters property ---');
  try {
    final testChars = ['a', 'A', '1', '@', 'Hello'];
    for (final char in testChars) {
      final data = RawKeyEventDataIos(
        characters: char,
        charactersIgnoringModifiers: char.toLowerCase(),
        keyCode: 0,
        modifiers: 0,
      );
      print('Characters: "${data.characters}"');
      assert(data.characters == char);
    }
    results.add('Test 2 PASSED: Characters property');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test charactersIgnoringModifiers
  print('\n--- Test 3: Test charactersIgnoringModifiers ---');
  try {
    final data = RawKeyEventDataIos(
      characters: 'A',
      charactersIgnoringModifiers: 'a',
      keyCode: 0,
      modifiers: 131072,
    );
    print('With Shift - characters: "${data.characters}"');
    print('Ignoring modifiers: "${data.charactersIgnoringModifiers}"');
    assert(data.characters == 'A');
    assert(data.charactersIgnoringModifiers == 'a');
    results.add('Test 3 PASSED: CharactersIgnoringModifiers');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test iOS keyCode mappings
  print('\n--- Test 4: Test iOS keyCode mappings ---');
  try {
    final keyCodes = {
      'A': 0,
      'B': 11,
      'C': 8,
      'Enter': 36,
      'Space': 49,
      'Escape': 53,
    };
    for (final entry in keyCodes.entries) {
      final data = RawKeyEventDataIos(
        characters: entry.key.toLowerCase(),
        charactersIgnoringModifiers: entry.key.toLowerCase(),
        keyCode: entry.value,
        modifiers: 0,
      );
      print('Key ${entry.key}: keyCode=${data.keyCode}');
    }
    results.add('Test 4 PASSED: KeyCode mappings');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test iOS modifier flags
  print('\n--- Test 5: Test iOS modifier flags ---');
  try {
    final modShift = 131072;
    final modControl = 262144;
    final modOption = 524288;
    final modCommand = 1048576;
    final data = RawKeyEventDataIos(
      characters: 'a',
      charactersIgnoringModifiers: 'a',
      keyCode: 0,
      modifiers: modShift | modCommand,
    );
    print('Modifiers: ${data.modifiers}');
    print('Has Shift: ${(data.modifiers & modShift) != 0}');
    print('Has Control: ${(data.modifiers & modControl) != 0}');
    print('Has Option: ${(data.modifiers & modOption) != 0}');
    print('Has Command: ${(data.modifiers & modCommand) != 0}');
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
    final data = RawKeyEventDataIos(
      characters: 'a',
      charactersIgnoringModifiers: 'a',
      keyCode: 0,
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
    final data = RawKeyEventDataIos(
      characters: 'a',
      charactersIgnoringModifiers: 'a',
      keyCode: 0,
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
    final data = RawKeyEventDataIos(
      characters: 'a',
      charactersIgnoringModifiers: 'a',
      keyCode: 0,
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
  print('RawKeyEventDataIos test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawKeyEventDataIos Tests',
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
