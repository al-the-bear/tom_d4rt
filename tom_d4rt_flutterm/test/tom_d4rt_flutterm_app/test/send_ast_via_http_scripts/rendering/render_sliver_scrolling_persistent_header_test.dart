// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverScrollingPersistentHeader from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverScrollingPersistentHeader test executing');
  print('=' * 50);

  // RenderSliverScrollingPersistentHeader is abstract
  print('\nRenderSliverScrollingPersistentHeader is abstract');
  print('Extends: RenderSliverPersistentHeader');
  print('Purpose: Header that scrolls normally, shrinks at edge, scrolls off');

  // Scrolling behavior explained
  print('\nScrolling header behavior:');
  print('1. Starts at maxExtent (fully expanded)');
  print('2. As user scrolls, begins to shrink');
  print('3. Shrinks to minExtent');
  print('4. Then scrolls off the viewport entirely');
  print('5. Does NOT stay pinned - disappears completely');

  // Key method
  print('\nKey method:');
  print('  updateGeometry()');
  print('  - Computes the visible portion during layout');
  print('  - Determines scroll extent and paint extent');
  print('  - Handles the transition from shrinking to scrolling off');

  // Layout math
  print('\nLayout calculation:');
  print('  If scrollOffset <= maxExtent:');
  print('    paintExtent = maxExtent - scrollOffset');
  print('    Gradually shrinks from maxExtent to 0');
  print('  If scrollOffset > maxExtent:');
  print('    paintExtent = 0 (fully scrolled off)');

  // Visual diagram
  print('\nVisual scroll progression:');
  print('  [=====HEADER=====]  <- maxExtent (no scroll)');
  print('  [===HEADER===]      <- shrinking');
  print('  [=HEADER=]          <- near minExtent');
  print('  [=]                 <- almost gone');
  print('                      <- scrolled off completely');

  // Comparison with siblings
  print('\nComparison with other persistent headers:');
  print('  Scrolling: Shrinks then scrolls away');
  print('  Pinned:    Shrinks then stays pinned');
  print('  Floating:  Scrolls away but reappears on reverse');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverPersistentHeader(');
  print('  delegate: MyDelegate(),');
  print('  pinned: false,');
  print('  floating: false,');
  print(');');

  // Practical use cases
  print('\nUse cases:');
  print('  - Section headers that scroll with content');
  print('  - Collapsible headers in long lists');
  print('  - Informational banners above list content');
  print('  - User profiles above feed content');

  print('\n${'=' * 50}');
  print('RenderSliverScrollingPersistentHeader test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverScrollingPersistentHeader Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Extends: RenderSliverPersistentHeader'),
      Text('Behavior: Shrinks then scrolls off'),
      Text('Does NOT stay pinned'),
    ],
  );
}
