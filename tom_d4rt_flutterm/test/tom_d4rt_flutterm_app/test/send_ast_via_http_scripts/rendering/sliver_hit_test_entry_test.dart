// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverHitTestEntry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverHitTestEntry test executing');
  print('=' * 50);

  // SliverHitTestEntry records a sliver hit test result
  print('\nSliverHitTestEntry:');
  print('Extends: HitTestEntry<RenderSliver>');
  print('Purpose: Records hit test position in sliver coordinates');
  print('Stores mainAxisPosition and crossAxisPosition');

  // Cannot create without a real RenderSliver target
  print('\nConstructor:');
  print('  SliverHitTestEntry(');
  print('    RenderSliver target,');
  print('    {required double mainAxisPosition,');
  print('     required double crossAxisPosition}');
  print('  )');

  // Properties
  print('\nProperties:');
  print('  target -> RenderSliver (the hit sliver)');
  print('  mainAxisPosition -> double (position along scroll axis)');
  print('  crossAxisPosition -> double (position across scroll axis)');

  // Coordinate system
  print('\nSliver coordinate system:');
  print('  mainAxisPosition: distance along the scroll direction');
  print('    - For vertical scroll: vertical position within sliver');
  print('    - For horizontal scroll: horizontal position within sliver');
  print('  crossAxisPosition: distance perpendicular to scroll');
  print('    - For vertical scroll: horizontal position within sliver');
  print('    - For horizontal scroll: vertical position within sliver');

  // Hit testing flow
  print('\nSliver hit testing flow:');
  print('  1. RenderViewport receives hit test');
  print('  2. Converts to sliver coordinates');
  print('  3. Calls RenderSliver.hitTest()');
  print('  4. If hit, creates SliverHitTestEntry');
  print('  5. Entry added to HitTestResult');

  // Difference from BoxHitTestEntry
  print('\nComparison with BoxHitTestEntry:');
  print('  BoxHitTestEntry: uses Offset (x, y) in box coords');
  print('  SliverHitTestEntry: uses mainAxis/crossAxis in sliver coords');
  print('  Sliver coords are scroll-direction-relative');

  // Related types
  print('\nRelated types:');
  print('  HitTestResult - accumulates hit test entries');
  print('  SliverHitTestResult - wraps HitTestResult for slivers');
  print('  BoxHitTestEntry - equivalent for box render objects');

  // toString
  print('\ntoString format:');
  print('  SliverHitTestEntry(target, mainAxisPosition, crossAxisPosition)');

  print('\n==================================================');
  print('SliverHitTestEntry test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SliverHitTestEntry Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: HitTestEntry<RenderSliver>'),
      Text('Fields: mainAxisPosition, crossAxisPosition'),
      Text('Purpose: Sliver hit test result'),
    ],
  );
}
