// D4rt test script: Tests BoxBorder from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxBorder test executing');

  // BoxBorder is abstract - test via subclasses
  print('BoxBorder is abstract base class');

  // Border (subclass)
  final border = Border.all(color: Colors.blue, width: 2);
  print('\nBorder (extends BoxBorder):');
  print('type: ${border.runtimeType}');
  print('is BoxBorder: ${border is BoxBorder}');
  print('top: ${border.top}');
  print('bottom: ${border.bottom}');
  print('left: ${border.left}');
  print('right: ${border.right}');

  // BorderDirectional (subclass)
  final directional = BorderDirectional(
    start: BorderSide(color: Colors.red, width: 2),
    end: BorderSide(color: Colors.green, width: 2),
  );
  print('\nBorderDirectional (extends BoxBorder):');
  print('type: ${directional.runtimeType}');
  print('is BoxBorder: ${directional is BoxBorder}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ShapeBorder (abstract)');
  print('  └── BoxBorder (abstract)');
  print('      └── Border');
  print('      └── BorderDirectional');

  // Key properties
  print('\nBoxBorder properties:');
  print('- top, bottom: BorderSide (vertical)');
  print('- isUniform: all sides same');
  print('- dimensions: EdgeInsetsGeometry');

  // Paint methods
  print('\nPaint methods:');
  print('- paintBorder(): to canvas');
  print('- lerp(): interpolate between');

  // Usage
  print('\nUsage:');
  print('Container(');
  print('  decoration: BoxDecoration(');
  print('    border: Border.all(color: Colors.blue),');
  print('  ),');
  print(')');

  print('\nBoxBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BoxBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract box border base'),
      Text('Subclasses: Border, BorderDirectional'),
      Text('For: BoxDecoration'),
    ],
  );
}
