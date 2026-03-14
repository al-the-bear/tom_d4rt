// D4rt test script: Tests TextSelectionPoint from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionPoint test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic TextSelectionPoint Creation ---');
  
  final point1 = TextSelectionPoint(
    Offset(100.0, 50.0),
    TextDirection.ltr,
  );
  print('Created TextSelectionPoint: ${point1.runtimeType}');
  print('point: ${point1.point}');
  print('direction: ${point1.direction}');
  results.add('Basic creation successful');

  // ========== Section 2: Various Points ==========
  print('--- Section 2: Various Points ---');
  
  final points = [
    Offset(0, 0),
    Offset(50, 25),
    Offset(100, 100),
    Offset(200, 150),
    Offset(500, 300),
  ];
  for (final point in points) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Point $point: ${tsp.point}');
  }
  results.add('Tested ${points.length} points');

  // ========== Section 3: Text Direction LTR ==========
  print('--- Section 3: Text Direction LTR ---');
  
  final ltrPoint = TextSelectionPoint(
    Offset(100.0, 50.0),
    TextDirection.ltr,
  );
  print('LTR direction: ${ltrPoint.direction}');
  print('Is LTR: ${ltrPoint.direction == TextDirection.ltr}');
  results.add('LTR direction tested');

  // ========== Section 4: Text Direction RTL ==========
  print('--- Section 4: Text Direction RTL ---');
  
  final rtlPoint = TextSelectionPoint(
    Offset(100.0, 50.0),
    TextDirection.rtl,
  );
  print('RTL direction: ${rtlPoint.direction}');
  print('Is RTL: ${rtlPoint.direction == TextDirection.rtl}');
  results.add('RTL direction tested');

  // ========== Section 5: Null Direction ==========
  print('--- Section 5: Null Direction ---');
  
  final nullDirPoint = TextSelectionPoint(
    Offset(100.0, 50.0),
    null,
  );
  print('Null direction: ${nullDirPoint.direction}');
  print('Is null: ${nullDirPoint.direction == null}');
  results.add('Null direction tested');

  // ========== Section 6: Point Components ==========
  print('--- Section 6: Point Components ---');
  
  final point2 = TextSelectionPoint(
    Offset(150.0, 75.0),
    TextDirection.ltr,
  );
  print('point.dx: ${point2.point.dx}');
  print('point.dy: ${point2.point.dy}');
  print('point.distance: ${point2.point.distance}');
  print('point.direction: ${point2.point.direction}');
  results.add('Point components tested');

  // ========== Section 7: Multiple Instances with Different Directions ==========
  print('--- Section 7: Multiple Instances with Different Directions ---');
  
  final directions = [TextDirection.ltr, TextDirection.rtl, null];
  for (final dir in directions) {
    final tsp = TextSelectionPoint(
      Offset(100.0, 50.0),
      dir,
    );
    print('Direction $dir: ${tsp.direction}');
  }
  results.add('Tested ${directions.length} directions');

  // ========== Section 8: Negative Point Coordinates ==========
  print('--- Section 8: Negative Point Coordinates ---');
  
  final negativePoints = [
    Offset(-10, -5),
    Offset(-50, 25),
    Offset(100, -50),
    Offset(-200, -150),
  ];
  for (final point in negativePoints) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Negative point $point: ${tsp.point}');
  }
  results.add('Tested ${negativePoints.length} negative points');

  // ========== Section 9: Large Point Coordinates ==========
  print('--- Section 9: Large Point Coordinates ---');
  
  final largePoints = [
    Offset(10000, 5000),
    Offset(50000, 25000),
    Offset(100000, 50000),
  ];
  for (final point in largePoints) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Large point: dx=${tsp.point.dx}, dy=${tsp.point.dy}');
  }
  results.add('Tested ${largePoints.length} large points');

  // ========== Section 10: Fractional Point Coordinates ==========
  print('--- Section 10: Fractional Point Coordinates ---');
  
  final fractionalPoints = [
    Offset(0.1, 0.2),
    Offset(1.5, 2.5),
    Offset(10.123, 20.456),
    Offset(100.999, 200.001),
  ];
  for (final point in fractionalPoints) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Fractional point: ${tsp.point}');
  }
  results.add('Tested ${fractionalPoints.length} fractional points');

  // ========== Section 11: Runtime Type Check ==========
  print('--- Section 11: Runtime Type Check ---');
  
  final point3 = TextSelectionPoint(
    Offset(100.0, 50.0),
    TextDirection.ltr,
  );
  print('runtimeType: ${point3.runtimeType}');
  print('Is TextSelectionPoint: ${point3 is TextSelectionPoint}');
  results.add('Runtime type verified');

  // ========== Section 12: TextDirection Enum Values ==========
  print('--- Section 12: TextDirection Enum Values ---');
  
  for (final dir in TextDirection.values) {
    print('TextDirection.${dir.name}: index=${dir.index}');
  }
  print('Total TextDirection values: ${TextDirection.values.length}');
  results.add('TextDirection enum: ${TextDirection.values.length} values');

  print('TextSelectionPoint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionPoint Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
