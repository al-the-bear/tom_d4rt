// D4rt test script: Tests RenderSliverFloatingPinnedPersistentHeader from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFloatingPinnedPersistentHeader test executing');
  print('=' * 50);

  // RenderSliverFloatingPinnedPersistentHeader for headers
  print('\nRenderSliverFloatingPinnedPersistentHeader:');
  print('Sliver header that floats AND pins');
  print('Combines floating and pinned behaviors');

  // Purpose
  print('\nPurpose:');
  print('- Render floating + pinned headers');
  print('- Stay visible while scrolling');
  print('- Reappear on scroll reversal');

  // Header types comparisons
  print('\nHeader type comparison:');
  print('');
  print('Pinned only:');
  print('  - Always visible at top');
  print('  - Stays fixed while scrolling');
  print('');
  print('Floating only:');
  print('  - Scrolls away with content');
  print('  - Reappears on reverse scroll');
  print('');
  print('Floating + Pinned:');
  print('  - Starts pinned at top');
  print('  - Shrinks/expands on scroll');
  print('  - Reappears on reverse scroll');
  print('  - Best of both worlds');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverPersistentHeader(');
  print('  delegate: MyDelegate(),');
  print('  pinned: true,');
  print('  floating: true,');
  print(');');

  // SliverAppBar usage
  print('\nSliverAppBar usage:');
  print('SliverAppBar(');
  print('  floating: true,');
  print('  pinned: true,');
  print('  expandedHeight: 200.0,');
  print('  flexibleSpace: FlexibleSpaceBar(...),');
  print(');');

  // Extends
  print('\nExtends:');
  print('RenderSliverFloatingPersistentHeader');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderSliver');
  print('  \u2514\u2500 RenderSliverPersistentHeader');
  print('       \u2514\u2500 RenderSliverFloatingPersistentHeader');
  print('            \u2514\u2500 RenderSliverFloatingPinnedPersistentHeader');

  // Explain purpose
  print('\nRenderSliverFloatingPinnedPersistentHeader purpose:');
  print('- Combined floating + pinned');
  print('- Sliver persistent header');
  print('- SliverAppBar rendering');
  print('- Best UX for headers');
  print('- Extends floating header');

  print('\n' + '=' * 50);
  print('RenderSliverFloatingPinnedPersistentHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFloatingPinnedPersistentHeader Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Floating: true'),
      Text('Pinned: true'),
      Text('Widget: SliverPersistentHeader'),
      Text('Purpose: Combined header'),
    ],
  );
}
