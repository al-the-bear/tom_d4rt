// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests VerticalDirection from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VerticalDirection test executing');
  print('=' * 50);

  // VerticalDirection enum overview
  print('VerticalDirection enum overview:');
  print('  - Direction of vertical layout');
  print('  - Used in Flex-based widgets');
  print('  - 2 values: up, down');

  // Enumerate all values
  print('\nVerticalDirection values:');
  for (final value in VerticalDirection.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('VerticalDirection has ${VerticalDirection.values.length} values');

  // Test up
  print('\nTest VerticalDirection.up:');
  final up = VerticalDirection.up;
  print('  Name: ${up.name}');
  print('  Layout: Bottom to top');
  print('  Similar to reverse order');

  // Test down
  print('\nTest VerticalDirection.down:');
  final down = VerticalDirection.down;
  print('  Name: ${down.name}');
  print('  Layout: Top to bottom');
  print('  Default behavior');

  // First and last
  print('\nFirst and last:');
  print('  First: ${VerticalDirection.values.first}');
  print('  Last: ${VerticalDirection.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  Column.verticalDirection');
  print('  Flex.verticalDirection');
  print('  ListBody.mainAxis');

  // Comparison with Axis
  print('\nComparison with Axis:');
  print('  Axis: Which axis');
  print('  VerticalDirection: Which way on axis');

  // Practical examples
  print('\nPractical examples:');
  print('  up: Chat messages (newest at bottom)');
  print('  down: Standard lists');

  // Switch pattern
  print('\nSwitch pattern:');
  final direction = VerticalDirection.down;
  switch (direction) {
    case VerticalDirection.up:
      print('  Laying out bottom to top');
      break;
    case VerticalDirection.down:
      print('  Laying out top to bottom');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  up == up: ${VerticalDirection.up == VerticalDirection.up}');
  print('  up == down: ${VerticalDirection.up == VerticalDirection.down}');

  // Default
  print('\nDefault:');
  print('  Column default: down');

  print('\n' + '=' * 50);
  print('VerticalDirection test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VerticalDirection Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: up, down'),
      Text('Purpose: Vertical layout direction'),
    ],
  );
}
