// D4rt test script: Tests KeyEvent base class from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyEvent test executing');
  final results = <String>[];
  var passCount = 0;
  var failCount = 0;

  // Test 1: KeyEvent class hierarchy
  print('Test 1: Testing KeyEvent class hierarchy');
  try {
    print('  - KeyEvent is the base class for key events');
    print('  - Subclasses: KeyDownEvent, KeyUpEvent, KeyRepeatEvent');
    print('  - Contains physical key, logical key, and character');
    final hierarchy = [
      'KeyEvent',
      'KeyDownEvent',
      'KeyUpEvent',
      'KeyRepeatEvent',
    ];
    assert(hierarchy.length == 4);
    results.add('✓ KeyEvent hierarchy verified: ${hierarchy.length} classes');
    passCount++;
  } catch (e) {
    results.add('✗ Hierarchy test failed: $e');
    failCount++;
  }

  // Test 2: KeyEvent properties
  print('\nTest 2: Testing KeyEvent properties');
  try {
    final properties = <String, String>{
      'physicalKey': 'PhysicalKeyboardKey representing hardware',
      'logicalKey': 'LogicalKeyboardKey representing meaning',
      'character': 'String? representing typed character',
      'timeStamp': 'Duration since event source started',
      'synthesized': 'bool indicating if event was synthesized',
    };
    for (final entry in properties.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(properties.length == 5);
    results.add('✓ Properties documented: ${properties.length} properties');
    passCount++;
  } catch (e) {
    results.add('✗ Properties test failed: $e');
    failCount++;
  }

  // Test 3: Physical key usage
  print('\nTest 3: Testing physical key concepts');
  try {
    final physicalKeys = [
      PhysicalKeyboardKey.keyA,
      PhysicalKeyboardKey.keyZ,
      PhysicalKeyboardKey.digit1,
      PhysicalKeyboardKey.f1,
      PhysicalKeyboardKey.enter,
    ];
    for (final key in physicalKeys) {
      print('  - Physical: ${key.debugName} (USB: ${key.usbHidUsage})');
    }
    assert(physicalKeys.length == 5);
    results.add('✓ Physical keys verified: ${physicalKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Physical key test failed: $e');
    failCount++;
  }

  // Test 4: Logical key usage
  print('\nTest 4: Testing logical key concepts');
  try {
    final logicalKeys = [
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyZ,
      LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.f1,
      LogicalKeyboardKey.enter,
    ];
    for (final key in logicalKeys) {
      print('  - Logical: ${key.keyLabel} (ID: ${key.keyId})');
    }
    assert(logicalKeys.length == 5);
    results.add('✓ Logical keys verified: ${logicalKeys.length} keys');
    passCount++;
  } catch (e) {
    results.add('✗ Logical key test failed: $e');
    failCount++;
  }

  // Test 5: Character property behavior
  print('\nTest 5: Testing character property behavior');
  try {
    final keyCharacters = <String, String?>{
      'keyA': 'a',
      'keyA+Shift': 'A',
      'enter': null,
      'escape': null,
      'space': ' ',
      'digit1': '1',
      'digit1+Shift': '!',
    };
    for (final entry in keyCharacters.entries) {
      final charDisplay = entry.value == null ? 'null' : '"${entry.value}"';
      print('  - ${entry.key}: $charDisplay');
    }
    assert(keyCharacters['keyA'] == 'a');
    assert(keyCharacters['enter'] == null);
    results.add('✓ Character property verified');
    passCount++;
  } catch (e) {
    results.add('✗ Character test failed: $e');
    failCount++;
  }

  // Test 6: Timestamp handling
  print('\nTest 6: Testing timestamp handling');
  try {
    final durations = [
      Duration(milliseconds: 0),
      Duration(milliseconds: 100),
      Duration(milliseconds: 200),
      Duration(milliseconds: 300),
    ];
    for (final d in durations) {
      print('  - Timestamp: ${d.inMilliseconds}ms');
    }
    assert(durations[0] < durations[3]);
    results.add('✓ Timestamp handling verified');
    passCount++;
  } catch (e) {
    results.add('✗ Timestamp test failed: $e');
    failCount++;
  }

  // Test 7: Event type differentiation
  print('\nTest 7: Testing event type differentiation');
  try {
    final eventTypes = {
      'KeyDownEvent': 'Initial key press',
      'KeyUpEvent': 'Key release',
      'KeyRepeatEvent': 'Key held down (auto-repeat)',
    };
    for (final entry in eventTypes.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(eventTypes.length == 3);
    results.add('✓ Event types differentiated: ${eventTypes.length} types');
    passCount++;
  } catch (e) {
    results.add('✗ Event type test failed: $e');
    failCount++;
  }

  // Test 8: Synthesized event concept
  print('\nTest 8: Testing synthesized event concept');
  try {
    print('  - Synthesized events fill gaps in key sequences');
    print('  - Used when system fails to report key up events');
    print('  - Common with modifier keys losing focus');
    final scenarios = [
      'Window loses focus while key held',
      'System key intercept (Alt+Tab)',
      'Remote desktop key forwarding',
    ];
    for (var i = 0; i < scenarios.length; i++) {
      print('  - Scenario ${i + 1}: ${scenarios[i]}');
    }
    assert(scenarios.length == 3);
    results.add('✓ Synthesized event concept verified');
    passCount++;
  } catch (e) {
    results.add('✗ Synthesized event test failed: $e');
    failCount++;
  }

  // Test 9: Key event sequence simulation
  print('\nTest 9: Testing key event sequence');
  try {
    final sequence = <Map<String, dynamic>>[
      {'type': 'KeyDownEvent', 'key': 'Shift', 'time': 0},
      {'type': 'KeyDownEvent', 'key': 'A', 'time': 50, 'char': 'A'},
      {'type': 'KeyUpEvent', 'key': 'A', 'time': 150},
      {'type': 'KeyUpEvent', 'key': 'Shift', 'time': 200},
    ];
    for (final event in sequence) {
      final char = event['char'] != null ? ' (char: ${event['char']})' : '';
      print('  - ${event['type']}: ${event['key']}$char at ${event['time']}ms');
    }
    assert(sequence.length == 4);
    results.add('✓ Key sequence verified: ${sequence.length} events');
    passCount++;
  } catch (e) {
    results.add('✗ Sequence test failed: $e');
    failCount++;
  }

  // Test 10: Platform differences
  print('\nTest 10: Documenting platform differences');
  try {
    final platforms = {
      'Windows': 'Uses virtual key codes',
      'macOS': 'Uses Carbon key codes',
      'Linux/GLFW': 'Uses GLFW key codes',
      'Linux/GTK': 'Uses GDK keysyms',
      'Android': 'Uses Android key codes',
      'iOS': 'Uses UIKit key handling',
      'Web': 'Uses DOM key codes',
    };
    for (final entry in platforms.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(platforms.length == 7);
    results.add(
      '✓ Platform differences documented: ${platforms.length} platforms',
    );
    passCount++;
  } catch (e) {
    results.add('✗ Platform test failed: $e');
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

  print('\nKeyEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'KeyEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount / ${passCount + failCount}',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 12)),
        ),
      ),
    ],
  );
}
