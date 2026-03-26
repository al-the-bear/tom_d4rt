// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionUtils from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionUtils test executing');
  print('=' * 50);

  // SelectionUtils is abstract final (utility class)
  print('\nSelectionUtils:');
  print('Type: abstract final class');
  print('Purpose: Static utility methods for selection calculations');
  print('Cannot be instantiated or extended');

  // getResultBasedOnRect
  print('\nStatic method: getResultBasedOnRect');
  print('  Signature: SelectionResult getResultBasedOnRect(Rect targetRect, Offset point)');
  print('  Determines selection result based on point position relative to rect');

  final rect = const Rect.fromLTWH(50, 50, 200, 100);

  // Point inside rect
  final inside = SelectionUtils.getResultBasedOnRect(rect, const Offset(100, 80));
  print('\n  Point inside rect:');
  print('    rect: $rect');
  print('    point: Offset(100, 80)');
  print('    result: $inside');

  // Point above rect
  final above = SelectionUtils.getResultBasedOnRect(rect, const Offset(100, 10));
  print('\n  Point above rect:');
  print('    point: Offset(100, 10)');
  print('    result: $above');

  // Point below rect
  final below = SelectionUtils.getResultBasedOnRect(rect, const Offset(100, 200));
  print('\n  Point below rect:');
  print('    point: Offset(100, 200)');
  print('    result: $below');

  // adjustDragOffset
  print('\nStatic method: adjustDragOffset');
  print('  Signature: Offset adjustDragOffset(Rect targetRect, Offset point, {TextDirection})'); 
  print('  Clamps a drag point to be within the target rect');

  final adjusted = SelectionUtils.adjustDragOffset(
    rect,
    const Offset(300, 300),
  );
  print('\n  Adjusted offset:');
  print('    original: Offset(300, 300)');
  print('    adjusted: $adjusted');

  final adjustedInside = SelectionUtils.adjustDragOffset(
    rect,
    const Offset(100, 80),
  );
  print('\n  Already inside:');
  print('    original: Offset(100, 80)');
  print('    adjusted: $adjustedInside');

  // With RTL direction
  final adjustedRtl = SelectionUtils.adjustDragOffset(
    rect,
    const Offset(300, 80),
    direction: TextDirection.rtl,
  );
  print('\n  RTL adjusted:');
  print('    adjusted: $adjustedRtl');

  print('\n==================================================');
  print('SelectionUtils test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectionUtils Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract final (utility) class'),
      Text('getResultBasedOnRect: $inside'),
      Text('adjustDragOffset: $adjusted'),
      Text('Purpose: Selection calculation helpers'),
    ],
  );
}
