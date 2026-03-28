// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests VoidCallbackIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VoidCallbackIntent test executing');
  print('=' * 50);

  // VoidCallbackIntent holds callback
  print('VoidCallbackIntent overview:');
  print('  - Extends Intent');
  print('  - Has callback property');
  print('  - Used with VoidCallbackAction');
  print('  - Generic intent for callbacks');

  // Create intent
  print('\nCreating intent:');
  int counter = 0;
  final intent = VoidCallbackIntent(() {
    counter++;
    print('  Callback executed! counter=$counter');
  });
  print('  Created: $intent');
  print('  callback type: ${intent.callback.runtimeType}');

  // Callback property
  print('\ncallback property:');
  print('  - Type: VoidCallback');
  print('  - Required in constructor');
  print('  - Invoked by VoidCallbackAction');
  print('  - No parameters, no return');

  // Execute manually
  print('\nExecuting callback manually:');
  intent.callback();
  print('  counter after callback: $counter');

  // With const callback
  print('\nWith const:');
  print('  const VoidCallbackIntent(myCallback)');
  print('  - Requires top-level function');
  print('  - Or static method');
  print('  - For const Intent');

  // Usage patterns
  print('\nUsage patterns:');
  print('  // Create intent with action');
  print('  VoidCallbackIntent(() => doSomething())');
  print('  ');
  print('  // Invoke via Actions');
  print('  Actions.invoke(context, intent)');

  // With keyboard shortcuts
  print('\nWith keyboard shortcuts:');
  print('  Shortcuts(');
  print('    shortcuts: {');
  print('      LogicalKeySet(LogicalKeyboardKey.escape):');
  print('        VoidCallbackIntent(closeDialog),');
  print('    },');
  print('    child: ...,');
  print('  )');

  // vs other intents
  print('\nvs specific intents:');
  print('  - VoidCallbackIntent: generic, any callback');
  print('  - ScrollIntent: scroll-specific');
  print('  - DirectionalFocusIntent: focus-specific');
  print('  - Use specific when semantic meaning needed');

  // Implementation
  print('\nImplementation:');
  print('  class VoidCallbackIntent extends Intent {');
  print('    const VoidCallbackIntent(this.callback);');
  print('    final VoidCallback callback;');
  print('  }');

  print('\n' + '=' * 50);
  print('VoidCallbackIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'VoidCallbackIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Intent subclass'),
      Text('Property: callback (VoidCallback)'),
      Text('Use: Generic callback intent'),
    ],
  );
}
