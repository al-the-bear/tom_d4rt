// D4rt test script: Tests ParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ParentData test executing');

  // ParentData - Base class for data stored in child render objects
  // Parent render objects use this to store layout information about children
  
  // Create a ParentData instance
  final parentData = ParentData();
  print('ParentData created: $parentData');
  print('runtimeType: ${parentData.runtimeType}');
  
  // ParentData lifecycle
  print('\nParentData lifecycle:');
  print('- Created by parent RenderObject.setupParentData()');
  print('- Stored in child.parentData');
  print('- Detached when child removed from parent');
  
  // Note: detach() is @protected - can only be called from subclasses
  print('\ndetach() is protected; called by framework during child removal');
  
  // Common subclasses
  print('\nCommon ParentData subclasses:');
  print('- BoxParentData: Stores offset for positioned children');
  print('- FlexParentData: Stores flex factor for Flex children');
  print('- StackParentData: Stores positioning for Stack children');
  print('- SliverLogicalParentData: Stores scroll offset');
  print('- SliverPhysicalParentData: Stores paint offset');
  print('- TableCellParentData: Stores table cell position');
  
  // ContainerParentData for linked-list traversal
  print('\nContainerParentDataMixin:');
  print('- Adds nextSibling/previousSibling links');
  print('- Used by ContainerRenderObjectMixin');
  print('- Enables efficient child traversal');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('ParentData is the base class');
  print('Specialized for different layout protocols');
  print('detach() called during child removal');
  
  // Use cases
  print('\nUse cases:');
  print('- Layout positioning (offset, flex, etc.)');
  print('- Child-specific rendering info');
  print('- Parent-managed child state');

  print('\nParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ParentData Tests'),
      Text('Base class for child layout data'),
      Text('Stored in child.parentData'),
      Text('Common: BoxParentData, FlexParentData'),
    ],
  );
}
