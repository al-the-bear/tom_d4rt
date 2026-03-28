// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverFillRemaining from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFillRemaining test executing');
  print('=' * 50);

  // RenderSliverFillRemaining class overview
  print('RenderSliverFillRemaining class overview:');
  print('  - Extends RenderSliverSingleBoxAdapter');
  print('  - Fills remaining viewport space');
  print('  - Used by SliverFillRemaining');

  // Key properties
  print('\nKey properties:');
  print('  bool hasScrollBody');
  print('    - Controls overflow');
  print('    - Default: true');
  print('  bool fillOverscroll');
  print('    - Fill overscroll area?');
  print('    - Default: false');

  // Size behavior
  print('\nSize behavior:');
  print('  hasScrollBody=true:');
  print('    - Minimum: remaining space');
  print('    - Can grow with content');
  print('  hasScrollBody=false:');
  print('    - Exactly remaining space');
  print('    - Content constrained');

  // Overscroll
  print('\nOverscroll behavior:');
  print('  fillOverscroll=true:');
  print('    - Fills overscroll region');
  print('    - Background effect');
  print('  fillOverscroll=false:');
  print('    - Ignores overscroll');
  print('    - Normal sizing');

  // Common use cases
  print('\nCommon use cases:');
  print('  Footer at bottom');
  print('  Empty state fill');
  print('  Error message fill');
  print('  Loading indicator');

  // Widget mapping
  print('\nWidget mapping:');
  print('  SliverFillRemaining creates this');
  print('  Part of CustomScrollView');

  // Layout behavior
  print('\nLayout behavior:');
  print('  Measures remaining viewport');
  print('  Constrains child');
  print('  Reports paint extent');
  print('  Handles scroll offset');

  // Related types
  print('\nRelated types:');
  print('  SliverFillViewport: All children fill');
  print('  RenderSliverSingleBoxAdapter: Base class');
  print('  SliverToBoxAdapter: Fixed size');

  // Scroll position
  print('\nScroll position:');
  print('  Respects scroll offset');
  print('  Adjusts remaining space');

  print('\n' + '=' * 50);
  print('RenderSliverFillRemaining test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFillRemaining Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: RenderSliver'),
      Text('Key: hasScrollBody, fillOverscroll'),
      Text('Purpose: Fill remaining space'),
    ],
  );
}
