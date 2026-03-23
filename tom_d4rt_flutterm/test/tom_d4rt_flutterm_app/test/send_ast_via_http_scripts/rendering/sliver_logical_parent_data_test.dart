// ignore_for_file: avoid_print
// D4rt test script: Tests SliverLogicalParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLogicalParentData test executing');

  // SliverLogicalParentData - Parent data for slivers with logical scrollOffset
  // Used for positioning sliver children based on scroll extent
  
  // Create a SliverLogicalParentData instance
  final parentData = SliverLogicalParentData();
  print('SliverLogicalParentData created: $parentData');
  
  // Test layoutOffset property (from SliverLogicalParentData)
  parentData.layoutOffset = 100.0;
  print('layoutOffset: ${parentData.layoutOffset}');
  
  // The layoutOffset represents the position along the scroll axis
  print('\nProperties:');
  print('- layoutOffset: Position along main scroll axis');
  print('- Inherited from parent classes for paint offset calculation');
  
  // Compare with SliverPhysicalParentData
  print('\nComparison with SliverPhysicalParentData:');
  print('- SliverLogicalParentData: Uses layoutOffset (extent-based)');
  print('- SliverPhysicalParentData: Uses paintOffset (pixel-based)');
  print('- Logical is scroll-direction agnostic');
  print('- Physical is axis-specific');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('SliverLogicalParentData extends SliverLogicalContainerParentData');
  print('SliverLogicalContainerParentData extends SliverLogicalParentData (circular for container)'); 
  print('Base provides layoutOffset, container adds nextSibling/previousSibling');
  
  // Use cases
  print('\nuse cases:');
  print('- RenderSliverList child positioning');
  print('- RenderSliverFixedExtentList layout');
  print('- Grid sliver implementations');
  print('- Any sliver with uniform main axis positioning');

  print('\nSliverLogicalParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverLogicalParentData Tests'),
      Text('Logical positioning for sliver children'),
      Text('layoutOffset: 100.0'),
      Text('Extent-based (vs physical pixel-based)'),
    ],
  );
}
