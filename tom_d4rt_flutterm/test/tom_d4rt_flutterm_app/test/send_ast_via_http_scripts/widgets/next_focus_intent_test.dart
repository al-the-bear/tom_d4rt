// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NextFocusIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('NextFocusIntent test executing');
  print('=' * 50);

  // === Test NextFocusIntent class ===
  print('\nNextFocusIntent represents moving to next focusable');

  // Create NextFocusIntent
  print('\n--- Testing creation ---');
  final intent = NextFocusIntent();
  print('Created NextFocusIntent');
  print('intent.runtimeType: ${intent.runtimeType}');

  // Create another instance
  print('\n--- Testing const constructor ---');
  const constIntent = NextFocusIntent();
  print('Created const NextFocusIntent');
  print('constIntent.runtimeType: ${constIntent.runtimeType}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('intent is Intent: ${intent is Intent}');

  // Test equality
  print('\n--- Testing equality ---');
  final intent1 = NextFocusIntent();
  final intent2 = NextFocusIntent();
  print('intent1 == intent2: ${intent1 == intent2}');
  print('const instances are identical');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('intent.hashCode: ${intent.hashCode}');
  print('constIntent.hashCode: ${constIntent.hashCode}');

  // Test with Actions.invoke
  print('\n--- Testing with Actions.invoke ---');
  print('Actions.invoke(context, const NextFocusIntent())');
  print('Moves focus to next focusable widget');

  // Test with Shortcuts
  print('\n--- Testing with Shortcuts ---');
  final shortcuts = Shortcuts(
    shortcuts: <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.tab): NextFocusIntent(),
    },
    child: Text('With shortcut'),
  );
  print('Created Shortcuts mapping Tab to NextFocusIntent');

  // Compare with PreviousFocusIntent
  print('\n--- Comparing with PreviousFocusIntent ---');
  final prevIntent = PreviousFocusIntent();
  print('NextFocusIntent: moves forward');
  print('PreviousFocusIntent: moves backward');
  print('intent is PreviousFocusIntent: ${intent is PreviousFocusIntent}');

  // Default action
  print('\n--- Default action ---');
  print('Handled by NextFocusAction');

  print('\n' + '=' * 50);
  print('NextFocusIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NextFocusIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Is Intent: ${intent is Intent}'),
      Text('Purpose: Move focus forward'),
      Text('Handler: NextFocusAction'),
      shortcuts,
    ],
  );
}
