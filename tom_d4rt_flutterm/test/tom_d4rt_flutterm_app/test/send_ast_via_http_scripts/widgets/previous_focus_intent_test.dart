// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PreviousFocusIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PreviousFocusIntent test executing');
  print('=' * 50);

  // === Test PreviousFocusIntent ===
  print('\nPreviousFocusIntent triggers previous focus action');

  // Create intent
  print('\n--- Creating PreviousFocusIntent ---');
  const intent = PreviousFocusIntent();
  print('Created const PreviousFocusIntent()');
  print('intent.runtimeType: ${intent.runtimeType}');

  // Test inheritance
  print('\n--- Inheritance ---');
  print('intent is Intent: ${intent is Intent}');
  print('Extends Intent base class');

  // Bound action
  print('\n--- Bound to PreviousFocusAction ---');
  print('Actions.invoke(context, PreviousFocusIntent())');
  print('Invokes PreviousFocusAction.invoke()');

  // Default shortcut
  print('\n--- Default shortcut ---');
  print('Shift + Tab key combination');
  print('SingleActivator(LogicalKeyboardKey.tab, shift: true)');

  // Focus traversal
  print('\n--- Focus traversal ---');
  print('Moves focus backward in traversal order');
  print('Uses current FocusTraversalPolicy');
  print('Stops at beginning of traversal');

  // Usage with Actions
  print('\n--- Usage with Actions widget ---');
  print('Actions(');
  print('  actions: {PreviousFocusIntent: PreviousFocusAction()},');
  print('  child: ...,');
  print(')');

  // Related intents
  print('\n--- Related intents ---');
  print('NextFocusIntent: forward focus');
  print('DirectionalFocusIntent: arrow key focus');
  print('RequestFocusIntent: request specific focus');


  // Actions system
  print('\n--- Actions system ---');
  print('WidgetsApp includes default bindings');
  print('Shortcuts widget maps keys to intents');
  print('Actions widget maps intents to actions');

  // Custom binding
  print('\n--- Custom binding example ---');
  print('Shortcuts(');
  print('  shortcuts: {');
  print('    SingleActivator(LogicalKeyboardKey.tab, shift: true):');
  print('      PreviousFocusIntent(),');
  print('  },');
  print(')');

  print('\n' + '=' * 50);
  print('PreviousFocusIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PreviousFocusIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Intent'),
      Text('Const constructor: yes'),
      Text('Bound: PreviousFocusAction'),
    ],
  );
}
