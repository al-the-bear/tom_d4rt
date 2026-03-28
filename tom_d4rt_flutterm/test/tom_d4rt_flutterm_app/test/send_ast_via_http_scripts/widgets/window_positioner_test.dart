// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WindowPositioner from widgets (internal API)
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WindowPositioner test executing');
  print('=' * 50);

  // WindowPositioner is internal in Flutter
  print('WindowPositioner overview:');
  print('  - Internal class in _window_positioner.dart');
  print('  - Not exported for public use');
  print('  - Defines popup window positioning');

  // Constructor parameters documented
  print('\nConstructor parameters (internal):');
  print('  parentAnchor: WindowPositionerAnchor');
  print('    - Point on parent rect where child anchors');
  print('  childAnchor: WindowPositionerAnchor');
  print('    - Point on child rect that connects to parent');
  print('  offset: Offset');
  print('    - Additional offset from anchored position');
  print('  constraintAdjustment: WindowPositionerConstraintAdjustment');
  print('    - How to handle overflow constraints');
  print('  parentSize: Size (optional)');
  print('    - Override for parent rectangle size');

  // Usage example
  print('\nUsage example (internal):');
  print('  WindowPositioner(');
  print('    parentAnchor: WindowPositionerAnchor.bottom,');
  print('    childAnchor: WindowPositionerAnchor.top,');
  print('    offset: Offset(0, 8),');
  print('    constraintAdjustment: ');
  print('      WindowPositionerConstraintAdjustment.flipY,');
  print('  )');

  // Positioning scenarios
  print('\nPositioning scenarios:');
  print('  ');
  print('  Dropdown menu:');
  print('    parent=bottomLeft, child=topLeft');
  print('    offset=Offset(0, 4)');
  print('  ');
  print('  Tooltip:');
  print('    parent=top, child=bottom');
  print('    offset=Offset(0, -4)');
  print('  ');
  print('  Context menu:');
  print('    parent=cursor position');
  print('    child=topLeft');

  // Anchor relationship
  print('\nAnchor relationship:');
  print('  Parent anchor attaches to child anchor');
  print('  Child positioned relative to parent');
  print('  Offset applied after anchoring');

  // Flutter widget alternatives
  print('\nPublic Flutter alternatives:');
  print('  - OverlayEntry for overlays');
  print('  - showMenu for context menus');
  print('  - showModalBottomSheet for sheets');
  print('  - PopupMenuButton for popup menus');

  // Related classes
  print('\nRelated internal classes:');
  print('  - WindowPositionerAnchor');
  print('  - WindowPositionerConstraintAdjustment');
  print('  - WindowingOwner');

  print('\n' + '=' * 50);
  print('WindowPositioner test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WindowPositioner Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Internal positioning class'),
      Text('Props: parentAnchor, childAnchor, offset'),
      Text('Alternative: OverlayEntry, showMenu'),
    ],
  );
}
