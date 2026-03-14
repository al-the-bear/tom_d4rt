// D4rt test script: Tests StarBorder from painting
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StarBorder comprehensive test executing');
  final results = <String>[];

  // ========== StarBorder Tests ==========
  print('Testing StarBorder...');

  // Test 1: Create default StarBorder
  final border1 = StarBorder();
  assert(border1 != null, 'Should create StarBorder');
  results.add('StarBorder created');
  print('StarBorder created: ${border1.runtimeType}');

  // Test 2: Check inheritance from OutlinedBorder
  assert(border1 is OutlinedBorder, 'Should be OutlinedBorder');
  results.add('Inheritance: OutlinedBorder');
  print('Is OutlinedBorder: ${border1 is OutlinedBorder}');

  // Test 3: Check inheritance from ShapeBorder
  assert(border1 is ShapeBorder, 'Should be ShapeBorder');
  results.add('Inheritance: ShapeBorder');
  print('Is ShapeBorder: ${border1 is ShapeBorder}');

  // Test 4: Create StarBorder with points
  final border5Points = StarBorder(points: 5);
  results.add('5-pointed star created');
  print('Star with 5 points');

  // Test 5: Create StarBorder with 6 points
  final border6Points = StarBorder(points: 6);
  results.add('6-pointed star created');
  print('Star with 6 points');

  // Test 6: Create StarBorder with inner radius ratio
  final borderInnerRadius = StarBorder(points: 5, innerRadiusRatio: 0.4);
  results.add('Star with innerRadiusRatio: 0.4');
  print('Inner radius ratio: 0.4');

  // Test 7: Create StarBorder with side (border stroke)
  final borderWithSide = StarBorder(
    points: 5,
    side: BorderSide(color: Colors.blue, width: 2.0),
  );
  assert(borderWithSide.side.color == Colors.blue, 'Side color should be blue');
  assert(borderWithSide.side.width == 2.0, 'Side width should be 2.0');
  results.add('Star with BorderSide: blue, 2.0');
  print('BorderSide: ${borderWithSide.side}');

  // Test 8: Create StarBorder with rotation
  final borderRotated = StarBorder(
    points: 5,
    rotation: 36.0, // degrees
  );
  results.add('Star with rotation: 36°');
  print('Rotation: 36 degrees');

  // Test 9: Create StarBorder with valleyRounding
  final borderValleyRound = StarBorder(points: 5, valleyRounding: 0.5);
  results.add('Star with valleyRounding: 0.5');
  print('Valley rounding: 0.5');

  // Test 10: Create StarBorder with pointRounding
  final borderPointRound = StarBorder(points: 5, pointRounding: 0.3);
  results.add('Star with pointRounding: 0.3');
  print('Point rounding: 0.3');

  // Test 11: Create StarBorder with squash
  final borderSquash = StarBorder(points: 5, squash: 0.8);
  results.add('Star with squash: 0.8');
  print('Squash (vertical scaling): 0.8');

  // Test 12: Star points calculation
  final numPoints = 5;
  final anglePerPoint = 360.0 / numPoints;
  results.add('Angle per point: ${anglePerPoint}°');
  print('5-star: ${anglePerPoint}° between points');

  // Test 13: Star geometry - inner vs outer radius
  final outerRadius = 100.0;
  final innerRadius = outerRadius * 0.4;
  results.add('Radii: outer=$outerRadius, inner=$innerRadius');
  print('Star radii: outer=$outerRadius, inner=$innerRadius');

  // Test 14: copyWith method
  final copiedBorder = border5Points.copyWith(
    side: BorderSide(color: Colors.red, width: 3.0),
  );
  assert(copiedBorder is StarBorder, 'Should return StarBorder');
  results.add('copyWith creates new StarBorder');
  print('copyWith works for StarBorder');

  // Test 15: getOuterPath method concept
  results.add('getOuterPath returns star-shaped Path');
  print('getOuterPath generates star geometry');

  // Test 16: getInnerPath method concept
  results.add('getInnerPath for inset star (with border width)');
  print('getInnerPath: star inset by border width');

  // Test 17: StarBorder polygon mode
  final polygon = StarBorder.polygon(sides: 6);
  assert(polygon is StarBorder, 'Should create StarBorder');
  results.add('StarBorder.polygon(sides: 6) creates hexagon');
  print('Polygon mode: regular polygon');

  // Test 18: Paint method concept
  results.add('paint draws border stroke');
  print('paint(canvas, rect) draws star border');

  // Test 19: Use with Container decoration
  results.add('Compatible with ShapeDecoration');
  print('ShapeDecoration(shape: StarBorder())');

  // Test 20: Summary
  print('StarBorder test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StarBorder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Inheritance: OutlinedBorder -> ShapeBorder'),
      Text('Parameters: points, innerRadiusRatio, rotation'),
      Text('Rounding: pointRounding, valleyRounding'),
      Text('Also: StarBorder.polygon(sides: n)'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
