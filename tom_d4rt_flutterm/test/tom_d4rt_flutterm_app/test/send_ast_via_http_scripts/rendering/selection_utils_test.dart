// D4rt test script: Tests SelectionUtils from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionUtils test executing');
  final results = <String>[];

  // ========== Section 1: SelectionUtils Overview ==========
  print('--- Section 1: SelectionUtils Overview ---');
  
  print('SelectionUtils provides utility methods for selection operations');
  print('It is a class with static helper methods');
  results.add('SelectionUtils is utility class');

  // ========== Section 2: getResultBasedOnRect ==========
  print('--- Section 2: getResultBasedOnRect ---');
  
  // Test with different rect and point combinations
  final testRect = Rect.fromLTWH(100, 100, 200, 50);
  print('Test rect: $testRect');
  
  // Point before rect (left of rect)
  final pointBefore = Offset(50, 125);
  final resultBefore = SelectionUtils.getResultBasedOnRect(testRect, pointBefore);
  print('Point before rect ($pointBefore): $resultBefore');
  results.add('getResultBasedOnRect before: $resultBefore');
  
  // Point in rect
  final pointInside = Offset(200, 125);
  final resultInside = SelectionUtils.getResultBasedOnRect(testRect, pointInside);
  print('Point inside rect ($pointInside): $resultInside');
  results.add('getResultBasedOnRect inside: $resultInside');
  
  // Point after rect (right of rect)
  final pointAfter = Offset(350, 125);
  final resultAfter = SelectionUtils.getResultBasedOnRect(testRect, pointAfter);
  print('Point after rect ($pointAfter): $resultAfter');
  results.add('getResultBasedOnRect after: $resultAfter');

  // ========== Section 3: SelectionResult Enum ==========
  print('--- Section 3: SelectionResult Enum ---');
  
  for (final result in SelectionResult.values) {
    print('  ${result.name}: index=${result.index}');
  }
  print('Total SelectionResult values: ${SelectionResult.values.length}');
  results.add('SelectionResult values: ${SelectionResult.values.length}');

  // ========== Section 4: Edge Cases for getResultBasedOnRect ==========
  print('--- Section 4: Edge Cases ---');
  
  // Point above rect
  final pointAbove = Offset(200, 50);
  final resultAbove = SelectionUtils.getResultBasedOnRect(testRect, pointAbove);
  print('Point above ($pointAbove): $resultAbove');
  
  // Point below rect
  final pointBelow = Offset(200, 200);
  final resultBelow = SelectionUtils.getResultBasedOnRect(testRect, pointBelow);
  print('Point below ($pointBelow): $resultBelow');
  
  // Point at exact left edge
  final pointAtLeft = Offset(100, 125);
  final resultAtLeft = SelectionUtils.getResultBasedOnRect(testRect, pointAtLeft);
  print('Point at left edge ($pointAtLeft): $resultAtLeft');
  
  // Point at exact right edge
  final pointAtRight = Offset(300, 125);
  final resultAtRight = SelectionUtils.getResultBasedOnRect(testRect, pointAtRight);
  print('Point at right edge ($pointAtRight): $resultAtRight');
  results.add('Edge cases tested');

  // ========== Section 5: Different Rect Sizes ==========
  print('--- Section 5: Different Rect Sizes ---');
  
  final smallRect = Rect.fromLTWH(0, 0, 10, 10);
  final largeRect = Rect.fromLTWH(0, 0, 1000, 500);
  final thinRect = Rect.fromLTWH(0, 0, 5, 100);
  final wideRect = Rect.fromLTWH(0, 0, 500, 20);
  
  print('Small rect (10x10): $smallRect');
  print('Large rect (1000x500): $largeRect');
  print('Thin rect (5x100): $thinRect');
  print('Wide rect (500x20): $wideRect');
  
  // Test same point with different rects
  final testPoint = Offset(50, 50);
  print('Test point: $testPoint');
  print('  vs small rect: ${SelectionUtils.getResultBasedOnRect(smallRect, testPoint)}');
  print('  vs large rect: ${SelectionUtils.getResultBasedOnRect(largeRect, testPoint)}');
  results.add('Tested various rect sizes');

  // ========== Section 6: Rect Corners ==========
  print('--- Section 6: Rect Corners ---');
  
  final cornerRect = Rect.fromLTWH(100, 100, 100, 100);
  
  // Test corners
  final topLeft = Offset(100, 100);
  final topRight = Offset(200, 100);
  final bottomLeft = Offset(100, 200);
  final bottomRight = Offset(200, 200);
  
  print('Rect corners test ($cornerRect):');
  print('  Top-left (${topLeft}): ${SelectionUtils.getResultBasedOnRect(cornerRect, topLeft)}');
  print('  Top-right (${topRight}): ${SelectionUtils.getResultBasedOnRect(cornerRect, topRight)}');
  print('  Bottom-left (${bottomLeft}): ${SelectionUtils.getResultBasedOnRect(cornerRect, bottomLeft)}');
  print('  Bottom-right (${bottomRight}): ${SelectionUtils.getResultBasedOnRect(cornerRect, bottomRight)}');
  results.add('Rect corners tested');

  // ========== Section 7: Negative Coordinates ==========
  print('--- Section 7: Negative Coordinates ---');
  
  final negativeRect = Rect.fromLTWH(-50, -50, 100, 100);
  print('Negative rect: $negativeRect');
  
  final negPoint1 = Offset(-75, -25);
  final negPoint2 = Offset(0, 0);
  final negPoint3 = Offset(75, 25);
  
  print('Point in negative space ($negPoint1): ${SelectionUtils.getResultBasedOnRect(negativeRect, negPoint1)}');
  print('Point at origin ($negPoint2): ${SelectionUtils.getResultBasedOnRect(negativeRect, negPoint2)}');
  print('Point in positive space ($negPoint3): ${SelectionUtils.getResultBasedOnRect(negativeRect, negPoint3)}');
  results.add('Negative coordinates tested');

  // ========== Section 8: Zero-Size Rect ==========
  print('--- Section 8: Zero-Size Rect ---');
  
  final zeroRect = Rect.fromLTWH(50, 50, 0, 0);
  print('Zero-size rect: $zeroRect');
  
  final zeroTestPoint = Offset(50, 50);
  print('Point at zero rect ($zeroTestPoint): ${SelectionUtils.getResultBasedOnRect(zeroRect, zeroTestPoint)}');
  results.add('Zero-size rect tested');

  // ========== Section 9: Very Large Offsets ==========
  print('--- Section 9: Very Large Offsets ---');
  
  final normalRect = Rect.fromLTWH(0, 0, 100, 100);
  final veryFarPoint = Offset(10000, 10000);
  final veryNegativePoint = Offset(-10000, -10000);
  
  print('Very far point ($veryFarPoint): ${SelectionUtils.getResultBasedOnRect(normalRect, veryFarPoint)}');
  print('Very negative point ($veryNegativePoint): ${SelectionUtils.getResultBasedOnRect(normalRect, veryNegativePoint)}');
  results.add('Large offsets tested');

  print('SelectionUtils test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SelectionUtils Tests',
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text('✓ $r', style: TextStyle(fontSize: 14)),
          )),
        ],
      ),
    ),
  );
}
