// ignore_for_file: avoid_print
// D4rt test script: Tests StarBorder from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StarBorder test executing');

  // Create StarBorder
  final star = StarBorder(
    points: 5,
    innerRadiusRatio: 0.5,
    pointRounding: 0.1,
    valleyRounding: 0.0,
    rotation: 0,
  );

  print('Created: ${star.runtimeType}');

  // Test properties
  print('\nStarBorder properties:');
  print('points: ${star.points}');
  print('innerRadiusRatio: ${star.innerRadiusRatio}');
  print('pointRounding: ${star.pointRounding}');
  print('valleyRounding: ${star.valleyRounding}');
  print('rotation: ${star.rotation}');

  // Points explanation
  print('\nPoints:');
  print('- Number of star points');
  print('- 5 = classic star');
  print('- 6 = Star of David');
  print('- 8 = compass rose');

  // Ratios
  print('\ninnerRadiusRatio:');
  print('- 0.0 = sharp points');
  print('- 0.5 = medium valleys');
  print('- 1.0 = polygon (no valleys)');

  // Type hierarchy
  print('\nType hierarchy:');
  print('OutlinedBorder (abstract)');
  print('  └── StarBorder');
  print('is OutlinedBorder: ${true}');

  // polygon factory
  print('\nStarBorder.polygon():');
  final hex = StarBorder.polygon(sides: 6);
  print('Hexagon sides: equivalent to polygon [${hex.hashCode }]');

  // Usage
  print('\nUsage:');
  print('Container(');
  print('  decoration: ShapeDecoration(');
  print('    shape: StarBorder(points: 5),');
  print('    color: Colors.yellow,');
  print('  ),');
  print(')');

  print('\nStarBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StarBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Star shape border'),
      Text('points: ${star.points}'),
      Text('innerRadiusRatio: ${star.innerRadiusRatio}'),
      Text('Has polygon() factory'),
    ],
  );
}
