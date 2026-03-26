// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionGeometry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionGeometry test executing');
  print('=' * 50);

  // SelectionGeometry describes the current selection state
  print('\nSelectionGeometry:');
  print('Mixes in: Diagnosticable');
  print('Purpose: Describes geometry of a selection in a Selectable');
  print('Value type for SelectionHandler (ValueListenable)');

  // Create with no selection
  const noSelection = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: true,
  );
  print('\nNo selection:');
  print('  runtimeType: ${noSelection.runtimeType}');
  print('  status: ${noSelection.status}');
  print('  hasContent: ${noSelection.hasContent}');
  print('  hasSelection: ${noSelection.hasSelection}');
  print('  startSelectionPoint: ${noSelection.startSelectionPoint}');
  print('  endSelectionPoint: ${noSelection.endSelectionPoint}');
  print('  selectionRects: ${noSelection.selectionRects}');

  // Create with uncollapsed selection
  final startPoint = SelectionPoint(
    localPosition: const Offset(10.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  final endPoint = SelectionPoint(
    localPosition: const Offset(200.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.right,
  );
  final uncollapsed = SelectionGeometry(
    startSelectionPoint: startPoint,
    endSelectionPoint: endPoint,
    selectionRects: const [Rect.fromLTWH(10, 16, 190, 16)],
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );
  print('\nUncollapsed selection:');
  print('  status: ${uncollapsed.status}');
  print('  hasSelection: ${uncollapsed.hasSelection}');
  print('  selectionRects count: ${uncollapsed.selectionRects.length}');

  // SelectionStatus enum
  print('\nSelectionStatus values:');
  for (final s in SelectionStatus.values) {
    print('  ${s.name}');
  }

  // copyWith
  final collapsed = uncollapsed.copyWith(
    status: SelectionStatus.collapsed,
  );
  print('\ncopyWith to collapsed:');
  print('  status: ${collapsed.status}');
  print('  hasSelection: ${collapsed.hasSelection}');

  // Equality
  const a = SelectionGeometry(status: SelectionStatus.none, hasContent: false);
  const b = SelectionGeometry(status: SelectionStatus.none, hasContent: false);
  print('\nEquality: ${a == b}');

  print('\n==================================================');
  print('SelectionGeometry test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectionGeometry Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable value class'),
      Text('Status: ${uncollapsed.status}'),
      Text('hasSelection: ${uncollapsed.hasSelection}'),
      Text('Purpose: Describe selection geometry'),
    ],
  );
}
