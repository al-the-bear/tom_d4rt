// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Axis from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Axis test executing');
  print('=' * 50);

  // Axis enum overview
  print('Axis enum overview:');
  print('  - Cardinal direction in 2D');
  print('  - horizontal or vertical');
  print('  - 2 values');

  // Enumerate all values
  print('\nAxis values:');
  for (final value in Axis.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('Axis has ${Axis.values.length} values');

  // Test horizontal
  print('\nTest Axis.horizontal:');
  final horizontal = Axis.horizontal;
  print('  Name: ${horizontal.name}');
  print('  Index: ${horizontal.index}');
  print('  Flipped: ${flipAxis(horizontal)}');

  // Test vertical
  print('\nTest Axis.vertical:');
  final vertical = Axis.vertical;
  print('  Name: ${vertical.name}');
  print('  Index: ${vertical.index}');
  print('  Flipped: ${flipAxis(vertical)}');

  // flipAxis function
  print('\nflipAxis function:');
  print('  flipAxis(horizontal): ${flipAxis(Axis.horizontal)}');
  print('  flipAxis(vertical): ${flipAxis(Axis.vertical)}');

  // First and last
  print('\nFirst and last:');
  print('  First: ${Axis.values.first}');
  print('  Last: ${Axis.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  ListView.scrollDirection');
  print('  Flex direction');
  print('  ScrollController.axis');
  print('  Scrollbar.axis');

  // Switch pattern
  print('\nSwitch pattern:');
  final axis = Axis.horizontal;
  switch (axis) {
    case Axis.horizontal:
      print('  Horizontal layout');
      break;
    case Axis.vertical:
      print('  Vertical layout');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  horizontal == horizontal: ${Axis.horizontal == Axis.horizontal}');
  print('  horizontal == vertical: ${Axis.horizontal == Axis.vertical}');

  // Related to AxisDirection
  print('\nRelated to AxisDirection:');
  print('  horizontal -> left or right');
  print('  vertical -> up or down');

  // Cross axis
  print('\nCross axis concept:');
  print('  Main horizontal -> cross vertical');
  print('  Main vertical -> cross horizontal');

  print('\n' + '=' * 50);
  print('Axis test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Axis Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: horizontal, vertical'),
      Text('Purpose: Layout direction'),
    ],
  );
}
