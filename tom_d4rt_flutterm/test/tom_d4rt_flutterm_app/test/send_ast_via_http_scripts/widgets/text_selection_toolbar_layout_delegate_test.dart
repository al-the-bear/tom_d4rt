// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionToolbarLayoutDelegate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionToolbarLayoutDelegate test executing');
  print('=' * 50);

  // Test construction
  print('Testing TextSelectionToolbarLayoutDelegate:');
  final delegate = TextSelectionToolbarLayoutDelegate(
    anchorAbove: Offset(100, 50),
    anchorBelow: Offset(100, 100),
  );
  print('  anchorAbove: Offset(100, 50)');
  print('  anchorBelow: Offset(100, 100)');
  print('  fitsAbove: null (will be calculated)');

  // With fitsAbove specified
  print('\nWith fitsAbove specified:');
  final delegate2 = TextSelectionToolbarLayoutDelegate(
    anchorAbove: Offset(100, 50),
    anchorBelow: Offset(100, 100),
    fitsAbove: true,
  );
  print('  fitsAbove: ${delegate2.fitsAbove} (forced)');

  // Class hierarchy
  print('\nClass hierarchy:');
  print('  - Extends SingleChildLayoutDelegate');
  print('  - Used for toolbar positioning');

  // Properties
  print('\nProperties:');
  print('  - anchorAbove: Offset (local coordinates)');
  print('  - anchorBelow: Offset (local coordinates)');
  print('  - fitsAbove: bool? (optional override)');

  // centerOn static method
  print('\ncenterOn static method:');
  print('  static double centerOn(double position, double width, double max)');
  print('  - Centers width around position');
  print('  - Constrains to [0, max - width]');
  
  // Test centerOn
  final centered = TextSelectionToolbarLayoutDelegate.centerOn(100, 50, 200);
  print('  centerOn(100, 50, 200) = $centered');

  // getConstraintsForChild
  print('\ngetConstraintsForChild:');
  print('  - Returns constraints.loosen()');
  print('  - Child can be smaller than available space');

  // getPositionForChild
  print('\ngetPositionForChild:');
  print('  - Calculates fitsAbove if not provided');
  print('  - Uses anchorAbove if fits above');
  print('  - Uses anchorBelow otherwise');
  print('  - Centers horizontally within bounds');

  // shouldRelayout
  print('\nshouldRelayout:');
  print('  - Returns true if anchors or fitsAbove changed');

  // Usage
  print('\nUsage:');
  print('  - TextSelectionToolbar');
  print('  - CupertinoTextSelectionToolbar');
  print('  - Positions toolbar relative to selection');

  // runtimeType
  print('\nType verification:');
  print('  delegate.runtimeType: ${delegate.runtimeType}');

  print('\n' + '=' * 50);
  print('TextSelectionToolbarLayoutDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextSelectionToolbarLayoutDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: SingleChildLayoutDelegate'),
      Text('Props: anchorAbove, anchorBelow, fitsAbove'),
      Text('Static: centerOn(position, width, max)'),
    ],
  );
}
