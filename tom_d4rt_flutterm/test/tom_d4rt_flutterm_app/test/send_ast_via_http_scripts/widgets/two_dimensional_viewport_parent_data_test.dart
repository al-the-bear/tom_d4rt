// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TwoDimensionalViewportParentData from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TwoDimensionalViewportParentData test executing');
  print('=' * 50);

  // TwoDimensionalViewportParentData for 2D positioning
  print('TwoDimensionalViewportParentData overview:');
  print('  - Extends ParentData');
  print('  - Mixes in KeepAliveParentDataMixin');
  print('  - Stores child position in 2D viewport');
  print('  - Used by RenderTwoDimensionalViewport');

  // Key properties
  print('\nKey properties:');
  print('  - layoutOffset: Offset? (set during layout)');
  print('  - vicinity: ChildVicinity (row/column position)');
  print('  - isVisible: bool (in visible area)');
  print('  - _paintExtent: Size? (visible portion)');

  // layoutOffset
  print('\nlayoutOffset property:');
  print('  - Set by implementors during layout');
  print('  - Top-left corner of child');
  print('  - In parent coordinate system');
  print('  - Used to compute paintOffset');

  // ChildVicinity
  print('\nvicinity property:');
  print('  - ChildVicinity(xIndex, yIndex)');
  print('  - Logical position in grid');
  print('  - Set by buildOrObtainChildFor');
  print('  - Used for traversal ordering');

  // isVisible
  print('\nisVisible property:');
  print('  - Returns true if child is visible');
  print('  - Based on _paintExtent');
  print('  - False if in cache extent only');
  print('  - Used during paint to skip invisible');

  // KeepAliveParentDataMixin
  print('\nKeepAliveParentDataMixin:');
  print('  - keepAlive: bool property');
  print('  - Prevents disposal when off-screen');
  print('  - For expensive children');
  print('  - AutomaticKeepAlive integration');

  // Paint data
  print('\nPaint-related data:');
  print('  - _paintExtent: visible size');
  print('  - _previousSibling: linked list prev');
  print('  - _nextSibling: linked list next');
  print('  - Used for efficient paint ordering');

  // Viewport usage
  print('\nViewport usage:');
  print('  - Created by viewport during layout');
  print('  - Updated each layout cycle');
  print('  - Read during paint phase');
  print('  - Enables efficient 2D scrolling');

  print('\n' + '=' * 50);
  print('TwoDimensionalViewportParentData test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TwoDimensionalViewportParentData Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ParentData + KeepAliveParentDataMixin'),
      Text('Key: layoutOffset, vicinity, isVisible'),
      Text('Use: 2D viewport child positioning'),
    ],
  );
}
