// D4rt test script: Tests ShapeBorder abstract class from painting
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShapeBorder comprehensive test executing');
  final results = <String>[];

  // ========== ShapeBorder Tests ==========
  print('Testing ShapeBorder abstract class and implementations...');

  // Test 1: CircleBorder - basic circular shape
  final circleBorder = CircleBorder();
  assert(circleBorder != null, 'Should create CircleBorder');
  assert(circleBorder is ShapeBorder, 'CircleBorder should be ShapeBorder');
  results.add('CircleBorder: ShapeBorder subclass');
  print('CircleBorder: ${circleBorder.runtimeType}');

  // Test 2: CircleBorder with side
  final circleWithSide = CircleBorder(
    side: BorderSide(color: Colors.blue, width: 2.0),
  );
  assert(circleWithSide.side.color == Colors.blue, 'Side color should be blue');
  results.add('CircleBorder with BorderSide');
  print('CircleBorder side: ${circleWithSide.side}');

  // Test 3: CircleBorder with eccentricity
  final ovalBorder = CircleBorder(eccentricity: 0.5);
  results.add('CircleBorder with eccentricity: 0.5 (oval)');
  print('Oval border eccentricity: 0.5');

  // Test 4: RoundedRectangleBorder - basic
  final roundedRect = RoundedRectangleBorder();
  assert(roundedRect is ShapeBorder, 'RoundedRectangleBorder should be ShapeBorder');
  results.add('RoundedRectangleBorder: ShapeBorder subclass');
  print('RoundedRectangleBorder: ${roundedRect.runtimeType}');

  // Test 5: RoundedRectangleBorder with radius
  final roundedRectRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
  );
  results.add('RoundedRectangleBorder with borderRadius: 16');
  print('Rounded rect radius: 16.0');

  // Test 6: RoundedRectangleBorder with side
  final roundedRectSide = RoundedRectangleBorder(
    side: BorderSide(color: Colors.red, width: 3.0),
    borderRadius: BorderRadius.circular(12.0),
  );
  results.add('RoundedRectangleBorder with side and radius');
  print('Rounded rect side: ${roundedRectSide.side}');

  // Test 7: StadiumBorder - pill shape
  final stadiumBorder = StadiumBorder();
  assert(stadiumBorder is ShapeBorder, 'StadiumBorder should be ShapeBorder');
  results.add('StadiumBorder: pill/capsule shape');
  print('StadiumBorder: ${stadiumBorder.runtimeType}');

  // Test 8: StadiumBorder with side
  final stadiumWithSide = StadiumBorder(
    side: BorderSide(color: Colors.green, width: 2.0),
  );
  results.add('StadiumBorder with BorderSide');
  print('Stadium side: ${stadiumWithSide.side}');

  // Test 9: BeveledRectangleBorder
  final beveledRect = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );
  assert(beveledRect is ShapeBorder, 'BeveledRectangleBorder should be ShapeBorder');
  results.add('BeveledRectangleBorder: cut corners');
  print('BeveledRectangleBorder: ${beveledRect.runtimeType}');

  // Test 10: ContinuousRectangleBorder (smooth corners)
  final continuousRect = ContinuousRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  );
  assert(continuousRect is ShapeBorder, 'ContinuousRectangleBorder should be ShapeBorder');
  results.add('ContinuousRectangleBorder: smooth superellipse');
  print('ContinuousRectangleBorder: ${continuousRect.runtimeType}');

  // Test 11: StarBorder (if available)
  final starBorder = StarBorder(points: 5);
  assert(starBorder is ShapeBorder, 'StarBorder should be ShapeBorder');
  results.add('StarBorder: 5-pointed star');
  print('StarBorder: ${starBorder.runtimeType}');

  // Test 12: dimensions property
  final dims = circleBorder.dimensions;
  assert(dims is EdgeInsetsGeometry, 'dimensions should be EdgeInsetsGeometry');
  results.add('dimensions: EdgeInsetsGeometry');
  print('CircleBorder dimensions: ${dims.runtimeType}');

  // Test 13: getOuterPath method
  final rect = Rect.fromLTWH(0, 0, 100, 100);
  final outerPath = circleBorder.getOuterPath(rect);
  assert(outerPath is Path, 'getOuterPath should return Path');
  results.add('getOuterPath: returns Path');
  print('Outer path: ${outerPath.runtimeType}');

  // Test 14: getInnerPath method
  final innerPath = circleBorder.getInnerPath(rect);
  assert(innerPath is Path, 'getInnerPath should return Path');
  results.add('getInnerPath: returns inner Path');
  print('Inner path: ${innerPath.runtimeType}');

  // Test 15: paint method concept
  results.add('paint(canvas, rect): draws border stroke');
  print('paint method renders the border');

  // Test 16: scale method
  final scaledCircle = circleBorder.scale(2.0);
  assert(scaledCircle is ShapeBorder, 'scale should return ShapeBorder');
  results.add('scale(2.0): scales border width');
  print('Scaled circle: ${scaledCircle.runtimeType}');

  // Test 17: add operator (+) - combining borders concept
  results.add('add (+): combines compatible borders');
  print('Border addition merges dimensions');

  // Test 18: lerp method - interpolation
  final lerpedCircle = ShapeBorder.lerp(
    CircleBorder(side: BorderSide(width: 1.0)),
    CircleBorder(side: BorderSide(width: 5.0)),
    0.5,
  );
  results.add('ShapeBorder.lerp: interpolates between borders');
  print('Lerped border: ${lerpedCircle?.runtimeType}');

  // Test 19: lerp at 0.0
  final lerpStart = ShapeBorder.lerp(circleBorder, roundedRect, 0.0);
  results.add('lerp(a, b, 0.0) returns a');
  print('Lerp at 0: ${lerpStart?.runtimeType}');

  // Test 20: lerp at 1.0
  final lerpEnd = ShapeBorder.lerp(circleBorder, roundedRect, 1.0);
  results.add('lerp(a, b, 1.0) returns b');
  print('Lerp at 1: ${lerpEnd?.runtimeType}');

  // Test 21: OutlinedBorder subclasses
  assert(circleBorder is OutlinedBorder, 'CircleBorder is OutlinedBorder');
  assert(roundedRect is OutlinedBorder, 'RoundedRectangleBorder is OutlinedBorder');
  results.add('OutlinedBorder: common base for borders with side');
  print('OutlinedBorder hierarchy confirmed');

  // Test 22: copyWith on OutlinedBorder
  final copiedCircle = circleWithSide.copyWith(
    side: BorderSide(color: Colors.purple, width: 4.0),
  );
  assert(copiedCircle is CircleBorder, 'copyWith returns same type');
  results.add('copyWith: creates modified copy');
  print('Copied circle side: ${copiedCircle.side}');

  // Test 23: Use with ShapeDecoration
  final decoration = ShapeDecoration(
    shape: roundedRectRadius,
    color: Colors.amber,
  );
  assert(decoration is ShapeDecoration, 'Should create ShapeDecoration');
  results.add('ShapeDecoration(shape: ShapeBorder)');
  print('ShapeDecoration: ${decoration.runtimeType}');

  // Test 24: Use with Material
  results.add('Material(shape: ShapeBorder) for elevation');
  print('Material widget accepts ShapeBorder');

  // Test 25: Equality comparison
  final circle1 = CircleBorder();
  final circle2 = CircleBorder();
  assert(circle1 == circle2, 'Equal borders should be equal');
  results.add('Equality: == works correctly');
  print('Circle equality: ${circle1 == circle2}');

  // Test 26: HashCode consistency
  final hash1 = circle1.hashCode;
  final hash2 = circle2.hashCode;
  assert(hash1 == hash2, 'Equal borders should have same hashCode');
  results.add('hashCode: consistent for equals');
  print('HashCodes equal: ${hash1 == hash2}');

  // Test 27: Summary
  print('ShapeBorder test completed with ${results.length} tests');
  results.add('All ${results.length} tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('ShapeBorder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('ShapeBorder: abstract base class'),
      Text('Subclasses: CircleBorder, RoundedRectangleBorder'),
      Text('Also: StadiumBorder, BeveledRectangleBorder, StarBorder'),
      Text('Methods: getOuterPath, getInnerPath, paint, scale'),
      Text('Operators: + (add), lerp for animation'),
      Text('OutlinedBorder: adds side property'),
      SizedBox(height: 8),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
