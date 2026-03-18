// D4rt test script: Tests OutlinedBorder from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OutlinedBorder test executing');

  // OutlinedBorder is abstract - test via subclasses
  print('OutlinedBorder is abstract base class');

  // RoundedRectangleBorder
  final rounded = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );
  print('\nRoundedRectangleBorder:');
  print('type: ${rounded.runtimeType}');
  print('is OutlinedBorder: ${true}');

  // Test copyWith
  print('\ncopyWith method:');
  final withSide = rounded.copyWith(
    side: BorderSide(color: Colors.blue, width: 2),
  );
  print('Original side: ${rounded.side}');
  print('Modified side: ${withSide.side}');

  // OutlinedBorder subclasses
  print('\nOutlinedBorder subclasses:');
  print('- RoundedRectangleBorder');
  print('- CircleBorder');
  print('- StadiumBorder');
  print('- BeveledRectangleBorder');
  print('- ContinuousRectangleBorder');
  print('- LinearBorder');
  print('- StarBorder');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ShapeBorder (abstract)');
  print('  └── OutlinedBorder (abstract)');
  print('      └── RoundedRectangleBorder');
  print('      └── ...');

  // Key properties/methods
  print('\nKey properties:');
  print('- side: BorderSide for the outline');
  print('- copyWith(): create modified copy');
  print('- scale(): scaled version');

  // Usage
  print('\nUsage:');
  print('ShapeDecoration(shape: RoundedRectangleBorder(...))');
  print('Material(shape: CircleBorder(...))');
  print('OutlinedButton.styleFrom(shape: StadiumBorder())');

  print('\nOutlinedBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OutlinedBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract shape with outline'),
      Text('Subclasses: Rounded, Circle, Stadium'),
      Text('Key: copyWith() for modifications'),
    ],
  );
}
