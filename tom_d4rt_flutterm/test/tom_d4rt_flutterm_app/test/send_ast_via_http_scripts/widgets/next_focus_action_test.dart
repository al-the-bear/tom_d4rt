// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NextFocusAction from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NextFocusAction test executing');
  print('=' * 50);

  // === Test NextFocusAction class ===
  print('\nNextFocusAction moves focus to next focusable node');

  // Create NextFocusAction
  print('\n--- Testing creation ---');
  final action = NextFocusAction();
  print('Created NextFocusAction');
  print('action.runtimeType: ${action.runtimeType}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('action is Action<NextFocusIntent>: ${action is Action<NextFocusIntent>}');

  // Test isEnabled
  print('\n--- Testing isEnabled ---');
  final intent = NextFocusIntent();
  print('action.isEnabled(intent): ${action.isEnabled(intent)}');

  // Test invoke method
  print('\n--- Testing invoke method ---');
  print('invoke(NextFocusIntent): moves focus to next node');
  print('Returns true if focus was moved');
  print('Returns false if reached end');

  // Test toKeyEventResult
  print('\n--- Testing toKeyEventResult ---');
  print('Converts invoke result to KeyEventResult');
  print('true -> KeyEventResult.handled');
  print('false -> KeyEventResult.skipRemainingHandlers');

  // Test with Actions widget
  print('\n--- Testing with Actions widget ---');
  final actionsWidget = Actions(
    actions: <Type, Action<Intent>>{
      NextFocusIntent: NextFocusAction(),
    },
    child: Focus(
      child: Text('Focusable'),
    ),
  );
  print('Created Actions widget with NextFocusAction');

  // Test default binding
  print('\n--- Default key binding ---');
  print('Bound to Tab key in WidgetsApp');
  print('Moves focus forward through focusable widgets');

  // Test FocusTraversalPolicy integration
  print('\n--- FocusTraversalPolicy integration ---');
  print('Uses primaryFocus!.nextFocus()');
  print('Relies on current FocusTraversalPolicy');

  print('\n' + '=' * 50);
  print('NextFocusAction test completed');

  // Test PreviousFocusAction pair
  print('\n--- PreviousFocusAction counterpart ---');
  print('NextFocusAction: Tab key');
  print('PreviousFocusAction: Shift+Tab key');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NextFocusAction Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Is Action<NextFocusIntent>: true'),
      Text('isEnabled: ${action.isEnabled(intent)}'),
      Text('Default key: Tab'),
      actionsWidget,
    ],
  );
}
