// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BorderStyle from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderStyle test executing');
  print('=' * 50);

  // BorderStyle enum overview
  print('BorderStyle enum overview:');
  print('  - Border rendering style');
  print('  - Used in BorderSide');
  print('  - 2 values: none, solid');

  // Enumerate all values
  print('\nBorderStyle values:');
  for (final value in BorderStyle.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('BorderStyle has ${BorderStyle.values.length} values');

  // Test none
  print('\nTest BorderStyle.none:');
  final none = BorderStyle.none;
  print('  Name: ${none.name}');
  print('  Index: ${none.index}');
  print('  Renders: No border drawn');

  // Test solid
  print('\nTest BorderStyle.solid:');
  final solid = BorderStyle.solid;
  print('  Name: ${solid.name}');
  print('  Index: ${solid.index}');
  print('  Renders: Solid line border');

  // First and last
  print('\nFirst and last:');
  print('  First: ${BorderStyle.values.first}');
  print('  Last: ${BorderStyle.values.last}');

  // Usage in BorderSide
  print('\nUsage in BorderSide:');
  final side1 = BorderSide(color: Colors.blue, width: 2.0, style: BorderStyle.solid);
  print('  Solid border side: ${side1.style}');
  final side2 = BorderSide.none;
  print('  No border side: ${side2.style}');

  // Usage in Border
  print('\nUsage in Border:');
  final border = Border.all(color: Colors.red, style: BorderStyle.solid);
  print('  Border.all with solid: ${border.top.style}');

  // Comparison
  print('\nComparison:');
  print('  none == none: ${BorderStyle.none == BorderStyle.none}');
  print('  none == solid: ${BorderStyle.none == BorderStyle.solid}');
  print('  solid == solid: ${BorderStyle.solid == BorderStyle.solid}');

  // Switch pattern
  print('\nSwitch pattern:');
  final style = BorderStyle.solid;
  switch (style) {
    case BorderStyle.none:
      print('  No border rendered');
      break;
    case BorderStyle.solid:
      print('  Solid border rendered');
      break;
  }

  // Default behavior
  print('\nDefault behavior:');
  print('  BorderSide default: solid');
  print('  BorderSide.none: none');

  print('\n' + '=' * 50);
  print('BorderStyle test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BorderStyle Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: none, solid'),
      Text('Purpose: Border rendering'),
    ],
  );
}
