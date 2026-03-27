// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ToolbarItemsParentData from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ToolbarItemsParentData test executing');
  print('=' * 50);

  // ToolbarItemsParentData is ParentData for toolbar buttons
  print('ToolbarItemsParentData overview:');
  print('  - Extends ContainerBoxParentData<RenderBox>');
  print('  - Controls whether child is painted');
  print('  - Used in text selection menus');
  print('  - Handles overflow button visibility');

  // Key property
  print('\nKey property:');
  print('  - shouldPaint: bool (default false)');
  print('  - Determines if child gets painted');
  print('  - Set after layout based on overflow');
  print('  - Read during paint phase');

  // Inheritance chain
  print('\nInheritance chain:');
  print('  - ToolbarItemsParentData');
  print('  - extends ContainerBoxParentData<RenderBox>');
  print('  - extends BoxParentData');
  print('  - extends ParentData');

  // Inherited properties
  print('\nInherited properties from BoxParentData:');
  print('  - offset: Offset (position in parent)');
  print('  - From ContainerBoxParentData:');
  print('  - previousSibling: RenderBox?');
  print('  - nextSibling: RenderBox?');

  // Usage in toolbar layout
  print('\nUsage in toolbar layout:');
  print('  - Layout measures all buttons');
  print('  - Determines which fit in available space');
  print('  - Sets shouldPaint=true for visible buttons');
  print('  - Sets shouldPaint=false for overflow items');

  // Paint behavior
  print('\nPaint behavior:');
  print('  - Parent checks shouldPaint before painting child');
  print('  - Skips painting if shouldPaint is false');
  print('  - Allows measuring without displaying');
  print('  - Overflow button shows hidden items');

  // Cupertino and Material usage
  print('\nUsed by:');
  print('  - CupertinoTextSelectionToolbar');
  print('  - Material text selection menus');
  print('  - Custom toolbar implementations');
  print('  - Adaptive text selection toolbar');

  // toString override
  print('\ntoString format:');
  print('  - Appends "; shouldPaint=<value>"');
  print('  - Extends super.toString()');
  print('  - Useful for debugging layout');

  // How to check in render object
  print('\nAccessing in RenderObject:');
  print('  - Cast child.parentData as ToolbarItemsParentData');
  print('  - Read shouldPaint before painting');
  print('  - Set shouldPaint during layout');

  print('\n' + '=' * 50);
  print('ToolbarItemsParentData test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ToolbarItemsParentData Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ContainerBoxParentData'),
      Text('Key property: shouldPaint'),
      Text('Purpose: Toolbar overflow handling'),
    ],
  );
}
