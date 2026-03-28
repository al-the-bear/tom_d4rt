// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AxisDirection from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AxisDirection test executing');
  print('=' * 50);

  // AxisDirection enum overview
  print('AxisDirection enum overview:');
  print('  - Scroll direction along an axis');
  print('  - Used in scrollable widgets');
  print('  - 4 values: up, right, down, left');

  // Enumerate all values
  print('\nAxisDirection values:');
  for (final value in AxisDirection.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('AxisDirection has ${AxisDirection.values.length} values');

  // Test up direction
  print('\nTest AxisDirection.up:');
  final up = AxisDirection.up;
  print('  Name: ${up.name}');
  print('  Axis: ${axisDirectionToAxis(up)}');
  print('  Reversed: ${axisDirectionIsReversed(up)}');

  // Test right direction  
  print('\nTest AxisDirection.right:');
  final right = AxisDirection.right;
  print('  Name: ${right.name}');
  print('  Axis: ${axisDirectionToAxis(right)}');
  print('  Reversed: ${axisDirectionIsReversed(right)}');

  // Test down direction
  print('\nTest AxisDirection.down:');
  final down = AxisDirection.down;
  print('  Name: ${down.name}');
  print('  Axis: ${axisDirectionToAxis(down)}');
  print('  Reversed: ${axisDirectionIsReversed(down)}');

  // Test left direction
  print('\nTest AxisDirection.left:');
  final left = AxisDirection.left;
  print('  Name: ${left.name}');
  print('  Axis: ${axisDirectionToAxis(left)}');
  print('  Reversed: ${axisDirectionIsReversed(left)}');

  // Flip tests
  print('\nFlip tests:');
  print('  flipAxisDirection(up): ${flipAxisDirection(up)}');
  print('  flipAxisDirection(right): ${flipAxisDirection(right)}');
  print('  flipAxisDirection(down): ${flipAxisDirection(down)}');
  print('  flipAxisDirection(left): ${flipAxisDirection(left)}');

  // Axis mapping
  print('\nAxis mapping:');
  print('  Vertical: up, down');
  print('  Horizontal: left, right');

  // Usage context
  print('\nUsage context:');
  print('  Viewport.axisDirection');
  print('  ScrollPosition.axisDirection');
  print('  RenderSliver.axisDirection');

  print('\n' + '=' * 50);
  print('AxisDirection test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AxisDirection Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: up, right, down, left'),
      Text('Purpose: Scroll direction'),
    ],
  );
}
