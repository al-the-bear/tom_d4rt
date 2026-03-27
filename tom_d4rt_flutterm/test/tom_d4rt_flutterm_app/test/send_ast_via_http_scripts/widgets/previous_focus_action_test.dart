// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PreviousFocusAction from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PreviousFocusAction test executing');
  print('=' * 50);

  // === Test PreviousFocusAction ===
  print('\nPreviousFocusAction moves focus to previous node');

  // Describe the class
  print('\n--- Understanding PreviousFocusAction ---');
  print('Action<PreviousFocusIntent>');
  print('Moves focus to previous focusable node');
  print('Default binding: Shift+Tab in WidgetsApp');

  // Create action
  print('\n--- Creating PreviousFocusAction ---');
  final action = PreviousFocusAction();
  print('Created PreviousFocusAction()');
  print('action.runtimeType: ${action.runtimeType}');

  // Invoke method
  print('\n--- invoke() method ---');
  print('bool invoke(PreviousFocusIntent intent)');
  print('Calls primaryFocus!.previousFocus()');
  print('Returns true if focus moved');
  print('Returns false at traversal start');

  // Key event result
  print('\n--- toKeyEventResult() ---');
  print('Returns KeyEventResult.handled if invoked');
  print('Returns skipRemainingHandlers if not');

  // Focus traversal
  print('\n--- Focus traversal order ---');
  print('Uses FocusTraversalPolicy');
  print('Default: ReadingOrderTraversalPolicy');
  print('Moves backward through focusable nodes');

  // Default binding
  print('\n--- Default binding ---');
  print('LogicalKeyboardKey.tab + shift');
  print('Bound in WidgetsApp shortcuts');

  // Related classes
  print('\n--- Related classes ---');
  print('PreviousFocusIntent: the intent');
  print('NextFocusAction: opposite direction');
  print('DirectionalFocusAction: arrow keys');


  // FocusTraversalPolicy
  print('\n--- FocusTraversalPolicy ---');
  print('Determines traversal order');
  print('ReadingOrderTraversalPolicy (default)');
  print('OrderedTraversalPolicy (explicit)');
  print('WidgetOrderTraversalPolicy (creation order)');

  // primaryFocus
  print('\n--- primaryFocus ---');
  print('FocusManager.instance.primaryFocus');
  print('Currently focused node');
  print('null if nothing focused');

  print('\n' + '=' * 50);
  print('PreviousFocusAction test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PreviousFocusAction Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Action<PreviousFocusIntent>'),
      Text('Method: invoke()'),
      Text('Binding: Shift+Tab'),
    ],
  );
}
