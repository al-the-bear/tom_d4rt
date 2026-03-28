// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetStatePropertyAll from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStatePropertyAll test executing');
  print('=' * 50);

  // WidgetStatePropertyAll returns same value for all states
  print('WidgetStatePropertyAll overview:');
  print('  - Class implementing WidgetStateProperty<T>');
  print('  - Returns same value regardless of state');
  print('  - Useful for constant properties');

  // Test with Color
  print('\nTesting with Color:');
  final colorProp = WidgetStatePropertyAll<Color>(Colors.blue);
  print('  Created: $colorProp');

  // Resolve with various states
  print('\nResolving with various states:');
  final empty = colorProp.resolve({});
  final pressed = colorProp.resolve({WidgetState.pressed});
  final disabled = colorProp.resolve({WidgetState.disabled});
  final all = colorProp.resolve(WidgetState.values.toSet());
  print('  Empty: $empty');
  print('  Pressed: $pressed');
  print('  Disabled: $disabled');
  print('  All states: $all');
  print('  All equal: ${empty == pressed && pressed == disabled && disabled == all}');

  // Test with double
  print('\nTesting with double:');
  final doubleProp = WidgetStatePropertyAll<double>(16.0);
  print('  Value: ${doubleProp.resolve({})}');
  print('  Same with pressed: ${doubleProp.resolve({WidgetState.pressed})}');

  // Test with nullable type
  print('\nTesting with nullable type:');
  final nullableProp = WidgetStatePropertyAll<Color?>(null);
  print('  Null value: ${nullableProp.resolve({})}');
  print('  With states: ${nullableProp.resolve({WidgetState.hovered})}');

  // Test with complex object
  print('\nTesting with TextStyle:');
  const style = TextStyle(fontSize: 14, color: Colors.black);
  final styleProp = WidgetStatePropertyAll<TextStyle>(style);
  final resolvedStyle = styleProp.resolve({WidgetState.focused});
  print('  fontSize: ${resolvedStyle.fontSize}');
  print('  color: ${resolvedStyle.color}');

  // Typical use case
  print('\nTypical use case:');
  print('  ElevatedButton.styleFrom(');
  print('    backgroundColor: Colors.blue, // becomes WidgetStatePropertyAll');
  print('  )');
  print('  ');
  print('  Or explicitly:');
  print('  ButtonStyle(');
  print('    elevation: WidgetStatePropertyAll(4.0),');
  print('  )');

  // Equality
  print('\nEquality:');
  final prop1 = WidgetStatePropertyAll<int>(42);
  final prop2 = WidgetStatePropertyAll<int>(42);
  print('  Two instances with same value:');
  print('  resolve equals: ${prop1.resolve({}) == prop2.resolve({})}');

  print('\n' + '=' * 50);
  print('WidgetStatePropertyAll test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetStatePropertyAll Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: WidgetStateProperty<T> implementation'),
      Text('Behavior: Same value for all states'),
      Text('Use: Constant widget properties'),
    ],
  );
}
