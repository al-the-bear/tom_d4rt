// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests VoidCallbackAction from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VoidCallbackAction test executing');
  print('=' * 50);

  // VoidCallbackAction invokes callback
  print('VoidCallbackAction overview:');
  print('  - Extends Action<VoidCallbackIntent>');
  print('  - Invokes intent callback');
  print('  - Simple callback execution');
  print('  - Generic action type');

  // Create and use
  print('\nCreating action:');
  final action = VoidCallbackAction();
  print('  Created: $action');
  print('  intentType: ${action.intentType}');

  // VoidCallbackIntent required
  print('\nRequires VoidCallbackIntent:');
  print('  - Intent must have callback property');
  print('  - Action calls intent.callback()');
  print('  - Callback is VoidCallback type');
  print('  - No arguments, no return value');

  // Invoke behavior
  print('\nInvoke behavior:');
  print('  @override');
  print('  void invoke(VoidCallbackIntent intent) {');
  print('    intent.callback();');
  print('  }');

  // Usage with Actions widget
  print('\nUsage with Actions widget:');
  print('  Actions(');
  print('    actions: <Type, Action<Intent>>{');
  print('      VoidCallbackIntent: VoidCallbackAction(),');
  print('    },');
  print('    child: ...,');
  print('  )');

  // Triggering the action
  print('\nTriggering:');
  print('  Actions.invoke<VoidCallbackIntent>(');
  print('    context,');
  print('    VoidCallbackIntent(() {');
  print('      print("Callback executed!");');
  print('    }),');
  print('  )');

  // Use cases
  print('\nUse cases:');
  print('  - Custom keyboard shortcuts');
  print('  - Button actions via intent');
  print('  - Generic action binding');
  print('  - Decoupled command execution');

  // vs CallbackAction
  print('\nvs CallbackAction:');
  print('  - VoidCallbackAction: uses intent callback');
  print('  - CallbackAction: has its own callback');
  print('  - VoidCallback: callback per intent');
  print('  - Callback: callback per action');

  // Implementation simplicity
  print('\nImplementation:');
  print('  class VoidCallbackAction extends Action<VoidCallbackIntent> {');
  print('    @override');
  print('    void invoke(VoidCallbackIntent intent) => intent.callback();');
  print('  }');

  print('\n' + '=' * 50);
  print('VoidCallbackAction test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'VoidCallbackAction Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Action<VoidCallbackIntent>'),
      Text('Behavior: Invokes intent.callback()'),
      Text('Use: Generic callback execution'),
    ],
  );
}
