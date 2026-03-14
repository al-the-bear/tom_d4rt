// D4rt test script: Tests OutlinedBorder abstract via RoundedRectangleBorder from painting
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OutlinedBorder test executing');
  final results = <String>[];

  // ========== OutlinedBorder Tests via RoundedRectangleBorder ==========
  // OutlinedBorder is abstract, RoundedRectangleBorder extends it
  print('Testing OutlinedBorder via RoundedRectangleBorder...');

  // Test 1: Default RoundedRectangleBorder
  final border1 = RoundedRectangleBorder();
  assert(border1.side == BorderSide.none, 'Default side should be none');
  results.add('RoundedRectangleBorder default: side=${border1.side}');
  print('RoundedRectangleBorder default created');

  // Test 2: RoundedRectangleBorder with borderRadius
  final border2 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );
  assert(
    border2.borderRadius == BorderRadius.circular(10.0),
    'Radius should be 10.0',
  );
  results.add('RoundedRectangleBorder radius: ${border2.borderRadius}');
  print('RoundedRectangleBorder borderRadius: ${border2.borderRadius}');

  // Test 3: RoundedRectangleBorder with side
  final border3 = RoundedRectangleBorder(
    side: BorderSide(color: Color(0xFF000000), width: 2.0),
    borderRadius: BorderRadius.circular(8.0),
  );
  assert(border3.side.width == 2.0, 'Side width should be 2.0');
  results.add('RoundedRectangleBorder side: width=${border3.side.width}');
  print('RoundedRectangleBorder side: width=${border3.side.width}');

  // Test 4: CircleBorder (another OutlinedBorder implementation)
  final circleBorder = CircleBorder();
  assert(
    circleBorder.side == BorderSide.none,
    'Default circle side should be none',
  );
  results.add('CircleBorder: side=${circleBorder.side}');
  print('CircleBorder created');

  // Test 5: CircleBorder with side
  final circleBorder2 = CircleBorder(
    side: BorderSide(color: Color(0xFFFF0000), width: 3.0),
  );
  assert(circleBorder2.side.width == 3.0, 'Circle side width should be 3.0');
  results.add('CircleBorder side: width=${circleBorder2.side.width}');
  print('CircleBorder side: width=${circleBorder2.side.width}');

  // Test 6: StadiumBorder (another OutlinedBorder)
  final stadiumBorder = StadiumBorder();
  assert(
    stadiumBorder.side == BorderSide.none,
    'Default stadium side should be none',
  );
  results.add('StadiumBorder: created');
  print('StadiumBorder created');

  // Test 7: StadiumBorder with side
  final stadiumBorder2 = StadiumBorder(
    side: BorderSide(color: Color(0xFF00FF00), width: 1.5),
  );
  assert(stadiumBorder2.side.width == 1.5, 'Stadium side width should be 1.5');
  results.add('StadiumBorder side: width=${stadiumBorder2.side.width}');
  print('StadiumBorder side: width=${stadiumBorder2.side.width}');

  // Test 8: BeveledRectangleBorder
  final beveledBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  );
  assert(
    beveledBorder.borderRadius == BorderRadius.circular(5.0),
    'Bevel radius should match',
  );
  results.add('BeveledRectangleBorder radius: ${beveledBorder.borderRadius}');
  print('BeveledRectangleBorder created');

  // Test 9: OutlinedBorder copyWith (via RoundedRectangleBorder)
  final copied = border3.copyWith(
    side: BorderSide(width: 5.0, color: Color(0xFF0000FF)),
  );
  assert(copied.side.width == 5.0, 'Copied side width should be 5.0');
  results.add('copyWith side: width=${copied.side.width}');
  print('OutlinedBorder copyWith: width=${copied.side.width}');

  // Test 10: OutlinedBorder getOuterPath
  final rect10 = Rect.fromLTWH(0, 0, 100, 50);
  final outerPath = border2.getOuterPath(rect10);
  final outerBounds = outerPath.getBounds();
  assert(outerBounds.width == 100, 'Outer width should be 100');
  results.add('getOuterPath: ${outerBounds.width}x${outerBounds.height}');
  print('OutlinedBorder getOuterPath: $outerBounds');

  // Test 11: OutlinedBorder getInnerPath
  final innerPath = border3.getInnerPath(rect10);
  final innerBounds = innerPath.getBounds();
  results.add('getInnerPath: ${innerBounds.width}x${innerBounds.height}');
  print('OutlinedBorder getInnerPath: $innerBounds');

  // Test 12: OutlinedBorder scale
  final scaled = border3.scale(2.0);
  results.add('scale(2.0): applied');
  print('OutlinedBorder scale applied');

  // Test 13: OutlinedBorder lerp
  final borderA = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
  );
  final borderB = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  );
  final lerped = ShapeBorder.lerp(borderA, borderB, 0.5);
  assert(lerped != null, 'Lerped border should not be null');
  results.add('ShapeBorder.lerp: computed');
  print('OutlinedBorder lerp computed');

  // Test 14: OutlinedBorder equality
  final eq1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
  final eq2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
  assert(eq1 == eq2, 'Equal borders should be equal');
  results.add('OutlinedBorder equality: ${eq1 == eq2}');
  print('OutlinedBorder equality verified');

  print('OutlinedBorder test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OutlinedBorder Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
