// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollIntent test executing');
  print('=' * 50);

  // ScrollIntent represents a scroll request from the user
  print('\nScrollIntent Analysis:');
  print('  Type: class');
  print('  Extends: Intent');
  print('  Purpose: Request scrolling in a direction');

  // Create intents with different directions
  print('\nConstruction Examples:');

  // Line scroll down
  final lineDown = ScrollIntent(
    direction: AxisDirection.down,
    type: ScrollIncrementType.line,
  );
  print('  Line down:');
  print('    direction: ${lineDown.direction}');
  print('    type: ${lineDown.type}');

  // Page scroll up
  final pageUp = ScrollIntent(
    direction: AxisDirection.up,
    type: ScrollIncrementType.page,
  );
  print('  Page up:');
  print('    direction: ${pageUp.direction}');
  print('    type: ${pageUp.type}');

  // Horizontal scrolls
  final lineRight = ScrollIntent(
    direction: AxisDirection.right,
  );
  print('  Line right (default type):');
  print('    direction: ${lineRight.direction}');
  print('    type: ${lineRight.type}');

  final lineLeft = ScrollIntent(
    direction: AxisDirection.left,
    type: ScrollIncrementType.line,
  );
  print('  Line left:');
  print('    direction: ${lineLeft.direction}');

  // Properties
  print('\nProperties:');
  print('  direction: AxisDirection (required)');
  print('    - Which direction to scroll');
  print('  type: ScrollIncrementType');
  print('    - Defaults to ScrollIncrementType.line');
  print('    - Can be line or page');

  // All AxisDirection values
  print('\nAxisDirection values:');
  for (final dir in AxisDirection.values) {
    print('  ${dir.name}');
  }

  // Usage with ScrollAction
  print('\nUsage with ScrollAction:');
  print('  1. Keyboard shortcut triggers ScrollIntent');
  print('  2. Actions widget finds ScrollAction');
  print('  3. ScrollAction.invoke receives intent');
  print('  4. Finds nearest Scrollable');
  print('  5. Scrolls by calculated increment');

  // Type information
  print('\nType Information:');
  print('  lineDown is Intent: ${lineDown is Intent}');
  print('  Runtime type: ${lineDown.runtimeType}');

  print('\n' + '=' * 50);
  print('ScrollIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScrollIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: Intent'),
      Text('Direction: ${lineDown.direction}'),
      Text('Default type: ${lineRight.type}'),
    ],
  );
}
