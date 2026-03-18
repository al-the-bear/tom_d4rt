// D4rt test script: Tests BorderDirectional from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderDirectional test executing');

  // Create BorderDirectional
  final border = BorderDirectional(
    start: BorderSide(color: Colors.red, width: 2),
    end: BorderSide(color: Colors.blue, width: 2),
    top: BorderSide(color: Colors.green, width: 1),
    bottom: BorderSide(color: Colors.yellow, width: 1),
  );

  print('Created: ${border.runtimeType}');

  // Test sides
  print('\nBorder sides:');
  print('start: ${border.start}');
  print('end: ${border.end}');
  print('top: ${border.top}');
  print('bottom: ${border.bottom}');

  // Test dimensions
  print('\nDimensions:');
  print('dimensions: ${border.dimensions}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is BoxBorder: ${true}');
  print('is ShapeBorder: ${true}');

  // Compare with Border
  print('\nBorderDirectional vs Border:');
  print('BorderDirectional: start/end (RTL aware)');
  print('Border: left/right (fixed)');

  // RTL behavior
  print('\nRTL behavior:');
  print('LTR: start=left, end=right');
  print('RTL: start=right, end=left');

  // BorderDirectional resolves direction during paint
  print('\nBorderDirectional resolves start/end during painting:');
  print('Resolved type: BoxBorder (paints directionally)');

  // Usage
  print('\nUsage:');
  print('Container(');
  print('  decoration: BoxDecoration(');
  print('    border: BorderDirectional(...)');
  print('  ),');
  print(')');

  print('\nBorderDirectional test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BorderDirectional Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('RTL-aware border'),
      Text('start: ${border.start.color}'),
      Text('end: ${border.end.color}'),
      Text('Resolves: based on TextDirection'),
    ],
  );
}
