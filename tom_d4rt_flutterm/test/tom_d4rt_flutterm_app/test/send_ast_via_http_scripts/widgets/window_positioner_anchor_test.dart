// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WindowPositionerAnchor from widgets (internal API)
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WindowPositionerAnchor test executing');
  print('=' * 50);

  // WindowPositionerAnchor is internal in Flutter
  print('WindowPositionerAnchor overview:');
  print('  - Internal enum in _window_positioner.dart');
  print('  - Not exported for public use');
  print('  - Used by Flutter window positioning system');

  // Enum values documented
  print('\nEnum values (internal):');
  print('  - center: Center of the anchor rectangle');
  print('  - top: Center of top edge');
  print('  - bottom: Center of bottom edge');
  print('  - left: Center of left edge');
  print('  - right: Center of right edge');
  print('  - topLeft: Top left corner');
  print('  - topRight: Top right corner');
  print('  - bottomLeft: Bottom left corner');
  print('  - bottomRight: Bottom right corner');

  // Anchor positions visualization
  print('\nAnchor positions:');
  print('  topLeft ---- top ---- topRight');
  print('     |                     |');
  print('   left      center      right');
  print('     |                     |');
  print('  bottomLeft-bottom-bottomRight');

  // Usage context
  print('\nUsage (internal to Flutter):');
  print('  WindowPositioner(');
  print('    parentAnchor: WindowPositionerAnchor.bottom,');
  print('    childAnchor: WindowPositionerAnchor.top,');
  print('    offset: Offset(0, 5),');
  print('  )');

  // Parent vs Child anchor
  print('\nParent vs Child anchor:');
  print('  parentAnchor: Point on parent where child attaches');
  print('  childAnchor: Point on child that attaches to parent');
  print('  offset: Additional Offset from anchored position');

  // Examples
  print('\nExample configurations:');
  print('  Dropdown below button:');
  print('    parent=bottomLeft, child=topLeft');
  print('  ');
  print('  Tooltip above widget:');
  print('    parent=top, child=bottom');
  print('  ');
  print('  Context menu at cursor:');
  print('    parent=center (cursor), child=topLeft');

  // Platform considerations
  print('\nPlatform considerations:');
  print('  - Desktop platforms use this for popups');
  print('  - Mobile typically uses overlay positioning');
  print('  - Web may have different constraints');

  // Related classes
  print('\nRelated internal classes:');
  print('  - WindowPositioner');
  print('  - WindowPositionerConstraintAdjustment');
  print('  - WindowingOwner (platform-specific)');

  // Index-like behavior
  print('\nEnum semantics:');
  print('  - 9 total anchor positions');
  print('  - Covers all corners, edges, and center');
  print('  - Natural for rectangle-based positioning');

  print('\n' + '=' * 50);
  print('WindowPositionerAnchor test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WindowPositionerAnchor Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Internal enum'),
      Text('Values: center, corners, edges'),
      Text('Use: Flutter window positioning'),
    ],
  );
}
