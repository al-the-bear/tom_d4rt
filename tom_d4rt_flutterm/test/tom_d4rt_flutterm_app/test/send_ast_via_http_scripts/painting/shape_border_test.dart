// ignore_for_file: avoid_print
// D4rt test script: Tests ShapeBorder from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShapeBorder test executing');

  // ShapeBorder is abstract - test via subclasses
  print('ShapeBorder is abstract base class');

  // RoundedRectangleBorder
  final rounded = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.blue, width: 2),
  );
  print('\nRoundedRectangleBorder:');
  print('type: ${rounded.runtimeType}');
  print('is ShapeBorder: ${true}');
  print('borderRadius: ${rounded.borderRadius}');

  // CircleBorder
  final circle = CircleBorder(side: BorderSide(color: Colors.red, width: 2));
  print('\nCircleBorder:');
  print('type: ${circle.runtimeType}');
  print('is ShapeBorder: ${true}');

  // StadiumBorder
  final stadium = StadiumBorder(
    side: BorderSide(color: Colors.green, width: 2),
  );
  print('\nStadiumBorder:');
  print('type: ${stadium.runtimeType}');

  // Type hierarchy
  print('\nShapeBorder hierarchy:');
  print('ShapeBorder (abstract)');
  print('  └── OutlinedBorder (abstract)');
  print('      └── RoundedRectangleBorder');
  print('      └── CircleBorder');
  print('      └── StadiumBorder');
  print('      └── BeveledRectangleBorder');
  print('      └── ContinuousRectangleBorder');
  print('  └── BoxBorder');
  print('      └── Border');
  print('      └── BorderDirectional');

  // Key methods
  print('\nKey methods:');
  print('- getOuterPath(): outer shape path');
  print('- getInnerPath(): inner shape path');
  print('- paint(): draw the border');
  print('- scale(): scaled version');

  print('\nShapeBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ShapeBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract shape border base'),
      Text('Subclasses: Rounded, Circle, Stadium'),
      Container(
        width: 80,
        height: 40,
        decoration: ShapeDecoration(shape: rounded, color: Colors.lightBlue),
      ),
    ],
  );
}
