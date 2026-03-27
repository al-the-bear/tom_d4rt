// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableValue from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableValue test executing');
  print('=' * 50);

  // RestorableValue is abstract base for valued properties
  print('RestorableValue<T>:');
  print('Purpose: Abstract base for properties with value accessor');
  print('Extends: RestorableProperty<T>');
  print('');

  // Key difference from RestorableProperty
  print('Adds to RestorableProperty:');
  print('  T get value - getter for wrapped value');
  print('  set value(T) - setter that triggers didUpdateValue');
  print('  didUpdateValue(T? oldValue) - abstract callback');
  print('');

  // Value accessor behavior
  print('Value accessor behavior:');
  print('  - Can only access after registration');
  print('  - Setting new value calls didUpdateValue');
  print('  - Subclasses should notify listeners in didUpdateValue');
  print('');

  // Abstract methods
  print('Abstract methods to implement:');
  print('  T createDefaultValue()');
  print('  T fromPrimitives(Object? data)');
  print('  void didUpdateValue(T? oldValue)');
  print('  Object? toPrimitives()');
  print('');

  // Concrete subclasses
  print('Concrete subclasses:');
  print('  RestorableNum, RestorableInt, RestorableDouble');
  print('  RestorableString, RestorableBool');
  print('  RestorableDateTime, RestorableDateTimeN');
  print('  RestorableEnum, RestorableEnumN');
  print('  (and nullable N variants)');
  print('');

  // Testing via RestorableInt
  print('Testing via RestorableInt:');
  final prop = RestorableInt(42);
  print('Created: RestorableInt(42)');
  print('is RestorableValue: ${prop is RestorableValue}');
  print('is RestorableProperty: ${prop is RestorableProperty}');
  print('');

  // Creating custom RestorableValue
  print('To create custom RestorableValue:');
  print('  1. Extend RestorableValue<YourType>');
  print('  2. Implement createDefaultValue()');
  print('  3. Implement fromPrimitives()');
  print('  4. Implement didUpdateValue() - call notifyListeners');
  print('  5. Implement toPrimitives()');

  // Cleanup
  prop.dispose();

  print('\n' + '=' * 50);
  print('RestorableValue test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableValue Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract: adds value getter/setter'),
      Text('Extends RestorableProperty'),
      Text('Base for typed restoration'),
    ],
  );
}
