// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionPoint from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionPoint test executing');
  print('=' * 50);

  // SelectionPoint describes a single selection handle
  print('\nSelectionPoint:');
  print('Mixes in: Diagnosticable');
  print('Purpose: Describes position and type of a selection handle');
  print('Used in SelectionGeometry for start/end points');

  // Create a left handle
  final leftPoint = SelectionPoint(
    localPosition: const Offset(10.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  print('\nLeft handle SelectionPoint:');
  print('  runtimeType: ${leftPoint.runtimeType}');
  print('  localPosition: ${leftPoint.localPosition}');
  print('  lineHeight: ${leftPoint.lineHeight}');
  print('  handleType: ${leftPoint.handleType}');

  // Create a right handle
  final rightPoint = SelectionPoint(
    localPosition: const Offset(200.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.right,
  );
  print('\nRight handle SelectionPoint:');
  print('  localPosition: ${rightPoint.localPosition}');
  print('  handleType: ${rightPoint.handleType}');

  // Create a collapsed handle
  final collapsedPoint = SelectionPoint(
    localPosition: const Offset(50.0, 100.0),
    lineHeight: 24.0,
    handleType: TextSelectionHandleType.collapsed,
  );
  print('\nCollapsed handle SelectionPoint:');
  print('  localPosition: ${collapsedPoint.localPosition}');
  print('  lineHeight: ${collapsedPoint.lineHeight}');
  print('  handleType: ${collapsedPoint.handleType}');

  // TextSelectionHandleType enum
  print('\nTextSelectionHandleType values:');
  for (final t in TextSelectionHandleType.values) {
    print('  ${t.name}');
  }

  // Equality
  final leftPoint2 = SelectionPoint(
    localPosition: const Offset(10.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  print('\nEquality: ${leftPoint == leftPoint2}');
  print('hashCode match: ${leftPoint.hashCode == leftPoint2.hashCode}');

  // Diagnostics
  print('\nDiagnostics support:');
  print('  toString: $leftPoint');

  // Usage in SelectionGeometry
  print('\nUsage in SelectionGeometry:');
  print('  SelectionGeometry(');
  print('    startSelectionPoint: leftPoint,');
  print('    endSelectionPoint: rightPoint,');
  print('    ...');
  print('  )');

  print('\n==================================================');
  print('SelectionPoint test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectionPoint Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable value class'),
      Text('localPosition: ${leftPoint.localPosition}'),
      Text('lineHeight: ${leftPoint.lineHeight}'),
      Text('handleType: ${leftPoint.handleType}'),
    ],
  );
}
