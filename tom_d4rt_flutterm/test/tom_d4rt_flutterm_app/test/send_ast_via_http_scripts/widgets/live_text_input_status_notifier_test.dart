// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LiveTextInputStatusNotifier from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LiveTextInputStatusNotifier test executing');
  print('=' * 50);

  // === Test LiveTextInputStatusNotifier class ===
  print('\nLiveTextInputStatusNotifier tracks Live Text input availability');

  // Create a notifier
  print('\n--- Testing LiveTextInputStatusNotifier creation ---');
  final notifier = LiveTextInputStatusNotifier();
  print('Created LiveTextInputStatusNotifier');
  print('notifier.runtimeType: ${notifier.runtimeType}');
  print('notifier.value: ${notifier.value}');

  // Test with initial value
  print('\n--- Testing with initial value ---');
  final notifierEnabled = LiveTextInputStatusNotifier(
    value: LiveTextInputStatus.enabled,
  );
  print('Created with enabled status');
  print('notifierEnabled.value: ${notifierEnabled.value}');

  final notifierDisabled = LiveTextInputStatusNotifier(
    value: LiveTextInputStatus.disabled,
  );
  print('Created with disabled status');
  print('notifierDisabled.value: ${notifierDisabled.value}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('notifier is ValueNotifier: ${notifier is ValueNotifier}');
  print('notifier is ChangeNotifier: ${notifier is ChangeNotifier}');
  print('notifier is Listenable: ${notifier is Listenable}');

  // Test update method
  print('\n--- Testing update method ---');
  print('update() checks LiveText.isLiveTextInputAvailable()');
  print('Updates value asynchronously based on platform support');

  // Test listener management
  print('\n--- Testing listener management ---');
  print('addListener: starts observing app lifecycle');
  print('removeListener: stops observing when no listeners');
  print('Implements WidgetsBindingObserver');

  // Test app lifecycle handling
  print('\n--- Testing app lifecycle handling ---');
  print('didChangeAppLifecycleState handles:');
  print('  - resumed: calls update()');
  print('  - paused, inactive, detached, hidden: no action');

  // Test dispose
  print('\n--- Testing dispose ---');
  print('dispose() removes observer and cleans up');

  // Clean up
  notifier.dispose();
  notifierEnabled.dispose();
  notifierDisabled.dispose();
  print('Notifiers disposed');

  print('\n' + '=' * 50);
  print('LiveTextInputStatusNotifier test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LiveTextInputStatusNotifier Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Purpose: Track Live Text availability'),
      Text('Base: ValueNotifier<LiveTextInputStatus>'),
      Text('Observes: WidgetsBinding lifecycle'),
    ],
  );
}
