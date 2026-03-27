// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Orientation from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Orientation test executing');
  print('=' * 50);

  // === Test Orientation enum ===
  print('\nOrientation indicates device orientation');

  // List all values
  print('\n--- Enum values ---');
  for (final orientation in Orientation.values) {
    print('Orientation.${orientation.name}');
  }

  // Test portrait value
  print('\n--- Testing portrait ---');
  final portrait = Orientation.portrait;
  print('portrait.name: ${portrait.name}');
  print('portrait.index: ${portrait.index}');
  print('Height > Width');

  // Test landscape value
  print('\n--- Testing landscape ---');
  final landscape = Orientation.landscape;
  print('landscape.name: ${landscape.name}');
  print('landscape.index: ${landscape.index}');
  print('Width > Height');

  // Test comparison
  print('\n--- Testing comparison ---');
  print('portrait == landscape: ${portrait == landscape}');
  print('portrait == Orientation.portrait: ${portrait == Orientation.portrait}');

  // Get from MediaQuery
  print('\n--- Getting from MediaQuery ---');
  final orientation = MediaQuery.of(context).orientation;
  print('Current orientation: ${orientation.name}');
  print('MediaQuery.orientationOf(context) also works');

  // Test with OrientationBuilder
  print('\n--- Testing with OrientationBuilder ---');
  final builder = OrientationBuilder(
    builder: (context, orientation) {
      print('OrientationBuilder: ${orientation.name}');
      return orientation == Orientation.portrait
          ? Text('Portrait mode')
          : Text('Landscape mode');
    },
  );
  print('Created OrientationBuilder');

  // Responsive design
  print('\n--- Responsive design ---');
  print('portrait: vertical layout');
  print('landscape: horizontal layout');
  print('Switch layouts based on orientation');

  // MediaQueryData.orientation
  print('\n--- MediaQueryData.orientation ---');
  final mqd = MediaQuery.of(context);
  print('mqd.orientation: ${mqd.orientation}');
  print('Computed from size.width vs size.height');

  print('\n' + '=' * 50);
  print('Orientation test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Orientation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('portrait.index: ${portrait.index}'),
      Text('landscape.index: ${landscape.index}'),
      Text('Current: ${orientation.name}'),
      builder,
    ],
  );
}
