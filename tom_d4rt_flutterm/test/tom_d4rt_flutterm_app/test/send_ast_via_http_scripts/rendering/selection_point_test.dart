// D4rt test script: Tests SelectionPoint from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionPoint test executing');
  final results = <String>[];

  // ========== Section 1: Basic SelectionPoint Creation ==========
  print('--- Section 1: Basic SelectionPoint Creation ---');

  final point1 = SelectionPoint(
    localPosition: Offset(10.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  print('Created SelectionPoint: ${point1.runtimeType}');
  print('localPosition: ${point1.localPosition}');
  print('lineHeight: ${point1.lineHeight}');
  print('handleType: ${point1.handleType}');
  results.add('SelectionPoint created with left handle');

  // ========== Section 2: Different Handle Types ==========
  print('--- Section 2: Different Handle Types ---');

  final leftPoint = SelectionPoint(
    localPosition: Offset(0.0, 0.0),
    lineHeight: 14.0,
    handleType: TextSelectionHandleType.left,
  );
  print('Left handle point: ${leftPoint.handleType}');

  final rightPoint = SelectionPoint(
    localPosition: Offset(100.0, 0.0),
    lineHeight: 14.0,
    handleType: TextSelectionHandleType.right,
  );
  print('Right handle point: ${rightPoint.handleType}');

  final collapsedPoint = SelectionPoint(
    localPosition: Offset(50.0, 0.0),
    lineHeight: 14.0,
    handleType: TextSelectionHandleType.collapsed,
  );
  print('Collapsed handle point: ${collapsedPoint.handleType}');
  results.add('Handle types: left, right, collapsed');

  // ========== Section 3: TextSelectionHandleType Values ==========
  print('--- Section 3: TextSelectionHandleType Values ---');

  for (final handleType in TextSelectionHandleType.values) {
    print('  ${handleType.name}: index=${handleType.index}');
  }
  print('Total handle types: ${TextSelectionHandleType.values.length}');
  results.add(
    'TextSelectionHandleType values: ${TextSelectionHandleType.values.length}',
  );

  // ========== Section 4: Different Local Positions ==========
  print('--- Section 4: Different Local Positions ---');

  final positions = [
    Offset(0, 0),
    Offset(50, 25),
    Offset(100, 50),
    Offset(-10, -5),
    Offset(1000, 500),
  ];

  for (final pos in positions) {
    final testPoint = SelectionPoint(
      localPosition: pos,
      lineHeight: 16.0,
      handleType: TextSelectionHandleType.left,
    );
    print('Point at $pos: localPosition=${testPoint.localPosition}');
  }
  results.add('Tested ${positions.length} different positions');

  // ========== Section 5: Different Line Heights ==========
  print('--- Section 5: Different Line Heights ---');

  final lineHeights = [10.0, 14.0, 16.0, 20.0, 24.0, 32.0];

  for (final height in lineHeights) {
    final testPoint = SelectionPoint(
      localPosition: Offset(0, 0),
      lineHeight: height,
      handleType: TextSelectionHandleType.left,
    );
    print('Point with lineHeight $height: ${testPoint.lineHeight}');
  }
  results.add('Tested ${lineHeights.length} line heights');

  // ========== Section 6: Selection Points for Text Selection ==========
  print('--- Section 6: Selection Points for Text Selection ---');

  final startSelection = SelectionPoint(
    localPosition: Offset(10.0, 100.0),
    lineHeight: 18.0,
    handleType: TextSelectionHandleType.left,
  );

  final endSelection = SelectionPoint(
    localPosition: Offset(200.0, 100.0),
    lineHeight: 18.0,
    handleType: TextSelectionHandleType.right,
  );

  print('Start selection: ${startSelection.localPosition}');
  print('End selection: ${endSelection.localPosition}');
  final selectionWidth =
      endSelection.localPosition.dx - startSelection.localPosition.dx;
  print('Selection width: $selectionWidth');
  results.add('Selection span width: $selectionWidth');

  // ========== Section 7: Multiple Lines Selection ==========
  print('--- Section 7: Multiple Lines Selection ---');

  final linePoints = <SelectionPoint>[];
  for (var line = 0; line < 5; line++) {
    linePoints.add(
      SelectionPoint(
        localPosition: Offset(0.0, line * 20.0),
        lineHeight: 18.0,
        handleType: line == 0
            ? TextSelectionHandleType.left
            : TextSelectionHandleType.right,
      ),
    );
  }
  print('Created ${linePoints.length} line selection points');
  for (var i = 0; i < linePoints.length; i++) {
    print(
      '  Line $i: y=${linePoints[i].localPosition.dy}, handle=${linePoints[i].handleType}',
    );
  }
  results.add('Multi-line selection: ${linePoints.length} points');

  // ========== Section 8: Equality and Properties ==========
  print('--- Section 8: Equality and Properties ---');

  final pointA = SelectionPoint(
    localPosition: Offset(10, 20),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );

  final pointB = SelectionPoint(
    localPosition: Offset(10, 20),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );

  print('pointA == pointA: ${pointA == pointA}');
  print('pointA == pointB: ${pointA == pointB}');
  print('pointA.hashCode: ${pointA.hashCode}');
  print('pointB.hashCode: ${pointB.hashCode}');
  results.add('Equality test: ${pointA == pointB}');

  // ========== Section 9: ToString ==========
  print('--- Section 9: ToString ---');

  print('point1.toString(): ${point1.toString()}');
  results.add('ToString available');

  print('SelectionPoint test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionPoint Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
