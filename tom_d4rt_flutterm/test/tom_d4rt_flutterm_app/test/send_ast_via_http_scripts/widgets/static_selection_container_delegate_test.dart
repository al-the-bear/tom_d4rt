// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StaticSelectionContainerDelegate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('StaticSelectionContainerDelegate test executing');
  print('=' * 50);

  // StaticSelectionContainerDelegate overview
  print('StaticSelectionContainerDelegate overview:');
  print('  - Extends MultiSelectableSelectionContainerDelegate');
  print('  - Used internally by SelectableRegion');
  print('  - Manages selection across multiple Selectables');
  print('  - Tracks selection geometry');

  // Class hierarchy
  print('\nClass hierarchy:');
  print('  - Object');
  print('  - ChangeNotifier');
  print('  - SelectionContainerDelegate');
  print('  - MultiSelectableSelectionContainerDelegate');
  print('  - StaticSelectionContainerDelegate');

  // Key properties from SelectionContainerDelegate
  print('\nInherited from SelectionContainerDelegate:');
  print('  - value: SelectionGeometry');
  print('  - Provides selection state information');

  // SelectionGeometry details
  print('\nSelectionGeometry properties:');
  print('  - startSelectionPoint: SelectionPoint?');
  print('  - endSelectionPoint: SelectionPoint?');
  print('  - selectionRects: List<Rect>');
  print('  - status: SelectionStatus');
  print('  - hasContent: bool');
  print('  - hasSelection: bool');

  // Use in SelectableRegion
  print('\nUsage in SelectableRegion:');
  print('  - Created in SelectableRegionState');
  print('  - Passed to SelectionContainer as delegate');
  print('  - Manages multiple Selectable children');
  print('  - Coordinates selection across regions');

  // Static nature
  print('\nStatic child management:');
  print('  - Optimized for static Selectables');
  print('  - Children do not change frequently');
  print('  - Suitable for text paragraphs, images');

  // Selection dispatch
  print('\nSelection event dispatch:');
  print('  - dispatchSelectionEvent to children');
  print('  - Coordinates start/end selection edges');
  print('  - Handles SelectAllSelectionEvent');
  print('  - Handles ClearSelectionEvent');

  // ChangeNotifier behavior
  print('\nChangeNotifier behavior:');
  print('  - Notifies when selection changes');
  print('  - Widget rebuilds on notification');
  print('  - Requires dispose() call');

  // Comparison with other delegates
  print('\nComparison with other selection delegates:');
  print('  - StaticSelectionContainerDelegate: static children');
  print('  - MultiSelectableSelectionContainerDelegate: base class');
  print('  - Custom delegate: dynamic children');

  print('\n' + '=' * 50);
  print('StaticSelectionContainerDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StaticSelectionContainerDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: MultiSelectableSelectionContainerDelegate'),
      Text('Purpose: Selection management for static children'),
      Text('Used by: SelectableRegionState'),
    ],
  );
}
