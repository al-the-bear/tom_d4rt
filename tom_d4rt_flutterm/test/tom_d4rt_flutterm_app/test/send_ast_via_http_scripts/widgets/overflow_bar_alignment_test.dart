// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OverflowBarAlignment from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OverflowBarAlignment test executing');
  print('=' * 50);

  // === Test OverflowBarAlignment enum ===
  print('\nOverflowBarAlignment positions children in overflow');

  // List all values
  print('\n--- Enum values ---');
  for (final alignment in OverflowBarAlignment.values) {
    print('OverflowBarAlignment.${alignment.name}');
  }

  // Test start value
  print('\n--- Testing start ---');
  final start = OverflowBarAlignment.start;
  print('start.name: ${start.name}');
  print('start.index: ${start.index}');
  print('Aligns children to start');

  // Test center value
  print('\n--- Testing center ---');
  final center = OverflowBarAlignment.center;
  print('center.name: ${center.name}');
  print('center.index: ${center.index}');
  print('Centers children');

  // Test end value
  print('\n--- Testing end ---');
  final end = OverflowBarAlignment.end;
  print('end.name: ${end.name}');
  print('end.index: ${end.index}');
  print('Aligns children to end');

  // Test comparison
  print('\n--- Testing comparison ---');
  print('start == end: ${start == end}');
  print('center == OverflowBarAlignment.center: ${center == OverflowBarAlignment.center}');

  // Test with OverflowBar
  print('\n--- Testing with OverflowBar ---');
  final bar = OverflowBar(
    overflowAlignment: OverflowBarAlignment.end,
    spacing: 8,
    overflowSpacing: 4,
    children: [
      ElevatedButton(onPressed: () {}, child: Text('Action 1')),
      ElevatedButton(onPressed: () {}, child: Text('Action 2')),
    ],
  );
  print('Created OverflowBar with end alignment');
  print('bar.overflowAlignment: ${bar.overflowAlignment}');

  // When overflow occurs
  print('\n--- When overflow occurs ---');
  print('Children wrap to new line');
  print('overflowAlignment positions wrapped children');
  print('start/center/end relative to container');

  // Common use cases
  print('\n--- Common use cases ---');
  print('Dialog action buttons');
  print('Form submit buttons');
  print('Responsive button groups');

  print('\n' + '=' * 50);
  print('OverflowBarAlignment test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OverflowBarAlignment Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('start.index: ${start.index}'),
      Text('center.index: ${center.index}'),
      Text('end.index: ${end.index}'),
      bar,
    ],
  );
}
