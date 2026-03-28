// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxShape from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxShape test executing');
  print('=' * 50);

  // BoxShape enum overview
  print('BoxShape enum overview:');
  print('  - Shape of a box decoration');
  print('  - Used in BoxDecoration');
  print('  - 2 values: rectangle, circle');

  // Enumerate all values
  print('\nBoxShape values:');
  for (final value in BoxShape.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('BoxShape has ${BoxShape.values.length} values');

  // Test rectangle
  print('\nTest BoxShape.rectangle:');
  final rectangle = BoxShape.rectangle;
  print('  Name: ${rectangle.name}');
  print('  Index: ${rectangle.index}');
  print('  Can have borderRadius: Yes');

  // Test circle
  print('\nTest BoxShape.circle:');
  final circle = BoxShape.circle;
  print('  Name: ${circle.name}');
  print('  Index: ${circle.index}');
  print('  Square aspect forced: Yes');

  // First and last
  print('\nFirst and last:');
  print('  First: ${BoxShape.values.first}');
  print('  Last: ${BoxShape.values.last}');

  // Usage in BoxDecoration
  print('\nUsage in BoxDecoration:');
  final rectDec = BoxDecoration(shape: BoxShape.rectangle, color: Colors.blue);
  print('  Rectangle: ${rectDec.shape}');
  final circleDec = BoxDecoration(shape: BoxShape.circle, color: Colors.red);
  print('  Circle: ${circleDec.shape}');

  // Circle vs rectangle
  print('\nCircle vs rectangle:');
  print('  Circle: forces 1:1 aspect ratio');
  print('  Rectangle: uses container bounds');
  print('  Circle: cannot use borderRadius');
  print('  Rectangle: can use borderRadius');

  // Switch pattern
  print('\nSwitch pattern:');
  final shape = BoxShape.circle;
  switch (shape) {
    case BoxShape.rectangle:
      print('  Rectangular box');
      break;
    case BoxShape.circle:
      print('  Circular box');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  rectangle == rectangle: ${BoxShape.rectangle == BoxShape.rectangle}');
  print('  rectangle == circle: ${BoxShape.rectangle == BoxShape.circle}');
  print('  circle == circle: ${BoxShape.circle == BoxShape.circle}');

  // Related widgets
  print('\nRelated widgets:');
  print('  CircleAvatar uses circle shape');
  print('  Container uses rectangle by default');

  print('\n' + '=' * 50);
  print('BoxShape test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxShape Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: rectangle, circle'),
      Text('Purpose: Decoration shape'),
    ],
  );
}
