// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetStateMouseCursor from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStateMouseCursor test executing');
  print('=' * 50);

  // WidgetStateMouseCursor resolves cursor based on state
  print('WidgetStateMouseCursor overview:');
  print('  - Abstract class extending MouseCursor');
  print('  - Implements WidgetStateProperty<MouseCursor>');
  print('  - Resolves cursor per widget state');

  // Test built-in clickable cursor
  print('\nTesting WidgetStateMouseCursor.clickable:');
  final clickable = WidgetStateMouseCursor.clickable;
  print('  Created: ${clickable.debugDescription}');

  // Resolve with empty states
  print('\nResolving clickable with empty states:');
  final defaultCursor = clickable.resolve({});
  print('  Empty: $defaultCursor');
  print('  Is click cursor: ${defaultCursor == SystemMouseCursors.click}');

  // Resolve with disabled
  print('\nResolving clickable with disabled:');
  final disabledCursor = clickable.resolve({WidgetState.disabled});
  print('  Disabled: $disabledCursor');
  print('  Is basic cursor: ${disabledCursor == SystemMouseCursors.basic}');

  // Test textable cursor
  print('\nTesting WidgetStateMouseCursor.textable:');
  final textable = WidgetStateMouseCursor.textable;
  final textCursor = textable.resolve({});
  print('  Default: $textCursor');
  print('  Is text cursor: ${textCursor == SystemMouseCursors.text}');

  final textDisabled = textable.resolve({WidgetState.disabled});
  print('  Disabled: $textDisabled');
  print('  Is basic: ${textDisabled == SystemMouseCursors.basic}');

  // Test resolveWith factory
  print('\nTesting resolveWith factory:');
  final custom = WidgetStateMouseCursor.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return SystemMouseCursors.grab;
    }
    if (states.contains(WidgetState.hovered)) {
      return SystemMouseCursors.click;
    }
    return SystemMouseCursors.basic;
  });
  print('  Custom cursor created');
  print('  Pressed: ${custom.resolve({WidgetState.pressed})}');
  print('  Hovered: ${custom.resolve({WidgetState.hovered})}');
  print('  Default: ${custom.resolve({})}');

  // Adaptive clickable
  print('\nWidgetStateMouseCursor.adaptiveClickable:');
  final adaptive = WidgetStateMouseCursor.adaptiveClickable;
  print('  Platform-adaptive cursor');
  print('  Web: click cursor');
  print('  Non-web: basic cursor');

  print('\n' + '=' * 50);
  print('WidgetStateMouseCursor test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetStateMouseCursor Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: MouseCursor + WidgetStateProperty'),
      Text('Static: clickable, textable, adaptiveClickable'),
      Text('Factory: resolveWith()'),
    ],
  );
}
