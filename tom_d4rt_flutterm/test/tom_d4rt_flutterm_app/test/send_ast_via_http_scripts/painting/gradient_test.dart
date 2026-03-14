// D4rt test script: Tests Gradient classes from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gradient test executing');
  final results = <String>[];

  // ========== LinearGradient Tests ==========
  print('Testing LinearGradient...');

  // Test 1: Basic LinearGradient with two colors
  final linearGradient1 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(linearGradient1.colors.length == 2, 'LinearGradient should have 2 colors');
  results.add('LinearGradient basic: ${linearGradient1.colors.length} colors');
  print('LinearGradient basic: ${linearGradient1.colors.length} colors');

  // Test 2: LinearGradient with custom begin/end
  final linearGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
  );
  assert(linearGradient2.begin == Alignment.topLeft, 'Begin should be topLeft');
  assert(linearGradient2.end == Alignment.bottomRight, 'End should be bottomRight');
  results.add('LinearGradient begin/end: ${linearGradient2.begin} to ${linearGradient2.end}');
  print('LinearGradient begin/end verified');

  // Test 3: LinearGradient with stops
  final linearGradient3 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
    stops: [0.0, 0.5, 1.0],
  );
  assert(linearGradient3.stops != null, 'Stops should not be null');
  assert(linearGradient3.stops!.length == 3, 'Should have 3 stops');
  results.add('LinearGradient stops: ${linearGradient3.stops}');
  print('LinearGradient stops: ${linearGradient3.stops}');

  // Test 4: LinearGradient with TileMode
  final linearGradient4 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    tileMode: TileMode.mirror,
  );
  assert(linearGradient4.tileMode == TileMode.mirror, 'TileMode should be mirror');
  results.add('LinearGradient tileMode: ${linearGradient4.tileMode}');
  print('LinearGradient tileMode: ${linearGradient4.tileMode}');

  // Test 5: LinearGradient with transform
  final transform = GradientRotation(3.14159 / 4);
  final linearGradient5 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    transform: transform,
  );
  assert(linearGradient5.transform != null, 'Transform should not be null');
  results.add('LinearGradient transform: applied');
  print('LinearGradient transform applied');

  // ========== RadialGradient Tests ==========
  print('Testing RadialGradient...');

  // Test 6: Basic RadialGradient
  final radialGradient1 = RadialGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFF000000)],
  );
  assert(radialGradient1.colors.length == 2, 'RadialGradient should have 2 colors');
  results.add('RadialGradient basic: ${radialGradient1.colors.length} colors');
  print('RadialGradient basic: ${radialGradient1.colors.length} colors');

  // Test 7: RadialGradient with center
  final radialGradient2 = RadialGradient(
    center: Alignment.topRight,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(radialGradient2.center == Alignment.topRight, 'Center should be topRight');
  results.add('RadialGradient center: ${radialGradient2.center}');
  print('RadialGradient center: ${radialGradient2.center}');

  // Test 8: RadialGradient with radius
  final radialGradient3 = RadialGradient(
    radius: 0.75,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(radialGradient3.radius == 0.75, 'Radius should be 0.75');
  results.add('RadialGradient radius: ${radialGradient3.radius}');
  print('RadialGradient radius: ${radialGradient3.radius}');

  // Test 9: RadialGradient with focal
  final radialGradient4 = RadialGradient(
    center: Alignment.center,
    focal: Alignment.topLeft,
    focalRadius: 0.1,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(radialGradient4.focal == Alignment.topLeft, 'Focal should be topLeft');
  assert(radialGradient4.focalRadius == 0.1, 'FocalRadius should be 0.1');
  results.add('RadialGradient focal: ${radialGradient4.focal}, focalRadius: ${radialGradient4.focalRadius}');
  print('RadialGradient focal settings verified');

  // ========== SweepGradient Tests ==========
  print('Testing SweepGradient...');

  // Test 10: Basic SweepGradient
  final sweepGradient1 = SweepGradient(
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF), Color(0xFFFF0000)],
  );
  assert(sweepGradient1.colors.length == 4, 'SweepGradient should have 4 colors');
  results.add('SweepGradient basic: ${sweepGradient1.colors.length} colors');
  print('SweepGradient basic: ${sweepGradient1.colors.length} colors');

  // Test 11: SweepGradient with angles
  final sweepGradient2 = SweepGradient(
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(sweepGradient2.startAngle == 0.0, 'StartAngle should be 0.0');
  results.add('SweepGradient angles: start=${sweepGradient2.startAngle}, end=${sweepGradient2.endAngle}');
  print('SweepGradient angles verified');

  // ========== Gradient comparison tests ==========
  print('Testing gradient equality...');

  // Test 12: LinearGradient equality
  final lgA = LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF0000FF)]);
  final lgB = LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF0000FF)]);
  assert(lgA == lgB, 'Identical LinearGradients should be equal');
  results.add('LinearGradient equality: ${lgA == lgB}');
  print('LinearGradient equality: ${lgA == lgB}');

  // Test 13: Different gradients should not be equal
  final lgC = LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF00FF00)]);
  assert(lgA != lgC, 'Different LinearGradients should not be equal');
  results.add('LinearGradient inequality: ${lgA != lgC}');
  print('LinearGradient inequality verified');

  // Test 14: Gradient hashCode
  final hashA = lgA.hashCode;
  final hashB = lgB.hashCode;
  assert(hashA == hashB, 'Equal gradients should have same hashCode');
  results.add('LinearGradient hashCode match: ${hashA == hashB}');
  print('LinearGradient hashCode: $hashA');

  // Test 15: All TileModes
  for (final mode in TileMode.values) {
    final lg = LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF0000FF)], tileMode: mode);
    assert(lg.tileMode == mode, 'TileMode should match');
    results.add('TileMode.$mode gradient created');
    print('TileMode.$mode verified');
  }

  print('Gradient test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Gradient Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 11)),
      )),
    ],
  );
}
