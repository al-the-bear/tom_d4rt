// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableChangeNotifier from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableChangeNotifier test executing');
  print('=' * 50);

  // RestorableChangeNotifier is an abstract class
  print('RestorableChangeNotifier<T extends ChangeNotifier>');
  print('Purpose: Base class for restorable ChangeNotifier properties');
  print('Extends: RestorableListenable<T>');
  print('');

  // Test via RestorableTextEditingController (concrete subclass)
  print('Testing via RestorableTextEditingController:');
  final controller = RestorableTextEditingController(text: 'Hello');
  print('Created RestorableTextEditingController');
  print('runtimeType: ${controller.runtimeType}');
  print('is RestorableProperty: ${controller is RestorableProperty}');
  print('');

  // The controller auto-disposes wrapped ChangeNotifier
  print('Key behaviors:');
  print('  - Disposes wrapped ChangeNotifier automatically');
  print('  - Listens to ChangeNotifier for state updates');
  print('  - Stores value in restoration data');
  print('');

  // Factory constructor demonstration
  print('Factory constructor patterns:');
  final c1 = RestorableTextEditingController();
  print('  Empty: creates controller with empty text');
  final c2 = RestorableTextEditingController(text: 'Test');
  print('  With text: creates controller with initial text');
  print('');

  // TextEditingValue fromValue constructor
  print('fromValue constructor:');
  final c3 = RestorableTextEditingController.fromValue(
    TextEditingValue(text: 'Custom', selection: TextSelection.collapsed(offset: 3)),
  );
  print('  Creates with TextEditingValue');
  print('');

  // Subclass implementation info
  print('To create custom RestorableChangeNotifier:');
  print('  1. Extend RestorableChangeNotifier<YourNotifier>');
  print('  2. Override createDefaultValue()');
  print('  3. Override fromPrimitives()');
  print('  4. Override toPrimitives()');
  print('');

  print('Known subclasses:');
  print('  - RestorableTextEditingController');
  print('');

  // Cleanup
  controller.dispose();
  c1.dispose();
  c2.dispose();
  c3.dispose();
  print('Controllers disposed');

  print('\n' + '=' * 50);
  print('RestorableChangeNotifier test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableChangeNotifier Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract base: RestorableListenable<T>'),
      Text('Concrete: RestorableTextEditingController'),
      Text('Auto-disposes wrapped ChangeNotifier'),
    ],
  );
}
