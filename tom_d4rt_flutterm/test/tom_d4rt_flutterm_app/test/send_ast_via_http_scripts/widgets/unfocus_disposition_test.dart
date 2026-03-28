// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UnfocusDisposition enum from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UnfocusDisposition test executing');
  print('=' * 50);

  // UnfocusDisposition controls unfocus behavior
  print('UnfocusDisposition overview:');
  print('  - Enum with 2 values');
  print('  - Controls where focus goes');
  print('  - Used by FocusNode.unfocus()');
  print('  - Determines unfocus strategy');

  // Enum values
  print('\nEnum values:');
  print('  - scope');
  print('  - previouslyFocusedChild');

  // Test values
  print('\nAll values:');
  for (final value in UnfocusDisposition.values) {
    print('  - ${value.name}: index=${value.index}');
  }

  // scope disposition
  print('\nUnfocusDisposition.scope:');
  print('  - Moves focus to enclosing scope');
  print('  - Default behavior');
  print('  - Focus goes to FocusScopeNode');
  print('  - No specific child remembered');

  // previouslyFocusedChild disposition
  print('\nUnfocusDisposition.previouslyFocusedChild:');
  print('  - Moves to previously focused child');
  print('  - Restores previous focus state');
  print('  - Within same scope');
  print('  - Falls back to scope if none');

  // Usage example
  print('\nUsage with FocusNode:');
  print('  focusNode.unfocus()');
  print('  -> Uses scope disposition (default)');
  print('  focusNode.unfocus(');
  print('    disposition: UnfocusDisposition.previouslyFocusedChild');
  print('  )');
  print('  -> Restores previous child');

  // When to use each
  print('\nWhen to use each:');
  print('  scope:');
  print('    - Dismiss keyboard');
  print('    - Clear focus completely');
  print('    - Form submission');
  print('  previouslyFocusedChild:');
  print('    - Modal dialogs closing');
  print('    - Restore focus after overlay');
  print('    - Tab navigation');

  // FocusNode.unfocus signature
  print('\nFocusNode.unfocus signature:');
  print('  void unfocus({');
  print('    UnfocusDisposition disposition = ');
  print('      UnfocusDisposition.scope,');
  print('  })');

  print('\n' + '=' * 50);
  print('UnfocusDisposition test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UnfocusDisposition Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: scope, previouslyFocusedChild'),
      Text('Used by: FocusNode.unfocus()'),
    ],
  );
}
