// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableListenable from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableListenable test executing');
  print('=' * 50);

  // RestorableListenable is an abstract class
  print('RestorableListenable<T extends Listenable>:');
  print('Purpose: Base class for restorable Listenable properties');
  print('Extends: RestorableProperty<T>');
  print('');

  // Key behaviors
  print('Key behaviors:');
  print('  - Wraps a Listenable object');
  print('  - Auto-subscribes to Listenable notifications');
  print('  - Updates restoration data on notify');
  print('  - Cleans up listener on dispose');
  print('');

  // Value accessor
  print('Value accessor:');
  print('  T get value - returns wrapped Listenable');
  print('  Only accessible after registration');
  print('');

  // initWithValue behavior
  print('initWithValue(T value) behavior:');
  print('  1. Removes listener from old value');
  print('  2. Sets new value');
  print('  3. Adds notifyListeners as listener');
  print('');

  // Subclass hierarchy
  print('Subclass hierarchy:');
  print('RestorableListenable<T>');
  print('  |-> RestorableChangeNotifier<T>');
  print('        |-> RestorableTextEditingController');
  print('');

  // When to use
  print('When to extend RestorableListenable:');
  print('  - Wrapping a custom Listenable');
  print('  - When Listenable state changes matter');
  print('  - No auto-dispose needed (use RestorableChangeNotifier otherwise)');
  print('');

  // Implementation requirements
  print('To implement:');
  print('  1. Override createDefaultValue()');
  print('  2. Override fromPrimitives()');
  print('  3. Override toPrimitives()');
  print('');

  // Difference from RestorableChangeNotifier
  print('vs RestorableChangeNotifier:');
  print('  RestorableListenable: Does NOT auto-dispose wrapped object');
  print('  RestorableChangeNotifier: Auto-disposes wrapped ChangeNotifier');
  print('');

  // Example use case
  print('Example use case:');
  print('  Custom animation controller wrapper');
  print('  Shared Listenable across widgets');
  print('  External state management integration');

  print('\n' + '=' * 50);
  print('RestorableListenable test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableListenable Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract base: RestorableProperty<T>'),
      Text('Auto-subscribes to Listenable'),
      Text('Parent of RestorableChangeNotifier'),
    ],
  );
}
