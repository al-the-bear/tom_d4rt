// D4rt test script: Tests KeyboardKey from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyboardKey test executing');
  final results = <String>[];
  var passCount = 0;
  var failCount = 0;

  // Test 1: LogicalKeyboardKey basic access
  print('Test 1: Testing LogicalKeyboardKey basic access');
  try {
    final keyA = LogicalKeyboardKey.keyA;
    final keyB = LogicalKeyboardKey.keyB;
    print('  - Key A: ${keyA.keyLabel}');
    print('  - Key B: ${keyB.keyLabel}');
    print('  - Key A ID: ${keyA.keyId}');
    assert(keyA != keyB);
    assert(keyA.keyId != keyB.keyId);
    results.add('✓ LogicalKeyboardKey basic access works');
    passCount++;
  } catch (e) {
    results.add('✗ LogicalKeyboardKey test failed: $e');
    failCount++;
  }

  // Test 2: PhysicalKeyboardKey access
  print('\nTest 2: Testing PhysicalKeyboardKey access');
  try {
    final physKeyA = PhysicalKeyboardKey.keyA;
    final physKeyB = PhysicalKeyboardKey.keyB;
    print('  - Physical Key A: ${physKeyA.debugName}');
    print('  - Physical Key B: ${physKeyB.debugName}');
    print('  - USB HID code A: ${physKeyA.usbHidUsage}');
    assert(physKeyA.usbHidUsage != physKeyB.usbHidUsage);
    results.add('✓ PhysicalKeyboardKey access works');
    passCount++;
  } catch (e) {
    results.add('✗ PhysicalKeyboardKey test failed: $e');
    failCount++;
  }

  // Test 3: Alphabet keys
  print('\nTest 3: Testing alphabet keys');
  try {
    final alphabetKeys = [
      LogicalKeyboardKey.keyA, LogicalKeyboardKey.keyB,
      LogicalKeyboardKey.keyC, LogicalKeyboardKey.keyD,
      LogicalKeyboardKey.keyE, LogicalKeyboardKey.keyF,
    ];
    for (final key in alphabetKeys) {
      print('  - ${key.keyLabel}: ${key.keyId}');
    }
    assert(alphabetKeys.length == 6);
    results.add('✓ Alphabet keys verified: ${alphabetKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Alphabet keys test failed: $e');
    failCount++;
  }

  // Test 4: Number keys
  print('\nTest 4: Testing number keys');
  try {
    final numberKeys = [
      LogicalKeyboardKey.digit0, LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.digit2, LogicalKeyboardKey.digit3,
      LogicalKeyboardKey.digit4, LogicalKeyboardKey.digit5,
      LogicalKeyboardKey.digit6, LogicalKeyboardKey.digit7,
      LogicalKeyboardKey.digit8, LogicalKeyboardKey.digit9,
    ];
    print('  - Number keys count: ${numberKeys.length}');
    for (var i = 0; i < 5; i++) {
      print('  - Digit $i: ${numberKeys[i].keyLabel}');
    }
    assert(numberKeys.length == 10);
    results.add('✓ Number keys verified: ${numberKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Number keys test failed: $e');
    failCount++;
  }

  // Test 5: Function keys
  print('\nTest 5: Testing function keys');
  try {
    final functionKeys = [
      LogicalKeyboardKey.f1, LogicalKeyboardKey.f2,
      LogicalKeyboardKey.f3, LogicalKeyboardKey.f4,
      LogicalKeyboardKey.f5, LogicalKeyboardKey.f6,
    ];
    for (final key in functionKeys) {
      print('  - Function key: ${key.keyLabel}');
    }
    assert(functionKeys.length == 6);
    results.add('✓ Function keys verified: ${functionKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Function keys test failed: $e');
    failCount++;
  }

  // Test 6: Modifier keys
  print('\nTest 6: Testing modifier keys');
  try {
    final modifiers = {
      'Shift Left': LogicalKeyboardKey.shiftLeft,
      'Shift Right': LogicalKeyboardKey.shiftRight,
      'Control Left': LogicalKeyboardKey.controlLeft,
      'Control Right': LogicalKeyboardKey.controlRight,
      'Alt Left': LogicalKeyboardKey.altLeft,
      'Alt Right': LogicalKeyboardKey.altRight,
      'Meta Left': LogicalKeyboardKey.metaLeft,
      'Meta Right': LogicalKeyboardKey.metaRight,
    };
    for (final entry in modifiers.entries) {
      print('  - ${entry.key}: ${entry.value.keyLabel}');
    }
    assert(modifiers.length == 8);
    results.add('✓ Modifier keys verified: ${modifiers.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Modifier keys test failed: $e');
    failCount++;
  }

  // Test 7: Navigation keys
  print('\nTest 7: Testing navigation keys');
  try {
    final navKeys = {
      'Arrow Up': LogicalKeyboardKey.arrowUp,
      'Arrow Down': LogicalKeyboardKey.arrowDown,
      'Arrow Left': LogicalKeyboardKey.arrowLeft,
      'Arrow Right': LogicalKeyboardKey.arrowRight,
      'Home': LogicalKeyboardKey.home,
      'End': LogicalKeyboardKey.end,
      'Page Up': LogicalKeyboardKey.pageUp,
      'Page Down': LogicalKeyboardKey.pageDown,
    };
    for (final entry in navKeys.entries) {
      print('  - ${entry.key}: ${entry.value.keyId}');
    }
    assert(navKeys.length == 8);
    results.add('✓ Navigation keys verified: ${navKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Navigation keys test failed: $e');
    failCount++;
  }

  // Test 8: Special keys
  print('\nTest 8: Testing special keys');
  try {
    final specialKeys = {
      'Enter': LogicalKeyboardKey.enter,
      'Escape': LogicalKeyboardKey.escape,
      'Backspace': LogicalKeyboardKey.backspace,
      'Tab': LogicalKeyboardKey.tab,
      'Space': LogicalKeyboardKey.space,
      'Delete': LogicalKeyboardKey.delete,
    };
    for (final entry in specialKeys.entries) {
      print('  - ${entry.key}: ${entry.value.keyLabel}');
    }
    assert(specialKeys.length == 6);
    results.add('✓ Special keys verified: ${specialKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Special keys test failed: $e');
    failCount++;
  }

  // Test 9: Key comparison
  print('\nTest 9: Testing key comparison');
  try {
    final keyA1 = LogicalKeyboardKey.keyA;
    final keyA2 = LogicalKeyboardKey.keyA;
    final keyB = LogicalKeyboardKey.keyB;
    assert(keyA1 == keyA2);
    assert(keyA1 != keyB);
    assert(keyA1.keyId == keyA2.keyId);
    print('  - keyA == keyA: ${keyA1 == keyA2}');
    print('  - keyA != keyB: ${keyA1 != keyB}');
    print('  - Key IDs match: ${keyA1.keyId == keyA2.keyId}');
    results.add('✓ Key comparison works correctly');
    passCount++;
  } catch (e) {
    results.add('✗ Key comparison test failed: $e');
    failCount++;
  }

  // Test 10: Numpad keys
  print('\nTest 10: Testing numpad keys');
  try {
    final numpadKeys = [
      LogicalKeyboardKey.numpad0, LogicalKeyboardKey.numpad1,
      LogicalKeyboardKey.numpad2, LogicalKeyboardKey.numpad3,
      LogicalKeyboardKey.numpad4, LogicalKeyboardKey.numpad5,
    ];
    for (final key in numpadKeys) {
      print('  - Numpad: ${key.keyLabel}');
    }
    assert(numpadKeys.length == 6);
    results.add('✓ Numpad keys verified: ${numpadKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Numpad keys test failed: $e');
    failCount++;
  }

  // Test 11: Key synonyms
  print('\nTest 11: Testing key synonyms concepts');
  try {
    final returnKey = LogicalKeyboardKey.enter;
    final numEnter = LogicalKeyboardKey.numpadEnter;
    print('  - Enter key: ${returnKey.keyLabel}');
    print('  - Numpad Enter: ${numEnter.keyLabel}');
    print('  - Both represent "enter" action but are different keys');
    assert(returnKey != numEnter);
    results.add('✓ Key synonyms concept verified');
    passCount++;
  } catch (e) {
    results.add('✗ Key synonyms test failed: $e');
    failCount++;
  }

  // Print summary
  print('\n========== Test Summary ==========');
  print('Total tests: ${passCount + failCount}');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('===================================');

  for (final result in results) {
    print(result);
  }

  print('\nKeyboardKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('KeyboardKey Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Passed: $passCount / ${passCount + failCount}',
          style: TextStyle(color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336))),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(r, style: TextStyle(fontSize: 12)),
          )),
    ],
  );
}
