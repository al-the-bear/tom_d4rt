// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableProperty from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableProperty test executing');
  print('=' * 50);

  // RestorableProperty is the base abstract class
  print('RestorableProperty<T>:');
  print('Purpose: Base class for all restorable properties');
  print('Extends: ChangeNotifier');
  print('');

  // Abstract methods
  print('Abstract methods to implement:');
  print('  T createDefaultValue()');
  print('    - Returns default value when no restoration data');
  print('');
  print('  T fromPrimitives(Object? data)');
  print('    - Converts serialized data back to T');
  print('');
  print('  void initWithValue(T value)');
  print('    - Initializes property with restored value');
  print('');
  print('  Object? toPrimitives()');
  print('    - Serializes current value for storage');
  print('');

  // Key properties
  print('Key properties:');
  print('  bool get enabled => true');
  print('    - Whether to include in restoration data');
  print('');
  print('  bool get isRegistered');
  print('    - True after registered with RestorationMixin');
  print('');
  print('  State get state');
  print('    - The State object this is registered with');
  print('');

  // Notification behavior
  print('Notification behavior:');
  print('  - Extends ChangeNotifier');
  print('  - Call notifyListeners() when value changes');
  print('  - RestorationMixin listens for updates');
  print('');

  // Concrete implementations
  print('Concrete implementations:');
  print('  RestorableValue<T> - adds value getter/setter');
  print('  RestorableInt, RestorableDouble, RestorableString');
  print('  RestorableBool, RestorableDateTime');
  print('  RestorableEnum<T>, RestorableEnumN<T>');
  print('  RestorableTextEditingController');
  print('  RestorableRouteFuture<T>');
  print('');

  // Testing via concrete class
  print('Testing via RestorableInt:');
  final prop = RestorableInt(0);
  print('Created: RestorableInt(0)');
  print('is RestorableProperty: ${prop is RestorableProperty}');
  print('is ChangeNotifier: ${prop is ChangeNotifier}');
  print('');

  // Cleanup
  prop.dispose();
  print('Property disposed');

  print('\n' + '=' * 50);
  print('RestorableProperty test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract base: ChangeNotifier'),
      Text('Core of state restoration'),
      Text('Many concrete subclasses'),
    ],
  );
}
