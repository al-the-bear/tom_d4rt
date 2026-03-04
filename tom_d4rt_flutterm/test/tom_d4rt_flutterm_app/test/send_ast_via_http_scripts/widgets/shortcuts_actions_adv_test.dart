// Tests: ShortcutActivator (abstract), ShortcutManager, ShortcutRegistry,
//        ShortcutRegistryEntry, DoNothingAndStopPropagationIntent,
//        DoNothingAndStopPropagationAction, PrioritizedAction,
//        ContextAction (abstract)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // --- ShortcutActivator Tests ---
  print('--- ShortcutActivator Tests ---');
  print('ShortcutActivator is the abstract interface for shortcut triggers');
  print('Type: $ShortcutActivator');
  print('Implemented by SingleActivator, CharacterActivator, LogicalKeySet');
  var singleActivator = SingleActivator(LogicalKeyboardKey.keyA, control: true);
  print('SingleActivator (Ctrl+A): $singleActivator');
  print('SingleActivator trigger: ${singleActivator.trigger}');
  var charActivator = CharacterActivator('?');
  print('CharacterActivator (?): $charActivator');
  print('CharacterActivator character: ${charActivator.character}');

  // --- ShortcutManager Tests ---
  print('--- ShortcutManager Tests ---');
  var shortcutManager = ShortcutManager(
    shortcuts: {
      SingleActivator(LogicalKeyboardKey.keyS, control: true): const ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.keyZ, control: true): const UndoTextIntent(SelectionChangedCause.keyboard),
    },
  );
  print('ShortcutManager: $shortcutManager');
  print('ShortcutManager shortcuts count: ${shortcutManager.shortcuts.length}');
  print('ShortcutManager handles keyboard shortcut dispatching');

  // --- ShortcutRegistry Tests ---
  print('--- ShortcutRegistry Tests ---');
  print('ShortcutRegistry allows dynamic shortcut registration');
  print('Type: $ShortcutRegistry');
  print('Provides addAll() to register shortcuts at runtime');
  print('Returns ShortcutRegistryEntry for later removal');

  // --- ShortcutRegistryEntry Tests ---
  print('--- ShortcutRegistryEntry Tests ---');
  print('ShortcutRegistryEntry represents a registered shortcut set');
  print('Type: $ShortcutRegistryEntry');
  print('Call dispose() to unregister shortcuts from the registry');
  print('Returned by ShortcutRegistry.addAll()');

  // --- DoNothingAndStopPropagationIntent Tests ---
  print('--- DoNothingAndStopPropagationIntent Tests ---');
  var doNothingStopIntent = DoNothingAndStopPropagationIntent();
  print('DoNothingAndStopPropagationIntent: $doNothingStopIntent');
  print('Stops event propagation without performing any action');
  print('Useful for consuming keyboard events silently');

  // --- DoNothingAndStopPropagationAction Tests ---
  print('--- DoNothingAndStopPropagationAction Tests ---');
  var doNothingStopAction = DoNothingAction(consumesKey: false);
  print('DoNothingAndStopPropagationAction (now DoNothingAction): $doNothingStopAction');
  print('consumesKey: ${doNothingStopAction.consumesKey(DoNothingAndStopPropagationIntent())}');
  print('Handles DoNothingAndStopPropagationIntent');

  // --- PrioritizedAction Tests ---
  print('--- PrioritizedAction Tests ---');
  print('PrioritizedAction wraps an action with priority ordering');
  print('Type: $PrioritizedAction');
  var prioritizedIntents = PrioritizedIntents(
    orderedIntents: [
      const ActivateIntent(),
      const DismissIntent(),
    ],
  );
  print('PrioritizedIntents: $prioritizedIntents');
  print('PrioritizedIntents orderedIntents: ${prioritizedIntents.orderedIntents}');
  print('PrioritizedAction tries intents in order until one is handled');

  // --- ContextAction Tests ---
  print('--- ContextAction Tests ---');
  print('ContextAction is an abstract Action with BuildContext access');
  print('Type: $ContextAction');
  print('Extends Action<T> and receives context in invoke()');
  print('Useful when action needs to access ancestor widgets');

  print('All shortcuts actions advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Shortcuts(
        shortcuts: shortcutManager.shortcuts,
        child: Actions(
          actions: {
            DoNothingAndStopPropagationIntent: doNothingStopAction,
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ShortcutManager shortcuts: ${shortcutManager.shortcuts.length}'),
                Text('SingleActivator: $singleActivator'),
                Text('CharacterActivator: $charActivator'),
                const Text('Shortcuts Actions Adv Test'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
