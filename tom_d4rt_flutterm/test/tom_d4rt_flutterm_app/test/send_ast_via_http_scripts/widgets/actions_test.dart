// D4rt test script: Tests Actions, Shortcuts, Intent, CallbackAction from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Actions test executing');

  // Test Intent - abstract, but can be used as a type marker
  // ActivateIntent and DismissIntent are concrete subclasses
  final activateIntent = ActivateIntent();
  print('ActivateIntent created');
  print('ActivateIntent runtimeType: ${activateIntent.runtimeType}');

  final dismissIntent = DismissIntent();
  print('DismissIntent created');
  print('DismissIntent runtimeType: ${dismissIntent.runtimeType}');

  // Test CallbackAction
  final callbackAction = CallbackAction<ActivateIntent>(
    onInvoke: (intent) {
      print('CallbackAction invoked with: ${intent.runtimeType}');
      return null;
    },
  );
  print('CallbackAction<ActivateIntent> created');
  print('CallbackAction runtimeType: ${callbackAction.runtimeType}');

  // Test Actions widget
  final actionsWidget = Actions(
    actions: {
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) {
          print('Activate action invoked');
          return null;
        },
      ),
      DismissIntent: CallbackAction<DismissIntent>(
        onInvoke: (intent) {
          print('Dismiss action invoked');
          return null;
        },
      ),
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Actions widget with 2 action mappings'),
        ElevatedButton(
          child: Text('Test Button'),
          onPressed: () {
            print('Button pressed under Actions');
          },
        ),
      ],
    ),
  );
  print('Actions widget with ActivateIntent and DismissIntent created');

  // Test Shortcuts widget
  final shortcutsWidget = Shortcuts(
    shortcuts: {
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
          ActivateIntent(),
    },
    child: Actions(
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            print('Ctrl+A shortcut activated');
            return null;
          },
        ),
      },
      child: Focus(
        autofocus: true,
        child: Container(
          width: 200.0,
          height: 80.0,
          color: Colors.blue,
          child: Center(
            child: Text('Press Ctrl+A', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ),
  );
  print('Shortcuts widget with Ctrl+A mapping created');

  // Test FocusableActionDetector
  final focusableDetector = FocusableActionDetector(
    actions: {
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) {
          print('FocusableActionDetector activate');
          return null;
        },
      ),
    },
    child: Container(
      width: 150.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text(
          'Focusable Detector',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('FocusableActionDetector created');

  // Test Actions.find and Actions.invoke concepts
  print('Actions.find(context) - finds action for a given intent type');
  print('Actions.invoke(context, intent) - invokes action for intent');

  print('Actions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Actions / Shortcuts / Intent Tests'),
      SizedBox(height: 8.0),
      actionsWidget,
      SizedBox(height: 8.0),
      shortcutsWidget,
      SizedBox(height: 8.0),
      focusableDetector,
    ],
  );
}
