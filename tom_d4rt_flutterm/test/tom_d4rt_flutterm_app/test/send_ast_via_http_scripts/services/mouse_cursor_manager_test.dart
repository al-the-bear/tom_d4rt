// D4rt test script: Tests MouseCursorManager class from services
// MouseCursorManager manages cursor appearance across the application
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('=== MouseCursorManager Test Suite ===');
  print('Testing MouseCursorManager class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: MouseCursor types
  print('\n--- Test 1: MouseCursor Types ---');
  try {
    final cursors = <String, MouseCursor>{
      'basic': SystemMouseCursors.basic,
      'click': SystemMouseCursors.click,
      'forbidden': SystemMouseCursors.forbidden,
      'wait': SystemMouseCursors.wait,
      'progress': SystemMouseCursors.progress,
      'text': SystemMouseCursors.text,
      'help': SystemMouseCursors.help,
      'move': SystemMouseCursors.move,
    };
    for (final entry in cursors.entries) {
      print('Cursor ${entry.key}: ${entry.value}');
    }
    results.add('✓ MouseCursor types test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseCursor types test failed: $e');
    failCount++;
  }

  // Test 2: SystemMouseCursors availability
  print('\n--- Test 2: SystemMouseCursors Availability ---');
  try {
    final basic = SystemMouseCursors.basic;
    final click = SystemMouseCursors.click;
    print('Basic cursor: $basic');
    print('Click cursor: $click');
    assert(basic != click, 'Cursors should be different');
    results.add('✓ SystemMouseCursors availability test passed');
    passCount++;
  } catch (e) {
    results.add('✗ SystemMouseCursors availability test failed: $e');
    failCount++;
  }

  // Test 3: Resize cursors
  print('\n--- Test 3: Resize Cursors ---');
  try {
    final resizeCursors = [
      SystemMouseCursors.resizeColumn,
      SystemMouseCursors.resizeRow,
      SystemMouseCursors.resizeUp,
      SystemMouseCursors.resizeDown,
      SystemMouseCursors.resizeLeft,
      SystemMouseCursors.resizeRight,
      SystemMouseCursors.resizeUpDown,
      SystemMouseCursors.resizeLeftRight,
    ];
    print('Available resize cursors: ${resizeCursors.length}');
    for (final cursor in resizeCursors) {
      print('  - $cursor');
    }
    results.add('✓ Resize cursors test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Resize cursors test failed: $e');
    failCount++;
  }

  // Test 4: Corner resize cursors
  print('\n--- Test 4: Corner Resize Cursors ---');
  try {
    final cornerCursors = [
      SystemMouseCursors.resizeUpLeft,
      SystemMouseCursors.resizeUpRight,
      SystemMouseCursors.resizeDownLeft,
      SystemMouseCursors.resizeDownRight,
      SystemMouseCursors.resizeUpLeftDownRight,
      SystemMouseCursors.resizeUpRightDownLeft,
    ];
    print('Corner resize cursors: ${cornerCursors.length}');
    for (final cursor in cornerCursors) {
      print('  - $cursor');
    }
    results.add('✓ Corner resize cursors test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Corner resize cursors test failed: $e');
    failCount++;
  }

  // Test 5: MouseCursor.defer
  print('\n--- Test 5: MouseCursor.defer ---');
  try {
    final deferred = MouseCursor.defer;
    print('MouseCursor.defer: $deferred');
    print('Used to defer cursor decision to ancestors');
    results.add('✓ MouseCursor.defer test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseCursor.defer test failed: $e');
    failCount++;
  }

  // Test 6: MouseCursor.uncontrolled
  print('\n--- Test 6: MouseCursor.uncontrolled ---');
  try {
    final uncontrolled = MouseCursor.uncontrolled;
    print('MouseCursor.uncontrolled: $uncontrolled');
    print('Used when widget does not control cursor');
    results.add('✓ MouseCursor.uncontrolled test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseCursor.uncontrolled test failed: $e');
    failCount++;
  }

  // Test 7: Special purpose cursors
  print('\n--- Test 7: Special Purpose Cursors ---');
  try {
    final specialCursors = <String, MouseCursor>{
      'none': SystemMouseCursors.none,
      'grab': SystemMouseCursors.grab,
      'grabbing': SystemMouseCursors.grabbing,
      'noDrop': SystemMouseCursors.noDrop,
      'alias': SystemMouseCursors.alias,
      'copy': SystemMouseCursors.copy,
      'disappearing': SystemMouseCursors.disappearing,
      'allScroll': SystemMouseCursors.allScroll,
      'cell': SystemMouseCursors.cell,
      'contextMenu': SystemMouseCursors.contextMenu,
    };
    print('Special purpose cursors:');
    for (final entry in specialCursors.entries) {
      print('  ${entry.key}: ${entry.value}');
    }
    results.add('✓ Special purpose cursors test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Special purpose cursors test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MouseCursorManager Test Summary ===');
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
      Text('MouseCursorManager Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
