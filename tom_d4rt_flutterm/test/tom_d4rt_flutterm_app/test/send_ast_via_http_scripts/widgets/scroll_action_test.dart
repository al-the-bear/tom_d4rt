// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollAction from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollAction test executing');
  print('=' * 50);

  // ScrollAction responds to ScrollIntent to scroll widgets
  print('\nScrollAction Analysis:');
  print('  Type: class');
  print('  Extends: ContextAction<ScrollIntent>');
  print('  Purpose: Scrolls widgets in response to ScrollIntent');

  // Create ScrollAction
  print('\nConstruction:');
  final action = ScrollAction();
  print('  Created ScrollAction: ${action.runtimeType}');

  // Check isEnabled behavior
  print('\nIsEnabled Behavior:');
  print('  - Returns false if context is null');
  print('  - Returns true if Scrollable.maybeOf(context) is not null');
  print('  - Returns true if PrimaryScrollController has clients');

  // ScrollIntent parameters
  print('\nScrollIntent Parameters:');
  print('  direction: AxisDirection - scroll direction');
  print('  type: ScrollIncrementType - line or page');

  // Create different intents
  print('\nScrollIntent Examples:');
  final lineDown = ScrollIntent(
    direction: AxisDirection.down,
    type: ScrollIncrementType.line,
  );
  print('  Line down: direction=${lineDown.direction}, type=${lineDown.type}');

  final pageUp = ScrollIntent(
    direction: AxisDirection.up,
    type: ScrollIncrementType.page,
  );
  print('  Page up: direction=${pageUp.direction}, type=${pageUp.type}');

  // Default increments
  print('\nDefault Scroll Increments:');
  print('  Line scroll: 50.0 logical pixels');
  print('  Page scroll: 80% of viewport dimension');
  print('  Custom: via Scrollable.incrementCalculator');

  // Static method
  print('\nStatic Method:');
  print('  getDirectionalIncrement(state, intent):');
  print('    - Calculates actual scroll amount');
  print('    - Takes direction into account');
  print('    - Returns 0.0 if axes don\'t match');

  // Usage pattern
  print('\nUsage Pattern:');
  print('  Actions widget registers ScrollAction for ScrollIntent');
  print('  Keyboard bindings trigger ScrollIntent');
  print('  ScrollAction.invoke scrolls the nearest Scrollable');

  print('\n' + '=' * 50);
  print('ScrollAction test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScrollAction Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Action type: ${action.runtimeType}'),
      Text('Line increment: 50.0 pixels'),
      Text('Page increment: 80% viewport'),
    ],
  );
}
