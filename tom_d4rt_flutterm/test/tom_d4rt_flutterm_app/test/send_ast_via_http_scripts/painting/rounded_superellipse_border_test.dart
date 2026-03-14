// D4rt test script: Tests RoundedSuperellipseBorder from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RoundedSuperellipseBorder test executing');

  // Create RoundedSuperellipseBorder
  final border = RoundedSuperellipseBorder(
    borderRadius: BorderRadiusGeometry.lerp(
      BorderRadius.circular(16),
      BorderRadius.circular(16),
      0.5,
    )!,
  );

  print('Created: ${border.runtimeType}');
  print('is ShapeBorder: ${border is ShapeBorder}');
  print('is OutlinedBorder: ${border is OutlinedBorder}');

  // What is a superellipse
  print('\nWhat is a superellipse:');
  print('- Squircle shape (iOS app icons)');
  print('- Smoother than rounded rectangle');
  print('- Continuous curvature');

  // vs RoundedRectangleBorder
  print('\nvs RoundedRectangleBorder:');
  print('RoundedRect: corners are circular arcs');
  print('Superellipse: continuous curve, no tangent discontinuity');

  // iOS style
  print('\niOS style:');
  print('- App icons use superellipse');
  print('- ContinuousRectangleBorder similar');
  print('- More "premium" look');

  // Properties
  print('\nProperties:');
  print('- borderRadius: corner radius');
  print('- side: BorderSide for outline');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ShapeBorder');
  print('  └── OutlinedBorder');
  print('      └── RoundedSuperellipseBorder');

  // Usage
  print('\nUsage:');
  print('Container(');
  print('  decoration: ShapeDecoration(');
  print('    shape: RoundedSuperellipseBorder(');
  print('      borderRadius: BorderRadius.circular(20),');
  print('    ),');
  print('  ),');
  print(')');

  print('\nRoundedSuperellipseBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RoundedSuperellipseBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Squircle / iOS style shape'),
      Text('Continuous curvature'),
      Text('Smoother than rounded rect'),
    ],
  );
}
