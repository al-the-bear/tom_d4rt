// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverOverlapAbsorber from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderSliverOverlapAbsorber test executing');

  // RenderSliverOverlapAbsorber - Absorbs overlap from AppBar in NestedScrollView
  // Used with SliverOverlapAbsorber widget and SliverOverlapInjector
  
  // Create a SliverOverlapAbsorberHandle
  final handle = SliverOverlapAbsorberHandle();
  print('SliverOverlapAbsorberHandle created: $handle');
  print('layoutExtent: ${handle.layoutExtent}');
  print('scrollExtent: ${handle.scrollExtent}');
  
  // Properties explained
  print('\nHandle properties:');
  print('- layoutExtent: The overlap amount for layout purposes');
  print('- scrollExtent: The overlap amount for scroll calculation');
  print('- Used to coordinate overlapping headers');
  
  // How overlap absorption works
  print('\nOverlap absorption mechanism:');
  print('1. SliverOverlapAbsorber wraps the overlapping sliver');
  print('2. Records overlap extent in the handle');
  print('3. SliverOverlapInjector reads from handle');
  print('4. Injects the overlap to push content down');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderSliverOverlapAbsorber extends RenderSliver');
  print('SliverOverlapAbsorberHandle is ChangeNotifier');
  print('SliverOverlapAbsorber creates the render object');
  
  // Use cases
  print('\nUse cases:');
  print('- NestedScrollView with SliverAppBar');
  print('- Coordinating overlapping slivers');
  print('- Custom scroll coordination');
  print('- TabBarView with flexible headers');

  print('\nRenderSliverOverlapAbsorber test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverOverlapAbsorber Tests'),
      Text('Absorbs overlap from SliverAppBar'),
      Text('Works with SliverOverlapInjector'),
      Text('Used in NestedScrollView'),
    ],
  );
}
