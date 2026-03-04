// D4rt test script: Tests Shortcuts, SingleActivator, LogicalKeySet,
// CallbackShortcuts, DoNothingAction, DismissAction, ActivateAction
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Shortcuts and actions test executing');

  // ========== SingleActivator ==========
  print('--- SingleActivator Tests ---');

  final ctrlC = SingleActivator(LogicalKeyboardKey.keyC, control: true);
  print('SingleActivator ctrl+C trigger: ${ctrlC.trigger}');
  print('SingleActivator ctrl+C control: ${ctrlC.control}');
  print('SingleActivator ctrl+C shift: ${ctrlC.shift}');
  print('SingleActivator ctrl+C alt: ${ctrlC.alt}');
  print('SingleActivator ctrl+C meta: ${ctrlC.meta}');

  final shiftEnter = SingleActivator(LogicalKeyboardKey.enter, shift: true);
  print('SingleActivator shift+enter trigger: ${shiftEnter.trigger}');
  print('SingleActivator shift+enter shift: ${shiftEnter.shift}');

  final altF4 = SingleActivator(LogicalKeyboardKey.f4, alt: true);
  print('SingleActivator alt+F4 trigger: ${altF4.trigger}');

  // ========== CharacterActivator ==========
  print('--- CharacterActivator Tests ---');

  final charA = CharacterActivator('a');
  print('CharacterActivator character: ${charA.character}');

  // ========== LogicalKeySet ==========
  print('--- LogicalKeySet Tests ---');

  final keySet1 = LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA);
  print('LogicalKeySet: $keySet1');

  final keySet2 = LogicalKeySet.fromSet({LogicalKeyboardKey.shift, LogicalKeyboardKey.keyB});
  print('LogicalKeySet.fromSet: $keySet2');

  // ========== Intents ==========
  print('--- Intent Tests ---');

  final activateIntent = ActivateIntent();
  print('ActivateIntent: $activateIntent');

  final dismissIntent = DismissIntent();
  print('DismissIntent: $dismissIntent');

  final scrollIntent = ScrollIntent(direction: AxisDirection.down);
  print('ScrollIntent direction: ${scrollIntent.direction}');

  // ========== Actions ==========
  print('--- Action Tests ---');

  final doNothing = DoNothingAction();
  print('DoNothingAction: consumesKey=${doNothing.consumesKey}');

  final doNothingNoConsume = DoNothingAction(consumesKey: false);
  print('DoNothingAction(consumesKey: false): consumesKey=${doNothingNoConsume.consumesKey}');

  // ========== VoidCallbackIntent ==========
  print('--- VoidCallbackIntent Tests ---');

  var callbackCalled = false;
  final voidIntent = VoidCallbackIntent(() {
    callbackCalled = true;
  });
  print('VoidCallbackIntent: $voidIntent');

  print('All shortcuts and actions tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: CallbackShortcuts(
        bindings: {
          SingleActivator(LogicalKeyboardKey.keyA, control: true): () {
            print('Ctrl+A pressed');
          },
          SingleActivator(LogicalKeyboardKey.keyS, control: true): () {
            print('Ctrl+S pressed');
          },
        },
        child: Focus(
          autofocus: true,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shortcuts & Actions Tests',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                SizedBox(height: 8.0),
                Text('SingleActivator ctrl+C: ${ctrlC.trigger}'),
                Text('LogicalKeySet: $keySet1'),
                Text('ActivateIntent: $activateIntent'),
                Text('DoNothingAction consumesKey: ${doNothing.consumesKey}'),
                SizedBox(height: 16.0),
                Shortcuts(
                  shortcuts: {
                    keySet1: activateIntent,
                    LogicalKeySet(LogicalKeyboardKey.escape): dismissIntent,
                  },
                  child: Actions(
                    actions: {
                      ActivateIntent: CallbackAction<ActivateIntent>(
                        onInvoke: (intent) => print('Activate!'),
                      ),
                      DismissIntent: CallbackAction<DismissIntent>(
                        onInvoke: (intent) => print('Dismiss!'),
                      ),
                    },
                    child: Text('Shortcuts active'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
