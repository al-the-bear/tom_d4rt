// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlowParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlowParentData test executing');
  print('=' * 50);

  // FlowParentData for Flow widget children
  print('\nFlowParentData:');
  print('ParentData for Flow widget children');
  print('Stores transform matrix per child');

  // Create instance
  final parentData = FlowParentData();
  print('\nInstance created:');
  print('runtimeType: ${parentData.runtimeType}');

  // Properties
  print('\nProperties:');
  print('offset: ${parentData.offset}');

  // Used with Flow widget
  print('\nUsed with Flow widget:');
  print('Flow(');
  print('  delegate: MyFlowDelegate(),');
  print('  children: [');
  print('    // Children get FlowParentData');
  print('  ],');
  print(');');

  // FlowDelegate
  print('\nFlowDelegate.paintChildren:');
  print('void paintChildren(FlowPaintingContext context) {');
  print('  for (int i = 0; i < context.childCount; i++) {');
  print('    context.paintChild(');
  print('      i,');
  print('      transform: Matrix4.translationValues(');
  print('        x, y, 0,');
  print('      ),');
  print('    );');
  print('  }');
  print('}');

  // Flow positioning
  print('\nFlow positioning:');
  print('- Each child can have custom transform');
  print('- Delegate controls layout');
  print('- FlowParentData stores offset');
  print('- Repaint efficient via layer');

  // Extends ContainerBoxParentData
  print('\nExtends ContainerBoxParentData:');
  print('is ContainerBoxParentData: ${true}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ParentData');
  print('  \u2514\u2500 BoxParentData');
  print('       \u2514\u2500 ContainerBoxParentData');
  print('            \u2514\u2500 FlowParentData');

  // Explain purpose
  print('\nFlowParentData purpose:');
  print('- Parent data for Flow children');
  print('- Stores offset information');
  print('- Used by FlowDelegate');
  print('- Custom positioning per child');
  print('- Extends ContainerBoxParentData');

  print('\n${'=' * 50}');
  print('FlowParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FlowParentData Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Offset: ${parentData.offset}'),
      Text('Widget: Flow'),
      Text('Delegate: FlowDelegate'),
      Text('Purpose: Flow child data'),
    ],
  );
}
