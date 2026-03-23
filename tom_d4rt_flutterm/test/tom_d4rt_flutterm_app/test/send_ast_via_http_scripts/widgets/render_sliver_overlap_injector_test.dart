// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverOverlapInjector from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverOverlapInjector test executing');

  // RenderSliverOverlapInjector - Injects overlap space into sliver scroll area
  // Reads from SliverOverlapAbsorberHandle to push content down

  // Create handle (shared with absorber)
  final handle = SliverOverlapAbsorberHandle();
  print('SliverOverlapAbsorberHandle: $handle');

  print('\nRenderSliverOverlapInjector purpose:');
  print('- Reads overlap extent from handle');
  print('- Injects equivalent space into scroll area');
  print('- Pushes content below overlapping header');
  print('- Works with RenderSliverOverlapAbsorber');

  // How injection works
  print('\nOverlap injection flow:');
  print('1. SliverOverlapAbsorber records overlap in handle');
  print('2. SliverOverlapInjector reads from same handle');
  print('3. Injector reports geometry matching overlap extent');
  print('4. Content scrolls past the injected space');

  // NestedScrollView internals
  print('\nNestedScrollView coordination:');
  print('- headerSliverBuilder: Contains absorber');
  print('- body: Contains injector');
  print('- Inner scroll uses injector to offset content');
  print('- Outer scroll uses absorber for header');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderSliverOverlapInjector extends RenderSliver');
  print('SliverOverlapInjector widget creates render object');
  print('Paired with RenderSliverOverlapAbsorber');

  // Use cases
  print('\nUse cases:');
  print('- NestedScrollView body content');
  print('- TabBarView beneath SliverAppBar');
  print('- Coordinated scrolling layouts');

  print('\nRenderSliverOverlapInjector test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverOverlapInjector Tests'),
      Text('Injects overlap space'),
      Text('Reads from SliverOverlapAbsorberHandle'),
      Text('Used in NestedScrollView body'),
    ],
  );
}
